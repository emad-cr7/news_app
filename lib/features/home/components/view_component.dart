import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';

class ViewComponent extends StatelessWidget {
  const ViewComponent({
    super.key,
    required this.title,
    this.color,
    required this.onTap,
  });

  final String title;
  final Color? color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:AppSizes.pw16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.w700,
              color: color ?? Color(0XFFFFFCFC),
            ),
          ),

          InkWell(
            onTap: () => onTap(),
            child: Text(
              "View all",
              style: TextStyle(
                fontSize:AppSizes.sp14,
                fontWeight: FontWeight.w400,
                color: color ?? Color(0XFFFFFCFC),
                decoration: TextDecoration.underline,
                decorationColor: color ?? Color(0XFFFFFCFC),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
