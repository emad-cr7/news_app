import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.withColorFilter = true,
    this.height,
    this.width,
    this.color,
  });

  final String path;
  final double? height;
  final double? width;
  final bool withColorFilter;
  final Color? color;

  const CustomSvgPicture.withColor({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
  }) : withColorFilter = false;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
