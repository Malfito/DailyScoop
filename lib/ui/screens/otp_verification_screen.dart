import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../services/auth_service.dart';
import '../../models/otp_verification_request.dart';
import '../widgets/rounded_otp_input.dart';
import '../widgets/animated_submit_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  // Create 6 controllers for the OTP input fields
  List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  String phone = "";

  // Animation controllers for fade and slide transitions
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);

    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1))
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _submitOtp() async {
    // Combine all OTP fields into one string
    String otp = _otpControllers.map((c) => c.text).join('');
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a 6-digit OTP")));
      return;
    }

    // Start animations
    _fadeController.forward();
    _slideController.forward();

    OtpVerificationRequest request =
    OtpVerificationRequest(otp: otp, phone: phone);
    var response = await AuthService.verifyOtp(request);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP Verified")));
      // Proceed further (e.g., navigate to home screen)
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Incorrect OTP")));
    }
  }

  void _resendOtp() async {
    var response = await AuthService.resendOtp(phone);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP Resent")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to resend OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the phone number passed as an argument from the signup screen.
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is String) {
      phone = args;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top fragment with black background
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: Stack(
                  children: [
                    // Full-Screen Background Image
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/waves_otp.svg', // Ensure the path is correct
                        fit: BoxFit.cover,  // Ensures it covers the parent
                        width: double.infinity, // Takes full width of parent
                        height: double.infinity/8, // Takes full height of parent
                      ),
                    ),

                    // Text with Image Background Effect
                    Padding(
                      padding: const EdgeInsets.all(20), // Ensures 20px padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                        children: [
                          // Logo
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                            child: SvgPicture.asset(
                              'assets/daily_scoop.svg', // Change to your actual SVG path
                              width: 118, // Adjust width as needed
                              height: 25, // Adjust height as needed
                            ),
                          ),

                          // Heading with Shader Effect
                          SizedBox(height: 80),
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade300, // Gradient effect
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcATop, // Applies shader to text
                            child: Text(
                              "Let’s Complete your\nVerification",
                              style: TextStyle(
                                fontFamily: 'PlayfairDisplay', // Set the font family
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ),

                          SizedBox(height: 5),

                          // Sign-in Text with GestureDetector
                          GestureDetector(
                            onTap: () {
                              // Navigate to Sign In screen (not implemented)
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Please enter the 6 digit OTP that we've sent to your email and mobile.",
                                style: TextStyle(
                                  fontFamily: 'Roboto', // Use Roboto font
                                  fontWeight: FontWeight.w200, // Set opacity to 700
                                  color: Colors.grey,
                                  fontSize: 12, // Adjust font size if needed
                                ),
                                children: [

                                ],
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),










              ),
            ),
            // Bottom fragment with white background
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // OTP input
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return RoundedOtpInput(
                          controller: _otpControllers[index],
                        );
                      }),
                    ),
                    SizedBox(height: 270),
                    AnimatedSubmitButton(
                      text: "Verify",
                      onPressed: _submitOtp,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Sign In screen (not implemented)
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't get the verification code? ",
                          style: TextStyle(
                            fontFamily: 'Roboto', // Use Roboto font
                            fontWeight: FontWeight.w500, // Set opacity to 700
                            color: Colors.grey,
                            fontSize: 12, // Adjust font size if needed
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to Sign In screen (replace with your function)
                                  print("Sign In Clicked");
                                },
                                child: Text(
                                  "Resend",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black, // Change color for better visibility
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
