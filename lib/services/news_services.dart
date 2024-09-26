import 'package:lingoganda_news/models/news.dart';
import 'package:lingoganda_news/services/api_core/api_core_service.dart';

class NewsServices {
  ApiCoreService appCoreServices = ApiCoreService();

  Future<List<Articles>> fetchNews({String? country}) async {
    try {
      final response = await appCoreServices
          .get('/top-headlines', params: {'country': country});
      final List articlesJson = response.data['articles'];
      return articlesJson.map((json) => Articles.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
