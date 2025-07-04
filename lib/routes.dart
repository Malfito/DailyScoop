import 'package:daily_scoop_phase_2/ui/screens/MAIN_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_scoop_phase_2/ui/screens/Home_screen.dart';
import 'package:daily_scoop_phase_2/ui/screens/State_selection.dart';
import 'package:daily_scoop_phase_2/ui/screens/news_screen.dart';

class AppRoutes {
  static const String stateSelection = '/';
  static const String home = '/home';
  static const String newsScreen = '/news';
  static const String Mainscreen = '/Mainscreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case stateSelection:
        return MaterialPageRoute(builder: (_) => StateSelectionScreen());

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case newsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => NewsScreen(
            initialIndex: args['initialIndex'] ?? 0,
            fullNewsList: args['newsList'], // optional but added
            newsId: args['newsId'], // ✅ New addition
          ),
        );
      case Mainscreen:
        return MaterialPageRoute(builder: (_) =>MainScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
