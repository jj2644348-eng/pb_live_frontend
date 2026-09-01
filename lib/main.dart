import 'package:flutter/material.dart';
import 'room_screen.dart';
import 'wallet_screen.dart';
import 'admin_panel.dart';

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
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int idx = 0;
  final screens = const [HomeTab(), RoomsTab(), MessageTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => idx = i),
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

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
          icon: const Icon(Icons.mic),
          label: const Text("Join Official Party Room"),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomScreen(roomName: "PB Official Hub"))),
        ),
      ),
    );
  }
}

class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});
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
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mic, color: Colors.amber, size: 36), SizedBox(height: 8), Text("Audio Live Room", style: TextStyle(color: Colors.white))]),
          ),
        ),
      ),
    );
  }
}

class MessageTab extends StatelessWidget {
  const MessageTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: ListView(children: const [ListTile(leading: CircleAvatar(child: Text("L")), title: Text("Liyana"), subtitle: Text("Hi there! 👋"))]),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: const [CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 35)), SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), Text("ID: 10590491 | 🛡️ Admin", style: TextStyle(color: Colors.white54, fontSize: 12))])]),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Diamonds: 99,99,999", style: TextStyle(color: Colors.amber)), Text("Wallet >", style: TextStyle(color: Colors.pinkAccent))]),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 40)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminWindowPanel())),
              child: const Text("Open Owner & Reseller Panel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

