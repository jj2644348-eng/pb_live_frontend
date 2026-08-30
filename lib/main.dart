import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- CURRENT USER SESSION ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 100000;
  static bool isOwner = true;
}

// ---------------- MAIN CLUB SHELL ----------------
class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});

  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      "name": "👑 Tech Love PB Official Club",
      "host": "Love Party Owner",
      "hostId": "0001",
      "active": "8/8 Live",
      "avatar": "👑"
    },
    {
      "name": "🔥 Punjabi Beats & DJ Party",
      "host": "Aman Deep",
      "hostId": "88451290",
      "active": "5/8 Live",
      "avatar": "🎧"
    },
    {
      "name": "🌹 Friends Gossip & Shayari",
      "host": "Riya Sharma",
      "hostId": "55219034",
      "active": "3/8 Live",
      "avatar": "🎤"
    },
  ];

  void _openCreateRoomModal() {
    final titleCtrl = TextEditingController();
    String selAvatar = "🔥";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setMState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🎙️ Create Live Party Room",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter Room Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color(0xFF161230),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["🔥", "👑", "🎤", "🌹", "🎧"].map((emoji) {
                      return InkWell(
                        onTap: () => setMState(() => selAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selAvatar == emoji ? const Color(0xFFFF007F) : const Color(0xFF2A2456),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 20)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                      onPressed: () {
                        final name = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Room" : titleCtrl.text.trim();
                        final newRoom = {
                          "name": name,
                          "host": CurrentUser.name,
                          "hostId": CurrentUser.id,
                          "active": "1/8 Live",
                          "avatar": selAvatar,
                        };
                        setState(() => rooms.insert(0, newRoom));
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => LiveRoomScreen(
                              roomData: newRoom,
                              onUpdate: () => setState(() {}),
                            ),
                          ),
                        );
                      },
                      child: const Text("Go Live Now 🚀", style: TextStyle(color: Colors.white)),
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

  void _openRechargeSheet() {
    final plans = [
      {"inr": "₹10", "diamonds": "100 💎", "tag": "Starter"},
      {"inr": "₹50", "diamonds": "550 💎", "tag": "+50 Bonus"},
      {"inr": "₹100", "diamonds": "1,200 💎", "tag": "Popular (+200)"},
      {"inr": "₹500", "diamonds": "6,500 💎", "tag": "VIP (+1500)"},
      {"inr": "₹1,000", "diamonds": "15,000 💎", "tag": "Mega (+5000)"},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("💎 Diamond Recharge Shop", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              ...plans.map((p) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(p["diamonds"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text(p["tag"]!, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Recharge for ${p["diamonds"]}! Contact WhatsApp: +91 97793 53560"), backgroundColor: Colors.green),
                          );
                        },
                        child: Text(p["inr"]!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
            ],
          ),
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
            TextField(
              controller: idCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Receiver 8-Digit ID", labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: amtCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Transferred ${amtCtrl.text} Diamonds to ID: ${idCtrl.text}"), backgroundColor: Colors.green),
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
        title: Text(_tabIndex == 0 ? "PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile"),
        actions: [
          Center(
            child: Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFFF007F),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
            onPressed: _openCreateRoomModal,
          )
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
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
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final r = rooms[index];
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
                        MaterialPageRoute(
                          builder: (c) => LiveRoomScreen(roomData: r, onUpdate: () => setState(() {})),
                        ),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 34, backgroundColor: Colors.amber, child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 32))),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                  Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                  const Text("👑 Master Super Owner", style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]),
              borderRadius: BorderRadius.circular(14),
            ),
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
          const SizedBox(height: 14),
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

// ---------------- LIVE AUDIO ROOM SCREEN ----------------
class LiveRoomScreen extends StatefulWidget {
  final Map<String, dynamic> roomData;
  final VoidCallback onUpdate;

  const LiveRoomScreen({super.key, required this.roomData, required this.onUpdate});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  bool isMic = false;
  late List<Map<String, String>?> seats;
  final List<String> chats = ["💬 Welcome to Party Room!"];
  final TextEditingController chatCtrl = TextEditingController();

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
    seats = List.generate(8, (i) {
      if (i == 0) {
        return {
          "name": widget.roomData["host"] as String,
          "id": widget.roomData["hostId"] as String,
          "avatar": widget.roomData["avatar"] as String
        };
      }
      return null;
    });
  }

  void handleSeatClick(int index) {
    setState(() {
      if (seats[index] == null) {
        seats[index] = {"name": CurrentUser.name, "id": CurrentUser.id, "avatar": CurrentUser.avatar};
        chats.add("📢 ${CurrentUser.name} joined Seat ${index + 1}");
      } else if (seats[index]!["id"] == CurrentUser.id) {
        seats[index] = null;
        chats.add("📢 ${CurrentUser.name} left Seat ${index + 1}");
      }
    });
  }

  void sendGift(Map<String, dynamic> gift) {
    int cost = gift["cost"] as int;
    if (CurrentUser.coins >= cost) {
      setState(() {
        CurrentUser.coins -= cost;
        chats.add("🎁 ${CurrentUser.name} sent ${gift["icon"]} ${gift["name"]} (${gift["inr"]} / -$cost 💎)");
      });
      widget.onUpdate();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Not enough diamonds!"), backgroundColor: Colors.red),
      );
    }
  }

  void openGiftSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (c) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 320,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Send Club Gift", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
