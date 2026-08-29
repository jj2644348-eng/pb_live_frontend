import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
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
  int _tabIndex = 0;
  int diamonds = 5000000;
  String myId = "78451290";

  final List<String> clubRooms = [
    "👑 Tech Love PB Club (8/8)",
    "🔥 Punjabi Beats Party (6/8)",
    "🌹 Friends Gossip Club (4/8)",
    "⚔️ PK Live Battle (7/8)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tabIndex == 0 ? "PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Text("💎 $diamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          )
        ],
      ),
      body: _tabIndex == 0 ? _buildPartyRooms() : _tabIndex == 1 ? _buildFamily() : _buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
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

  Widget _buildPartyRooms() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: clubRooms.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF1E193D),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.pinkAccent, child: Icon(Icons.mic, color: Colors.white)),
            title: Text(clubRooms[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text("Live audio chatting & fun", style: TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => AudioRoomScreen(title: clubRooms[index])),
                );
              },
              child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFamily() {
    return const Center(
      child: Text("👥 Official PB Family\nLevel 5 Club Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent, child: Text("👑", style: TextStyle(fontSize: 26))),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Love Party Owner", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("ID: $myId (VIP 10)", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.amber),
              title: const Text("Diamonds Balance", style: TextStyle(color: Colors.white)),
              trailing: Text("$diamonds 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.security, color: Colors.pinkAccent),
              title: const Text("👑 Super Reseller Panel", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Transfer Coins by 8-digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Reseller Panel Active!"), backgroundColor: Colors.green),
                  );
                },
                child: const Text("Open", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- AUDIO ROOM SCREEN ----------------
class AudioRoomScreen extends StatefulWidget {
  final String title;
  const AudioRoomScreen({super.key, required this.title});

  @override
  State<AudioRoomScreen> createState() => _AudioRoomScreenState();
}

class _AudioRoomScreenState extends State<AudioRoomScreen> {
  bool isMic = false;
  final List<String> chats = ["💬 Welcome to Club Party!"];
  final TextEditingController chatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(widget.title, style: const TextStyle(fontSize: 14)),
      ),
      body: Column(
        children: [
          // 8 Mic Seats
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemCount: 8,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B163A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: i == 0 ? Colors.pinkAccent : Colors.deepPurple),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(i == 0 ? Icons.star : Icons.mic_none, color: i == 0 ? Colors.amber : Colors.white70),
                      const SizedBox(height: 4),
                      Text(i == 0 ? "Host" : "Seat ${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
          // Chat Box
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF161230), borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (c, idx) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(chats[idx], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
              ),
            ),
          ),
          // Bottom Controller
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFF161230),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(isMic ? Icons.mic : Icons.mic_off, color: isMic ? Colors.green : Colors.red),
                  onPressed: () => setState(() => isMic = !isMic),
                ),
                Expanded(
                  child: TextField(
                    controller: chatCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(hintText: "Type chat...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: () {
                    if (chatCtrl.text.trim().isNotEmpty) {
                      setState(() => chats.add("💬 You: ${chatCtrl.text.trim()}"));
                      chatCtrl.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

