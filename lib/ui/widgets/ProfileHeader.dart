import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback? onEditTap;

  ProfileHeader({this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/profile.jpg"), // Change as needed
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ruben Amorim", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("rubenamorim@gmail.com", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: onEditTap, // Navigate when edit button is clicked
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: onEditTap, // Navigate when edit button is clicked
            ),
          ],
        ),
      ],
    );
  }
}
