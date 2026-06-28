import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_sizes.dart';

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.all( AppSizes.w16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height: AppSizes.h80, color: Colors.white),
          ),
        );
      },
    );
  }
}
