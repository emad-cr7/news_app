import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.errorMessage,
     this.suffix,
    this.extraValidator,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final String errorMessage;
  final Widget? suffix;
  final bool obscureText ;
  final String? Function(String?)? extraValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          obscureText:obscureText ,
          controller: controller,

          validator: (String? value) {
            if (value == null || value.trim().isEmpty) {
              return errorMessage;
            }
            if (extraValidator != null) {
              return extraValidator!(value);
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
