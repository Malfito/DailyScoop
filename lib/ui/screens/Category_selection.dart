import 'package:daily_scoop_phase_2/ui/screens/Publisher_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/Onboarding_provider.dart';
import '../widgets/category_buttons.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<String> categories = [
    "Breaking News",
    "Politics",
    "Business",
    "Technology",
    "Health & Wellness",
    "Sports",
    "Entertainment",
    "Travel",
    "Lifestyle",
    "Science",
    "Gaming",
    "Education"
  ];

  void _showSelectedCategoriesDialog(BuildContext context, List<String> selectedCategories) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Selected Categories"),
        content: selectedCategories.isEmpty
            ? Text("No categories selected.")
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: selectedCategories.map((c) => Text("• $c")).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);
    final selectedCategories = provider.selectedCategories;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your desired categories", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Skip", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Pick at least 4 categories to proceed further.",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: categories.map((category) {
                return CategoryButton(
                  category: category,
                  isSelected: selectedCategories.contains(category),
                  onTap: () => provider.toggleCategory(category), // ✅ corrected method
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(
              "You can skip configuring your preferences anytime later in the app settings.",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PublisherSelectionScreen()),
            );
          },
          child: Text("Next"),
        ),
      ),

    );
  }
}
