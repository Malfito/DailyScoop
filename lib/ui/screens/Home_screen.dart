import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Provider/News_provider.dart';
import '../../routes.dart';
import '../../models/NewsArticleModel.dart';
import '../widgets/Bottom_nav_bar.dart';
import '../widgets/Home_app_bar.dart';
import 'Test.dart';



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

    final allNews = [
      ...newsProvider.karnatakaNews,
      ...newsProvider.internationalNews,
    ];

    return Scaffold(
      // appBar: const HomeAppBar(),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHomeAppBar(),
              buildQuickActions(),
              _buildSectionTitle('Top News in Karnataka'),
              if (newsProvider.karnatakaNews.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    final tappedArticle = newsProvider.karnatakaNews[0];
                    final allNews = [
                      ...newsProvider.karnatakaNews,
                      ...newsProvider.internationalNews,
                    ];
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsScreen,
                      arguments: {
                        'newsId': tappedArticle.id,
                        'newsList': allNews,
                      },
                    );
                  },
                  child: _buildLargeNewsCard(
                    _toMap(newsProvider.karnatakaNews[0]),
                    screenWidth,
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: 0.6,
                  color: Color(0xFFF3F3F3),
                ),
              ),
              if (newsProvider.karnatakaNews.length > 2)
                _buildHorizontalNewsList(
                  newsProvider.karnatakaNews.sublist(1, 3),
                  screenWidth,
                  newsProvider,
                ),
              if (newsProvider.karnatakaNews.length > 4)
                _buildHorizontalNewsList(
                  newsProvider.karnatakaNews.sublist(3, 5),
                  screenWidth,
                  newsProvider,
                ),

              _buildSectionTitle('Trending Hashtags', showSeeAll: true),
              _buildHashtagList(),

              _buildSectionTitle('Top News in International'),
              if (newsProvider.internationalNews.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    final tappedArticle = newsProvider.internationalNews[0];
                    final allNews = [
                      ...newsProvider.karnatakaNews,
                      ...newsProvider.internationalNews,
                    ];
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsScreen,
                      arguments: {
                        'newsId': tappedArticle.id,
                        'newsList': allNews,
                      },
                    );
                  },
                  child: _buildLargeNewsCard(
                    _toMap(newsProvider.internationalNews[0]),
                    screenWidth,
                  ),
                ),
              if (newsProvider.internationalNews.length > 2)
                _buildHorizontalNewsList(
                  newsProvider.internationalNews.sublist(1, 3),
                  screenWidth,
                  newsProvider,
                ),
              if (newsProvider.internationalNews.length > 4)
                _buildHorizontalNewsList(
                  newsProvider.internationalNews.sublist(3, 5),
                  screenWidth,
                  newsProvider,
                ),

              _buildSectionTitle('Top Publishers in Karnataka', showSeeAll: true),
              _buildPublisherList(screenWidth),
              const SizedBox(height: 20),
              _buildFeedbackCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

    );
  }

  Map<String, dynamic> _toMap(NewsArticle article) => {
    'title': article.title,
    'description': article.description,
    'imageUrl': article.imageUrl,
    'publisher': article.publisherName,
    'publisherLogo': article.publisherLogo, // <-- added
    'timeAgo': article.timeAgo ?? 'Just now',
  };


  Widget _buildSectionTitle(String title, {bool showSeeAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:  TextStyle(fontSize: 18,
              fontFamily: 'Brygada 1918',
              )),
          if (showSeeAll)
            TextButton(
              onPressed: () {},
              child: const Text('See All', style:
                TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1399FF)

                ),),
            ),
        ],
      ),
    );
  }

  Widget _buildLargeNewsCard(Map<String, dynamic> news, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                news['imageUrl'],
                height: screenWidth * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Brygada 1918'
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (news['description'] != null)
                    DefaultTextStyle.merge(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey,
                      ),
                      child: Text(
                        news['description'],
                        textAlign: TextAlign.start,
                      ),
                    ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage:
                        NetworkImage(news['publisherLogo'] ?? ''),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: news['publisher'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' • ${news['timeAgo']}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.italic, // only this part italic
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildHorizontalNewsList(
      List<NewsArticle> articles,
      double screenWidth,
      NewsProvider provider,
      ) {
    final allNews = [
      ...provider.karnatakaNews,
      ...provider.internationalNews,
    ];

    return SizedBox(
      height: screenWidth * 0.55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          final news = _toMap(article);

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.newsScreen,
                arguments: {
                  'newsId': article.id,
                  'newsList': allNews,
                },
              );
            },
            child: Container(
              color: Colors.white,
              width: screenWidth * 0.45,
              margin: const EdgeInsets.all(8),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 0,
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
                            fontWeight: FontWeight.bold, fontSize: 14,
                        fontFamily:'Brygada 1918' ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundImage:
                            NetworkImage(news['publisherLogo'] ?? ''),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: news['publisher'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' • ${news['timeAgo']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic, //  only this part italic
                                    ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHashtagList() {
    final hashtagData = [
      {'tag': '#AIRevolution', 'posts': '1.2K Posts'},
      {'tag': '#FIFAWorldCup', 'posts': '1K Posts'},
      {'tag': '#HollywoodNews', 'posts': '934 Posts'},
      {'tag': '#StockMarket', 'posts': '754 Posts'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: List.generate(hashtagData.length, (index) {
            final item = hashtagData[index];
            return Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: Text(
                    item['tag']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item['posts']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                // Add divider except after last item
                if (index < hashtagData.length - 1)
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                    indent: 12,
                    endIndent: 12,
                  ),
              ],
            );
          }),
        ),
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
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: screenWidth * 0.075,
                    backgroundImage: NetworkImage(publisher['logoUrl']!),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    publisher['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    publisher['region']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ✅ Custom black rounded "Add" button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Handle Add tap
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildQuickActions() {
    final items = [
      {'icon': 'assets/kannada.svg', 'label': 'Kannada'},
      {'icon': 'assets/Marketprice.svg', 'label': 'Marketprice'},
      {'icon': 'assets/Highlights.svg', 'label': 'Highlights'},
      {'icon': 'assets/Polling.svg', 'label': 'Polling'},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔘 Gray circle with SVG inside
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1), // light grey
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  item['icon']!,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['label']!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ],
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
  Widget _buildFeedbackCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          // Top Emoji Line with Dividers
          Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                  endIndent: 12,
                ),
              ),
              // 👇 Use your own SVG asset path here
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3C0),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF3C0),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '🤩', // 👈 your emoji here
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                  indent: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bold Title
          const Text(
            'Enjoying the app?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Rate us and share your thoughts to make Daily Scoop even better!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 16),

          // Rate Us CTA
          GestureDetector(
            onTap: () {
              // Handle tap
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Rate Us',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
