import 'package:daily_scoop_phase_2/Provider/News_provider.dart';
import 'package:daily_scoop_phase_2/ui/screens/Category_selection.dart';
import 'package:daily_scoop_phase_2/ui/screens/Home_screen.dart';
import 'package:daily_scoop_phase_2/ui/screens/Publisher_selection.dart';
import 'package:daily_scoop_phase_2/ui/screens/news_screen.dart';
import 'package:daily_scoop_phase_2/ui/widgets/States_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_scoop_phase_2/ui/screens/Profile_screen.dart';
import 'package:daily_scoop_phase_2/ui/screens/State_selection.dart';

import 'Provider/Onboarding_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "DailyScoop",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    ),
  );

}
