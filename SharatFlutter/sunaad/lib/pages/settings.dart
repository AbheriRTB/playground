import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunaad/main.dart';
import 'package:sunaad/pages/events/event_date.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'CHOOSE A COLOR THEME',
                  style: TextStyle(
                    fontSize: 38.0,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _incrementColor('deepPurple');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'PURPLE',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _incrementColor('orange');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'ORANGE',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _incrementColor('lightGreen');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightGreen[700],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'GREEN',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _incrementColor('cyan');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.cyan[600],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'BLUE',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _incrementColor(String color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getString('color');
    prefs.setString('color', color);
  }
}
