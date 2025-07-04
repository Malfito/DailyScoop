import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/News_provider.dart';
import '../widgets/news_swipe_stack.dart';
import '../widgets/news_category_tabs.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../models/NewsArticleModel.dart';

class NewsScreen extends StatefulWidget {
  final int initialIndex;
  final List<NewsArticle>? fullNewsList;
  final int? newsId;

  const NewsScreen({
    super.key,
    this.initialIndex = 0,
    this.fullNewsList,
    this.newsId,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedCategoryIndex = 0;
  bool hideTabs = false;
  int selectedTab = 0;
  int effectiveInitialIndex = 0;

  final List<String> categories = [
    "All News",
    "at Chitradurga",
    "Business",
    "Sports"
  ];

  late PageController _pageController;
  List<Map<String, dynamic>> parsedNews = [];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NewsProvider>(context, listen: false);

      provider.fetchNews(3, categories[selectedCategoryIndex]).then((_) {
        final articles = provider.articles;
        parsedNews = articles
            .map((article) => {
          "id": article.id,
          "imageUrl": article.imageUrl,
          "headline": article.title,
          "description": article.description,
          "category": article.category,
          "timeAgo": "Just now",
          "likes": 0,
          "shares": 0,
        })
            .toList();

        if (widget.newsId != null) {
          final index = articles.indexWhere((e) => e.id == widget.newsId);
          if (index != -1) {
            setState(() => effectiveInitialIndex = index);
          }
        } else {
          setState(() => effectiveInitialIndex = widget.initialIndex);
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabChanged(int index) {
    setState(() {
      selectedCategoryIndex = index;
      effectiveInitialIndex = 0; // ✅ reset index for new tab
    });

    Provider.of<NewsProvider>(context, listen: false)
        .fetchNews(3, categories[index]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: hideTabs
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title:
        const Text('Top News', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          if (!hideTabs)
            NewsCategoryTabs(
              categories: categories,
              selectedIndex: selectedCategoryIndex,
              onCategorySelected: onTabChanged,
            ),
          if (!hideTabs) const Divider(height: 1),
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.articles.isEmpty) {
                  return const Center(child: Text("No news found"));
                }

                parsedNews = provider.articles
                    .map((article) => {
                  "id": article.id,
                  "imageUrl": article.imageUrl,
                  "headline": article.title,
                  "description": article.description,
                  "category": article.category,
                  "timeAgo": "Just now",
                  "likes": 0,
                  "shares": 0,
                })
                    .toList();
                final safeIndex = effectiveInitialIndex.clamp(0, parsedNews.length - 1);
                return NewsSwipeStack(
                  newsList: parsedNews,
                  initialIndex: safeIndex,
                  onSwipeStarted: (bool hide) {
                    setState(() => hideTabs = hide);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavBar(
      //   selectedIndex: selectedTab,
      //   onItemTapped: (int index) {
      //     setState(() => selectedTab = index);
      //   },
      // ),
    );
  }
}
