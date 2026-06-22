import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.suffix,
    this.validator,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final Widget? suffix;
  final bool obscureText;

  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0XFF141414),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,

          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          decoration: InputDecoration(hintText: hint, suffixIcon: suffix),
        ),
      ],
    );
  }
}
