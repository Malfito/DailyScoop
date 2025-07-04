// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../services/auth_service.dart';
// import '../../models/signup_request.dart';
// import '../../services/custom_text_field.dart';
//
// import '../widgets/animated_submit_button.dart';
// import 'otp_verification_screen.dart';
//
// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen>
//     with TickerProviderStateMixin {
//   // Controllers for form fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _passwordVisible = false;
//   final _formKey = GlobalKey<FormState>();
//
//   // Animation controllers for fade and slide transitions
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//   late AnimationController _slideController;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _passwordVisible = false;
//
//     _fadeController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _fadeAnimation =
//         Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);
//
//     _slideController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1))
//         .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeIn));
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _submitSignup() async {
//     // Validate form fields
//     if (_nameController.text.isEmpty ||
//         _emailController.text.isEmpty ||
//         _phoneController.text.isEmpty ||
//         _passwordController.text.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("All fields are required")));
//       return;
//     }
//     if (!_validateEmail(_emailController.text)) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Enter a valid email")));
//       return;
//     }
//     if (_passwordController.text.length < 6) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Password too short")));
//       return;
//     }
//
//     // Start animations
//     _fadeController.forward();
//     _slideController.forward();
//
//     // Wait for the animation to complete before proceeding
//     await Future.delayed(Duration(milliseconds: 500));
//
//     // Create a signup request
//     SignupRequest request = SignupRequest(
//       name: _nameController.text,
//       email: _emailController.text,
//       phone: _phoneController.text,
//       password: _passwordController.text,
//     );
//
//     // Call the signup API
//     var response = await AuthService.signup(request);
//
//     if (response.statusCode == 200) {
//       // After signup success, trigger a fade-out effect
//       _fadeController.reverse().then((_) {
//         // Navigate to the OTP verification screen using ModalRoute arguments
//         Navigator.pushNamed(
//           context,
//           '/otp',
//           arguments: _phoneController.text, // Passing phone number as argument
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Signup failed")));
//     }
//   }
//
//
//
//   bool _validateEmail(String email) {
//     return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       // Using SingleChildScrollView for smaller screens
//       body:Stack(
//         children: [ Positioned.fill(
//           child: SvgPicture.asset(
//             'assets/waves.svg',
//             fit: BoxFit.cover, // Ensures full background coverage
//           ),
//         ), SingleChildScrollView(
//           child: Column(
//             children: [
//               // Top fragment with black background
//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Container(
//                   color: Colors.black,
//                   padding: EdgeInsets.all(5),
//                   width: double.infinity,
//                   child: Stack(
//                     children: [
//                       // Full-Screen Background Image
//                       Positioned.fill(
//                         child: SvgPicture.asset(
//                           'assets/waves.svg', // Ensure the path is correct
//                           fit: BoxFit.cover,  // Ensures it covers the parent
//                           width: double.infinity, // Takes full width of parent
//                           height: double.infinity/8, // Takes full height of parent
//                         ),
//                       ),
//
//                       // Text with Image Background Effect
//                       Padding(
//                         padding: const EdgeInsets.all(20), // Ensures 20px padding
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
//                           children: [
//                             // Logo
//                             Padding(
//                               padding: const EdgeInsets.only(top: 40.0, bottom: 20),
//                               child: SvgPicture.asset(
//                                 'assets/daily_scoop.svg', // Change to your actual SVG path
//                                 width: 118, // Adjust width as needed
//                                 height: 25, // Adjust height as needed
//                               ),
//                             ),
//
//                             // Heading with Shader Effect
//                             SizedBox(height: 80),
//                             ShaderMask(
//                               shaderCallback: (Rect bounds) {
//                                 return LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     Colors.grey.shade300, // Gradient effect
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ).createShader(bounds);
//                               },
//                               blendMode: BlendMode.srcATop, // Applies shader to text
//                               child: Text(
//                                 "Let’s Create an Account",
//                                 style: TextStyle(
//                                   fontFamily: 'PlayfairDisplay', // Set the font family
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                             ),
//
//                             SizedBox(height: 5),
//
//                             // Sign-in Text with GestureDetector
//                             GestureDetector(
//                               onTap: () {
//                                 // Navigate to Sign In screen (not implemented)
//                               },
//                               child: RichText(
//                                 text: TextSpan(
//                                   text: "Already have an account? ",
//                                   style: TextStyle(
//                                     fontFamily: 'Roboto', // Use Roboto font
//                                     fontWeight: FontWeight.w200, // Set opacity to 700
//                                     color: Colors.grey,
//                                     fontSize: 12, // Adjust font size if needed
//                                   ),
//                                   children: [
//                                     WidgetSpan(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // Navigate to Sign In screen (replace with your function)
//                                           print("Sign In Clicked");
//                                         },
//                                         child: Text(
//                                           " Sign In",
//                                           style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w200,
//                                             decoration: TextDecoration.underline,
//                                             color: Colors.white, // Change color for better visibility
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//
//
//
//
//
//
//
//
//                 ),
//               ),
//               // Bottom fragment with white background (form fields)
//               SlideTransition(
//                 position: _slideAnimation,
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20),
//                         Text(
//                           "Name",
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w200,
//
//                             color: Colors.black, // Change color for better visibility
//                             fontSize: 12,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextField(
//                           hintText: "Eg., John Doe",
//                           controller: _nameController,
//                         ),
//
//                         SizedBox(height: 15),
//                         Text(
//                           "Email",
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w200,
//
//                             color: Colors.black, // Change color for better visibility
//                             fontSize: 12,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextField(
//                           hintText: "Eg., johndoe@gmail.com",
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           "Mobile",
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w200,
//
//                             color: Colors.black, // Change color for better visibility
//                             fontSize: 12,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextField(
//                           hintText: "Enter mobile number",
//                           controller: _phoneController,
//                           keyboardType: TextInputType.phone,
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           " Sign In",
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w200,
//
//                             color: Colors.black, // Change color for better visibility
//                             fontSize: 12,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: !_passwordVisible,
//                           decoration: InputDecoration(
//                             hintText: "Enter Password",
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 16),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _passwordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _passwordVisible = !_passwordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 95),
//                         AnimatedSubmitButton(
//                           text: "Create Account",
//                           onPressed: _submitSignup,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),],
//       )
//
//     );
//   }
// }
