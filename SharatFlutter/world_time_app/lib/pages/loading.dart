import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_time_app/services/time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'Loading...';

  void setupWorldTime() async {
    Time instance =
        Time(location: 'India', flag: 'germany.png', url: 'Asia/Kolkata');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.amber,
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[400]),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.amber[300],
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
