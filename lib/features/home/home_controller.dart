import 'package:flutter/cupertino.dart';

import '../../core/api/remote_data/api_config.dart';
import '../../core/api/remote_data/api_service.dart';
import 'models/news_article_model.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  bool topHeadLineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  void getTopHeadLine() async {
    try {

      Map<String, dynamic> resalt = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},

      );

      newsTopHeadLineList = (resalt[ApiConfig.articles] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEverything() async {
    try {
      Map<String, dynamic> resalt = await apiService.get(
        ApiConfig.everything,
        params: {"q": "news"},
      );
      newsEverythingList = (resalt[ApiConfig.articles] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
