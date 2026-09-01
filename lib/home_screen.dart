import 'package:flutter/material.dart';
import 'party_room_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Map<String, String>> rooms = const [
    {"title": "👑✨DIL KA SUKOON✨👑", "count": "20", "tag": "💬 Chat", "sub": "3 seats left for you", "img": "https://picsum.photos/300/300?1"},
    {"title": "🎵MUSIC POINT💖", "count": "14", "tag": "💓 Pick Me", "sub": "🏠 C A S P E R", "img": "https://picsum.photos/300/300?2"},
    {"title": "145+ Follow vs Follow", "count": "135", "tag": "💬 Chat", "sub": "3 seats left for you", "img": "https://picsum.photos/300/300?3"},
    {"title": "💔😭अपनों की झूठी मोहब्बत", "count": "29", "tag": "💬 Chat", "sub": "🏠 Reet 💔", "img": "https://picsum.photos/300/300?4"}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Row(children: [
        const Text("PB Live Party", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const Spacer(),
        IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
      ])),
      SizedBox(height: 36, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: [
        _pill("Hot", true), _pill("Event", false), _pill("Date", false), _pill("Music", false),
      ])),
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8),
          itemCount: rooms.length,
          itemBuilder: (ctx, i) => InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PartyRoomScreen(roomTitle: rooms[i]["title"]!))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                color: const Color(0xFF221E38),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: Stack(children: [
                    Image.network(rooms[i]["img"]!, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                    Positioned(top: 6, right: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(rooms[i]["count"]!, style: const TextStyle(color: Colors.white, fontSize: 10)))),
                    Positioned(bottom: 6, left: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8)), child: Text(rooms[i]["tag"]!, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)))),
                  ])),
                  Padding(padding: const EdgeInsets.all(6), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(rooms[i]["title"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(rooms[i]["sub"]!, maxLines: 1, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                  ])),
                ]),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _pill(String t, bool sel) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: sel ? Colors.amber : const Color(0xFF26223D), borderRadius: BorderRadius.circular(16)), child: Text(t, style: TextStyle(color: sel ? Colors.black : Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)));
}

