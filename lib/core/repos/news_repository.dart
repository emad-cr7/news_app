
import '../../features/home/models/news_article_model.dart';
import '../datasource/remote_data/api_config.dart';
import '../datasource/remote_data/api_service.dart';


abstract class BaseNewsRepository{

  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory = "general",});
  Future<List<NewsArticleModel>> getEverything({String? query = "news"});
}

class NewsRepository extends BaseNewsRepository{
  NewsRepository(this.apiService);

  final BaseApiService apiService ;


  @override
  Future<List<NewsArticleModel>>
  getTopHeadLine({String? selectedCategory = "general",}) async {
    Map<String, dynamic> result = await ApiService().get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (result[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    Map<String, dynamic> result = await ApiService().get(ApiConfig.everything,
      params: {"q": query},
    );
    return (result[ApiConfig.articles] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
