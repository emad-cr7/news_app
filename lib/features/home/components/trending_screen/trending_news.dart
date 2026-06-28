import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status.dart';
import 'package:news_app/features/home/components/trending_screen/trending_news_Shimmer.dart';
import 'package:news_app/features/home/components/view_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extentions/date_time_extention.dart';
import '../../../../core/widget/Custom_cached_network_image.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h310,
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
                children: [
                  Text(
                    "NEWST",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: AppSizes.h12),
                  ViewComponent(title: "Trending News", onTap: () {}),
                  SizedBox(height: AppSizes.h12),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder:
                          (
                            BuildContext context,
                            HomeController controller,
                            Widget? child,
                          ) {
                            switch (controller.everythingLoading) {
                              case RequestStatus.loading:
                                return TrendingNewsShimmer();
                              case RequestStatus.error:
                                return Center(
                                  child: Text(controller.errorMessage!),
                                );
                              case RequestStatus.loaded:
                                return ListView.separated(
                                  padding: EdgeInsets.only(left:AppSizes.pw16),
                                  itemCount: controller.newsEverythingList
                                      .take(10)
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(width: AppSizes.pw12),
                                  itemBuilder: (BuildContext context, int index) {
                                    final model =
                                        controller.newsEverythingList[index];
                                    return SizedBox(
                                      width: AppSizes.w240,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(AppSizes.r12),
                                        child: Stack(
                                          children: [
                                            CustomCachedNetworkImage(
                                              imagePath: model.urlToImage ?? "",
                                              height:AppSizes.h140,
                                              width:AppSizes.w240,
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: ([
                                                      Colors.black.withValues(
                                                        alpha: 0.5,
                                                      ),
                                                      Colors.black.withValues(
                                                        alpha: 0.7,
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom:AppSizes.ph12,
                                              left: AppSizes.pw12,
                                              right: AppSizes.pw12,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.title ?? "No title",
                                                    style: TextStyle(
                                                      fontSize: AppSizes.sp14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: AppSizes.ph6),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  model.urlToImage !=
                                                                      null
                                                                  ? NetworkImage(
                                                                      model
                                                                          .urlToImage!,
                                                                    )
                                                                  : null,
                                                              radius: AppSizes.r12,
                                                            ),
                                                            SizedBox(width: AppSizes.ph6),
                                                            Expanded(
                                                              child: Text(
                                                                model.author ??
                                                                    "No author",
                                                                style: TextStyle(
                                                                  fontSize: AppSizes.sp12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            Text(
                                                              model.publishedAt
                                                                  .formatDateTime(),
                                                              style: TextStyle(
                                                                fontSize: AppSizes.sp12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
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
