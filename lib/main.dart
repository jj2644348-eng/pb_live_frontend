import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MainClubApp(), debugShowCheckedModeBanner: false));

class CurrentUser {
  static String id = "0001", name = "Love Party Owner", avatar = "👑", frame = "Gold";
  static int coins = 1000000, userLevel = 15, vipLevel = 3;
  static bool isOwner = true;
}

List<String> sellers = ["88451290"], banned = [];
final List<String> avs = ["👑", "🦁", "🎧", "🌹", "⚡", "💎", "🔥", "🎤"];
final List<String> frames = ["None", "Gold", "Cyan", "Crown", "Rose"];

Widget getDP(String av, String fr, double r) {
  Color c = fr == "Gold" ? Colors.amber : fr == "Cyan" ? Colors.cyan : fr == "Crown" ? Colors.purpleAccent : fr == "Rose" ? Colors.red : Colors.transparent;
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: c, width: fr == "None" ? 0 : 2)),
    child: CircleAvatar(radius: r, backgroundColor: const Color(0xFF2A2456), child: Text(av, style: TextStyle(fontSize: r * 0.9))),
  );
}

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tab = 0;
  final List<String> rooms = ["👑 Tech Love PB Official", "🔥 Punjabi Beats DJ", "🌹 Friends Gossip"];

  void _openOwner() {
    final idC = TextEditingController(), amtC = TextEditingController();
    String act = "Coins";
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setS) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("👑 Master Owner Panel", style: TextStyle(color: Colors.amber, fontSize: 14)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: act, dropdownColor: const Color(0xFF1E193D), style: const TextStyle(color: Colors.pinkAccent),
                items: ["Coins", "Make Seller", "Remove Seller", "Ban", "Unban"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setS(() => act = v!),
              ),
              TextField(controller: idC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Target ID", labelStyle: TextStyle(color: Colors.grey))),
              if (act == "Coins") TextField(controller: amtC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds", labelStyle: TextStyle(color: Colors.grey))),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final id = idC.text.trim();
                if (id.isNotEmpty) {
                  if (act == "Make Seller" && !sellers.contains(id)) sellers.add(id);
                  if (act == "Remove Seller") sellers.remove(id);
                  if (act == "Ban" && !banned.contains(id)) banned.add(id);
                  if (act == "Unban") banned.remove(id);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action $act on ID $id Done!")));
                }
              },
              child: const Text("Apply"),
            )
          ],
        ),
      ),
    );
  }

  void _openSeller() {
    final bId = TextEditingController(), amt = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💼 Seller Merchant Panel", style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
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

  void _openEditProfile() {
    final nameC = TextEditingController(text: CurrentUser.name);
    String av = CurrentUser.avatar, fr = CurrentUser.frame;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setP) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("Edit Profile & DP Frame", style: TextStyle(color: Colors.white, fontSize: 14)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getDP(av, fr, 28),
                TextField(controller: nameC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Nickname", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 8),
                Wrap(spacing: 4, children: avs.map((e) => InkWell(onTap: () => setP(() => av = e), child: Text(e, style: const TextStyle(fontSize: 20)))).toList()),
                const SizedBox(height: 8),
                Wrap(spacing: 4, children: frames.map((f) => ChoiceChip(label: Text(f, style: const TextStyle(fontSize: 9)), selected: fr == f, onSelected: (_) => setP(() => fr = f))).toList()),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  CurrentUser.name = nameC.text.trim().isEmpty ? CurrentUser.name : nameC.text.trim();
                  CurrentUser.avatar = av;
                  CurrentUser.frame = fr;
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
    bool isSeller = sellers.contains(CurrentUser.id);
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(backgroundColor: const Color(0xFF1A1635), title: Text(_tab == 0 ? "PB Party Club" : _tab == 1 ? "Family Club" : "My Profile"), actions: [Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))]),
      body: _tab == 0
          ? ListView.builder(
              padding: const EdgeInsets.all(8), itemCount: rooms.length,
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
              ? Center(child: Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisSize: MainAxisSize.min, children: [const Text("👑 PB Tigers Family (Lv.5)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 6), const Text("24 Members • Ranking #1", style: TextStyle(color: Colors.amber, fontSize: 12)), const SizedBox(height: 12), ElevatedButton(onPressed: () { if (CurrentUser.coins >= 5000) setState(() => CurrentUser.coins -= 5000); }, child: const Text("Create Family (5k 💎)"))])))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(children: [
                      getDP(CurrentUser.avatar, CurrentUser.frame, 26), const SizedBox(width: 10),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Row(children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), color: Colors.blue, child: Text("Lv.${CurrentUser.userLevel}", style: const TextStyle(color: Colors.white, fontSize: 9))), const SizedBox(width: 4),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), color: Colors.amber, child: Text("VIP ${CurrentUser.vipLevel}", style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold))), const SizedBox(width: 4),
                          Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 11)),
                        ]),
                      ]),
                      const Spacer(), IconButton(icon: const Icon(Icons.edit, color: Colors.white70), onPressed: _openEditProfile),
                    ]),
                    const SizedBox(height: 14),
                    Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("Diamonds Wallet", style: TextStyle(color: Colors.white)), subtitle: Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber)))),
                    if (CurrentUser.isOwner) Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("👑 Super Owner Master Controls", style: TextStyle(color: Colors.amber)), subtitle: const Text("Ban Users, Sellers & Coins"), onTap: _openOwner)),
                    if (CurrentUser.isOwner || isSeller) Card(color: const Color(0xFF1E193D), child: ListTile(title: const Text("💼 Seller Merchant Panel", style: TextStyle(color: Colors.greenAccent)), subtitle: const Text("Sell Coins by ID"), onTap: _openSeller)),
                  ]),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab, onTap: (v) => setState(() => _tab = v), backgroundColor: const Color(0xFF161230), selectedItemColor: const Color(0xFFFF007F), unselectedItemColor: Colors.grey,
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
  final List<Map<String, dynamic>?> seats = List.generate(8, (i) => i == 0 ? {"name": CurrentUser.name, "id": CurrentUser.id, "av": CurrentUser.avatar, "fr": CurrentUser.frame, "lv": CurrentUser.userLevel, "vip": CurrentUser.vipLevel} : null);
  final List<Map<String, dynamic>> gifts = [{"n": "Rose", "c": 10, "i": "🌹"}, {"n": "Coffee", "c": 50, "i": "☕"}, {"n": "Mic", "c": 100, "i": "🎤"}, {"n": "Crown", "c": 500, "i": "👑"}, {"n": "Car", "c": 1200, "i": "🏎️"}, {"n": "Rocket", "c": 6500, "i": "🚀"}];

  void _showUserCard(Map<String, dynamic> u, int seatIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getDP(u["av"] as String, u["fr"] as String, 28), const SizedBox(height: 6),
            Text(u["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("ID: ${u['id']}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 12)), const SizedBox(height: 6),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), color: Colors.blue, child: Text("Lv.${u['lv']}", style: const TextStyle(color: Colors.white, fontSize: 10))), const SizedBox(width: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), color: Colors.amber, child: Text("VIP ${u['vip']}", style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
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
      context: context, backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setS) => Container(
          padding: const EdgeInsets.all(12), height: 350,
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
                        banner = "✨ ${gifts[i]['i']} ${gifts[i]['n']} -> ${self ? 'Self' : all ? 'All' : 'Host'} ✨";
                        chats.add("🎁 ${CurrentUser.name} sent ${gifts[i]['i']}");
                      });
                      widget.onUp(); Navigator.pop(ctx);
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
            shrinkWrap: true, padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.85, crossAxisSpacing: 6, mainAxisSpacing: 6),
            itemCount: 8,
            itemBuilder: (_, i) {
              final u = seats[i];
              return InkWell(
                onTap: () {
                  if (u == null) {
                    setState(() => seats[i] = {"name": CurrentUser.name, "id": CurrentUser.id, "av": CurrentUser.avatar, "fr": CurrentUser.frame, "lv": CurrentUser.userLevel, "vip": CurrentUser.vipLevel});
                  } else {
                    _showUserCard(u, i);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF1B163A), borderRadius: BorderRadius.circular(8), border: Border.all(color: u != null ? Colors.pinkAccent : Colors.deepPurple)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (u != null) getDP(u["av"] as String, u["fr"] as String, 13) else const Text("+", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(u != null ? u["name"] as String : "Seat ${i + 1}", style: const TextStyle(color: Colors.white70, fontSize: 9), maxLines: 1),
                    if (u != null) Text("VIP ${u['vip']}", style: const TextStyle(color: Colors.amberAccent, fontSize: 8)),
                  ]),
                ),
              );
            },
          ),
          Expanded(child: ListView.builder(itemCount: chats.length, itemBuilder: (_, i) => Padding(padding: const EdgeInsets.all(4), child: Text(chats[i], style: const TextStyle(color: Colors.white70, fontSize: 11))))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), color: const Color(0xFF161230),
            child: Row(children: [
              IconButton(icon: Icon(mic ? Icons.mic : Icons.mic_off, color: mic ? Colors.green : Colors.red), onPressed: () => setState(() => mic = !mic)),
              IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: _openGifts),
              Expanded(child: TextField(controller: chatC, style: const TextStyle(color: Colors.white, fontSize: 12), decoration: const InputDecoration(hintText: "Chat...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none))),
              IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () { if (chatC.text.isNotEmpty) { setState(() => chats.add("💬 ${CurrentUser.name}: ${chatC.text}")); chatC.clear(); } }),
            ]),
          )
        ]),
        if (banner != null) Positioned(top: 20, left: 20, right: 20, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)), child: Text(banner!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      ]),
    );
  }
}

