import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> stats = [
    {"label": "12 Hrs", "icon": Icons.access_time},
    {"label": "246", "icon": Icons.article},
    {"label": "27", "icon": Icons.bookmark},
    {"label": "365", "icon": Icons.thumb_up},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(stats[index]["icon"], color: Colors.black),
                SizedBox(width: 8),
                Text(stats[index]["label"], style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}
