import 'package:flutter/material.dart';
import 'pages/location.dart';
import 'pages/home.dart';
import 'pages/loading.dart';

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/location': (context) => Location(),
        }));
