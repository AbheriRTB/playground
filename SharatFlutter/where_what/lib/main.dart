import 'package:flutter/material.dart';
import 'package:where_what/models/user.dart';
import 'package:where_what/pages/home/splash.dart';
import 'package:where_what/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        theme:
            ThemeData(primaryColor: Colors.red, accentColor: Colors.redAccent),
      ),
    );
  }
}
