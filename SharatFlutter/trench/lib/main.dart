import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/pages/wrapper.dart';
import 'package:trench/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final Color primary = Color(0xff252629);
  final Color scaffoldColor = Color(0xff1B1A1D);
  final Color secondary = Color(0xff2D2E41);
  final Color accent = Color(0xffF33935);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: Users.initialData(),
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //fontFamily: GoogleFonts.robotoCondensed().fontFamily,
            fontFamily: 'Imposter',
            primaryColor: primary,
            accentColor: accent,
            scaffoldBackgroundColor: scaffoldColor,
            inputDecorationTheme: InputDecorationTheme(
              focusColor: accent,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              filled: true,
              fillColor: primary.withOpacity(0.5), //.withOpacity(0.4),
              labelStyle: TextStyle(
                color: Colors.white54,
              ),
            ),
            buttonColor: accent,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[800],
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(1.0),
                ),
                elevation: 8,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white54,
            ),
            appBarTheme: AppBarTheme(
                color: Colors.grey[900]!.withOpacity(0.6),
                elevation: 2,
                centerTitle: false)),
      ),
    );
  }
}
