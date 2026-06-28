import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String  title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      onPressed: onPressed,
      child: Text(title),
    );
  }
}
