import 'package:flutter/material.dart';

textInputDecoration(String label) => InputDecoration(
      contentPadding: EdgeInsets.all(12.0),
      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
      labelText: label,
    );
