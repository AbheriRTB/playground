import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_what/models/what.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/services/database.dart';
import 'package:where_what/utils/lists.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:where_what/utils/text_input_signin.dart';

class WhereList extends StatefulWidget {
  @override
  _WhereListState createState() => _WhereListState();
}

class _WhereListState extends State<WhereList> {
  final AuthService _auth = AuthService();
  String docID,
      object = "OBJECT",
      whereStr = "Where",
      finalDate,
      whereEdited,
      whatStr;
  final myWhereController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final what = Provider.of<List<What>>(context) ?? [];
    return ListView.builder(
      itemCount: what.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.15,
          child: CustomList(
            what: what[index],
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              color: Colors.amber,
              icon: Icons.edit,
              foregroundColor: Colors.white,
              onTap: () {
                object = what[index].what;
                whereStr = what[index].where;
                docID = what[index].docID;
                whatStr = what[index].what;
                return _onButtonPressed();
              },
            ),
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                setState(() {
                  docID = what[index].docID;
                });
                deleteWhat(docID);
              },
            ),
          ],
        );
      },
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Container(
                child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: _buildBottomNavigationMenu()),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Form _buildBottomNavigationMenu() {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'UPDATE $object LOCATION',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: whereStr,
              decoration: textInputDecoration("Enter new where"),
              validator: (val) =>
                  val.isEmpty ? 'Please enter a location' : null,

              onChanged: (val) {
                setState(() {
                  whereEdited = val;
                });
              },
              //controller: myWhereController,
            ),
            SizedBox(height: 24.0),
            FlatButton(
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  getDate();
                  String uid = await _auth.getUID();
                  DatabaseService().updateWhere(
                      where: whereEdited,
                      date: finalDate,
                      uid: uid,
                      docID: docID,
                      what: whatStr);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "UPDATE",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteWhat(String docs) async {
    String uid = await _auth.getUID();
    DatabaseService().deleteWhere(docs, uid);
  }

  getDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }
}
