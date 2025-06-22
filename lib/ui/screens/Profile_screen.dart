import 'package:flutter/material.dart';
import '../widgets/Bottom_nav_bar.dart';
import '../widgets/ProfileHeader.dart';
import '../widgets/UserLevel_widget.dart';
import '../widgets/activity_screen_widget.dart';
import '../widgets/leaderboard_widget.dart';

import '../widgets/activity_list.dart';
import '../widgets/stats_grid_widget.dart';
import '../screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  int _selectedIndex = 3; // Profile ka tab number
  void _onItemTapped(int index) {
    // Tu yahan navigation kar sakta hai
    print('Tapped $index');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                onEditTap: () { // Callback for Edit button
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              LevelProgressCard(),
              SizedBox(height: 20),
              LeaderboardCard(),
              SizedBox(height: 20),
              StatsGrid(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActivityScreen()),
                      );
                    },
                    child: Text("See All", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              ActivityList(showAll: false),
            ],
          ),
        ),
      ),
    );
  }
}
