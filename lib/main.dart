import 'package:flutter/material.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFFFF007F),
      ),
      home: const PBLiveHomeScreen(),
    );
  }
}

class PBLiveHomeScreen extends StatefulWidget {
  const PBLiveHomeScreen({super.key});

  @override
  State<PBLiveHomeScreen> createState() => _PBLiveHomeScreenState();
}

class _PBLiveHomeScreenState extends State<PBLiveHomeScreen> {
  String currentUserId = "0001";
  String currentUserName = "Lovepreet Singh (Owner)";
  String currentUserEmail = "lp5006352@gmail.com";
  bool isOwner = true;
  int userDiamonds = 5400;
  String activeFrame = "👑 Golden King Frame";

  void _showLoginDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Welcome to PB Live Club", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("Choose your account to sign in", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  currentUserId = "0001";
                  currentUserName = "Lovepreet Singh (Owner)";
                  currentUserEmail = "lp5006352@gmail.com";
                  isOwner = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("👑 Super Owner Logged In (lp5006352@gmail.com)!"), backgroundColor: Colors.green),
                );
              },
              child: const Text("Continue with Google (Gmail)", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("PB", style: TextStyle(color: Colors.white))),
                Positioned(bottom: 0, right: 0, child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)))
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PB Live Club", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(isOwner ? "👑 Super Owner (0001)" : "ID: $currentUserId", style: const TextStyle(fontSize: 10, color: Colors.amber)),
              ],
            ),
          ],
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Text("💎 ", style: TextStyle(fontSize: 12)),
                  Text("$userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 3),
                    ),
                    child: const Center(child: Icon(Icons.person, size: 35, color: Colors.white)),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUserName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 3),
                      Text(currentUserEmail, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text("Frame: $activeFrame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Live Voice Party Room (15 Seats)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text("Multi-seat audio streaming, gifting, and admin seat controls.", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 40)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🚀 Entering 15-Seater Voice Room...")));
                    },
                    child: const Text("Enter Party Room", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                icon: const Icon(Icons.login),
                label: const Text("Switch Account / Login", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _showLoginDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

