import 'package:flutter/material.dart';

class CustomTextField extends TextFormField {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final String hintText;
  final String Function(String) validator;
  final bool obscureText;

  CustomTextField({
    Key key,
    @required this.controller,
    this.keyboardType: TextInputType.text,
    @required this.suffixIcon,
    this.hintText: "",
    this.obscureText: false,
    @required this.validator,
  })  : assert(controller != null),
        assert(suffixIcon != null),
        assert(validator != null),
        super(
          key: key,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            labelText: hintText,
            labelStyle: TextStyle(fontWeight: FontWeight.w400),
          ),
          validator: validator,
        );
}
