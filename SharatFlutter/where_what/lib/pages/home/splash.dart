import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_what/pages/wrapper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void splash() async => await Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        });
    splash();
    return Container(
      color: Colors.indigo,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.accessibility_new,
                size: 64,
                color: Colors.indigo[200],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 60, 100, 0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
