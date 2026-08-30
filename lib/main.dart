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
  int _tab = 0;
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
        title: const Text("🎙️ Start Live Voice Room", style: TextStyle(color: Colors.white, fontSize: 16)),
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
              final name = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Live Room" : titleCtrl.text.trim();
              final newR = {"name": name, "host": CurrentUser.name, "hostId": CurrentUser.id, "active": "1/8 Live", "avatar": CurrentUser.avatar};
              setState(() => rooms.insert(0, newR));
              Navigator.pop(ctx);
              Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(title: name, onUpdate: () => setState(() {}))));
            },
            child: const Text("Go Live", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _showRecharge() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Diamond Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Packs:\n₹10 = 100 💎\n₹50 = 550 💎\n₹100 = 1,200 💎\n₹500 = 6,500 💎", style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Divider(color: Colors.white24),
            const Text("WhatsApp Official Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close", style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  void _showTransfer() {
    final idC = TextEditingController();
    final amtC = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("👑 Super Owner Transfer", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Receiver 8-Digit ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transferred ${amtC.text} 💎 to ID: ${idC.text}"), backgroundColor: Colors.green));
            },
            child: const Text("Send", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _openProfileEditor() {
    final nameC = TextEditingController(text: CurrentUser.name);
    String tempAvatar = CurrentUser.avatar;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("Edit Profile & DP", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 30, backgroundColor: Colors.amber, child: Text(tempAvatar, style: const TextStyle(fontSize: 28))),
              const SizedBox(height: 10),
              TextField(controller: nameC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Nickname", labelStyle: TextStyle(color: Colors.grey))),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: ["👑", "🦁", "🎧", "🌹", "⚡", "💎", "🔥", "🎤"].map((e) => InkWell(
                  onTap: () => setDState(() => tempAvatar = e),
                  child: Container(padding: const EdgeInsets.all(6), color: tempAvatar == e ? const Color(0xFFFF007F) : Colors.transparent, child: Text(e, style: const TextStyle(fontSize: 20))),
                )).toList(),
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
              onPressed: () {
                setState(() {
                  CurrentUser.name = nameC.text.trim().isEmpty ? CurrentUser.name : nameC.text.trim();
                  CurrentUser.avatar = tempAvatar;
                });
                Navigator.pop(ctx);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tab == 0 ? "PB Party Club" : _tab == 1 ? "Family Club" : "My Profile"),
        actions: [
          Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
          if (_tab == 0)
            IconButton(icon: const CircleAvatar(radius: 14, backgroundColor: Color(0xFFFF007F), child: Icon(Icons.add, color: Colors.white, size: 18)), onPressed: _openCreateRoom),
        ],
      ),
      body: _tab == 0
          ? ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: rooms.length,
              itemBuilder: (ctx, i) => Card(
                color: const Color(0xFF1E193D),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: const Color(0xFF2A2456), child: Text(rooms[i]["avatar"] as String, style: const TextStyle(fontSize: 20))),
                  title: Text(rooms[i]["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("Host: ${rooms[i]['host']} • ${rooms[i]['active']}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(title: rooms[i]["name"] as String, onUpdate: () => setState(() {})))),
                    child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          : _tab == 1
              ? const Center(child: Text("👥 Official PB Family Club\nLevel 5 Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 32, backgroundColor: Colors.amber, child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 30))),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("ID: ${CurrentUser.id} (Super Owner)", style: const TextStyle(color: Colors.pinkAccent)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.edit, color: Colors.white70), onPressed: _openProfileEditor),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: const Color(0xFF1E193D),
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on, color: Colors.amber),
                          title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)),
                          subtitle: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                          trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: _showRecharge, child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                      ),
                      Card(
                        color: const Color(0xFF1E193D),
                        child: ListTile(
                          leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
                          title: const Text("👑 Super Owner Transfer", style: TextStyle(color: Colors.white)),
                          subtitle: const Text("Transfer Diamonds by ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
                          onTap: _showTransfer,
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (v) => setState(() => _tab = v),
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
}

class PartyRoomScreen extends StatefulWidget {
  final String title;
  final VoidCallback onUpdate;
  const PartyRoomScreen({super.key, required this.title, required this.onUpdate});
  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  bool mic = false;
  String? giftBanner;
  final List<String> chats = ["💬 Welcome to PB Live Party Room!"];
  final TextEditingController chatC = TextEditingController();
  final List<String?> seats = ["Love Party Owner", "Aman Deep", null, null, null, null, null, null];

  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose", "cost": 10, "icon": "🌹"},
    {"name": "Coffee", "cost": 50, "icon": "☕"},
    {"name": "Golden Mic", "cost": 100, "icon": "🎤"},
    {"name": "VIP Crown", "cost": 500, "icon": "👑"},
    {"name": "Supercar", "cost": 1200, "icon": "🏎️"},
    {"name": "Rocket", "cost": 6500, "icon": "🚀"},
    {"name": "Castle", "cost": 15000, "icon": "🏰"},
  ];

  void _triggerGiftAnimation(String giftIcon, String giftName, String receiverName) {
    setState(() {
      giftBanner = "✨ $giftIcon $giftName -> $receiverName ✨";
      chats.add("🎁 ${CurrentUser.name} sent $giftIcon $giftName to $receiverName");
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => giftBanner = null);
    });
  }

  void _openGiftingModal() {
    List<int> selectedSeats = [];
    bool sendToAll = false;
    bool sendToSelf = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setGiftState) {
          return Container(
            padding: const EdgeInsets.all(14),
            height: 440,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("🎁 Send Gifts", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("💎 ${CurrentUser.coins}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                // Target Selectors (Self / All / Specific Seat)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        selected: sendToSelf,
                        label: const Text("Self (Me) 👤", style: TextStyle(fontSize: 11)),
                        selectedColor: const Color(0xFFFF007F),
                        onSelected: (v) => setGiftState(() {
                          sendToSelf = v;
                          if (v) {
                            sendToAll = false;
                            selectedSeats.clear();
                          }
                        }),
                      ),
                      const SizedBox(width: 6),
                      FilterChip(
                        selected: sendToAll,
                        label: const Text("All Mic 🚀", style: TextStyle(fontSize: 11)),
                        selectedColor: Colors.amber,
                        onSelected: (v) => setGiftState(() {
                          sendToAll = v;
                          if (v) {
                            sendToSelf = false;
                            selectedSeats.clear();
                          }
                        }),
                      ),
                      const SizedBox(width: 6),
                      ...List.generate(8, (i) {
                        final seatUser = seats[i];
                        if (seatUser == null) return const SizedBox.shrink();
                        final isSel = selectedSeats.contains(i);
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: FilterChip(
                            selected: isSel,
                            label: Text("${i + 1}. $seatUser", style: const TextStyle(fontSize: 11)),
                            selectedColor: Colors.pinkAccent,
                            onSelected: (v) => setGiftState(() {
                              sendToAll = false;
                              sendToSelf = false;
                              if (v) {
                                selectedSeats.add(i);
                              } else {
                                selectedSeats.remove(i);
                              }
                            }),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const Divider(color: Colors.white24, height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.1, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemCount: gifts.length,
                    itemBuilder: (ctx2, i) {
                      final g = gifts[i];
                      return InkWell(
                        onTap: () {
                          int totalCost = 0;
                          String targetName = "";

                          if (sendToSelf) {
                            totalCost = g["cost"] as int;
                            targetName = "Self (${CurrentUser.name})";
                          } else if (sendToAll) {
                            int activeCount = seats.where((s) => s != null).length;
                            activeCount = activeCount == 0 ? 1 : activeCount;
                            totalCost = (g["cost"] as int) * activeCount;
                            targetName = "All ($activeCount Mics)";
                          } else if (selectedSeats.isNotEmpty) {
                            totalCost = (g["cost"] as int) * selectedSeats.length;
                            targetName = selectedSeats.map((idx) => seats[idx] ?? "Seat ${idx + 1}").join(", ");
                          } else {
                            totalCost = g["cost"] as int;
                            targetName = "Room Host";
                          }

                          if (CurrentUser.coins >= totalCost) {
                            setState(() {
                              CurrentUser.coins -= totalCost;
                            });
                            widget.onUpdate();
                            Navigator.pop(ctx);
                            _triggerGiftAnimation(g["icon"] as String, g["name"] as String, targetName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insufficient diamonds!"), backgroundColor: Colors.red));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(g["icon"] as String, style: const Tex
