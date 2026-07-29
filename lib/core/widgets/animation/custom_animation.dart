import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimation extends StatelessWidget {
  const CustomAnimation({
    super.key,
    required this.child,
    required this.position,
  });

  final Widget child;
  final int position;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: position,
        duration: Duration(milliseconds: 600),
        child: SlideAnimation(child: FadeInAnimation(child: child)),
      ),
    );
  }
}
