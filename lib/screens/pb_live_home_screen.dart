import 'package:flutter/material.dart';

class PBLiveHomeScreen extends StatefulWidget {
  final Function(String roomTitle) onJoinRoom;
  final VoidCallback onCreateRoom;

  const PBLiveHomeScreen({
    super.key,
    required this.onJoinRoom,
    required this.onCreateRoom,
  });

  @override
  State<PBLiveHomeScreen> createState() => _PBLiveHomeScreenState();
}

class _PBLiveHomeScreenState extends State<PBLiveHomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> categories = ["Hot 🔥", "Event 🏆", "Music 🎧", "Party 🎙️", "Game 🎮", "Dating 💖"];

  final List<Map<String, dynamic>> popularRooms = [
    {
      "title": "SONG All VIBE 💗",
      "tag": "💬 Chat",
      "tagColor": Colors.teal,
      "online": 8,
      "seatsLeft": "4 seats left for you",
      "img": "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7",
    },
    {
      "title": "Meeting Room ✨",
      "tag": "📻 Pick Me",
      "tagColor": Colors.pinkAccent,
      "online": 3,
      "seatsLeft": "7 seats left for you",
      "img": "https://images.unsplash.com/photo-1534528741775-53994a69daeb",
    },
    {
      "title": "Friends Gossip 🌷",
      "tag": "💬 Chat",
      "tagColor": Colors.teal,
      "online": 8,
      "seatsLeft": "4 seats left for you",
      "img": "https://images.unsplash.com/photo-1517841905240-472988babdf9",
    },
    {
      "title": "Punjabi Beats & DJ 🔥",
      "tag": "🔥 DJ Party",
      "tagColor": Colors.deepOrange,
      "online": 21,
      "seatsLeft": "1 seat left for you",
      "img": "https://images.unsplash.com/photo-1514525253161-7a46d19cd819",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C20),
        elevation: 0,
        title: Row(
          children: [
            // Custom Stylish Brand Logo Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF007F), Color(0xFFFFD700)]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "PB",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            // Custom Bold Typography (Bold Stylish Font)
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "PB ",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 0.5),
                  ),
                  TextSpan(
                    text: "Live",
                    style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.pinkAccent, size: 26),
            onPressed: widget.onCreateRoom,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Horizontal Categories Bar (Hot, Event, Music, etc.)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: List.generate(categories.length, (i) {
                  final isSelected = _selectedCategoryIndex == i;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedCategoryIndex = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFFD700) : const Color(0xFF1E193D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[i],
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // 2. Event / Official Announcement Banner
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E0854), Color(0xFFFF007F), Color(0xFF00F2FE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFF007F).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Text("📢", style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🎉 MEGA FAMILY & RECHARGE EVENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("Win 50,000 💎 + Crown Badge This Week!", style: TextStyle(color: Colors.amberAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(12)),
                      child: const Text("Details >", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Section Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("🔥 POPULAR LIVE ROOMS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  Text("Explore All >", style: TextStyle(color: Colors.pinkAccent, fontSize: 11)),
                ],
              ),
            ),

            // 4. 2-Column Grid of Live Rooms
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.76,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
              ),
              itemCount: popularRooms.length,
              itemBuilder: (ctx, i) {
                final r = popularRooms[i];
                return InkWell(
                  onTap: () => widget.onJoinRoom(r["title"] as String),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E193D),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room Cover Image with Online Count & Tag
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                                child: Image.network(
                                  r["img"] as String,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFF2A2456),
                                    child: const Center(child: Icon(Icons.music_note, color: Colors.pinkAccent, size: 40)),
                                  ),
                                ),
                              ),
                              // Online Member Count (Top Right)
                              Positioned(
                                top: 6,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.equalizer, color: Colors.greenAccent, size: 10),
                                      const SizedBox(width: 3),
                                      Text("${r['online']}", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              // Category / Chat Tag (Bottom Left of Photo)
                              Positioned(
                                bottom: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: (r["tagColor"] as Color).withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    r["tag"] as String,
                                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Room Name & Seats Left Info
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r["title"] as String,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(Icons.chair_outlined, color: Colors.grey, size: 11),
                                  const SizedBox(width: 4),
                                  Text(
                                    r["seatsLeft"] as String,
                                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

