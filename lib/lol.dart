import 'package:flutter/material.dart';

void main() {
  runApp(DailyScoopApp());
}

class DailyScoopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Scoop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

///
/// SCREEN 1: Splash Screen
///
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for "Grow from Center" effect
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    // Stay on Splash Screen for 2 seconds, then navigate with fade-out transition.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        FadePageRoute(widget: OnboardingScreen1()),
      );
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // Tapping the logo triggers the scale animation.
        child: GestureDetector(
          onTap: () {
            if (!_scaleController.isAnimating) {
              _scaleController.forward();
            }
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/daily_scoop_logo.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

///
/// Custom Fade Transition Route
///
class FadePageRoute extends PageRouteBuilder {
  final Widget widget;
  FadePageRoute({required this.widget})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

///
/// SCREEN 2: Onboarding Screen 1
///
class OnboardingScreen1 extends StatefulWidget {
  @override
  _OnboardingScreen1State createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _bottomSheetController;
  late Animation<Offset> _bottomSheetAnimation;

  @override
  void initState() {
    super.initState();
    // Animate the bottom sheet sliding up from the bottom.
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _bottomSheetAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _bottomSheetController,
      curve: Curves.easeOut,
    ));
    _bottomSheetController.forward();
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background: Stack of newspapers image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/newspapers.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bottom sheet drawer
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _bottomSheetAnimation,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Stay Updated, Stay Ahead",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Discover the latest news tailored to your interests. Your gateway to trustworthy stories and trending updates starts here.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 'Prev' Button (disabled)
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: Text("Prev"),
                        ),
                        // 'Next' Button (active)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadePageRoute(widget: OnboardingScreen2()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Pagination dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First dot: elongated and black
                        Container(
                          width: 20,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 5),
                        // Second dot: gray and small
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        // Third dot: gray and small
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// SCREEN 3: Onboarding Screen 2
///
class OnboardingScreen2 extends StatefulWidget {
  @override
  _OnboardingScreen2State createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<Offset> _bgAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();
    // Background "Wave from Left" animation
    _bgController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _bgAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeOut,
    ));

    // Text "Rise from Bottom" animation
    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _textAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _bgController.forward();
    _textController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background: Man giving a speech
          SlideTransition(
            position: _bgAnimation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/man_speech.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Bottom sheet with text and buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _textAnimation,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "News, Your Way",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your personalized news experience awaits. Dive into the stories that matter to you.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 'Prev' Button (active)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.white,
                          ),
                          child: Text(
                            "Prev",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // 'Next' Button (active)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadePageRoute(widget: OnboardingScreen3()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Pagination dots with simulated liquid-like animation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First dot: gray
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        // Second dot: enlarged and black
                        Container(
                          width: 20,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 5),
                        // Third dot: gray
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// SCREEN 4: Onboarding Screen 3
///
class OnboardingScreen3 extends StatefulWidget {
  @override
  _OnboardingScreen3State createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<Offset> _bgAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();
    // Background animation: Wave from Left
    _bgController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _bgAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeOut,
    ));

    // Text animation: Rise from Bottom
    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _textAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _bgController.forward();
    _textController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background: Red pencil ticking a checkbox image
          SlideTransition(
            position: _bgAnimation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/red_pencil.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Bottom sheet with text and "Get Started" button
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _textAnimation,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Engage and Share",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Join the conversation and share your insights with a community that values your voice.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // "Get Started" Button with arrow icon
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          FadePageRoute(widget: MainScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Get Started"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Pagination dots: third dot enlarged and black
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First dot: gray
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        // Second dot: gray
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        // Third dot: enlarged and black
                        Container(
                          width: 20,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// MAIN APPLICATION SCREEN (After Onboarding)
///
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Scoop"),
      ),
      body: Center(
        child: Text(
          "Welcome to the Main App Screen!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
