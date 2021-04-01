import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunaad/pages/banner.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void splash() async => await Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BannerPage()));
        });
    splash();
    return Container(
      color: Theme.of(context).primaryColor,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 64,
                color: Theme.of(context).primaryColorLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
