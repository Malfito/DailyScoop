import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/News_provider.dart';
import '../widgets/news_swipe_stack.dart';
import '../widgets/news_category_tabs.dart';
import '../widgets/bottom_nav_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedCategoryIndex = 0;
  bool hideTabs = false;
  int selectedTab = 0;

  final List<String> categories = ["All News", "at Chitradurga", "Business", "Sports"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false)
          .fetchNews(1, categories[selectedCategoryIndex]);
    });
  }

  void onTabChanged(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });

    Provider.of<NewsProvider>(context, listen: false)
        .fetchNews(1, categories[index]);
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
        title: const Text('Top News', style: TextStyle(color: Colors.black)),
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

                final parsedNews = provider.articles
                    .map((article) => {
                  "imageUrl": article.imageUrl,
                  "headline": article.title,
                  "description": article.description,
                  "category": article.category,
                  "timeAgo": "Just now",
                  "likes": 0,
                  "shares": 0,
                })
                    .toList();

                return NewsSwipeStack(
                  newsList: parsedNews,
                  onSwipeStarted: (bool hide) {
                    setState(() => hideTabs = hide);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedTab,
        onItemTapped: (int index) {
          setState(() => selectedTab = index);
        },
      ),
    );
  }
}
