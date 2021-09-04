import 'package:chalk_and_duster/services/auth.dart';
import 'package:flutter/material.dart';

class CustomProvider extends InheritedWidget {
  final AuthService? auth;

  CustomProvider({Key? key, Widget? child, this.auth})
      : super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CustomProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<CustomProvider>()
          as CustomProvider);
}
