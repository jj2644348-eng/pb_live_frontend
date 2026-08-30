import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- GLOBAL STATE & PERMISSIONS ----------------
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 100000;
  static bool isOwner = true;
  static bool isSeller = false;
}

// Registered Official Sellers List (Stored by User ID)
List<String> officialSellers = ["88451290"];

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tab = 0;

  final List<Map<String, dynamic>> rooms = [
    {"name": "👑 Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Live", "avatar": "👑"},
    {"name": "🔥 Punjabi Beats & DJ Party", "host": "Aman Deep (Seller)", "hostId": "88451290", "active": "5/8 Live", "avatar": "🎧"},
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

  // Master Super Owner Panel (With Assign Seller Option)
  void _openSuperOwnerPanel() {
    final sellerIdC = TextEditingController();
    final coinIdC = TextEditingController();
    final coinAmtC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setPanelState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("👑 Super Owner Master Dashboard", style: TextStyle(color: Colors.amber, fontSize: 16)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("1. 💼 Assign / Make Official Seller", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: sellerIdC,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: const InputDecoration(labelText: "Target 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                      onPressed: () {
                        final tid = sellerIdC.text.trim();
                        if (tid.isNotEmpty) {
                          if (!officialSellers.contains(tid)) {
                            setState(() => officialSellers.add(tid));
                          }
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("✅ User $tid is now an Official Coin Seller!"), backgroundColor: Colors.green),
                          );
                        }
                      },
                      child: const Text("Make Seller 💎", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent)),
                      onPressed: () {
                        final tid = sellerIdC.text.trim();
                        setState(() => officialSellers.remove(tid));
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("❌ Removed Seller rights for ID: $tid"), backgroundColor: Colors.red),
                        );
                      },
                      child: const Text("Remove", style: TextStyle(color: Colors.redAccent, fontSize: 11)),
                    ),
                  ],
                ),
                const Divider(color: Colors.white24, height: 20),
                const Text("2. 💎 Load / Transfer Coins to Anyone", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
                TextField(controller: coinIdC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Receiver ID", labelStyle: TextStyle(color: Colors.grey))),
                TextField(controller: coinAmtC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Transferred ${coinAmtC.text} 💎 to ID: ${coinIdC.text}"), backgroundColor: Colors.green),
                    );
                  },
                  child: const Text("Transfer Diamonds", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  // Seller Dashboard (For Sellers to Resell Coins)
  void _openSellerPanel() {
    final buyerIdC = TextEditingController();
    final buyerAmtC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💼 Official Seller Coin Reselling Panel", style: TextStyle(color: Colors.greenAccent, fontSize: 15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Seller ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            Text("Stock: ${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24, height: 16),
            TextField(
              controller: buyerIdC,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Buyer 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: buyerAmtC,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Diamonds to Send", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
            onPressed: () {
              final amt = int.tryParse(buyerAmtC.text) ?? 0;
              if (amt > 0 && CurrentUser.coins >= amt) {
                setState(() => CurrentUser.coins -= amt);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("✅ Successfully Sold $amt 💎 to User ID: ${buyerIdC.text}!"), backgroundColor: Colors.green),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough stock diamonds!"), backgroundColor: Colors.red));
              }
            },
            child: const Text("Sell Coins", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
    final bool isUserSeller = officialSellers.contains(CurrentUser.id);

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
                              Row(
                                children: [
                                  Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 6),
                                  if (CurrentUser.isOwner)
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(6)), child: const Text("SUPER OWNER", style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)))
                                  else if (isUserSeller)
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(6)), child: const Text("💎 SELLER", style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold))),
                                ],
                              ),
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
                      // Super Owner Master Panel
                      if (CurrentUser.isOwner)
                        Card(
                          color: const Color(0xFF1E193D),
                          child: ListTile(
                            leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
                            title: const Text("👑 Super Owner Master Panel", style: TextStyle(color: Colors.white)),
                            subtitle: const Text("Assign Sellers & Transfer Coins", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                            onTap: _openSuperOwnerPanel,
                          ),
                        ),
                      // Seller Dashboard Panel (Visible if Owner or Seller)
                      if (CurrentUser.isOwner || isUserSeller)
                        Card(
                          color: const Color(0xFF1E193D),
                          child: ListTile(
                            leading: const Icon(Icons.storefront, color: Colors.greenAccent),
                            title: const Text("💼 Seller Merchant Panel", style: TextStyle(color: Colors.white)),
                            subtitle: const Text("Sell/Transfer Coins to Users by ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                            onTap: _openSellerPanel,
                          ),
                        ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (v) => setState(() => _tab = v),
        backgrou
