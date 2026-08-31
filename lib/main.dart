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
      home: const PBLiveLiveHome(),
    );
  }
}

class PBLiveLiveHome extends StatefulWidget {
  const PBLiveLiveHome({super.key});

  @override
  State<PBLiveLiveHome> createState() => _PBLiveLiveHomeState();
}

class _PBLiveLiveHomeState extends State<PBLiveLiveHome> {
  // Live Server Link from Render
  final String serverUrl = "https://party-live-server.onrender.com";
  
  String userId = "0001";
  String userName = "Lovepreet Singh (Owner)";
  String userEmail = "lp5006352@gmail.com";
  int diamonds = 5400;
  String activeFrame = "👑 Golden King Frame";
  bool isInPartyRoom = false;

  final List<Map<String, dynamic>> partySeats = List.generate(15, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "Lovepreet (Owner)" : (index < 4 ? "User ${index + 1}" : null),
  });

  void _showVipShop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🛍️ VIP Avatar & Flag Shop", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            ListTile(
              leading: const Text("🐉", style: TextStyle(fontSize: 28)),
              title: const Text("Dragon Fire Frame", style: TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() => activeFrame = "🐉 Dragon Fire Frame");
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
                  setState(() => activeFrame = "🇮🇳 Indian Flag Pride");
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
    if (isInPartyRoom) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("🎙️ 15-Seater Live Party Room"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => isInPartyRoom = false),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("💎 $diamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            final seat = partySeats[index];
            bool isOccupied = seat["user"] != null;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2456),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: index == 0 ? Colors.amber : Colors.purpleAccent, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: isOccupied ? Colors.pinkAccent : Colors.grey[800],
                    child: Text("${seat["seatNo"]}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isOccupied ? seat["user"].split(" ")[0] : "Empty",
                    style: TextStyle(fontSize: 9, color: isOccupied ? Colors.white : Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

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
      body: SingleChildScrollView(
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
                      Text(userEmail, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text("Frame: $activeFrame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Icon(Icons.cloud_done, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text("Server: $serverUrl", style: const TextStyle(color: Colors.greenAccent, fontSize: 10), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🛍️"),
              label: const Text("Open VIP Shop (Dragon & Flags)"),
              onPressed: () => _showVipShop(context),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6200EE), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🎁"),
              label: const Text("Invite Friends & Family System"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Invite Link Copied: PB0001")));
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 40)),
                    onPressed: () => setState(() => isInPartyRoom = true),
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

