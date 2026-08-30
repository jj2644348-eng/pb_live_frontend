import 'package:flutter/material.dart';

void main() => runApp(const PBLiveApp());

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF141026)),
      home: const PBHome(),
    );
  }
}

class PBHome extends StatefulWidget {
  const PBHome({super.key});

  @override
  State<PBHome> createState() => _PBHomeState();
}

class _PBHomeState extends State<PBHome> {
  String userId = "0001";
  String userName = "Lovepreet Singh (Owner)";
  int diamonds = 5400;
  String frame = "🐉 Dragon Fire Frame";

  void _showShop() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🛍️ VIP Avatar & Flag Shop", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            ListTile(
              leading: const Text("🐉", style: TextStyle(fontSize: 28)),
              title: const Text("Dragon Fire Frame", style: TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() => frame = "🐉 Dragon Fire Frame");
                  Navigator.pop(context);
                },
                child: const Text("💎 800"),
              ),
            ),
            ListTile(
              leading: const Text("🇮🇳", style: TextStyle(fontSize: 28)),
              title: const Text("Indian Flag Pride", style: TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  setState(() => frame = "🇮🇳 Indian Flag Pride");
                  Navigator.pop(context);
                },
                child: const Text("💎 1200"),
              ),
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
            const CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("PB", style: TextStyle(color: Colors.white))),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PB Live Club", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("👑 Super Owner ($userId)", style: const TextStyle(fontSize: 10, color: Colors.amber)),
              ],
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text("💎 $diamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 35)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text("lp5006352@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text("Frame: $frame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🛍️"),
              label: const Text("Open VIP Shop (Dragon & Flags)"),
              onPressed: _showShop,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6200EE), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🎁"),
              label: const Text("Invite Friends & Earn Commission"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Invite Link: PB0001")));
              },
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Live Voice Party Room (15 Seats)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 38)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🚀 Entering 15-Seater Voice Room...")));
                    },
                    child: const Text("Enter Party Room"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

