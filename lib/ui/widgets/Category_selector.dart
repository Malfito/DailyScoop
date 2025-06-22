import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> selectedCategories = ["Breaking News", "Sports"];
  List<String> categories = [
    "Breaking News", "Politics", "Business", "Technology", "Health & Wellness",
    "Entertainment", "Travel", "Lifestyle", "Science", "Gaming", "Education"
  ];

  void _toggleCategory(String category) {
    setState(() {
      selectedCategories.contains(category)
          ? selectedCategories.remove(category)
          : selectedCategories.add(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: categories.map((category) {
        bool isSelected = selectedCategories.contains(category);
        return ChoiceChip(
          label: Text(category),
          selected: isSelected,
          selectedColor: Colors.red,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
          onSelected: (selected) => _toggleCategory(category),
        );
      }).toList(),
    );
  }
}
