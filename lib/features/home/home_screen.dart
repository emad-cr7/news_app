import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'components/categories_list.dart';
import 'components/top_headLine_screen/top_headLine.dart';
import 'components/trending_screen/trending_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  TrendingNews(),
                  CategoriesList(),
                  TopHeadline(),
                ],
              ),
            );
          },
    );
  }
}
