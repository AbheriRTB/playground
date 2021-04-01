import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red[400]),
          ),
        ),
      ),
    );
  }
}
