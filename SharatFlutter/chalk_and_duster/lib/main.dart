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
  Color scaffoldColor = Color(0xff1A1A1A);
  Color accent = Color(0xff90D44B);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Colors.grey[900],
              statusBarColor: Colors.grey[900]!.withOpacity(0.5),
            ),
            child: Wrapper()),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: scaffoldColor,
          inputDecorationTheme: InputDecorationTheme(
            focusColor: Colors.grey[400],
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
            ),
            filled: true,
            fillColor: Colors.grey[900]!.withOpacity(0.5),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900]!.withOpacity(0.2),
            elevation: 0,
            centerTitle: false,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.grey[900]),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(accent),
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(accent),
              overlayColor: MaterialStateProperty.all(Colors.grey[900]),
              shadowColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: accent,
          ),
        ),
      ),
    );
  }
}
