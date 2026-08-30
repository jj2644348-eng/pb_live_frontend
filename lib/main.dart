import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: LoginAuthScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- USER SESSION & STATE ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 5000000;
  static bool isOwner = true;
  static const String masterOwnerId = "0001";
}

// Global Rooms List
List<Map<String, dynamic>> globalRooms = [
  {"id": "101", "name": "👑 Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Full", "avatar": "👑", "tag": "Official"},
  {"id": "102", "name": "🔥 Punjabi Beats & Shayari", "host": "Aman Deep", "hostId": "88451290", "active": "5/8 Live", "avatar": "🎤", "tag": "Music"},
  {"id": "103", "name": "🌹 Friends Gossip & Chill", "host": "Riya Sharma", "hostId": "55219034", "active": "3/8 Live", "avatar": "🎧", "tag": "Chat"},
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
                  hintText: "Enter Your Display Name",
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
                    const Text("👑 Super Master Mode (ID: 0001)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
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
                  const Text("Choose Room Icon / Avatar:", style: TextStyle(color: Colors.white70, fontSize: 13)),
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
                          "tag": "Party"
                        };
                        setState(() {
                          globalRooms.insert(0, newRoom);
                        });
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: newRoom, onUpdate: () => setState(() {}))),
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
                    // TOP RIGHT PLUS BUTTON TO CREATE ROOM
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
                        MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: r, onUpdate: () => setState(() {}))),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                                const SizedBox(height: 4),
                                Text("Host: ${r["host"]} (ID: ${r["hostId"]})", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                const SizedBox(height: 4),
                                Text(r["active"] as String, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: r, onUpdate: () => setState(() {}))),
                              );
                            },
                            child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyScreen() {
    return const Center(
      child: Text("👥 Official PB Family Club\nJoin Battles and Earn Rewards!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
    );
  }

  Widget _buildMeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: CurrentUser.isOwner ? Colors.amber : Colors.pinkAccent,
                  child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 34)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(CurrentUser.isOwner ? "👑 Master Super Owner" : "⭐ Verified Member", style: TextStyle(color: CurrentUser.isOwner ? Colors.amberAccent : Colors.grey, fontSize: 11)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white70),
                  onPressed: _openEditProfileDialog,
                )
              ],
            ),
            const SizedBox(height: 20),

            // WALLET CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("💎 Diamond Wallet Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Recharge Gateway: 100 💎 = ₹10"), backgroundColor: Colors.purple));
                        },
                        child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SUPER OWNER CONTROL
            if (CurrentUser.isOwner)
              Card(
                color: const Color(0xFF1E193D),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
                  title: const Text("👑 Super Owner Panel (0001)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text("Transfer Diamonds by 8-Digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                  onTap: _openTransferDialog,
                ),
              ),

            _buildMenuItem(Icons.card_giftcard, "My Gift Backpack"),
            _buildMenuItem(Icons.security, "Privacy & Safety"),
            _buildMenuItem(Icons.settings, "App Settings"),
            ListTile(
              tileColor: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Ic
