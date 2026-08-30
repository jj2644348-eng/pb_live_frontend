import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB Live",
    home: MainClubApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static String customDpUrl = "";
  static int coins = 1000000;
  static bool isOwner = true;
  static bool isSeller = false;
  static String familyName = "PB Tigers Club";
}

List<String> registeredSellers = ["88451290", "55219034"];

List<Map<String, dynamic>> activeFamilies = [
  {"name": "PB Tigers Club", "leader": "Love Party Owner", "members": 24, "level": "Lv.5 👑"},
  {"name": "Royal Punjabi Club", "leader": "Aman Deep", "members": 18, "level": "Lv.3 ⭐"},
];

class MainClubApp extends StatefulWidget {
  const MainClubApp({super.key});
  @override
  State<MainClubApp> createState() => _MainClubAppState();
}

class _MainClubAppState extends State<MainClubApp> {
  int _tabIndex = 0;

  final List<Map<String, dynamic>> roomList = [
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
          decoration: const InputDecoration(hintText: "Enter Room Name / Topic", hintStyle: TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              final roomTitle = titleCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Live Club" : titleCtrl.text.trim();
              final newRoom = {
                "name": roomTitle,
                "host": CurrentUser.name,
                "hostId": CurrentUser.id,
                "active": "1/8 Live",
                "avatar": CurrentUser.avatar
              };
              setState(() => roomList.insert(0, newRoom));
              Navigator.pop(ctx);
              Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(title: roomTitle, onUpdate: () => setState(() {}))));
            },
            child: const Text("Go Live", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void _showRechargeRates() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("💎 Diamond Rate Comparison", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text("👑 Owner Direct (Max Bonus) vs 💼 Seller Rate:", style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 8),
            _buildRateRow("₹10 Pack", "110 💎 (Direct)", "100 💎 (Seller)"),
            _buildRateRow("₹50 Pack", "600 💎 (Direct)", "550 💎 (Seller)"),
            _buildRateRow("₹100 Pack", "1,300 💎 (Direct)", "1,200 💎 (Seller)"),
            _buildRateRow("₹500 VIP", "7,000 💎 (Direct)", "6,500 💎 (Seller)"),
            _buildRateRow("₹1,000 Mega", "16,000 💎 (Direct)", "15,000 💎 (Seller)"),
            const Divider(color: Colors.white24, height: 16),
            const Text("WhatsApp Official Support: +91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildRateRow(String pack, String direct, String seller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(pack, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
          Text(direct, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
          Text(seller, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  void _openCreateFamilyModal() {
    final famNameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("👥 Create New Family Club", style: TextStyle(color: Colors.white, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Creation Fee: 5,000 💎", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            TextField(
              controller: famNameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: "Enter Family Name", hintStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              if (CurrentUser.coins >= 5000) {
                final fn = famNameCtrl.text.trim().isEmpty ? "${CurrentUser.name}'s Family" : famNameCtrl.text.trim();
                setState(() {
                  CurrentUser.coins -= 5000;
                  CurrentUser.familyName = fn;
                  activeFamilies.insert(0, {"name": fn, "leader": CurrentUser.name, "members": 1, "level": "Lv.1 🆕"});
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Created Family '$fn' (-5,000 💎)!"), backgroundColor: Colors.green));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You need 5,000 💎 to create a Family!"), backgroundColor: Colors.red));
              }
            },
            child: const Text("Create (5000 💎)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void _openMasterOwnerPanel() {
    final targetSellerId = TextEditingController();
    final transferIdCtrl = TextEditingController();
    final transferAmtCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("👑 Super Owner Master Dashboard", style: TextStyle(color: Colors.amber, fontSize: 15)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("1. 💼 Assign / Revoke Seller", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                TextField(controller: targetSellerId, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "User 8-Digit ID", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                      onPressed: () {
                        final tid = targetSellerId.text.trim();
                        if (tid.isNotEmpty) {
                          setState(() {
                            if (!registeredSellers.contains(tid)) registeredSellers.add(tid);
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ ID: $tid is now an Official Seller!"), backgroundColor: Colors.green));
                        }
                      },
                      child: const Text("Make Seller", style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent)),
                      onPressed: () {
                        final tid = targetSellerId.text.trim();
                        setState(() => registeredSellers.remove(tid));
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ Removed Seller rights for ID: $tid"), backgroundColor: Colors.red));
                      },
                      child: const Text("Remove", style: TextStyle(color: Colors.redAccent, fontSize: 11)),
                    ),
                  ],
                ),
                const Divider(color: Colors.white24, height: 20),
                const Text("2. 💎 Master Coins Generator/Transfer", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                TextField(controller: transferIdCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Receiver ID", labelStyle: TextStyle(color: Colors.grey))),
                TextField(controller: transferAmtCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transferred ${transferAmtCtrl.text} 💎 to ID: ${transferIdCtrl.text}"), backgroundColor: Colors.green));
                  },
                  child: const Text("Generate & Transfer 💎", style: TextStyle(color: Colors.white, fontSize: 11)),
                )
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close")),
          ],
        ),
      ),
    );
  }

  void _openSellerMerchantPanel() {
    final buyerIdCtrl = TextEditingController();
    final buyerAmtCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💼 Seller Merchant Reseller Panel", style: TextStyle(color: Colors.greenAccent, fontSize: 15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Seller: ${CurrentUser.name} (ID: ${CurrentUser.id})", style: const TextStyle(color: Colors.pinkAccent, fontSize: 12)),
            Text("Stock: ${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
            const Divider(color: Colors.white24, height: 16),
            TextField(controller: buyerIdCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Buyer 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: buyerAmtCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds to Send", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
            onPressed: () {
              final amt = int.tryParse(buyerAmtCtrl.text) ?? 0;
              if (amt > 0 && CurrentUser.coins >= amt) {
                setState(() => CurrentUser.coins -= amt);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Sold $amt 💎 to User ID: ${buyerIdCtrl.text}!"), backgroundColor: Colors.green));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insufficient diamond stock!"), backgroundColor: Colors.red));
              }
            },
            child: const Text("Transfer to Buyer", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void _openProfileEditor() {
    final nameCtrl = TextEditingController(text: CurrentUser.name);
    final dpUrlCtrl = TextEditingController(text: CurrentUser.customDpUrl);
    String tempAvatar = CurrentUser.avatar;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("🖼️ Custom DP & Profile Setup", style: TextStyle(color: Colors.white, fontSize: 16)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.amber,
                  child: Text(tempAvatar, style: const TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 10),
                TextField(controller: nameCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Display Name / Brand", labelStyle: TextStyle(color: Colors.grey))),
                TextField(controller: dpUrlCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Custom DP/Logo Image Link (URL)", labelStyle: TextStyle(color: Colors.grey))),
                const SizedBox(height: 12),
                const Text("Or Select VIP DP Avatar:", style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: ["👑", "🦁", "🎧", "🌹", "⚡", "💎", "🔥", "🎤", "👸"].map((e) => InkWell(
                    onTap: () => setDState(() => tempAvatar = e),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: tempAvatar == e ? const Color(0xFFFF007F) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                      child: Text(e, style: const TextStyle(fontSize: 20)),
                    ),
                  )).toList(),
                )
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
              onPressed: () {
                setState(() {
                  CurrentUser.name = nameCtrl.text.trim().isEmpty ? CurrentUser.name : nameCtrl.text.trim();
                  CurrentUser.customDpUrl = dpUrlCtrl.text.trim();
                  CurrentUser.avatar = tempAvatar;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile & DP Logo Updated!"), backgroundColor: Colors.green));
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
    final bool isUserSeller = registeredSellers.contains(CurrentUser.id);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(_tabIndex == 0 ? "PB Party Club" : _tabIndex == 1 ? "Family Club" : "My Profile"),
        actions: [
          Center(child: Text("💎 ${CurrentUser.coins} ", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
          if (_tabIndex == 0)
            IconButton(icon: const CircleAvatar(radius: 14, backgroundColor: Color(0xFFFF007F), child: Icon(Icons.add, color: Colors.white, size: 18)), onPressed: _openCreateRoom),
        ],
      ),
      body: _tabIndex == 0
          ? _buildHomeScreen()
          : _tabIndex == 1
              ? _buildFamilyScreen()
              : _buildProfileScreen(isUserSeller),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (v) => setState(() => _tabIndex = v),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black26,
                  child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 22)),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🔥 OFFICIAL TECH LOVE PB LIVE CLUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                      Text("💎 Direct Rate: ₹10 = 110 💎 • ₹100 = 1,300 💎", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold,
