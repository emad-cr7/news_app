import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatefulWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.errorMessage,
    this.suffix,
    this.extraValidator,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final String errorMessage;
  final Widget? suffix;
  final bool obscureText;

  final String? Function(String?)? extraValidator;

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          obscureText: widget.obscureText && isPassword,
          controller: widget.controller,

          validator: (String? value) {
            if (value == null || value.trim().isEmpty) {
              return widget.errorMessage;
            }
            if (widget.extraValidator != null) {
              return widget.extraValidator!(value);
            }
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: isPassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
