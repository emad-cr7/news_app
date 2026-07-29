import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/date_time_extension.dart';
import '../../../core/widgets/bookmark_button.dart';
import '../../../core/widgets/custom_cached_network_image.dart';
import '../../details/news_details_screen.dart';
import '../cubit/home_cubit.dart';

class Trending extends StatelessWidget {
  const Trending({super.key, required this.state});

  final HomeState state ;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: AppSizes.pw16),
      itemCount: state.newsEverythingList.take(6).length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(width: AppSizes.pw12),
      itemBuilder: (BuildContext context, int index) {
        final model = state.newsEverythingList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return NewsDetailsScreen(model: model);
                },
              ),
            );
          },
          child: SizedBox(
            width: AppSizes.w240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r12),
              child: Stack(
                children: [
                  if (model.urlToImage != null)
                    CustomCachedNetworkImage(
                      imagePath: model.urlToImage ?? "",
                      width: AppSizes.w240,
                      height: AppSizes.h140,
                    ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: AppSizes.ph8,
                    right: AppSizes.pw8,
                    child: BookmarkButton(article: model, size: 30),
                  ),

                  Positioned(
                    bottom: AppSizes.ph12,
                    right: AppSizes.pw12,
                    left: AppSizes.pw12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w700,
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
                                    backgroundImage: NetworkImage(
                                      model.urlToImage.toString(),
                                    ),
                                    radius: AppSizes.r10,
                                  ),
                                  SizedBox(width: AppSizes.pw6),
                                  Expanded(
                                    child: Text(
                                      model.author ?? "",
                                      style: TextStyle(
                                        color: Color(0xFFFFFCFC),
                                        fontSize: AppSizes.sp12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              model.publishedAt.formatDateTime(),
                              style: TextStyle(
                                color: Color(0xFFFFFCFC),
                                fontWeight: FontWeight.w400,
                                fontSize: AppSizes.sp14,
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
          ),
        );
      },
    );
  }
}
