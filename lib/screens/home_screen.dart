import 'package:flutter/material.dart';
import 'room_screen.dart';

class HomeScreen extends StatelessWidget {
  final String myId;
  final int diamonds;

  const HomeScreen({super.key, required this.myId, required this.diamonds});

  final List<String> clubRooms = const [
    "👑 Tech Love PB Club (8/8)",
    "🔥 Punjabi Beats Party (6/8)",
    "🌹 Friends Gossip Club (4/8)",
    "⚔️ PK Live Battle (7/8)",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Event Banner
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
        // Rooms List
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
                        MaterialPageRoute(builder: (c) => RoomScreen(title: clubRooms[index], myId: myId)),
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

