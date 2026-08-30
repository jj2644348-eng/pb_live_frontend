import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: MainClubApp(),
      debugShowCheckedModeBanner: false,
    ));

class CurrentUser {
  static String id = "0001", name = "Love Party Owner", avatar = "👑", family = "PB Tigers Club";
  static int coins = 1000000;
  static bool isOwner = true;
}

List<String> sellers = ["88451290", "55219034"];

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tab = 0;
  final List<String> rooms = ["👑 Tech Love PB Official", "🔥 Punjabi Beats DJ", "🌹 Friends Gossip"];

  void _showRecharge() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (c) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("💎 Recharge Rates (ID: ${CurrentUser.id})", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24),
            const Text("👑 Owner Direct Rate:\n₹10 = 110 💎 | ₹100 = 1,300 💎 | ₹500 = 7,000 💎", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
            const SizedBox(height: 6),
            const Text("💼 Seller Rate:\n₹10 = 100 💎 | ₹100 = 1,200 💎 | ₹500 = 6,500 💎", style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 10),
            const Text("WhatsApp Direct: +91 97793 53560", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _openOwnerPanel() {
    final sId = TextEditingController(), cId = TextEditingController(), amt = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("👑 Owner Master Panel", style: TextStyle(color: Colors.amber, fontSize: 15)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: sId, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Seller ID", labelStyle: TextStyle(color: Colors.grey))),
              Row(children: [
                ElevatedButton(onPressed: () { if(sId.text.isNotEmpty) setState(() => sellers.add(sId.text)); Navigator.pop(ctx); }, child: const Text("Make Seller")),
                const SizedBox(width: 8),
                TextButton(onPressed: () { setState(() => sellers.remove(sId.text)); Navigator.pop(ctx); }, child: const Text("Remove", style: TextStyle(color: Colors.red))),
              ]),
              const Divider(color: Colors.white24),
              TextField(controller: cId, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Receiver ID", labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: amt, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds", labelStyle: TextStyle(color: Colors.grey))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sent ${amt.text} 💎 to ${cId.text}"))); },
                child: const Text("Generate 💎", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openSellerPanel() {
    final bId = TextEditingController(), amt = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💼 Seller Merchant Panel", style: TextStyle(color: Colors.greenAccent, fontSize: 15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Stock: ${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            TextField(controller: bId, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Buyer ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amt, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              int a = int.tryParse(amt.text) ?? 0;
              if (CurrentUser.coins >= a && a > 0) {
                setState(() => CurrentUser.coins -= a);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sold $a 💎 to ${bId.text}")));
              }
            },
            child: const Text("Transfer"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSeller = sellers.contains(CurrentUser.id);
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tab == 0 ? "PB Party Club" : _tab == 1 ? "Family Club" : "My Profile"),
        actions: [Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))],
      ),
      body: _tab == 0
          ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: rooms.length,
              itemBuilder: (c, i) => Card(
                color: const Color(0xFF1E193D),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.pinkAccent, child: Text("🎙️")),
                  title: Text(rooms[i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text("8/8 Live Seats", style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                  trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoomScreen(title: rooms[i], onUp: () => setState(() {})))), child: const Text("Join")),
                ),
              ),
            )
          : _tab == 1
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.purple, Colors.pinkAccent]), borderRadius: BorderRadius.circular(12)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("${CurrentUser.family}\nLevel 5 (24 Members)", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ElevatedButton(onPressed: () { if(CurrentUser.coins >= 5000) setState(() => CurrentUser.coins -= 5000); }, child: const Text("Create (5k 💎)", style: TextStyle(fontSize: 11))),
                      ]),
                    ),
                  ]),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(children: [
                      const CircleAvatar(radius: 28, backgroundColor: Colors.amber, child: Text("👑", style: TextStyle(fontSize: 26))),
                      const SizedBox(width: 12),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("ID: ${CurrentUser.id} (Owner)", style: const TextStyle(color: Colors.pinkAccent)),
                      ]),
                    ]),
                    const SizedBox(height: 16),
                    Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)), subtitle: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber)), trailing: ElevatedButton(onPressed: _showRecharge, child: const Text("Rates")))),
                    if (CurrentUser.isOwner) Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("👑 Super Owner Panel", style: TextStyle(color: Colors.amber)), subtitle: const Text("Assign Sellers & Gen Coins"), onTap: _openOwnerPanel)),
                    if (CurrentUser.isOwner || isSeller) Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("💼 Seller Merchant Panel", style: TextStyle(color: Colors.greenAccent)), subtitle: const Text("Sell Coins by ID"), onTap: _openSellerPanel)),
                  ]),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (v) => setState(() => _tab = v),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"), BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"), BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me")],
      ),
    );
  }
}

class RoomScreen extends StatefulWidget {
  final String title;
  final VoidCallback onUp;
  const RoomScreen({super.key, required this.title, required this.onUp});
  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool mic = false;
  String? banner;
  final List<String> chats = ["💬 Welcome to PB Live Party Room!"];
  final TextEditingController chatC = TextEditingController();
  final List<String?> seats = ["Love Party Owner", "Aman Deep (Seller)", null, null, null, null, null, null];
  final List<Map<String, dynamic>> gifts = [
    {"n": "Rose", "c": 10, "i": "🌹"}, {"n": "Coffee", "c": 50, "i": "☕"},
    {"n": "Mic", "c": 100, "i": "🎤"}, {"n": "Crown", "c": 500, "i": "👑"},
    {"n": "Car", "c": 1200, "i": "🏎️"}, {"n": "Rocket", "c": 6500, "i": "🚀"},
  ];

  void _sendGift(Map<String, dynamic> g, String target, int total) {
    if (CurrentUser.coins >= total) {
      setState(() {
        CurrentUser.coins -= total;
        banner = "✨ ${g['i']} ${g['n']} -> $target ✨";
        chats.add("🎁 ${CurrentUser.name} sent ${g['i']} to $target");
      });
      widget.onUp();
      Navigator.pop(context);
      Future.delayed(const Duration(seconds: 3), () { if (mounted) setState(() => banner = null); });
    }
  }

  void _openGifts() {
    bool all = false, self = false;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setS) => Container(
          padding: const EdgeInsets.all(12),
          height: 380,
          child: Column(children: [
            Row(children: [
              FilterChip(selected: self, label: const Text("Self 👤", style: TextStyle(fontSize: 10)), onSelected: (v) => setS(() { self = v; if (v) all = false; })),
              const SizedBox(width: 6),
              FilterChip(selected: all, label: const Text("All Mic 🚀", style: TextStyle(fontSize: 10)), onSelected: (v) => setS(() { all = v; if (v) self = false; })),
            ]),
            const Divider(color: Colors.white24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 6, mainAxisSpacing: 6),
                itemCount: gifts.length,
                itemBuilder: (_, i) => InkWell(
                  onTap: () {
                    int mult = all ? seats.where((s) => s != null).length : 1;
                    _sendGift(gifts[i], self ? "Self" : all ? "All Mics" : "Host", (gifts[i]["c"] as int) * (mult == 0 ? 1 : mult));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(8)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(gifts[i]["i"], style: const TextStyle(fontSize: 22)),
                      Text(gifts[i]["n"], style: const TextStyle(color: Colors.white, fontSize: 11)),
                      Text("${gifts[i]['c']} 💎", style: const TextStyle(color: Colors.amber, fontSize: 10)),
                    ]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(backgroundColor: const Color(0xFF1A1635), title: Text(widget.title, style: const TextStyle(fontSize: 14))),
      body: Stack(children: [
        Column(children: [
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.9, crossAxisSpacing: 6, mainAxisSpacing: 6),
            itemCount: 8,
            itemBuilder: (_, i) => InkWell(
              onTap: () => setState(() => seats[i] = seats[i] == null ? CurrentUser.name : null),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF1B163A), borderRadius: BorderRadius.circular(8), border: Border.all(color: seats[i] != null ? Colors.pinkAccent : Colors.deepPurple)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(seats[i] != null ? "👑" : "+", style: const TextStyle(color: Colors.white)),
                  Text(seats[i] ?? "Seat ${i + 1}", style: const TextStyle(color: Colors.white70, fontSize: 9), maxLines: 1),
                ]),
              ),
            ),
          ),
          Expanded(child: ListView.builder(itemCount: chats.length, itemBuilder: (_, i) => Padding(padding: const EdgeInsets.all(4), child: Text(chats[i], style: const TextStyle(color: Colors.white70, fontSize: 11))))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: const Color(0xFF161230),
            child: Row(children: [
              IconButton(icon: Icon(mic ? Icons.mic : Icons.mic_off, color: mic ? Colors.green : Colors.red), onPressed: () => setState(() => mic = !mic)),
              IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: _openGifts),
              Expanded(child: TextField(controller: chatC, style: const TextStyle(color: Colors.white, fontSize: 12), decoration: const InputDecoration(hintText: "Chat...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none))),
              IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () { if(chatC.text.isNotEmpty) { setState(() => chats.add("💬 ${CurrentUser.name}: ${chatC.text}")); chatC.clear(); } }),
            ]),
          )
        ]),
        if (banner != null) Positioned(top: 20, left: 20, right: 20, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)), child: Text(banner!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      ]),
    );
  }
}

