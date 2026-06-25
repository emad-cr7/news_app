import 'package:flutter/cupertino.dart';
import '../../core/api/remote_data/api_config.dart';
import '../../core/api/remote_data/api_service.dart';
import '../../core/enums/request_status.dart';
import 'models/news_article_model.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  RequestStatus everythingLoading = RequestStatus.loading;

  RequestStatus topHeadLineLoading = RequestStatus.loading;

  List<NewsArticleModel> newsTopHeadLineList = [];

  List<NewsArticleModel> newsEverythingList = [];

  ApiService apiService = ApiService();

  String? errorMessage;

  String? selectedCategory;

  void getTopHeadLine({String? category}) async {
    try {
       topHeadLineLoading = RequestStatus.loading;
       notifyListeners();
      Map<String, dynamic> resalt = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us" , "category" : selectedCategory},
      );

      newsTopHeadLineList = (resalt[ApiConfig.articles] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = RequestStatus.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = RequestStatus.error;
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
      everythingLoading = RequestStatus.loaded;
      errorMessage = null;
    } catch (e) {
      everythingLoading = RequestStatus.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    notifyListeners();
  }
}
