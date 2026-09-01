import 'package:flutter/material.dart';
import 'admin_panel.dart';
import 'room_screen.dart';

void main() => runApp(const PBApp());

class PBApp extends StatelessWidget {
  const PBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: Colors.pinkAccent,
      ),
      home: const MobileMainScreen(),
    );
  }
}

class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({super.key});

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RoomsTabScreen(),
    const MessagesTabScreen(),
    const ProfileTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
          icon: const Icon(Icons.mic),
          label: const Text("Join Official Party Room"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RoomScreen(roomName: "PB Party Hub")),
          ),
        ),
      ),
    );
  }
}

class RoomsTabScreen extends StatelessWidget {
  const RoomsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 4,
        itemBuilder: (c, i) => InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoomScreen(roomName: "Party Room ${i + 1}"))),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pinkAccent)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.mic, color: Colors.amber, size: 36),
                SizedBox(height: 8),
                Text("Audio Live Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessagesTabScreen extends StatelessWidget {
  const MessagesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: ListView(
        children: const [
          ListTile(leading: CircleAvatar(child: Text("L")), title: Text("Liyana"), subtitle: Text("Hi there! 👋")),
        ],
      ),
    );
  }
}

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminWindowPanel())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(radius: 35, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 40, color: Colors.white)),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text("ID: 10590491 | 🛡️ Official Admin", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Diamonds: 99,99,999 (Unlimited)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  Text("Wallet", style: TextStyle(color: Colors.pinkAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 45)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminWindowPanel())),
              child: const Text("Super Admin & Owner Panel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

