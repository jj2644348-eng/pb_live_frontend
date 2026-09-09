import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PB Party Live Voice Club',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF130F26),
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
    const ClubHomePage(),
    const FamilyPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF130F26),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Club',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Family',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

// 1. Club Home Page Structure
class ClubHomePage extends StatelessWidget {
  const ClubHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1438),
        title: const Text('PB Party Live Voice Club', style: TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: const [
                  Icon(Icons.diamond, color: Colors.cyanAccent, size: 20),
                  SizedBox(width: 4),
                  Text('5000000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          // Banner Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '🔥 PB PARTY LIVE VOICE CLUB\nRECHARGE • WhatsApp: +91 97793 53560',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          
          // Rooms List Grid/Items
          _buildRoomItem('Tech Love PB Club (8/8)', 'Live audio chatting & fun'),
          _buildRoomItem('Punjabi Beats Party (6/8)', 'Live audio chatting & fun'),
          _buildRoomItem('Friends Gossip Club (4/8)', 'Live audio chatting & fun'),
          _buildRoomItem('PK Live Battle (7/8)', 'Live audio chatting & fun'),
        ],
      ),
    );
  }

  Widget TextStyle({required Color color, required FontWeight fontWeight, double? fontSize}) {
    return Text('', style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize));
  }

  Widget _buildRoomItem(String title, String subtitle) {
    return Card(
      color: const Color(0xFF1E183B),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.mic, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
          onPressed: () {},
          child: const Text('Join', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// 2. Family Page Structure
class FamilyPage extends StatelessWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Family Section', style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}

// 3. Profile / Me Page Structure
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130F26),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.star, size: 35, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Love Party Owner', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('ID: 0001 (Super Owner)', style: TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E183B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Diamonds Wallet', style: TextStyle(color: Colors.white54)),
                      SizedBox(height: 4),
                      Text('5000000 💎', style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
                    onPressed: () {},
                    child: const Text('Recharge', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E183B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.admin_panel_settings, color: Colors.pinkAccent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Super Owner Panel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Offline Recharge / WhatsApp: +91 97793 53560', style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
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

