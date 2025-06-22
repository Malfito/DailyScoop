import 'package:flutter/material.dart';

class PublisherSelector extends StatefulWidget {
  @override
  _PublisherSelectorState createState() => _PublisherSelectorState();
}

class _PublisherSelectorState extends State<PublisherSelector> {
  List<String> selectedPublishers = ["CNN News", "BBC"];
  List<String> publishers = ["CNN News", "BBC", "NDTV", "NBC", "Times Now", "Sky News"];

  void _togglePublisher(String publisher) {
    setState(() {
      selectedPublishers.contains(publisher)
          ? selectedPublishers.remove(publisher)
          : selectedPublishers.add(publisher);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: publishers.map((publisher) {
        bool isSelected = selectedPublishers.contains(publisher);
        return ChoiceChip(
          label: Text(publisher),
          selected: isSelected,
          selectedColor: Colors.red,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
          onSelected: (selected) => _togglePublisher(publisher),
        );
      }).toList(),
    );
  }
}
