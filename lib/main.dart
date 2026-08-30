import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MainClubApp(), debugShowCheckedModeBanner: false));

class CurrentUser {
  static String id = "0001", name = "Love Party Owner", avatar = "👑", frame = "🔥 Gold Ring";
  static int coins = 1000000, userLevel = 15, vipLevel = 3;
  static bool isOwner = true;
}

List<String> sellers = ["88451290"], bannedUsers = [];
final List<String> roomAvatars = ["👑", "🦁", "🎧", "🌹", "⚡", "💎", "🔥", "🎤"];
final List<String> vipFrames = ["None", "🔥 Gold Ring", "💎 Neon Cyan", "👑 Royal Crown", "🌹 Red Rose"];

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tab = 0;
  final List<String> rooms = ["👑 Tech Love PB Official", "🔥 Punjabi Beats DJ", "🌹 Friends Gossip"];

  void _openOwnerMaster() {
    final tId = TextEditingController(), amt = TextEditingController();
    String act = "Coins";
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setS) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("👑 Super Owner Master Controls", style: TextStyle(color: Colors.amber, fontSize: 14)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: act,
                  dropdownColor: const Color(0xFF1E193D),
                  style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                  items: ["Coins", "Make Seller", "Remove Seller", "Ban User", "Unban User"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setS(() => act = v!),
                ),
                TextField(controller: tId, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Target 8-Digit ID", labelStyle: TextStyle(color: Colors.grey))),
                if (act == "Coins") TextField(controller: amt, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
              onPressed: () {
                final id = tId.text.trim();
                if (id.isNotEmpty) {
                  if (act == "Make Seller" && !sellers.contains(id)) sellers.add(id);
                  if (act == "Remove Seller") sellers.remove(id);
                  if (act == "Ban User" && !bannedUsers.contains(id)) bannedUsers.add(id);
                  if (act == "Unban User") bannedUsers.remove(id);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Action '$act' applied to ID: $id"), backgroundColor: Colors.green));
                }
              },
              child: const Text("Apply Action"),
            )
          ],
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
        title: const Text("💼 Seller Merchant Reseller Panel", style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
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

  void _openProfileEditor() {
    final nameC = TextEditingController(text: CurrentUser.name);
    String tempAv = CurrentUser.avatar, tempFrame = CurrentUser.frame;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setP) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("🖼️ Profile DP & VIP Frames", style: TextStyle(color: Colors.white, fontSize: 15)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAvatarWidget(tempAv, tempFrame, 32),
                const SizedBox(height: 8),
                TextField(controller: nameC, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Nickname", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 10),
                const Text("Select Avatar DP:", style: TextStyle(color: Colors.grey, fontSize: 11)),
                Wrap(spacing: 6, children: roomAvatars.map((e) => InkWell(onTap: () => setP(() => tempAv = e), child: Container(padding: const EdgeInsets.all(4), color: tempAv == e ? Colors.pink : Colors.transparent, child: Text(e, style: const TextStyle(fontSize: 18))))).toList()),
                const SizedBox(height: 10),
                const Text("Select VIP Glow Frame:", style: TextStyle(color: Colors.grey, fontSize: 11)),
                Wrap(spacing: 6, children: vipFrames.map((f) => ChoiceChip(label: Text(f, style: const TextStyle(fontSize: 10)), selected: tempFrame == f, onSelected: (_) => setP(() => tempFrame = f))).toList()),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  CurrentUser.name = nameC.text.trim().isEmpty ? CurrentUser.name : nameC.text.trim();
                  CurrentUser.avatar = tempAv;
                  CurrentUser.frame = tempFrame;
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

  static Widget _buildAvatarWidget(String av, String frame, double r) {
    Color bColor = frame.contains("Gold") ? Colors.amber : frame.contains("Cyan") ? Colors.cyanAccent : frame.contains("Rose") ? Colors.redAccent : frame.contains("Crown") ? Colors.purpleAccent : Colors.transparent;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: bColor, width: frame == "None" ? 0 : 3)),
      child: CircleAvatar(radius: r, backgroundColor: const Color(0xFF2A2456), child: Text(av, style: TextStyle(fontSize: r * 0.9))),
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
                  subtitle: const Text("8/8 Live Seats • Safe Room", style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
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
                        const Text("PB Tigers Family\nLevel 5 (24 Active)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ElevatedButton(onPressed: () { if (CurrentUser.coins >= 5000) setState(() => CurrentUser.coins -= 5000); }, child: const Text("Create 5k 💎", style: TextStyle(fontSize: 10))),
                      ]),
                    ),
                  ]),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(children: [
                      _buildAvatarWidget(CurrentUser.avatar, CurrentUser.frame, 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Row(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(4)), child: Text("Lv.${CurrentUser.userLevel}", style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
                            const SizedBox(width: 4),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)), child: Text("VIP ${CurrentUser.vipLevel}", style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold))),
                            const SizedBox(width: 4),
                            Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 11)),
                          ]),
                        ]),
                      ),
                      IconButton(icon: const Icon(Icons.edit, color: Colors.white70), onPressed: _openProfileEditor),
                    ]),
                    const SizedBox(height: 14),
                    Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)), subtitle: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber)))),
                    if (CurrentUser.isOwner) Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("👑 Super Owner Master Controls", style: TextStyle(color: Colors.amber)), subtitle: const Text("Ban Users, Frames, Sellers & Coins"), onTap: _openOwnerMaster)),
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
  final List<String> chats = ["💬 Welcome to Official Live Party Room!"];
  final TextEditingController chatC = TextEditingController();
  final List<Map<String, dynamic>?> seats = List.generate(8, (i) => i == 0 ? {"name": CurrentUser.name, "id": CurrentUser.id, "av": CurrentUser.avatar, "frame": CurrentUser.frame, "lv": CurrentUser.userLevel, "vip": CurrentUser.vipLevel} : null);

  final List<Map<String, dynamic>> gifts = [
    {"n": "Rose", "c": 10, "i": "🌹"}, {"n": "Coffee", "c": 50, "i": "☕"},
    {"n": "Mic", "c": 100, "i": "🎤"}, {"n": "Crown", "c": 500, "i": "👑"},
    {"n": "Car", "c": 1200, "i": "🏎️"}, {"n": "Rocket", "c": 6500, "i": "🚀"},
  ];

  void _showUserCard(Map<String, dynamic> u, int seatIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MainClubAppState._buildAvatarWidget(u["av"] as String, u["frame"] as String, 32),
            const SizedBox(height: 6),
            Text(u["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("ID: ${u['id']}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 12)),
            const SizedBox(height: 6),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(4)), child: Text("Free Lv.${u['lv']}", style: const TextStyle(color: Colors.white, fontSize: 10))),
              const SizedBox(width: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)), child: Text("VIP Lv.${u['vip']}", style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
            ]),
            const SizedBox(height: 12),
            if (u["id"] == CurrentUser.id) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), onPressed: () { setState(() => seats[seatIdx] = null); Navigator.pop(ctx); }, child: const Text("Leave Mic"))
          ],
        ),
      ),
    );
  }

  void _openGifts() {
    bool all = false, self = false;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setS) => Container(
          padding: const EdgeInsets.all(12),
          height: 360,
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
                    int cost = (gifts[i]["c"] as int) * (mult == 0 ? 1 : mult);
                    if (CurrentUser.coins >= cost) {
                      setState(() {
                        CurrentUser.coins -= cost;
                        banner = "✨ ${gifts[i]['i']} ${gifts[i]['n']} -> ${self ? 'Self' : all ? 'All Mics' : 'Host'} ✨";
                        chats.add("🎁 ${CurrentUser.name} sent ${gifts[i]['i']}");
                      });
                      widget.onUp();
                      Navigator.pop(ctx);
                      Future.delayed(const Duration(seconds: 3), () { if (mounted) setState(() => banner = null); });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(8)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(gifts[i]["i"] as String, style: const TextStyle(fontSize: 20)),
                      Text(gifts[i]["n"] as String, style: const TextStyle(color: Colors.white, fontSize: 11)),
                      Text("${gifts[i]['c']} 💎", style: const TextStyle(color: Colors.amber, fontSize: 9)),
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.85, crossAxisSpacing: 6, mainAxisSpacing: 6),
            itemCount: 8,
            itemBuilder: (_, i) {
              final u = seats[i];
              return InkWell(
                onTap: () {
                  if (u == null) {
                    setState(() => seats[i] = {"name": CurrentUser.name, "id": CurrentUser.id, "av": CurrentUser.avatar, "frame": CurrentUser.frame, "lv": CurrentUser.userLevel, "vip": CurrentUser.vipLevel});
                  } else {
                    _showUserCard(u, i);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF1B163A), borderRadius: BorderRadius.circular(8), border: Border.all(color: u != null ? Colors.pinkAccent : Colors.deepPurple)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (u != null) _MainClubAppState._
