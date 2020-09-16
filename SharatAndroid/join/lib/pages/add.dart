import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:join/styles/icons.dart';

class AddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        Column(
          /*crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,*/
          children: [
            SvgPicture.asset(topAdd),
          ],
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
          ),
        ));
  }
}
