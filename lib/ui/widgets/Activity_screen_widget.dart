import 'package:flutter/material.dart';
import '../widgets/activity_list.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Activity")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActivityList(showAll: true), // FIXED: Passed required parameter
      ),
    );
  }
}
