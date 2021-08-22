import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:protrack/pages/wrapper.dart';
import 'package:protrack/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'VictorMono',
              primaryColor: Colors.lime,
              accentColor: Colors.red),
          home: Wrapper(),
        ));
  }
}
