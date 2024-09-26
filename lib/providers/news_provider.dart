import 'package:flutter/material.dart';
import 'package:lingoganda_news/models/news.dart';
import 'package:lingoganda_news/models/user_model.dart';
import 'package:lingoganda_news/services/auth_services.dart';
import 'package:lingoganda_news/services/news_services.dart';
import 'package:lingoganda_news/utils/api_utils/api_response_state.dart';

class NewsViewModel extends ChangeNotifier {
  ApiResponseState<List<Articles>> _articles = ApiResponseState.initial();
  ApiResponseState<List<Articles>> get articles => _articles;

  ApiResponseState<UserModel> _userData = ApiResponseState.initial();
  ApiResponseState<UserModel> get userData => _userData;

  final AuthService _authService = AuthService();
  final NewsServices _newsServices = NewsServices();

  String? countryRemoteConfig; // default value
  String? get apiBaseUrl => countryRemoteConfig;

  Future<void> fetchArticles() async {
    _articles = ApiResponseState.loading();
    notifyListeners();
    try {
      final fetchedArticles =
          await _newsServices.fetchNews(country: countryRemoteConfig ?? "us");
      _articles = ApiResponseState.completed(fetchedArticles);
    } catch (e) {
      _articles = ApiResponseState.error(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchRemoteConfig() async {
    try {
      countryRemoteConfig = await _authService.fetchRemoteConfig();
    } catch (e) {
      countryRemoteConfig = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchUserDetails({required String email}) async {
    _userData = ApiResponseState.loading();
    try {
      final userDetails = await _authService.fetchUserData(email);
      _userData = ApiResponseState.completed(userDetails);
    } catch (e) {
      _userData = ApiResponseState.error(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> storeUserDetails(
      {required String email, required String username}) async {
    try {
      await _authService.addUserToFirestore(email: email, name: username);
    } catch (e) {
      notifyListeners();
    }
  }
}
