import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech PB - Profile'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'Lovepreet Singh',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ID: OfficialTechPB_01',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Wallet / Coins Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('My Coins', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 4),
                      Text('10,500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
                    ],
                  ),
                  VerticalDivider(color: Colors.white24),
                  Column(
                    children: [
                      Text('Beans', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 4),
                      Text('4,200', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Menu Options
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.edit, 'Edit Profile', () {}),
                  _buildMenuItem(Icons.monetization_on, 'Recharge Coins', () {}),
                  _buildMenuItem(Icons.settings, 'App Settings', () {}),
                  _buildMenuItem(Icons.info, 'About Official Tech PB', () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

