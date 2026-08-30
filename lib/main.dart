import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- USER SESSION ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 5000000;
  static int level = 25;
  static bool isOwner = true;
}

List<Map<String, dynamic>> globalRooms = [
  {
    "id": "101",
    "name": "👑 Tech Love PB Official Club",
    "host": "Love Party Owner",
    "hostId": "0001",
    "active": "8/8 Live",
    "avatar": "👑",
  },
  {
    "id": "102",
    "name": "🔥 Punjabi Beats & DJ Party",
    "host": "Aman Deep",
    "hostId": "88451290",
    "active": "5/8 Live",
    "avatar": "🎧",
  },
  {
    "id": "103",
    "name": "🌹 Friends Gossip & Shayari",
    "host": "Riya Sharma",
    "hostId": "55219034",
    "active": "3/8 Live",
    "avatar": "🎤",
  },
];

// ---------------- MAIN SHELL ----------------
class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});

  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;

  void _openCreateRoom() {
    final titleCtrl = TextEditingController();
    String selectedAvatar = "🔥";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🎙️ Create Live Party Room",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Room Name / Topic",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF161230),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Select Room Icon:",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["🔥", "👑", "🎤", "🌹", "🎧", "⚔️"].map((emoji) {
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedAvatar == emoji
                                ? const Color(0xFFFF007F)
                                : const Color(0xFF2A2456),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF007F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final roomName = titleCtrl.text.trim().isEmpty
                            ? "${CurrentUser.name}'s Room"
                            : titleCtrl.text.trim();
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
                          MaterialPageRoute(
                            builder: (c) => LiveAudioRoomScreen(
                              roomData: newRoom,
                              onUpdate: () => setState(() {}),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Go Live Now 🚀",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  void _openRechargeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text("💎 Offline Diamond Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Recharge Rate: 100 💎 = ₹10\nPayment: UPI / GPay / PhonePe", style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Divider(color: Colors.white24, height: 16),
            const Text("WhatsApp Official Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("WhatsApp: +91 97793 53560"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Chat on WhatsApp", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _openEditProfileDialog() {
    final nameCtrl = TextEditingController(text: CurrentUser.name);
    String tempAvatar = CurrentUser.avatar;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("Edit Profile & Avatar", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: const Color(0xFFFF007F),
                child: Text(tempAvatar, style: const TextStyle(fontSize: 35)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Nickname",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 14),
              const Text("Choose Your VIP Avatar:", style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ["👑", "👤", "🎧", "🌹", "⚡", "🔥", "💎", "🦁", "👸", "🦸"].map((a) {
                  return InkWell(
                    onTap: () => setDState(() => tempAvatar = a),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: tempAvatar == a ? const Color(0xFFFF007F) : const Color(0xFF2A2456),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(a, style: const TextStyle(fontSize: 20)),
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
                  CurrentUser.name = nameCtrl.text.trim().isEmpty ? CurrentUser.name : nameCtrl.text.trim();
                  CurrentUser.avatar = tempAvatar;
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
        title: Text(
          _tabIndex == 0 ? "Official PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(
              child: Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFFF007F),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
            onPressed: _openCreateRoom,
          ),
        ],
      ),
      body: _tabIndex == 0
          ? _buildHomeScreen()
          : _tabIndex == 1
              ? const Center(child: Text("👥 Official PB Family Club\nLevel 5 Club Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)))
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
                      Text("💎 RECHARGE • WhatsApp: +91 97793 53560", style: TextStyle(color: Colors.amberAccent, fontSize: 10)),
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
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF2A2456),
                    child: Text(r["avatar"] as String, style: const TextStyle(fontSize: 22)),
                  ),
                  title: Text(r["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text("Host: ${r["host"]} (ID: ${r["hostId"]}) • ${r["active"]}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => LiveAudioRoomScreen(
                            roomData: r,
                            onUpdate: () => setState(() {}),
                          ),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: CurrentUser.isOwner ? Colors.amber : const Color(0xFFFF007F),
                child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 34)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      CurrentUser.isOwner ? "👑 Master Super Owner (Lv. ${CurrentUser.level})" : "⭐ Member (Lv. ${CurrentUser.level})",
                      style: TextStyle(color: CurrentUser.isOwner ? Colors.amberAccent : Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.edit, color: Colors.white70), onPressed: _openEditProfileDialog)
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]),
              borderRadius: BorderRadius.circular(16),
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
                  onPressed: _openRechargeDialog,
                  child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: Fo
