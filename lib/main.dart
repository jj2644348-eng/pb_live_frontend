import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: LoginAuthScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- USER SESSION ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 5000000;
  static bool isOwner = true;
  static const String masterOwnerId = "0001";
}

List<Map<String, dynamic>> globalRooms = [
  {"id": "101", "name": "Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Full", "avatar": "👑"},
  {"id": "102", "name": "Punjabi Beats & Shayari", "host": "Aman Deep", "hostId": "88451290", "active": "5/8 Live", "avatar": "🎤"},
  {"id": "103", "name": "Friends Gossip & Chill", "host": "Riya Sharma", "hostId": "55219034", "active": "3/8 Live", "avatar": "🎧"},
];

// ---------------- LOGIN SCREEN ----------------
class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({super.key});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  bool isMaster = true;

  void login() {
    String n = nameCtrl.text.trim();
    if (isMaster) {
      CurrentUser.id = "0001";
      CurrentUser.name = n.isEmpty ? "Love Party Owner" : n;
      CurrentUser.coins = 99999999;
      CurrentUser.isOwner = true;
      CurrentUser.avatar = "👑";
    } else {
      CurrentUser.id = (10000000 + Random().nextInt(90000000)).toString();
      CurrentUser.name = n.isEmpty ? "Tech Clubber" : n;
      CurrentUser.coins = 2000;
      CurrentUser.isOwner = false;
      CurrentUser.avatar = "👤";
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainNavigationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(radius: 46, backgroundColor: Color(0xFF1E193D), child: Text("👑", style: TextStyle(fontSize: 48))),
              const SizedBox(height: 14),
              const Text("Official Tech Love PB", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const Text("VIP Live Party & Voice Rooms", style: TextStyle(color: Colors.pinkAccent, fontSize: 13)),
              const SizedBox(height: 35),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Display Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E193D),
                  prefixIcon: const Icon(Icons.person, color: Colors.pinkAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                  label: const Text("Sign in with Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: login,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFF1A1635), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.amber.withOpacity(0.4))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("👑 Master Mode (ID: 0001)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    Switch(value: isMaster, activeColor: Colors.amber, onChanged: (v) => setState(() => isMaster = v)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- MAIN NAVIGATION ----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void openCreateRoomModal() {
    final titleCtrl = TextEditingController();
    String selectedAvatar = "🔥";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Create Live Party Room", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  TextField(
                    controller: titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Room Name / Topic",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF161230),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text("Choose Avatar:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["🔥", "👑", "🎤", "🌹", "💎", "⚔️"].map((emoji) {
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedAvatar == emoji ? Colors.pinkAccent : const Color(0xFF2A2456),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 22)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        final roomName = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Party" : titleCtrl.text.trim();
                        final newRoom = {
                          "id": Random().nextInt(99999).toString(),
                          "name": roomName,
                          "host": CurrentUser.name,
                          "hostId": CurrentUser.id,
                          "active": "1/8 Live",
                          "avatar": selectedAvatar,
                        };
                        setState(() {
                          globalRooms.insert(0, newRoom);
                        });
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: newRoom)),
                        );
                      },
                      child: const Text("Go Live Now 🚀", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openEditProfileDialog() {
    final editCtrl = TextEditingController(text: CurrentUser.name);
    String selAvatar = CurrentUser.avatar;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Display Name", labelStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["👑", "👤", "🎧", "🌹", "⚡"].map((a) {
                  return InkWell(
                    onTap: () => setDState(() => selAvatar = a),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: selAvatar == a ? Colors.pinkAccent : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                      child: Text(a, style: const TextStyle(fontSize: 22)),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
              onPressed: () {
                setState(() {
                  CurrentUser.name = editCtrl.text.trim().isEmpty ? CurrentUser.name : editCtrl.text.trim();
                  CurrentUser.avatar = selAvatar;
                });
                Navigator.pop(ctx);
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  void _openTransferDialog() {
    final idCtrl = TextEditingController();
    final amtCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Owner Coin Transfer", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Target 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transferred ${amtCtrl.text} Diamonds to ID: ${idCtrl.text}!"), backgroundColor: Colors.green));
            },
            child: const Text("Transfer", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Card(
      color: const Color(0xFF1E193D),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title Active"), duration: const Duration(seconds: 1)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildHomeScreen(),
      _buildFamilyScreen(),
      _buildMeScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Club"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1635),
              border: Border(bottom: BorderSide(color: Color(0xFF2A2456), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Official Tech Love PB", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("My ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const Text("💎 ", style: TextStyle(fontSize: 12)),
                          Text("${CurrentUser.coins}", style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFFFF007F),
                        child: Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                      onPressed: openCreateRoomModal,
                    )
                  ],
                )
              ],
            ),
          ),

          // INBUILT 3D NEON EVENT BANNER
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E0854), Color(0xFFFF007F), Color(0xFF7928CA), Color(0xFF00F2FE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black26,
                    child: Text("👑", style: TextStyle(fontSize: 26)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🔥 PB PARTY - LIVE VOICE CLUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                        SizedBox(height: 2),
                        Text("💎 REAL COIN SALE • WhatsApp: +91 97793 53560", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text("LIVE", style: TextStyle(color: Color(0xFFFF007F), fontWeight: FontWeight.bold, fontSize: 11)),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: globalRooms.length,
              itemBuilder: (context, index) {
                final r = globalRooms[index];
                return Card(
                  color: const Color(0xFF1E193D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: r)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFF2A2456),
                            child: Text(r["avatar"] as String, style: const TextStyle(fontSize: 22)),
                          ),
                          const SizedBox(width: 12),
                        
