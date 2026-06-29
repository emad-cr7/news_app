import '../../../core/api/remote_data/api_config.dart';
import '../../../core/api/remote_data/api_service.dart';
import '../models/news_article_model.dart';


abstract class BaseNewsRepository{

  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory = "general",});
  Future<List<NewsArticleModel>> getEverything();
}

class NewsRepository extends BaseNewsRepository{
  NewsRepository(this.apiService);

  final BaseApiService apiService ;


  @override
  Future<List<NewsArticleModel>>
  getTopHeadLine({String? selectedCategory = "general",}) async {
    Map<String, dynamic> resalt = await ApiService().get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (resalt[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>>
  getEverything() async {
    Map<String, dynamic> resalt = await ApiService().get(
      ApiConfig.everything,
      params: {"q": "news"},
    );
    return (resalt[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
