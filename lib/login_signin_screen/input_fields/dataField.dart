import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  DataField({this.labelText,this.isPassword,this.icon,this.validation, this.onSaved});

  final String Function(String) validation;
  final void Function(String) onSaved;
  final String labelText;
  final Icon icon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      style: TextStyle(fontFamily: 'Baloo', fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon,
          labelStyle: TextStyle(fontFamily: 'Baloo', fontWeight: FontWeight.w600),
          focusColor: Colors.orange,
          errorStyle: TextStyle(color: Colors.redAccent)
      ),
      obscureText: isPassword,
      validator: validation,
      onSaved: onSaved,
    );
  }
}
