import 'package:flutter/material.dart';
import '../models/NewsArticleModel.dart';
import '../services/NewsService.dart';

class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchNews(int userId, String tab) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await NewsService.fetchNews(userId, tab);
    } catch (e) {
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ NEW FIELDS & METHODS FOR HOMESCREEN NEWS

  List<NewsArticle> _karnatakaNews = [];
  List<NewsArticle> _internationalNews = [];

  List<NewsArticle> get karnatakaNews => _karnatakaNews;
  List<NewsArticle> get internationalNews => _internationalNews;

  bool _homeLoading = false;
  bool get homeLoading => _homeLoading;

  Future<void> fetchHomeScreenNews() async {
    _homeLoading = true;
    notifyListeners();

    try {
      _karnatakaNews = await NewsService.fetchNewsByState("Karnataka");
      _internationalNews = await NewsService.fetchNewsByState("International");
    } catch (e) {
      _karnatakaNews = [];
      _internationalNews = [];
    }

    _homeLoading = false;
    notifyListeners();
  }
}
