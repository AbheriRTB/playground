import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void splash() async => await Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/list');
        });

    splash();

    return Container(
      color: Colors.green,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 64,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 40, 100, 0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
