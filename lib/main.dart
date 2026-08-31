import 'package:flutter/material.dart';

void main() {
  runAsPBLivePartyApp();
}

void runAsPBLivePartyApp() {
  runApp(const PBLivePartyApp());
}

class PBLivePartyApp extends StatelessWidget {
  const PBLivePartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Party',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFF3F2B96),
        colorScheme: const ColorScheme.dark(
          primary: Colors.pinkAccent,
          secondary: Colors.amber,
          surface: Color(0xFF1E193D),
        ),
        fontFamily: 'Roboto',
      ),
      home: const PBLiveMainContainer(),
    );
  }
}

class PBLiveMainContainer extends StatefulWidget {
  const PBLiveMainContainer({super.key});

  @override
  State<PBLiveMainContainer> createState() => _PBLiveMainContainerState();
}

class _PBLiveMainContainerState extends State<PBLiveMainContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PBLiveHomeScreen(),
    const PBLivePartyRoomsScreen(),
    const PBLiveMessagesScreen(),
    const PBLiveProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E193D),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic_rounded),
              label: 'Party Rooms',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// 1. Home Screen Stub
class PBLiveHomeScreen extends StatelessWidget {
  const PBLiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("PB Live Party - Home", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF3F2B96), Color(0xFF1F1C2C)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome to PB Live Party", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Official Tech Love PB Platform", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  Icon(Icons.star, color: Colors.amber, size: 36),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Live Audio Rooms", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF1E193D),
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.pinkAccent,
                        child: Icon(Icons.mic, color: Colors.white),
                      ),
                      title: Text("PB Official Room #${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: const Text("Host: ID 0001 (Owner)\n15 Seats Available", style: TextStyle(color: Colors.white60, fontSize: 12)),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Party Rooms Screen Stub
class PBLivePartyRoomsScreen extends StatelessWidget {
  const PBLivePartyRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("15-Seater Party Rooms", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text("Party Rooms Grid & Audio Engine Integration Area", style: TextStyle(color: Colors.white70)),
      ),
    );
  }
}

// 3. Messages Screen Stub
class PBLiveMessagesScreen extends StatelessWidget {
  const PBLiveMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("Messages & Chats", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text("Direct Messages and System Notifications", style: TextStyle(color: TextStyle(color: Colors.white70).color)),
      ),
    );
  }
}

// 4. Profile Screen Stub (Owner ID 0001, Blue Tick, WhatsApp Recharge)
class PBLiveProfileScreen extends StatelessWidget {
  const PBLiveProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("My Profile", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("Lovepreet Singh", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6),
                        Icon(Icons.verified, color: Colors.blue, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("ID: 0001 (Official Owner)", style: TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.electric_bolt, color: Colors.amber),
                      SizedBox(width: 8),
                      Text("Offline Recharge (Official Owner)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text("WhatsApp Official Number: +91 9779353560", style: TextStyle(color: Colors.greenAccent, fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("• 10,000 Diamonds = ₹100\n• 50,000 Diamonds = ₹500\n• 1,00,000 Diamonds = ₹1,000\n• 5,000,000 Diamonds = ₹5,000", style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

