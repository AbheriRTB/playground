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
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(what.what.toUpperCase()),
                  content: Text(
                      '${what.what} was placed in ${what.where.toLowerCase()} as of ${what.date.toString()}'),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
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
                  height: 0,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0.0,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
