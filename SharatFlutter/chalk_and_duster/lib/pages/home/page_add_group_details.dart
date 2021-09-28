import 'dart:math';

import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:flutter/material.dart';

class AddGroupDetails extends StatefulWidget {
  List _userList;
  AddGroupDetails(this._userList);

  @override
  _AddGroupDetailsState createState() => _AddGroupDetailsState();
}

class _AddGroupDetailsState extends State<AddGroupDetails> {
  Color primary = Color(0xff303242);

  Color secondary = Color(0xff394359);

  Color accentDark = Color(0xffE0C097);

  Color accent = Color(0xffB85C38);

  String? name;
  List<String> uploadList = [];

  @override
  Widget build(BuildContext context) {
    Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    String colorString = color.toString();

    print(widget._userList);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        //backgroundColor: secondary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: accent,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: TextField(
                onChanged: (val) {
                  setState(() => name = val.trim());
                },
                //decoration: textInputDecoration("Enter Group Name"),
                maxLength: 15,
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: accentDark,
        ),
        label: Text(
          'Create',
          style: TextStyle(color: accentDark),
        ),
        onPressed: () async {
          widget._userList.forEach((element) {
            uploadList.add(element['uid']);
          });
          await DatabaseService(
            orgId: widget._userList[1]['orgId'],
          ).updateGroupData(Groups(
            grupName: name!,
            grupUsers: uploadList,
            photoColor: colorString,
          ));
          Navigator.pop(context);
        },
        backgroundColor: secondary,
      ),
    );
  }
}
