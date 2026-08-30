import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});

  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;
  int diamonds = 5000000;
  String myId = "0001";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tabIndex == 0 ? "PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Text("💎 $diamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          )
        ],
      ),
      body: _tabIndex == 0
          ? HomeScreen(myId: myId, diamonds: diamonds)
          : _tabIndex == 1
              ? const Center(child: Text("👥 Official PB Family Club", style: TextStyle(color: Colors.white70, fontSize: 16)))
              : _buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 30, backgroundColor: Colors.amber, child: Text("👑", style: TextStyle(fontSize: 26))),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Love Party Owner", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("ID: $myId (Super Owner)", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.amber),
              title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)),
              trailing: Text("$diamonds 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.pinkAccent),
              title: const Text("👑 Super Owner Panel", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Offline Recharge / WhatsApp: +91 97793 53560", style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
            ),
          ),
        ],
      ),
    );
  }
}
