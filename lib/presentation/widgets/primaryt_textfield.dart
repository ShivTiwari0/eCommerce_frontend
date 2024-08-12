// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrimarytTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obsecureText;
  final String? Function(String?)?  validator;
  final String? initialValue;
  final void Function(String)? onChanged;

  const PrimarytTextfield(
      {super.key,
      required this.labelText,
      this.controller,
      this.obsecureText = false,
      this.validator, this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validator ,
      initialValue:initialValue ,onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
        label: Text(labelText),
      ),
    );
  }
}
