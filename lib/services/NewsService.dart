import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/NewsArticleModel.dart';

class NewsService {
  static Future<List<NewsArticle>> fetchNews(int userId, String tab) async {
    final url = Uri.parse("http://localhost:9090/api/news/user/$userId?tab=$tab");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  // ✅ NEW: fetch by state only (used in HomeScreen for "Karnataka" / "International")
  static Future<List<NewsArticle>> fetchNewsByState(String state) async {
    final url = Uri.parse("http://localhost:9090/api/news/user/1?tab=All News&state=$state");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch $state news");
    }
  }
}
