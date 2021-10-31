import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/auth.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<Users?>.value(
        value: AuthService().user,
        initialData: Users.initialData(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  Color primary = const Color(0xff356859);
  Color primaryVariant = const Color(0xff37966F);
  Color onPrimary = const Color(0xffFFFBE3);
  Color surface = const Color(0xffB9E4C9);
  Color onSurface = const Color(0xff356859);
  Color secondary = const Color(0xffFD5523);
  Color secondaryVariant = Colors.deepOrange[400]!;
  Color onSecondary = const Color(0xffFFFBE3);
  Color error = Colors.red;
  Color onError = Colors.white;
  Color background = const Color(0xffFFFBE3);
  Color onBackground = const Color(0xffFD5523);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    var themeData = ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(),
      primaryColor: primary,
      colorScheme: ColorScheme(
        primary: primary,
        primaryVariant: primaryVariant,
        secondary: secondary,
        secondaryVariant: secondaryVariant,
        surface: surface,
        background: background,
        error: error,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onBackground: onBackground,
        onError: onError,
        brightness: Brightness.light,
      ),
      hoverColor: Theme.of(context).hoverColor.withOpacity(0.01),
      scaffoldBackgroundColor: background,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.lekton().fontFamily,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(elevation: 1),
      iconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
    );
    return user != null
        ? StreamProvider<UsersData?>.value(
            initialData: UsersData.initialData(),
            value: DatabaseService(uid: user.uid).userData,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.dark.copyWith(),
                  child: Wrapper()),
              theme: themeData,
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(), child: Wrapper()),
            theme: themeData,
          );
  }
}
