import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

import 'Trending.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h330,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset(
                "assets/images/background_home.png",
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              top: AppSizes.ph70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "NEWST",
                      style: TextStyle(
                        fontSize: AppSizes.sp40,
                        fontWeight: FontWeight.w600,
                        color: LightColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizes.ph6),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 2,
                    ),
                    child: Text(
                      'Trending News',
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: AppSizes.sp18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  SizedBox(height: AppSizes.ph12),

                  SizedBox(
                    height: AppSizes.h140,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (BuildContext context, HomeState state) {
                        switch (state.everythingStatus) {
                          case RequestStatusEnum.initial:
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(child: Text(state.errorMessage!));
                          case RequestStatusEnum.loaded:
                            return Trending(state: state,);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
