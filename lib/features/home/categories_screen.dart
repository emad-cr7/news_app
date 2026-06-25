import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../core/extentions/date_time_extention.dart';
import '../../core/theme/light_color.dart';
import '../../core/widget/Custom_cached_network_image.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Consumer<HomeController>(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 16,
                      bottom: 24,
                    ),
                    child: SizedBox(
                      height: 35,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 12);
                        },
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 16),
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected =
                              categories[index] == controller.selectedCategory;
                          return IntrinsicWidth(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.updateSelectedCategory(
                                      categories[index],
                                    );
                                  },
                                  child: Text(
                                    categories[index][0].toUpperCase() +
                                        categories[index].substring(1),
                                    style: TextStyle(
                                      color: Color(0XFF363636),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(height: 4),

                                  Container(
                                    height: 2,
                                    color: LightColor.primaryColor,
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsTopHeadLineList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsTopHeadLineList[index];
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          backgroundImage:
                                              model.urlToImage != null
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
                                                        (model.author ??
                                                                "Not defined")
                                                            .length,
                                                        10,
                                                      ),
                                                    ),
                                                style: TextStyle(
                                                  color: Color(0XFF141414),

                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                model.publishedAt
                                                    .formatDateTime(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0XFF141414),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
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
                        );
                      },
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }

  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
}
