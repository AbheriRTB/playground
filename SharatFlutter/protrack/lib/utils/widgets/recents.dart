import 'package:flutter/material.dart';

class RecentContainer extends StatelessWidget {
  RecentContainer();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: Colors.red,
        height: 100,
        width: 100,
      ),
      borderRadius: BorderRadius.circular(28),
    );
  }
}
