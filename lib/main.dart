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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUserId = "0001";
  String currentUserName = "Lovepreet Singh (Owner)";
  bool isOwner = true;
  int userDiamonds = 5000;
  String activeFrame = "👑 Golden King Frame";

  void _openLoginSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Login Method", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentUserId = "0001";
                  currentUserName = "Lovepreet Singh (Owner)";
                  isOwner = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("👑 Super Owner Logged In!")));
              },
              child: const Text("Continue with Google (lp5006352@gmail.com)"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1877F2), foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentUserId = "FB8892";
                  currentUserName = "Facebook User";
                  isOwner = false;
                });
              },
              child: const Text("Continue with Facebook"),
            ),
          ],
        ),
      ),
    );
  }

  void _openVipShop() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🛍️ VIP Avatar Shop & Flag Mall", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Text("🐉", style: TextStyle(fontSize: 30)),
                    title: const Text("Dragon Fire Frame", style: TextStyle(color: Colors.white)),
                    subtitle: const Text("7 Days - Glowing Effect", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        if (userDiamonds >= 800) {
                          setState(() {
                            userDiamonds -= 800;
                            activeFrame = "🐉 Dragon Fire Frame";
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Purchased Dragon Fire Frame!")));
                        }
                      },
                      child: const Text("💎 800"),
                    ),
                  ),
                  ListTile(
                    leading: const Text("🇮🇳", style: TextStyle(fontSize: 30)),
                    title: const Text("Indian Flag Pride", style: TextStyle(color: Colors.white)),
                    subtitle: const Text("30 Days - Tricolor Border", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        if (userDiamonds >= 1200) {
                          setState(() {
                            userDiamonds -= 1200;
                            activeFrame = "🇮🇳 Indian Flag Pride";
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Purchased Indian Flag Frame!")));
                        }
                      },
                      child: const Text("💎 1200"),
                    ),
                  ),
                ],
              ),
            )
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
            // Profile & Equipped Frame Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 3),
                    ),
                    child: const Center(child: Icon(Icons.person, size: 30, color: Colors.white)),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUserName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text("Active Frame: $activeFrame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // VIP Shop Banner Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF007F),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Text("🛍️", style: TextStyle(fontSize: 18)),
              label: const Text("Open VIP Shop (Dragon & Flag Frames)", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: _openVipShop,
            ),
            const SizedBox(height: 16),

            // Live 15-Seat Room Access Card
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
                    child: const Text("Enter Party Room"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Login Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                icon: const Icon(Icons.login),
                label: Text("Switch Account / Login"),
                onPressed: _openLoginSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

