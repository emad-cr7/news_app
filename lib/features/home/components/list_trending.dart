import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class ListTrending extends StatelessWidget {
  const ListTrending({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 16),
              itemCount: controller.newsEverythingList.take(10).length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 12),
              itemBuilder: (BuildContext context, int index) {
                final model = controller.newsEverythingList[index];
                return SizedBox(
                  width: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Stack(
                      children: [
                        if (model.urlToImage != null)
                          Image.network(
                            width: 240,
                            height: 140,
                            model.urlToImage!,
                          ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: ([
                                  Colors.black.withValues(alpha: 0.5),
                                  Colors.black.withValues(alpha: 0.7),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.title ?? "No title",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
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
                                          child: Text(
                                            model.author ?? "No author",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          formatDateTime(model.publishedAt),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
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
          },
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
