import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

import '../../core/extentions/date_time_extention.dart';
import '../../core/widget/Custom_cached_network_image.dart';
import '../../core/widget/custom_svg_picture.dart';
import '../home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.ph20),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CustomCachedNetworkImage(
                  imagePath: model.urlToImage ?? "",
                  height: AppSizes.h240,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                model.title ?? "",
                maxLines: 2,
                style: TextStyle(
                  fontSize: AppSizes.sp20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff141414),
                ),
              ),
              SizedBox(height: AppSizes.h16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: model.urlToImage != null
                        ? NetworkImage(model.urlToImage!)
                        : null,
                    radius: AppSizes.r12,
                  ),
                  SizedBox(width: AppSizes.w8),
                  Text(
                    (model.author ?? "Not defined").substring(0,
                      min((model.author ?? "Not defined").length, 10),
                    ),
                    style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: AppSizes.sp12,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: AppSizes.w12),
                  Text(
                    model.publishedAt.formatDateTime(),
                    style: TextStyle(
                      fontSize: AppSizes.sp12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff363636),
                    ),
                  ),
                  Spacer(),
                  CustomSvgPicture.withColor(
                    path: "assets/images/bookMark.svg",
                    width:AppSizes.w14 ,
                    height:AppSizes.h18 ,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                model.description ?? "",
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff141414),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
