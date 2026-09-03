import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const LovePartyApp());

class LovePartyApp extends StatelessWidget {
  const LovePartyApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF131124),
      primaryColor: Colors.amber,
    ),
    home: const MainNav(),
  );
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [const ClubTab(), const FamilyTab0(), const MeTab()][tab],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tab,
      onTap: (v) => setState(() => tab = v),
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.white54,
      backgroundColor: const Color(0xFF0D0B18),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      ],
    ),
  );
}

class ClubTab extends StatelessWidget {
  const ClubTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Love Party Club 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF0D0B18)),
    body: Center(child: Text("Welcome to Club Rooms", style: TextStyle(color: Colors.white70, fontSize: 16))),
  );
}

class FamilyTab0 extends StatelessWidget {
  const FamilyTab0({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Family & Squads", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF0D0B18)),
    body: Center(child: Text("Family Hub", style: TextStyle(color: Colors.white70, fontSize: 16))),
  );
}

class MeTab extends StatefulWidget {
  const MeTab({super.key});
  @override State<MeTab> createState() => _MeTabTabState();
}

class _MeTabTabState extends State<MeTab> {
  File? _img;
  int diamonds = 5000000;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _img = File(picked.path));
  }

  void _recharge() {
    setState(() => diamonds += 100000);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully added 100,000 Diamonds! 💎")));
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF0D0B18),
      title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Icon(Icons.diamond, color: Colors.cyanAccent, size: 18),
        const SizedBox(width: 4),
        Text("$diamonds", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        CircleAvatar(radius: 12, backgroundColor: Colors.pinkAccent, child: IconButton(padding: EdgeInsets.zero, icon: const Icon(Icons.add, size: 14, color: Colors.white), onPressed: _recharge)),
      ]),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Stack(children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  backgroundImage: _img != null ? FileImage(_img!) : null,
                  child: _img == null ? const Icon(Icons.person, size: 40, color: Colors.black) : null,
                ),
                Positioned(bottom: 0, right: 0, child: InkWell(onTap: _pickImage, child: const CircleAvatar(radius: 12, backgroundColor: Colors.pinkAccent, child: Icon(Icons.camera_alt, size: 12, color: Colors.white)))),
              ]),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Love Party Owner", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text("ID: 001 (Super Owner)", style: TextStyle(fontSize: 13, color: Colors.amber)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1E1A38), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [
                      Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                      SizedBox(width: 6),
                      Text("Diamonds", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    ]),
                    const SizedBox(height: 4),
                    const Text("Wallet", style: TextStyle(fontSize: 13, color: Colors.white54)),
                    const SizedBox(height: 4),
                    Text("$diamonds 💎", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  onPressed: _recharge,
                  child: const Text("Recharge", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1E1A38), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Icon(Icons.admin_panel_settings, color: Colors.amber, size: 18),
                  SizedBox(width: 6),
                  Text("Super Owner Panel", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                ]),
                const SizedBox(height: 6),
                const Text("Offline Recharge / WhatsApp: +91 97793 53560", style: TextStyle(fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

