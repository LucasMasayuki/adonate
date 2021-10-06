import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? errorText;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLength;
  final controller;
  final textCapitalization;
  final inputFormatters;
  final contentPadding;
  final bool obscureText;

  const TextFormFieldCustom({
    Key? key,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.inputFormatters,
    this.textCapitalization,
    this.contentPadding,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
          ),
          contentPadding: this.contentPadding,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: Colors.grey)),
      style: TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscureText,
      onChanged: this.onChanged,
    );
  }
}
