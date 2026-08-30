import 'package:flutter/material.dart';

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
  int _tabIndex = 0;
  int diamonds = 5000000;
  String myId = "0001";
  String myName = "Love Party Owner";
  String myAvatar = "👑";

  final List<String> clubRooms = const [
    "👑 Tech Love PB Club (8/8)",
    "🔥 Punjabi Beats Party (6/8)",
    "🌹 Friends Gossip Club (4/8)",
    "⚔️ PK Live Battle (7/8)",
  ];

  void _openCreateRoom() {
    final titleCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("🎙️ Create Voice Room", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: titleCtrl,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter Room Name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              final name = titleCtrl.text.trim().isEmpty ? "$myName's Room" : titleCtrl.text.trim();
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => SimpleRoomScreen(title: name, myId: myId)),
              );
            },
            child: const Text("Go Live", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openRechargeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Offline Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your ID: $myId", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Rate: 100 💎 = ₹10\nMode: UPI / GPay / PhonePe", style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Divider(color: Colors.white24, height: 16),
            const Text("WhatsApp Official Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tabIndex == 0 ? "PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text("💎 $diamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFFF007F),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
            onPressed: _openCreateRoom,
          ),
        ],
      ),
      body: _tabIndex == 0
          ? _buildHomeScreen()
          : _tabIndex == 1
              ? const Center(child: Text("👥 Official PB Family Club\nLevel 5 Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)))
              : _buildProfileScreen(),
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
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: Colors.black26, child: Text("👑", style: TextStyle(fontSize: 22))),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🔥 PB PARTY LIVE VOICE CLUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      Text("💎 RECHARGE • WhatsApp: +91 97793 53560", style: TextStyle(color: Colors.amberAccent, fontSize: 10)),
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
                        MaterialPageRoute(builder: (c) => SimpleRoomScreen(title: clubRooms[index], myId: myId)),
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

  Widget _buildProfileScreen() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 32, backgroundColor: Colors.amber, child: Text(myAvatar, style: const TextStyle(fontSize: 28))),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(myName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("ID: $myId (Super Owner)", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.amber),
              title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)),
              subtitle: Text("$diamonds 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: _openRechargeDialog,
                child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Card(
            color: const Color(0xFF1E193D),
            child: const ListTile(
              leading: Icon(Icons.admin_panel_settings, color: Colors.pinkAccent),
              title: Text("👑 Super Owner Panel", style: TextStyle(color: Colors.white)),
              subtitle: Text("Offline Recharge / WhatsApp: +91 97793 53560", style: TextStyle(color: Colors.grey, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleRoomScreen extends StatefulWidget {
  final String title;
  final String myId;

  const SimpleRoomScreen({super.key, required this.title, required this.myId});

  @override
  State<SimpleRoomScreen> createState() => _SimpleRoomScreenState();
}

class _SimpleRoomScreenState extends State<SimpleRoomScreen> {
  bool isMic = false;
  final List<String> chats = ["💬 Welcome to Party Room!"];
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
