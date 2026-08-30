import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 100000;
  static bool isOwner = true;
}

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});

  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {"name": "👑 Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Live", "avatar": "👑"},
    {"name": "🔥 Punjabi Beats & DJ Party", "host": "Aman Deep", "hostId": "88451290", "active": "5/8 Live", "avatar": "🎧"},
    {"name": "🌹 Friends Gossip & Shayari", "host": "Riya Sharma", "hostId": "55219034", "active": "3/8 Live", "avatar": "🎤"},
  ];

  void _openCreateRoom() {
    final titleCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("🎙️ Create Voice Room", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: titleCtrl,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: "Enter Room Name", hintStyle: TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              final name = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Room" : titleCtrl.text.trim();
              final newR = {"name": name, "host": CurrentUser.name, "hostId": CurrentUser.id, "active": "1/8 Live", "avatar": "🔥"};
              setState(() => rooms.insert(0, newR));
              Navigator.pop(ctx);
              Navigator.push(context, MaterialPageRoute(builder: (c) => LiveRoomScreen(roomData: newR, onUpdate: () => setState(() {}))));
            },
            child: const Text("Go Live", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openRechargeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Offline Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Rate: 100 💎 = ₹10\nPayment: UPI / GPay / PhonePe", style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Divider(color: Colors.white24, height: 16),
            const Text("WhatsApp Official Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close", style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  void _openOwnerTransfer() {
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
            TextField(controller: idCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Receiver ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transferred ${amtCtrl.text} Diamonds to ID: ${idCtrl.text}"), backgroundColor: Colors.green));
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
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(child: Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
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
                      Navigator.push(context, MaterialPageRoute(builder: (c) => LiveRoomScreen(roomData: r, onUpdate: () => setState(() {}))));
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
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.amber),
              title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)),
              subtitle: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: _openRechargeDialog,
                child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
              title: const Text("👑 Super Owner Panel (0001)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text("Transfer Diamonds by 8-Digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
              onTap: _openOwnerTransfer,
            ),
          ),
        ],
      ),
    );
  }
}

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
        return {"name": widget.roomData["host"] as String, "id": widget.roomData["hostId"] as String, "avatar": widget.roomData["avatar"] as String};
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough diamonds!"), backgroundColor: Colors.red));
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
                ],
              ),
              const Divider(color: Colors.white24, height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.05, crossAxisSpacing: 8, mainAxisSpacing: 8),
                  itemCount: gifts.length,
                  itemBuilder: (context, i) {
                    final g = gifts[i];
                    return InkWell(
                      onTap: () => sendGift(g),
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(g["icon"] as String, style: const TextStyle(fontSize: 22)),
                            Text(g["name"] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            Text("${g["cost"]} 💎 (${g["inr"]})", style: const TextStyle(color: Colors.amberAccent, fontSize: 9, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(widget.roomData["name"] as String, style: const TextStyle(fontSize: 14)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.85),
              itemCount: 8,
              itemBuilder: (context, index) {
                final userOnSeat = seats[index];
                final isSpeaking = userOnSeat != null && isMic && userOnSeat["id"] == CurrentUser.id;

                return InkWell(
                  onTap: () => handleSeatClick(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B163A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSpeaking ? Colors.greenAccent : userOnSeat != null ? Colors.pinkAccent : Colors.deepPurple.shade700, width: isSpeaking ? 2.5 : 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: userOnSeat != null ? Colors.pinkAccent.withOpacity(0.3) : const Color(0xFF140E2D),
                          child: Text(userOnSeat != null ? userOnSeat["avatar"]! : "+", style: const TextStyle(fontSize: 16, color: Colors.white70)),
                        ),
                        const SizedBox(height: 4),
                        Text(userOnSeat != null ? userOnSeat["name"]! : "Seat ${index + 1}", style: TextStyle(color: isSpeaking ? Colors.greenAccent : Colors.white70, fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                        if (isSpeaking)
                          const Text("🔊 Speaking", style: TextStyle(color: Colors.greenAccent, fontSize: 8, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF161230), borderRadius: BorderRadius.circular(12)),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (c, idx) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(chats[idx], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFF161230),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(isMic ? Icons.mic : Icons.mic_off, color: isMic ? Colors.greenAccent : Col
