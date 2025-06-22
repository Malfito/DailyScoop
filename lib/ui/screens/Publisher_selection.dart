import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/Onboarding_provider.dart';
import '../../models/OnboardingRequestModel.dart';
import '../../services/OnboardingService.dart';
import '../widgets/PublisherButton.dart';

class PublisherSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> publishers = [
    {'id': 1, 'name': 'CNN News'},
    {'id': 2, 'name': 'BBC'},
    {'id': 3, 'name': 'NDTV'},
    {'id': 4, 'name': 'NBC'},
    {'id': 5, 'name': 'Times Now'},
    {'id': 6, 'name': 'Sky News'},
  ];

  void _showSelectedPublishersDialog(BuildContext context, List<int> selectedIds) {
    final selectedNames = publishers
        .where((p) => selectedIds.contains(p['id']))
        .map((p) => p['name'])
        .toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Selected Publishers"),
        content: selectedNames.isEmpty
            ? Text("No publishers selected.")
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: selectedNames.map((name) => Text("• $name")).toList(),
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
    final selectedPublisherIds = provider.selectedPublisherIds;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your desired Publishers", style: TextStyle(color: Colors.black)),
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
            Text("Please follow atleast 2 publishers to get started.",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: publishers.map((publisher) {
                return PublisherButton(
                  id: publisher['id'],
                  name: publisher['name'],
                  isSelected: selectedPublisherIds.contains(publisher['id']),
                  onTap: () => provider.togglePublisher(publisher['id']),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(
              "You can skip configure your preferences anytime later in the app settings.",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () async{
    final provider = Provider.of<OnboardingProvider>(context, listen: false);

    if (provider.selectedDistricts.isEmpty ||
    provider.selectedCategories.length < 3 ||
    provider.selectedPublisherIds.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("❗ Please complete all onboarding steps")),
    );
    return;
    }

    final model = OnboardingRequestModel(
    userId: 3, //
    state: provider.selectedState,
    district: provider.selectedDistricts.first, // assuming one district
    categories: provider.selectedCategories,
    publisherIds: provider.selectedPublisherIds,
    );

    final success = await OnboardingService.submitOnboarding(model);

    if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("🎉 Onboarding submitted successfully!")),
    );
    } else {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("❌ Failed to submit. Please try again.")),
    );
    }
    },
          child: Text("Submit"),
        ),
      ),
    );
  }
}
