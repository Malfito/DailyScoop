class NewsArticle {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String publisherName;
  final String? publisherLogo; // ✅ NEW
  final String? timeAgo;       // ✅ NEW

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.publisherName = "Unknown",
    this.publisherLogo,
    this.timeAgo,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      publisherName: json['publisher']?['name'] ?? 'Unknown',
      publisherLogo: json['publisher']?['logoUrl'],
      timeAgo: _formatTime(json['timestamp']), // ✅ Optional: format if timestamp given
    );
  }

  static String _formatTime(String? timestamp) {
    try {
      final dt = DateTime.parse(timestamp ?? '');
      final duration = DateTime.now().difference(dt);
      if (duration.inMinutes < 60) return '${duration.inMinutes}m ago';
      if (duration.inHours < 24) return '${duration.inHours}h ago';
      return '${duration.inDays}d ago';
    } catch (_) {
      return 'Just now';
    }
  }
}
