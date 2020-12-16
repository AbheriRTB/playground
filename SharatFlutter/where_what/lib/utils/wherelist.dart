import 'package:flutter/material.dart';
import 'package:where_what/models/what.dart';
import 'package:where_what/utils/lists.dart';
import 'package:provider/provider.dart';

class WhereList extends StatefulWidget {
  @override
  _WhereListState createState() => _WhereListState();
}

class _WhereListState extends State<WhereList> {
  @override
  Widget build(BuildContext context) {
    final what = Provider.of<List<What>>(context);
    return ListView.builder(
      itemCount: what.length,
      itemBuilder: (context, index) {
        return CustomList(
          what: what[index],
        );
      },
    );
  }
}
