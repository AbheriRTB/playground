import 'package:flutter/material.dart';

class GroupMessagesPage extends StatelessWidget {
  GroupMessagesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  String id;

  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
