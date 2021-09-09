import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color?>(accent),
          ),
        ),
      ),
    );
  }
}
