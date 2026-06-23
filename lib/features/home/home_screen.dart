import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'components/trending_news.dart';
import 'components/view_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                TrendingNews(),
                ViewComponent(
                  title: 'Categories',
                  color: Colors.black,
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12 , left: 16 , bottom: 24),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 12,);
                      },
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: Color(0XFF363636),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
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
      ),
    );
  }
}

final List<String> categories = [
  'Business',
  'Entertainment',
  'General',
  'Health',
  'Science',
  'Sports',
  'Technology',
];
