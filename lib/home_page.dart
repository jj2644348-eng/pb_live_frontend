import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131124),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // Top Search Bar & Icons
            Row(
              children: [
                const Icon(Icons.hub, color: Colors.pinkAccent, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF221E3F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.white54, size: 20),
                        hintText: "Search People...",
                        hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                const SizedBox(width: 12),
                const CircleAvatar(radius: 14, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 16, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 15),

            // Circular Shortcut Icons (My Room, Quick Join, etc.)
            SizedBox(
              height: 85,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildShortcutItem(Icons.home, "My Room", Colors.pinkAccent),
                  _buildShortcutItem(Icons.chat_bubble, "Quick Join", Colors.cyan),
                  _buildShortcutItem(Icons.star, "Boss Babe", Colors.amber),
                  _buildShortcutItem(Icons.weekend, "Cozy Corner", Colors.purpleAccent),
                  _buildShortcutItem(Icons.flash_on, "Trending", Colors.orange),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Find Your Vibe Banner
            Container(
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF8B2284), Color(0xFFE040FB)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("✨ Find Your Vibe", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Join live dating & party rooms", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Country Filter Chips
            SizedBox(
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("All", true),
                  _buildFilterChip("🇦🇫 Afghanistan", false),
                  _buildFilterChip("🇦🇱 Albania", false),
                  _buildFilterChip("🇩🇿 Algeria", false),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Room Cards List
            _buildRoomCard("The Glam Room ✨", "Welcome to The Glam Room. Drop your mic, share your voice...", "38"),
            _buildRoomCard("Pink Palace 🎀👑", "Step into the Pink Palace - sparkle, sass, and all things pretty live here.", "91"),
            _buildRoomCard("Moon Lounge 🛋️✨", "Enter the Moon Lounge - silence is golden here.", "95"),
            _buildRoomCard("Doll House 🏰", "Welcome to the Doll House live audio party.", "64"),
          ],
        ),
      ),
    );
  }

  static Widget _buildShortcutItem(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(radius: 26, backgroundColor: color, child: Icon(icon, color: Colors.white, size: 22)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.pinkAccent : const Color(0xFF221E3F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  static Widget _buildRoomCard(String title, String desc, String fireCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2A1B4E), Color(0xFF1B1436)]),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.mic, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber)),
                const SizedBox(height: 4),
                Text(desc, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text(fireCount, style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.pinkAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                      child: const Text("Public Room", style: TextStyle(fontSize: 10, color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

