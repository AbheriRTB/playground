import 'package:flutter/material.dart';

textInputDecoration(
  String label, {
  String? indicator,
  MaterialColor? color,
  String? suffix = '',
}) =>
    InputDecoration(
      labelText: label,
      helperText: indicator ?? null,
      helperStyle: TextStyle(
        color: color,
      ),
      suffixText: '$suffix',
    );
