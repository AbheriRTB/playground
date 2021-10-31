import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/widgets/widget_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  Color primary = Color(0xff303242);

  Color secondary = Color(0xff394359);

  Color accentDark = Color(0xffE0C097);

  Color accent = Color(0xffB85C38);

  String? message;

  List<String> uploadList = [];

  final _formKey = GlobalKey<FormState>();

  TextEditingController _searchController = TextEditingController();
  TextEditingController controller = TextEditingController();

  Future? resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  List _selectedList = [];

  String desc = '';

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);
    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: users!.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          resultsLoaded = getUsers(snapshot.data!.orgId!);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'Select Users',
                  style: TextStyle(
                    fontFamily: 'Integral',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.4, -0.8),
                  stops: [0.0, 0.5, 0.5, 1],
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.grey[900]!.withOpacity(0.2),
                    Colors.grey[900]!.withOpacity(0.2),
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0.0),
                        child: TextField(
                          controller: _searchController,
                          // onChanged: _onSearchChanged(),
                          decoration: textInputDecoration("Search"),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          controller: controller,
                          validator: (val) =>
                              val!.isNotEmpty ? null : 'Enter Group Name',
                          onChanged: (val) {
                            setState(() => message = val.trim());
                          },
                          cursorColor: Color(0xff90D44B),
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[600]),
                          decoration: InputDecoration(
                            icon: Icon(Icons.group, color: Colors.grey[800]),
                            filled: false,
                            hintText: 'Group Name'.toUpperCase(),
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey[700]),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[900]!, width: 3),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          //keyboardType: TextInputType.phone,
                          autocorrect: true,
                        ),
                      ),
                      _selectedList.length > 0
                          ? Divider(
                              color: Colors.grey[900],
                              thickness: 3,
                            )
                          : Container(),
                      _selectedList.length > 0
                          ? Expanded(
                              flex: 2,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _selectedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            color: Colors.grey[900]!
                                                .withOpacity(0.7),
                                            child: Center(
                                              child: Text(
                                                _selectedList[index]
                                                        ['displayName'][0]
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontFamily: 'Integral',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _selectedList.removeAt(index);
                                          },
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  color: Colors.grey[800],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 8.0,
                      ),
                      Divider(
                        color: Colors.grey[900],
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged(),
                          cursorColor: Color(0xff90D44B),
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[600]),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey[800],
                              size: 22,
                            ),
                            filled: false,
                            hintText: 'Search Users'.toUpperCase(),
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Colors.grey[800]),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[900]!, width: 3),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          //keyboardType: TextInputType.phone,
                          autocorrect: true,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        flex: 15,
                        child: ListView.builder(
                            itemCount: _resultsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (_resultsList[index]['isAdmin'] &&
                                  _resultsList[index]['isTeacher']) {
                                desc = 'Admin & Teacher';
                              } else if (_resultsList[index]['isAdmin']) {
                                desc = 'Admin';
                              } else if (_resultsList[index]['isTeacher']) {
                                desc = 'Teacher';
                              } else {
                                desc = 'Student';
                              }
                              return CustomList.listTypeTwo(
                                onTap: () {
                                  bool contains = false;
                                  for (int i = 0;
                                      i < _selectedList.length;
                                      ++i) {
                                    if (_selectedList[i]['uid'] ==
                                        _resultsList[index]['uid']) {
                                      contains = true;
                                      break;
                                    }
                                  }
                                  if (!contains)
                                    _selectedList.add(_resultsList[index]);
                                },
                                name: _resultsList[index]['displayName'],
                                desc: desc,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add, size: 20, color: Colors.grey[900]),
              label: Text(
                'Create'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Integral',
                  color: Colors.grey[900],
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _selectedList.forEach((element) {
                    uploadList.add(element['uid']);
                  });
                  await DatabaseService(
                    orgId: _selectedList[1]['orgId'],
                  ).updateGroupData(Groups(
                    grupName: message,
                    grupUsers: uploadList,
                  ));
                  Navigator.pop(context);
                }
              },
            ),
          );
        });
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var userSnapshot in _allResults) {
        var title =
            UsersData.fromDocument(userSnapshot).displayName!.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(userSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    //setState(() {
    _resultsList = showResults;
    //  });
  }

  getUsers(String orgID) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('orgId', isEqualTo: orgID)
        .get();

    setState(() {
      _allResults = result.docs;
    });
    searchResultsList();

    return 'complete';
  }
}
