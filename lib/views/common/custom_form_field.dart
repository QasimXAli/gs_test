import 'package:flutter/material.dart';
import 'package:gs_test/utils/theme_manager.dart';

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  const CustomFormField({
    super.key,
    required this.hintText,
    this.fillColor = ThemeManager.whiteColor,
    this.validator,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });
  //
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        controller: controller,
        autovalidateMode: autovalidateMode,
        obscureText: obscureText,
        validator: validator,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          focusColor: ThemeManager.blackColor,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fillColor: fillColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
