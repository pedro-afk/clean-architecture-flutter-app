import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool readOnly;
  final Widget? suffixIcon;
  final void Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.errorText,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
    );
  }
}
