import 'package:flutter/material.dart';
import 'models/user_session.dart';
import 'screens/admin_panel.dart';
import 'screens/party_room.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tab = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      "name": "👑 Tech Love PB Official Club",
      "host": "Love Party Owner",
      "hostId": "0001",
      "active": "8/8 Live",
      "avatar": "👑"
    },
    {
      "name": "🔥 Punjabi Beats & DJ Party",
      "host": "Aman Deep",
      "hostId": "88451290",
      "active": "5/8 Live",
      "avatar": "🎧"
    },
    {
      "name": "🌹 Friends Gossip & Shayari",
      "host": "Riya Sharma",
      "hostId": "55219034",
      "active": "3/8 Live",
      "avatar": "🎤"
    },
  ];

  void _openCreateRoomModal() {
    final titleCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🎙️ Start Your Live Voice Room",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber,
                    child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 10),
                  Text("Host: ${CurrentUser.name}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter Room Name / Topic",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF161230),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                  onPressed: () {
                    final name = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Live Club" : titleCtrl.text.trim();
                    final newRoom = {
                      "name": name,
                      "host": CurrentUser.name,
                      "hostId": CurrentUser.id,
                      "active": "1/8 Live",
                      "avatar": CurrentUser.avatar,
                    };
                    setState(() => rooms.insert(0, newRoom));
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => PartyRoomScreen(title: name),
                      ),
                    );
                  },
                  child: const Text("Go Live Now 🚀", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tab == 0 ? "PB Party Club" : _tab == 1 ? "Family Club" : "My Profile"),
        actions: [
          Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
          if (_tab == 0)
            IconButton(
              icon: const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFFFF007F),
                child: Icon(Icons.add, color: Colors.white, size: 18),
              ),
              onPressed: _openCreateRoomModal,
            ),
        ],
      ),
      body: _tab == 0
          ? _buildHomeScreen()
          : _tab == 1
              ? const Center(child: Text("👥 Official PB Family Club\nLevel 5 Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)))
              : ProfileScreen(onProfileUpdated: () => setState(() {})),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (v) => setState(() => _tab = v),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF2E0854), Color(0xFFFF007F), Color(0xFF00F2FE)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: Colors.black26, child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 22))),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🔥 PB PARTY LIVE VOICE CLUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      Text("💎 ₹10 = 100 💎 • ₹100 = 1,200 💎", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final r = rooms[index];
              return Card(
                color: const Color(0xFF1E193D),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF2A2456),
                    child: Text(r["avatar"] as String, style: const TextStyle(fontSize: 22)),
                  ),
                  title: Text(r["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text("Host: ${r["host"]} (ID: ${r["hostId"]}) • ${r["active"]}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => PartyRoomScreen(title: r["name"] as String),
                        ),
                      );
                    },
                    child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

