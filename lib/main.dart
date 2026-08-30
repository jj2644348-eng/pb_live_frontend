import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- USER SESSION & ECONOMY ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 100000; // Starting Owner Balance
  static int level = 25;
  static bool isOwner = true;
}

List<Map<String, dynamic>> globalRooms = [
  {"id": "101", "name": "👑 Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Live", "avatar": "👑"},
  {"id": "102", "name": "🔥 Punjabi Beats & DJ Party", "host": "Aman Deep", "hostId": "88451290", "active": "5/8 Live", "avatar": "🎧"},
  {"id": "103", "name": "🌹 Friends Gossip & Shayari", "host": "Riya Sharma", "hostId": "55219034", "active": "3/8 Live", "avatar": "🎤"},
];

// ---------------- MAIN SHELL ----------------
class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});

  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;

  void _openRechargeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        final plans = [
          {"inr": "₹10", "diamonds": "100 💎", "tag": "Starter"},
          {"inr": "₹50", "diamonds": "550 💎", "tag": "+50 Bonus"},
          {"inr": "₹100", "diamonds": "1,200 💎", "tag": "Popular (+200)"},
          {"inr": "₹500", "diamonds": "6,500 💎", "tag": "VIP (+1500)"},
          {"inr": "₹1,000", "diamonds": "15,000 💎", "tag": "Mega (+5000)"},
        ];

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("💎 Diamond Recharge Shop", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                  Text("My ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              const Text("Select Coin Pack (Offline WhatsApp UPI Recharge):", style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 10),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: plans.length,
                  itemBuilder: (c, i) {
                    final p = plans[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const CircleAvatar(backgroundColor: Colors.amber, child: Text("💎", style: TextStyle(fontSize: 18))),
                        title: Text(p["diamonds"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(p["tag"]!, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                          onPressed: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Selected ${p["inr"]} for ${p["diamonds"]}. WhatsApp: +91 97793 53560"), backgroundColor: Colors.green),
                            );
                          },
                          child: Text(p["inr"]!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openCreateRoom() {
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
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
                      hintText: "Enter Room Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF161230),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text("Room Theme Icon:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["🔥", "👑", "🎤", "🌹", "🎧", "⚔️"].map((emoji) {
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedAvatar == emoji ? const Color(0xFFFF007F) : const Color(0xFF2A2456),
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
                          MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: newRoom, onUpdate: () => setState(() {}))),
                        );
                      },
                      child: const Text("Go Live Now 🚀", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openOwnerTransferDialog() {
    final idCtrl = TextEditingController();
    final amtCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("👑 Master Coin Transfer", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Target 8-Digit ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Transferred ${amtCtrl.text} Diamonds to ID: ${idCtrl.text}!"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Transfer", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tabIndex == 0 ? "Official PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(
              child: Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          IconButton(
            icon: const CircleAvatar(radius: 14, backgroundColor: Color(0xFFFF007F), child: Icon(Icons.add, color: Colors.white, size: 18)),
            onPressed: _openCreateRoom,
          ),
        ],
      ),
      body: _tabIndex == 0
          ? _buildHomeScreen()
          : _tabIndex == 1
              ? const Center(child: Text("👥 Official PB Family Club\nLevel 5 Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)))
              : _buildProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF2E0854), Color(0xFFFF007F), Color(0xFF00F2FE)]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: Colors.black26, child: Text("👑", style: TextStyle(fontSize: 22))),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🔥 PB PARTY LIVE VOICE CLUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      Text("💎 ₹10 = 100 💎 • ₹100 = 1,200 💎", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                ),
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
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: const Color(0xFF2A2456), child: Text(r["avatar"] as String, style: const TextStyle(fontSize: 22))),
                  title: Text(r["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text("Host: ${r["host"]} • ${r["active"]}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => LiveAudioRoomScreen(roomData: r, onUpdate: () => setState(() {}))),
                      );
                    },
                    child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 36, backgroundColor: CurrentUser.isOwner ? Colors.amber : const Color(0xFFFF007F), child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 34))),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    Text(CurrentUser.isOwner ? "👑 Master Super Owner" : "⭐ Club Member", style: TextStyle(color: CurrentUser.isOwner ? Colors.amberAccent : Colors.grey, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]), borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("💎 Diamond Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: _openRechargeSheet,
                  child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (CurrentUser.isOwner)
            Card(
              color: const Color(0xFF1E193D),
              child: ListTile(
                leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
                title: const Text("👑 Super Owner Panel (0001)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text("Transfer Diamonds by 8-Digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                onTap: _openOwnerTransferDialog,
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- LIVE AUDIO ROOM SCREEN & CALCULATED GIFTS ----------------
class LiveAudioRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  final VoidCallback onUpdate;

  const LiveAudioRoomScreen({super.key, required this.roomData, required this.onUpdate});

  @override
  State<LiveAudioRoomScreen> createState() => _LiveAudioRoomScreenState();
}

class _LiveAudioRoomScreenState extends State<LiveAudioRoomScreen> with SingleTickerProviderStateMixin {
  bool isMic = false;
  late AnimationController _waveAnimCtrl;
  late List<Map<String, String>?> seats;
  final List<String> chats = [];
  final TextEditingController chatCtrl = TextEditingController();

  // REAL CALCULATED GIFTING SYSTEM (100 Coins = ₹10)
  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose", "cost": 10, "icon": "🌹", "inr": "₹1"},
    {"name": "Coffee", "cost": 50, "icon": "☕", "inr": "₹5"},
    {"name": "Golden Mic", "cost": 100, "icon": "🎤", "inr": "₹10"},
    {"name": "VIP Crown", "cost": 500, "icon": "👑", "inr": "₹50"},
    {"name": "Supercar", "cost": 1200, "icon": "🏎️", "inr": "₹100"},
    {"name": "Rocket", "cost": 6500, "icon": "🚀", "inr": "₹500"},
    {"name": "VIP Castle", "cost": 15000, "icon": "🏰", "inr": "₹1000"},
  ];

  @override
  void initState() {
    super.initState();
    _waveAnimCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..repeat(reverse: true);

    seats = List.generate(8, (i) {
      if (i == 0) {
        return {"name": widget.roomData["host"] as String, "id": widget.roomData["hostId"] as String, "avatar": widget.roomData["avatar"] as String};
      }
      return null;
    });

    chats.add("👑 Host: ${widget.roomData["host"]} (ID: ${widget.roomData["hostId"]})");
    chats.add("💬 Welcome to ${widget.roomData["name"]}!");
  }

  @override
  void dispose() {
    _waveAnimCtrl.dispose();
    chatCtrl.dispose();
    super.dispose();
  }

  void handleSeatClick(int index) {
    setState(() {
      if (seats[index] == null) {
        seats[index] = {"name": CurrentUser.name, "id": CurrentUser.id, "avatar": CurrentUser.avatar};
        chats.add("📢 ${CurrentUse
