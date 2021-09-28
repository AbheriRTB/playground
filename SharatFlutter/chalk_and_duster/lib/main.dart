import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    return StreamProvider<Users?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          home: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: Colors.white,
                statusBarColor: Colors.white,
              ),
              child: Wrapper()),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.rubikTextTheme(),
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              focusColor: Colors.grey[400],
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              labelStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.0,
              ),
            ),
            appBarTheme: AppBarTheme(color: Colors.white, centerTitle: false),
          ),
        ));
  }
}
