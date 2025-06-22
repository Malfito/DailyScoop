import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/Onboarding_provider.dart';
import '../widgets/States_widget.dart';
import 'Category_selection.dart';
import 'dummy.dart';

class StateSelectionScreen extends StatefulWidget {
  @override
  _StateSelectionScreenState createState() => _StateSelectionScreenState();
}

class _StateSelectionScreenState extends State<StateSelectionScreen> {
  String selectedState = "Karnataka";

  List<String> districts = [
    "Bagalkot", "Bengaluru Urban", "Bengaluru Rural", "Belagavi", "Ballari",
    "Vijayapur", "Bidar", "Chamarajanagar", "Chikkaballapur", "Chikkamagaluru"
  ];

  void _showSelectedDistrictDialog(BuildContext context, List<String> selectedDistricts) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Selected Districts"),
        content: selectedDistricts.isEmpty
            ? Text("No districts selected.")
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: selectedDistricts.map((d) => Text("• $d")).toList(),
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
    final selectedDistricts = provider.selectedDistricts;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Select State & District", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Please select a state",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Get personalized updates, breaking news, and stories."),
            const SizedBox(height: 20),
            Text("Select State *", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedState,
              items: ["Karnataka"].map((state) {
                return DropdownMenuItem(value: state, child: Text(state));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.setSelectedState(value);
                  setState(() {
                    selectedState = value;
                  });
                }
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Text("Select District *", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: districts.map((district) {
                return DistrictButton(
                  district: district,
                  isSelected: selectedDistricts.contains(district),
                  onTap: () => provider.toggleDistrict(district),
                );
              }).toList(),
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
              MaterialPageRoute(builder: (context) => CategorySelectionScreen()),
            );
          },
          child: Text("Next"),
        ),
      ),

    );
  }
}
