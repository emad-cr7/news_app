import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

import '../../../core/extentions/date_time_extention.dart';
import '../../../core/widget/Custom_cached_network_image.dart';
import '../../../core/widget/custom_svg_picture.dart';

class NewsItemCategorie extends StatelessWidget {
  const NewsItemCategorie({super.key, required this.model});

  final NewsArticleModel model ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(
              imagePath: model.urlToImage ?? "",
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: model.urlToImage != null
                          ? NetworkImage(model.urlToImage!)
                          : null,
                      radius: 12,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            (model.author ?? "Not defined")
                                .substring(
                              0,
                              min(
                                (model.author ?? "Not defined")
                                    .length,
                                10,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0XFF141414),

                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              model.publishedAt.formatDateTime(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFF141414),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomSvgPicture.withColor(
                            path: "assets/images/bookMark.svg",
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
    );
  }
}
