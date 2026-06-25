import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status.dart';
import 'package:news_app/features/home/components/top_headLine_screen/top_headline_Shimmer.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'list_top_headline.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            switch (controller.topHeadLineLoading) {
              case RequestStatus.loading:
                return TopHeadlineShimmer();
              case RequestStatus.error:
                return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage!),));
              case RequestStatus.loaded:
                return ListTopHeadline();
            }
          },
    );
  }
}
