import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/pages/wrapper.dart';
import 'package:trench/services/auth.dart';

import 'models/model_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
        value: AuthService().user,
        initialData: Users.initialData(),
        child: MaterialApp(
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Courier',
            primaryColor: primary,
            accentColor: accentDark,
            inputDecorationTheme: InputDecorationTheme(
              focusColor: accentDark,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: accent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: accentDark),
              ),
              labelStyle: TextStyle(color: accentDark),
            ),
          ),
        ));
  }
}
