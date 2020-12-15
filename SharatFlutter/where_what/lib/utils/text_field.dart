import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label, validate;
  const DefaultTextField({
    Key key,
    @required this.controller,
    @required this.label,
    @required this.validate,
  }) : super(key: key);

  DefaultTextField.underline({
    Key key,
    @required this.controller,
    @required this.label,
    @required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value.isEmpty ? validate : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: label,
      ),
      autocorrect: true,
      keyboardType: TextInputType.name,
      controller: controller,
    );
  }
}
