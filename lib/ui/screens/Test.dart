import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Scoop Demo',
      home: const DummyHomeScreen(),
    );
  }
}

class DummyHomeScreen extends StatelessWidget {
  const DummyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHomeAppBar(),
          Expanded(
            child: Center(
              child: Text(
                "Welcome to Daily Scoop!",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          // Background SVG pattern
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/wavy4.svg', // 👈 your wavy background SVG
              fit: BoxFit.cover,
            ),
          ),

          // Logo and Text and Notification Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Logo + Text
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2), // Thickness of border

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1399FF), // Dailyscoop Blue start
                                Color(0xFF5AA5DF), // Mid tone
                                Color(0xFF87C5F3), // End tone
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black, // Inner background
                              shape:  BoxShape.circle
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child:SvgPicture.asset('assets/DS_logo.svg',
                                width: 16,
                                height: 16,

                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),
                        const Text(
                          "DAILY SCOOP",
                          style: TextStyle(

                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.white,

                            fontWeight: FontWeight.w500,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Notification Icon with red dot
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {},
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
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
