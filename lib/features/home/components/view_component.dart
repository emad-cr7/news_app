import 'package:flutter/material.dart';

class ViewComponent extends StatelessWidget {
  const ViewComponent({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final String title;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),

          InkWell(
            onTap: () => onTap(),
            child: Text(
              "View all",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: color,
                decoration: TextDecoration.underline,
                decorationColor: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
