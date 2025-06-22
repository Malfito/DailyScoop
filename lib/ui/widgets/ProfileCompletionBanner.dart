import 'dart:async';
import 'package:flutter/material.dart';

class ProfileCompletionBanner extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final VoidCallback onTap;

  const ProfileCompletionBanner({
    Key? key,
    required this.progress,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProfileCompletionBanner> createState() => _ProfileCompletionBannerState();
}

class _ProfileCompletionBannerState extends State<ProfileCompletionBanner> with SingleTickerProviderStateMixin {
  bool _visible = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Start animation

    // Auto dismiss after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _hideBanner();
      }
    });
  }

  void _hideBanner() {
    _controller.reverse(); // Reverse animation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _visible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: 16,
      right: 16,
      bottom: 70, // Bottom NavBar ke thoda upar
      child: SlideTransition(
        position: _offsetAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFFFF0D9),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        child: CircularProgressIndicator(
                          value: widget.progress,
                          strokeWidth: 4,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      ),
                      Text(
                        '${(widget.progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Complete Your Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Personalized news is just one step away',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Colors.black),
                    onPressed: _hideBanner,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
