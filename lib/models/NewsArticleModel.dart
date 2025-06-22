class NewsArticle {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String publisherName; // ✅ NEW

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.publisherName = "Unknown", // ✅ NEW
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      publisherName: json['publisherName'] ?? 'Unknown', // ✅ NEW
    );
  }
}
