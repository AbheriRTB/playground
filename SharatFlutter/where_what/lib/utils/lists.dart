import 'package:flutter/material.dart';
import 'package:where_what/models/what.dart';

class CustomList extends StatelessWidget {
  final What what;
  CustomList({this.what});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            what.what,
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            what.where,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Divider(
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
