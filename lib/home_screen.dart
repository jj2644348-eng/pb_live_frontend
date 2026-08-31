import 'package:flutter/material.dart';
import 'party_room_screen.dart'; // जो पार्टी रूम वाली फाइल हमने पहले बनाई थी

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // सैंपल रूम्स (जो अभी दिखेंगे, बाद में डेटाबेस/यूजर आने पर ये लाइव डेटा से बदल जाएंगे)
    final List<Map<String, dynamic>> sampleRooms = [
      {
        "name": "The Glam Room✨",
        "desc": "Welcome to The Glam Room✨ Drop your mic, share your voice...",
        "heat": 60,
        "type": "Public Room",
        "image": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500",
      },
      {
        "name": "Pink Palace🎀👑",
        "desc": "Step into the Pink Palace – sparkle ✨, sass 😘...",
        "heat": 96,
        "type": "Public Room",
        "image": "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500",
      },
      {
        "name": "Moon Lounge🛋️✨",
        "desc": "Enter the Moon Lounge – silence is golden here.",
        "heat": 114,
        "type": "Public Room",
        "image": "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=500",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF141026),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. टॉप बार: सर्च बार और प्रोफाइल/ट्रॉफी आइकॉन (जैसे फोटो 13434.jpg में है)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search People...",
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                          icon: Icon(Icons.search, color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.pinkAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. शॉर्टकट बबल्स (My Room, Quick Join, आदि)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShortcutBubble("My Room", Icons.home, Colors.pinkAccent),
                  _buildShortcutBubble("Quick Join", Icons.chat_bubble, Colors.blueAccent),
                  _buildShortcutBubble("Boss Babe", Icons.star, Colors.amber),
                  _buildShortcutBubble("Cozy Corner", Icons.favorite, Colors.purpleAccent),
                ],
              ),
              const SizedBox(height: 20),

              // 3. "Find Your Vibe" बैनर
              Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Find Your Vibe", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("Join live dating & party rooms", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.phone_android, color: Colors.white38, size: 50),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. देश / फिल्टर टैब्स (All, Afghanistan, Albania...)
              SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterTab("All", true),
                    _buildFilterTab("Afghanistan", false),
                    _buildFilterTab("Albania", false),
                    _buildFilterTab("Algeria", false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. एक्टिव रूम्स की लिस्ट (फोटो के साथ)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sampleRooms.length,
                itemBuilder: (context, index) {
                  final room = sampleRooms[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E193D),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        // रूम की फोटो
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            room["image"],
                            width: 65,
                            height: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // रूम का नाम और विवरण
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room["name"],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                room["desc"],
                                style: const TextStyle(color: Colors.white60, fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Text("🔥 ", style: TextStyle(fontSize: 12)),
                                  Text("${room["heat"]}", style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      room["type"],
                                      style: const TextStyle(color: Colors.pinkAccent, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Join बटन जिसपर क्लिक करके सीधे रूम के अंदर (PartyRoomScreen) जा सकते हैं
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PartyRoomScreen(roomName: room["name"]),
                              ),
                            );
                          },
                          child: const Text("Join", style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // शॉर्टकट बबल विजेट
  Widget _buildShortcutBubble(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  // फिल्टर टैब विजेट
  Widget _buildFilterTab(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.pinkAccent : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

