import 'package:flutter/material.dart';
import '../widgets/ProfileHeader.dart';
import '../widgets/States_widget.dart';
import '../widgets/category_selector.dart';
import '../widgets/publisher_selector.dart';
import '../widgets/text_input_field.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedState = "Karnataka"; // Default selected state
  List<String> selectedDistricts = [];

  List<String> districts = [
    "Bagalkot", "Bengaluru Urban", "Bengaluru Rural", "Belagavi", "Ballari",
    "Vijayapur", "Bidar", "Chamarajanagar", "Chikkaballapur", "Chikkamagaluru"
  ];

  void _toggleDistrict(String district) {
    setState(() {
      selectedDistricts.contains(district)
          ? selectedDistricts.remove(district)
          : selectedDistricts.add(district);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(), // Reused profile header with edit option
            SizedBox(height: 20),

            // Personal Information
            Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextInputField(label: "Name", hintText: "Enter your name"),
            TextInputField(label: "Email", hintText: "Enter your email"),
            TextInputField(label: "Mobile Number", hintText: "Enter mobile number"),
            TextInputField(label: "Password", hintText: "********", isPassword: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, // Handle password change
                child: Text("Change Password", style: TextStyle(color: Colors.blue)),
              ),
            ),
            SizedBox(height: 20),

            // Location Preferences
            Text("Location Preferences", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Select State *", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedState,
              items: ["Karnataka"].map((state) {
                return DropdownMenuItem(value: state, child: Text(state));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value!;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            Text("Select District *", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: districts.map((district) {
                return DistrictButton(
                  district: district,
                  isSelected: selectedDistricts.contains(district),
                  onTap: () => _toggleDistrict(district),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Category Preferences
            Text("Category Preferences", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            CategorySelector(),
            SizedBox(height: 20),

            // Publisher Preferences
            Text("Publisher Preferences", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            PublisherSelector(),
            SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // Handle save
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
