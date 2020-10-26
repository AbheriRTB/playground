import 'package:flutter/material.dart';
import 'package:flutter_app_hp/quotes.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List <Quotes> quote = [
    Quotes(author: "Sharat", quote: '"Evoryone no one beleave anyone"'),
  ];  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Text("+"),
        ),
    );
  }
}