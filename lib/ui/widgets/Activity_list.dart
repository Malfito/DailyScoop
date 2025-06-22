import 'package:flutter/material.dart';

class ActivityList extends StatelessWidget {
  final bool showAll;
  ActivityList({required this.showAll}); // Ensure `showAll` is required

  final List<Map<String, dynamic>> activityData = [
    {"title": "Newcomer", "date": "Dec 12, 2024", "points": null, "achieved": true},
    {"title": "Curious Reader", "date": "Jan 15, 2025", "points": null, "achieved": true},
    {"title": "Insight Seeker", "points": "169/200", "achieved": false},
    {"title": "Headline Hunter", "points": "169/350", "achieved": false},
    {"title": "Insight Seeker", "points": "169/500", "achieved": false},
    {"title": "Trend Watcher", "points": "169/650", "achieved": false},
    {"title": "News Navigator", "points": "169/800", "achieved": false},
    {"title": "Daily Scoop Guru", "points": "169/1000", "achieved": false},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedActivities =
    showAll ? activityData : activityData.take(2).toList(); // Limit if `showAll` is false

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedActivities.length,
      itemBuilder: (context, index) {
        bool isAchieved = displayedActivities[index]["achieved"];
        bool isLastItem = index == displayedActivities.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Timeline with Dots & Icons
            Column(
              children: [
                Icon(
                  isAchieved ? Icons.check_circle : Icons.lock,
                  color: isAchieved ? Colors.green : Colors.grey,
                  size: 24,
                ),
                if (!isLastItem) // Avoid extra line at last item
                  Container(
                    width: 2,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10),

            // Activity Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(displayedActivities[index]["title"],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  if (isAchieved)
                    Text("Obtained on ${displayedActivities[index]["date"]}",
                        style: TextStyle(color: Colors.grey))
                  else
                    Text("To be obtained - ${displayedActivities[index]["points"]}",
                        style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
