import '../../../core/api/remote_data/api_config.dart';
import '../../../core/api/remote_data/api_service.dart';
import '../models/news_article_model.dart';

class NewsRepository {
  ApiService apiService = ApiService();

  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory,}) async {
    Map<String, dynamic> resalt = await apiService.get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (resalt[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  Future<List<NewsArticleModel>> getEverything() async {
    Map<String, dynamic> resalt = await apiService.get(
      ApiConfig.everything,
      params: {"q": "news"},
    );
    return (resalt[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
