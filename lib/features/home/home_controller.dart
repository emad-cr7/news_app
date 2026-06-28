import 'package:flutter/cupertino.dart';
import 'package:news_app/features/home/repos/news_repository.dart';
import '../../core/api/remote_data/api_config.dart';
import '../../core/api/remote_data/api_service.dart';
import '../../core/enums/request_status.dart';
import 'models/news_article_model.dart';



class HomeController with ChangeNotifier {
  HomeController(this.newsRepository) {
    getTopHeadLine();
    getEverything();
  }


  RequestStatus everythingLoading = RequestStatus.loading;
  RequestStatus topHeadLineLoading = RequestStatus.loading;

  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEverythingList = [];

  String? errorMessage;
  String? selectedCategory;


  NewsRepository newsRepository ;





  void getTopHeadLine({String? category}) async {
    try {
      topHeadLineLoading = RequestStatus.loading;
      notifyListeners();

    newsTopHeadLineList = await newsRepository.getTopHeadLine(selectedCategory: selectedCategory );

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
      newsEverythingList =  await newsRepository.getEverything();
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