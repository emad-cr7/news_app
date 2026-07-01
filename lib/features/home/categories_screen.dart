import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import '../../core/theme/light_color.dart';
import 'components/news_item_categorie.dart';

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
                    padding:  EdgeInsets.only(
                      top: AppSizes.ph20,
                      left: AppSizes.pw12,
                      bottom: AppSizes.ph12,
                    ),
                    child: SizedBox(
                      height:AppSizes.h35,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width:AppSizes.w12);
                        },
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right:AppSizes.pw12),
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
                                    categories[index][0].toUpperCase() + categories[index].substring(1),
                                    style: TextStyle(
                                      color: Color(0XFF363636),
                                      fontSize: AppSizes.h16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(height:AppSizes.h4),

                                  Container(
                                    height:AppSizes.h2,
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
                        return NewsItem(model: model);
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
