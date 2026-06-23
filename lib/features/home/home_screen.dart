import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'components/categories_list.dart';
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
                body: CustomScrollView(
                  slivers: [
                    TrendingNews(),
                    SliverToBoxAdapter(
                      child: ViewComponent(
                        title: 'Categories',
                        color: Colors.black,
                        onTap: () {},
                      ),
                    ),
                    CategoriesList(),
                    SliverList.builder(
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
                                child: Image.network(
                                  model.urlToImage ?? "",
                                  height: 80,
                                  width: 140,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, _) =>
                                      Container(
                                        height: 80,
                                        width: 140,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.broken_image),
                                      ),
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
                                                        model.author!.length,
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
                                                formatDateTime(
                                                  model.publishedAt ?? "",
                                                ).substring(
                                                  0,
                                                  min(model.author!.length, 10),
                                                ),
                                                style: TextStyle(
                                                  color: Color(0XFF141414),

                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                  ],
                ),
              );
            },
      ),
    );
  }

  String formatDateTime(String? date) {
    if (date == null) return "";

    final diff = DateTime.now().difference(DateTime.parse(date));

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    }

    if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    }

    return "${(diff.inDays / 30).floor()} months ago";
  }
}
