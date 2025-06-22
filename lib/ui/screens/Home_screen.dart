import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/News_provider.dart';
import '../../models/NewsArticleModel.dart';
import '../widgets/Bottom_nav_bar.dart';
import '../widgets/Home_app_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> trendingHashtags = [
    '#AIRevolution',
    '#FIFAWorldCup',
    '#HollywoodNews',
    '#StockMarket',
  ];

  final List<Map<String, String>> topPublishers = [
    {
      'name': 'CNN',
      'region': 'Top in Karnataka',
      'logoUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'BBC News',
      'region': 'Top in Karnataka',
      'logoUrl': 'https://via.placeholder.com/100',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<NewsProvider>(context, listen: false).fetchHomeScreenNews();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: const HomeAppBar(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔴 Karnataka News
              _buildSectionTitle('Top News in Karnataka'),
              if (newsProvider.karnatakaNews.isNotEmpty)
                _buildLargeNewsCard(_toMap(newsProvider.karnatakaNews[0]), screenWidth),
              if (newsProvider.karnatakaNews.length > 2)
                _buildHorizontalNewsList(
                  _toMapList(newsProvider.karnatakaNews.sublist(1, 3)),
                  screenWidth,
                ),
              if (newsProvider.karnatakaNews.length > 4)
                _buildHorizontalNewsList(
                  _toMapList(newsProvider.karnatakaNews.sublist(3, 5)),
                  screenWidth,
                ),

              _buildSectionTitle('Trending Hashtags', showSeeAll: true),
              _buildHashtagList(),

              // 🌍 International News
              _buildSectionTitle('Top News in International'),
              if (newsProvider.internationalNews.isNotEmpty)
                _buildLargeNewsCard(_toMap(newsProvider.internationalNews[0]), screenWidth),
              if (newsProvider.internationalNews.length > 2)
                _buildHorizontalNewsList(
                  _toMapList(newsProvider.internationalNews.sublist(1, 3)),
                  screenWidth,
                ),
              if (newsProvider.internationalNews.length > 4)
                _buildHorizontalNewsList(
                  _toMapList(newsProvider.internationalNews.sublist(3, 5)),
                  screenWidth,
                ),

              _buildSectionTitle('Top Publishers in Karnataka', showSeeAll: true),
              _buildPublisherList(screenWidth),

              const SizedBox(height: 20),
              _buildFeedbackSection(),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _toMap(NewsArticle article) => {
    'title': article.title,
    'description': article.description,
    'imageUrl': article.imageUrl,
    'publisher': article.publisherName,
    'timeAgo': 'Just now',
  };

  List<Map<String, dynamic>> _toMapList(List<NewsArticle> list) =>
      list.map((a) => _toMap(a)).toList();

  Widget _buildSectionTitle(String title, {bool showSeeAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          if (showSeeAll)
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
        ],
      ),
    );
  }

  Widget _buildLargeNewsCard(Map<String, dynamic> news, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(news['imageUrl'],
                  height: screenWidth * 0.5,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  if (news['description'] != null)
                    Text(news['description'],
                        style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('${news['publisher']} • ${news['timeAgo']}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalNewsList(
      List<Map<String, dynamic>> newsList, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return Container(
            width: screenWidth * 0.45,
            margin: const EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(news['imageUrl'],
                        height: screenWidth * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      news['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${news['publisher']} • ${news['timeAgo']}',
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHashtagList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: trendingHashtags.map((tag) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title:
            Text(tag, style: const TextStyle(fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPublisherList(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: topPublishers.map((publisher) {
          return Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.network(publisher['logoUrl']!,
                      height: screenWidth * 0.15),
                  const SizedBox(height: 8),
                  Text(publisher['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(publisher['region']!,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: () {}, child: const Text('Add')),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Center(
      child: Column(
        children: [
          const Text('Enjoying the app?', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Rate Us'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
