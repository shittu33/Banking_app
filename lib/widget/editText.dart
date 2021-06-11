import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditText extends StatelessWidget {
  final String? hint;
  final TextInputType? type;
  final bool? passwordField;
  final TextEditingController? controller;

  const EditText({
    Key? key,
    this.hint,
    this.controller, this.type, this.passwordField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: passwordField??false,
      controller: controller,keyboardType: type,
      decoration: InputDecoration(hintText: hint),
    );
  }
}