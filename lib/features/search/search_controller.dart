import 'package:flutter/cupertino.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

import '../../core/enums/request_status.dart';
import '../../core/repos/news_repository.dart';
import '../home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixin{

  SearchScreenController(this.newsRepository);

final  BaseNewsRepository newsRepository ;
  TextEditingController searchController = TextEditingController();



  List<NewsArticleModel> newsEverythingList = [];
  RequestStatus everythingLoading = RequestStatus.loading;
  String? errorMessage;


  void getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything(query:searchController.text);
      everythingLoading = RequestStatus.loaded;
      errorMessage = null;
    } catch (e) {
      everythingLoading = RequestStatus.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

}