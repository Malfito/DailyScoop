import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': 'assets/home_outline.svg', 'active': 'assets/home_filled.svg', 'label': 'Home'},
      {'icon': 'assets/watch_outline.svg', 'active': 'assets/watch_filled_new.svg', 'label': 'Watch'},
      {'icon': 'assets/local_outline.svg', 'active': 'assets/local_filled.svg', 'label': 'Local'},
      {'icon': 'assets/explore_outline.svg', 'active': 'assets/explore_filled.svg', 'label': 'Explore'},
      {'icon': 'assets/Profile_outline.svg', 'active': 'assets/profile_filled.svg', 'label': 'Profile'},
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;

          return Expanded(
            child: InkWell(
              onTap: () => onItemTapped(index),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 4,
                    width: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: SvgPicture.asset(
                      isSelected ? item['active']! : item['icon']!,
                      key: ValueKey(isSelected),
                      height: 24,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    child: Text(item['label']!),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
