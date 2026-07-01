import 'package:flutter/cupertino.dart';
import '../../core/enums/request_status.dart';
import '../../core/mixins/safe_notify_mixin.dart';
import '../../core/repos/news_repository.dart';
import 'models/news_article_model.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixin {
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

  final BaseNewsRepository newsRepository;

  void getTopHeadLine({String? category}) async {
    try {
      topHeadLineLoading = RequestStatus.loading;
      safeNotify();

      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        selectedCategory: selectedCategory,
      );

      topHeadLineLoading = RequestStatus.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = RequestStatus.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything();
      everythingLoading = RequestStatus.loaded;
      errorMessage = null;
    } catch (e) {
      everythingLoading = RequestStatus.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    safeNotify();
  }
}
