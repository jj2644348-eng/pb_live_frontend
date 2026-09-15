import 'package:flutter/material.dart';

void main() {
  runApp(const OfficialTechApp());
}

class OfficialTechApp extends StatelessWidget {
  const OfficialTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Official Tech PB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primarySwatch: Colors.pink,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const RoomsDiscoveryTab(),
    const LeaderboardTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Party Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Ranking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Profile'),
        ],
      ),
    );
  }
}

class RoomsDiscoveryTab extends StatelessWidget {
  const RoomsDiscoveryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech PB - Live Party'),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('🔥 Trending Voice Rooms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 10),
          _roomBannerCard(context, 'Official Tech PB Official Room', 'Lovepreet Singh', '5.2k', Colors.pinkAccent),
          _roomBannerCard(context, 'Punjabi Superstars & Music', 'DJ Karan', '3.8k', Colors.deepPurpleAccent),
          _roomBannerCard(context, 'Shayari & Sad Songs Club', 'Simran', '2.1k', Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _roomBannerCard(BuildContext context, String title, String host, String viewers, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color,
          child: const Icon(Icons.mic, color: Colors.white, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Host: $host', style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.visibility, size: 14, color: Colors.greenAccent),
                const SizedBox(width: 4),
                Text('$viewers Online', style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HeavyPartyRoomScreen()),
            );
          },
          child: const Text('Join', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class HeavyPartyRoomScreen extends StatelessWidget {
  const HeavyPartyRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech PB Party Room'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2b1055), Color(0xFF7597de)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('🎤 8-Seat Mic Party Active', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: index == 0 ? Colors.pink : Colors.white24,
                        child: Icon(index == 0 ? Icons.person : Icons.mic_none, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text('Seat ${index + 1}', style: const TextStyle(fontSize: 10, color: Colors.white70)),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black54,
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Send message to room...',
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
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

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Official Tech PB - Weekly Ranking')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Creator User ${index + 1}'),
            subtitle: const Text('Gifts Sent: 50,000 Coins'),
            trailing: const Icon(Icons.military_tech, color: Colors.amber),
          );
        },
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile - Official Tech PB')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 12),
            Text('Lovepreet Singh', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Brand: Official Tech Love PB', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
