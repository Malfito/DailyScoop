import 'package:flutter/material.dart';
import 'news_card.dart';

class NewsSwipeStack extends StatefulWidget {
  final List<Map<String, dynamic>> newsList;
  final Function(bool) onSwipeStarted;
  final int initialIndex;


  const NewsSwipeStack({
    super.key,
    required this.newsList,
    required this.onSwipeStarted,
    this.initialIndex = 0,
  });
  @override
  State<NewsSwipeStack> createState() => _NewsSwipeStackState();
}

class _NewsSwipeStackState extends State<NewsSwipeStack> with TickerProviderStateMixin {
  int currentIndex = 0;
  double dragOffsetY = 0.0;
  bool isDragging = false;
  late AnimationController _snapController;
  late Animation<double> _snapAnimation;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _snapController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      isDragging = true;
      dragOffsetY += details.delta.dy;
    });

    if (dragOffsetY.abs() > 20) {
      widget.onSwipeStarted(true);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    final threshold = 50.0;
    final velocity = details.primaryVelocity ?? 0;

    final atLast = currentIndex >= widget.newsList.length - 1;
    final atFirst = currentIndex == 0;

    if ((dragOffsetY < -threshold || velocity < -300)) {
      if (atLast) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You're all caught up!"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black87,
          ),
        );
        _snapBack();
      } else {
        _animateCardTransition(true); // swipe up
      }
    } else if ((dragOffsetY > threshold || velocity > 300)) {
      if (atFirst) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This is the first story!"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black87,
          ),
        );
        _snapBack();
      } else {
        _animateCardTransition(false); // swipe down
      }
    } else {
      _snapBack(); // not enough drag
    }
  }



  void _animateCardTransition(bool swipeUp) {
    final screenHeight = MediaQuery.of(context).size.height;

    _snapAnimation = Tween<double>(
      begin: dragOffsetY,
      end: swipeUp ? -screenHeight : screenHeight,
    ).animate(_snapController)
      ..addListener(() {
        setState(() {
          dragOffsetY = _snapAnimation.value;
        });
      });

    _snapController.forward(from: 0).then((_) {
      setState(() {
        currentIndex += swipeUp ? 1 : -1;
        dragOffsetY = 0;
        isDragging = false;
      });
    });
  }

  void _snapBack() {
    _snapAnimation = Tween<double>(begin: dragOffsetY, end: 0).animate(_snapController)
      ..addListener(() {
        setState(() {
          dragOffsetY = _snapAnimation.value;
        });
      });

    _snapController.forward(from: 0).then((_) {
      setState(() {
        dragOffsetY = 0;
        isDragging = false;
      });
    });
  }

  void _onTap() {
    widget.onSwipeStarted(false);
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentNews = widget.newsList[currentIndex];
    final nextIndex = currentIndex < widget.newsList.length - 1 ? currentIndex + 1 : null;
    final prevIndex = currentIndex > 0 ? currentIndex - 1 : null;

    return GestureDetector(
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      onTap: _onTap,
      child: Stack(
        children: [
          // Fullscreen preview (below)
          if (dragOffsetY < 0 && nextIndex != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NewsCard(
                    imageUrl: widget.newsList[nextIndex]['imageUrl'],
                    headline: widget.newsList[nextIndex]['headline'],
                    description: widget.newsList[nextIndex]['description'],
                    category: widget.newsList[nextIndex]['category'],
                    timeAgo: widget.newsList[nextIndex]['timeAgo'],
                    likes: widget.newsList[nextIndex]['likes'],
                    shares: widget.newsList[nextIndex]['shares'],
                  ),
                ),
              ),
            )
          else if (dragOffsetY > 0 && prevIndex != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NewsCard(
                    imageUrl: widget.newsList[prevIndex]['imageUrl'],
                    headline: widget.newsList[prevIndex]['headline'],
                    description: widget.newsList[prevIndex]['description'],
                    category: widget.newsList[prevIndex]['category'],
                    timeAgo: widget.newsList[prevIndex]['timeAgo'],
                    likes: widget.newsList[prevIndex]['likes'],
                    shares: widget.newsList[prevIndex]['shares'],
                  ),
                ),
              ),
            ),

          // Top card with drag
          Transform.translate(
            offset: Offset(0, dragOffsetY),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NewsCard(
                  imageUrl: currentNews['imageUrl'],
                  headline: currentNews['headline'],
                  description: currentNews['description'],
                  category: currentNews['category'],
                  timeAgo: currentNews['timeAgo'],
                  likes: currentNews['likes'],
                  shares: currentNews['shares'],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
