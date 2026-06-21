import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'list_trending.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(
              "assets/images/background_home.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text("NEWST", style: Theme.of(context).textTheme.displayLarge),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      InkWell(
                        onTap: () {},
                        child: Text(
                          "View all",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder:
                        (
                          BuildContext context,
                          HomeController controller,
                          Widget? child,
                        ) {
                          switch (controller.everythingLoading) {
                            case RequestStatus.loading:
                              return Center(child: CircularProgressIndicator());
                            case RequestStatus.error:
                              return Center(
                                child: Text(controller.errorMessage!),
                              );
                            case RequestStatus.loaded:
                              return ListTrending();
                          }
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
