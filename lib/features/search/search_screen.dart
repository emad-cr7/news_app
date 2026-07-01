import 'package:flutter/material.dart';
import 'package:news_app/core/api/remote_data/api_service.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          SearchScreenController(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(title: Text("Search")),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Consumer<SearchScreenController>(
            builder:
                (
                  BuildContext context,
                  SearchScreenController controller,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getEverything();
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xffA0A0A0),
                            size: AppSizes.r25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.newsEverythingList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final model = controller.newsEverythingList[index];
                            return Padding(
                              padding:  EdgeInsets.all(AppSizes.w8),
                              child: ListTile(
                                leading: Icon(
                                  Icons.search,
                                  color: Color(0xffA0A0A0),
                                  size: AppSizes.r20,
                                ),
                                title: Text(
                                  model.title!,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: AppSizes.sp16),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: Color(0xFFA0A0A0));
                          },
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }
}
