import 'package:flutter/material.dart';

class CheckboxState {
  final String title;
  bool val;

  CheckboxState({
    @required this.title,
    this.val = false,
  });
}
