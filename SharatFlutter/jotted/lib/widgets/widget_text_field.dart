import 'package:flutter/material.dart';

textInputDecoration(
  String label, {
  String? indicator,
  MaterialColor? color,
  String? suffix = '',
}) =>
    InputDecoration(
      /*focusedBorder: OutlineInputBorder(
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
      ),*/
      labelText: label,
      helperText: indicator ?? null,
      helperStyle: TextStyle(
        color: color,
      ),
      suffixText: '$suffix',
    );
