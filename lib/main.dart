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
  final List<String> rooms = [
    "👑 Tech Love PB Official Club",
    "🔥 Punjabi Beats & DJ Party",
    "🌹 Friends Gossip & Shayari",
    "⚔️ PK Live Audio Battle"
  ];

  void _showRecharge() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Offline Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Packs:\n₹10 = 100 💎\n₹50 = 550 💎\n₹100 = 1,200 💎\n₹500 = 6,500 💎", style: TextStyle(color: Colors.white70)),
            const Divider(color: Colors.white24),
            const Text("WhatsApp Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
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
        title: const Text("👑 Master Transfer", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "User ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sent ${amtC.text} 💎 to ID: ${idC.text}"), backgroundColor: Colors.green));
            },
            child: const Text("Send", style: TextStyle(color: Colors.white)),
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
        title: Text(_tab == 0 ? "PB Party Club" : _tab == 1 ? "Family Club" : "My Profile"),
        actions: [
          Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
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
                  leading: const CircleAvatar(backgroundColor: Colors.pinkAccent, child: Text("🎙️")),
                  title: Text(rooms[i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text("8/8 Live Seats", style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(title: rooms[i]))),
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
                          const CircleAvatar(radius: 30, backgroundColor: Colors.amber, child: Text("👑", style: TextStyle(fontSize: 28))),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("ID: ${CurrentUser.id} (Owner)", style: const TextStyle(color: Colors.pinkAccent)),
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
                          trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: _showRecharge, child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                      ),
                      Card(
                        color: const Color(0xFF1E193D),
                        child: ListTile(
                          leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
                          title: const Text("👑 Super Owner Transfer", style: TextStyle(color: Colors.white)),
                          subtitle: const Text("Transfer by 8-Digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
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
  const PartyRoomScreen({super.key, required this.title});
  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  bool mic = false;
  final List<String> chats = ["💬 Welcome to Party Room!"];
  final TextEditingController chatC = TextEditingController();
  final List<String?> seats = List.filled(8, null);

  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose", "cost": 10, "icon": "🌹"},
    {"name": "Coffee", "cost": 50, "icon": "☕"},
    {"name": "Mic", "cost": 100, "icon": "🎤"},
    {"name": "Crown", "cost": 500, "icon": "👑"},
    {"name": "Car", "cost": 1200, "icon": "🏎️"},
    {"name": "Rocket", "cost": 6500, "icon": "🚀"},
  ];

  void _sendGift(Map<String, dynamic> g) {
    int cost = g["cost"] as int;
    if (CurrentUser.coins >= cost) {
      setState(() {
        CurrentUser.coins -= cost;
        chats.add("🎁 ${CurrentUser.name} sent ${g['icon']} ${g['name']} (-$cost 💎)");
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Low balance!"), backgroundColor: Colors.red));
    }
  }

  void _openGifts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        height: 260,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: gifts.length,
          itemBuilder: (c, i) => InkWell(
            onTap: () => _sendGift(gifts[i]),
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(gifts[i]["icon"] as String, style: const TextStyle(fontSize: 20)),
                  Text(gifts[i]["name"] as String, style: const TextStyle(color: Colors.white, fontSize: 11)),
                  Text("${gifts[i]['cost']} 💎", style: const TextStyle(color: Colors.amberAccent, fontSize: 9)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(backgroundColor: const Color(0xFF1A1635), title: Text(widget.title, style: const TextStyle(fontSize: 14))),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.9),
            itemCount: 8,
            itemBuilder: (ctx, i) => InkWell(
              onTap: () => setState(() => seats[i] = seats[i] == null ? CurrentUser.name : null),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1B163A),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: seats[i] != null ? Colors.pinkAccent : Colors.deepPurple),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(seats[i] != null ? "👑" : "+", style: const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(seats[i] ?? "Seat ${i + 1}", style: const TextStyle(color: Colors.white70, fontSize: 10), maxLines: 1),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF161230), borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (c, i) => Text(chats[i], style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFF161230),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(mic ? Icons.mic : Icons.mic_off, color: mic ? Colors.green : Colors.red),
                  onPressed: () => setState(() => mic = !mic),
                ),
                IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: _openGifts),
                Expanded(
                  child: TextField(
                    controller: chatC,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(hintText: "Chat...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: () {
                    if (chatC.text.trim().isNotEmpty) {
                      setState(() => chats.add("💬 ${CurrentUser.name}: ${chatC.text.trim()}"));
                      chatC.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

