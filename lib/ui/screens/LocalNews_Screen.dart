import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/News_provider.dart';
import '../widgets/news_swipe_stack.dart';
import '../../models/NewsArticleModel.dart';

class LocalNewsScreen extends StatefulWidget {
  const LocalNewsScreen({super.key});

  @override
  State<LocalNewsScreen> createState() => _LocalNewsScreenState();
}

class _LocalNewsScreenState extends State<LocalNewsScreen> {
  bool hideTabs = false;
  int effectiveInitialIndex = 0;

  String selectedDistrict = 'Chitradurga';
  String tempSelectedDistrict = 'Chitradurga';

  final List<String> districts = [
    'Bagalkot',
    'Bengaluru Urban',
    'Bengaluru Rural',
    'Belagavi',
    'Ballari',
    'Vijayapur',
    'Chikkaballapur',
    'Chikkamagaluru',
    'Chitradurga',
    'Kalaburagi',
    'Hassan',
    'Kodagu',
    'Koppal',
    'Mandya',
    'Mysuru',
  ];

  late PageController _pageController;
  List<Map<String, dynamic>> parsedNews = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NewsProvider>(context, listen: false);
      provider.fetchNews(3, 'at $selectedDistrict').then((_) {
        final articles = provider.articles;
        parsedNews = articles.map((article) => {
          "id": article.id,
          "imageUrl": article.imageUrl,
          "headline": article.title,
          "description": article.description,
          "category": article.category,
          "timeAgo": "Just now",
          "likes": 0,
          "shares": 0,
        }).toList();
      });
    });
  }

  void _showDistrictPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select a District", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: districts.length,
                  itemBuilder: (context, index) {
                    return RadioListTile<String>(
                      title: Text(districts[index]),
                      value: districts[index],
                      groupValue: tempSelectedDistrict,
                      onChanged: (value) {
                        setState(() => tempSelectedDistrict = value!);
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedDistrict = tempSelectedDistrict;
                    effectiveInitialIndex = 0;
                  });
                  Provider.of<NewsProvider>(context, listen: false)
                      .fetchNews(3, 'at $selectedDistrict');
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: GestureDetector(
          onTap: _showDistrictPicker,
          child: Row(
            children: [
              const Text("At ",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Text(selectedDistrict,
                  style: const TextStyle(color: Colors.black)),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            ],
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.articles.isEmpty) {
                  return const Center(child: Text("No news found"));
                }

                parsedNews = provider.articles.map((article) => {
                  "id": article.id,
                  "imageUrl": article.imageUrl,
                  "headline": article.title,
                  "description": article.description,
                  "category": article.category,
                  "timeAgo": "Just now",
                  "likes": 0,
                  "shares": 0,
                }).toList();

                final safeIndex =
                effectiveInitialIndex.clamp(0, parsedNews.length - 1);

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
    );
  }
}
