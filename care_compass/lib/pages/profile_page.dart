import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'Profile',
          style: TextStyle(color: black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: primary,
              // You can add an image here for the profile picture
            ),
            SizedBox(height: 16),
            Text(
              'John Doe',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: primary),
            ),
            SizedBox(height: 8),
            Text(
              'Software Developer',
              style: TextStyle(fontSize: 16, color: thirdColor),
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              icon: Icons.email,
              label: 'Email',
              value: 'john.doe@example.com',
            ),
            _buildInfoCard(
              icon: Icons.phone,
              label: 'Phone',
              value: '+1 123-456-7890',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String label, required String value}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: primary),
        title: Text(label, style: TextStyle(color: primary)),
        subtitle: Text(value),
      ),
    );
  }
}
