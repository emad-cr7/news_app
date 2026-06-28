import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/view_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../categories_screen.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  ViewComponent(
                    title: 'Categories',
                    color: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ChangeNotifierProvider.value(
                              value: controller,
                              child: CategoriesScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppSizes.ph16,
                      left: AppSizes.pw16,
                      bottom: AppSizes.ph16,
                    ),
                    child: SizedBox(
                      height: AppSizes.h35,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: AppSizes.pw12);
                        },
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: AppSizes.pw16),
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
                                      fontSize: AppSizes.sp16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(height: AppSizes.ph4),

                                  Container(
                                    height: AppSizes.h2,
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
                ],
              ),
            );
          },
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
