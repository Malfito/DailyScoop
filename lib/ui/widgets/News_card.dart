import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String headline;
  final String description;
  final String category;
  final String timeAgo;
  final int likes;
  final int shares;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.headline,
    required this.description,
    required this.category,
    required this.timeAgo,
    required this.likes,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFF9F3FF),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with placeholder
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
              imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (ctx, error, stackTrace) => Image.asset(
                'assets/tesla.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : Image.asset(
              'assets/tesla.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headline, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 28),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: Text(category, style: const TextStyle(fontSize: 12)),
                    ),
                    const Spacer(),
                    Text(timeAgo, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    const Icon(Icons.favorite_border, size: 16),
                    Text(' $likes'),
                    const SizedBox(width: 8),
                    const Icon(Icons.share, size: 16),
                    Text(' $shares'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
