import 'package:flutter/material.dart';
import 'package:where_what/models/user.dart';
import 'package:where_what/pages/home/splash.dart';
import 'package:where_what/pages/wrapper.dart';
import 'package:where_what/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    //initialRoute: "/",
    debugShowCheckedModeBanner: false,
    /*routes: {
      "/": (context) => SplashPage(),
      "/wrapper": (context) => Wrapper(),
      "/add": (context) => AddPage(),
      "/list": (context) => ListPage(),
      "/sign_in": (context) => SignInPage(),
    },
    theme: ThemeData(
        primaryColor: Colors.indigo, accentColor: Colors.indigoAccent),
  ));*/
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        theme: ThemeData(
            primaryColor: Colors.indigo, accentColor: Colors.indigoAccent),
      ),
    );
  }
}
