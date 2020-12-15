import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLists extends StatefulWidget {
  @override
  _UserListsState createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<QuerySnapshot>(context);
    print(users.documents);
    return Container();
  }
}
