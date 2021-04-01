import 'package:flutter/material.dart';

textInputDecoration(String label, {String indicator}) => InputDecoration(
      labelText: label,
      helperText: indicator ?? null,
    );
