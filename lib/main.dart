import 'package:flutter/material.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFFFF007F),
      ),
      home: const PBLiveMainScreen(),
    );
  }
}

class PBLiveMainScreen extends StatefulWidget {
  const PBLiveMainScreen({super.key});

  @override
  State<PBLiveMainScreen> createState() => _PBLiveMainScreenState();
}

class _PBLiveMainScreenState extends State<PBLiveMainScreen> {
  // Render Live Server Link
  final String serverUrl = "https://party-live-server.onrender.com";
  
  String userId = "0001";
  String userName = "Lovepreet Singh (Super Owner)";
  int totalAvailableCoins = 150000; // Coin Seller / Reseller Pool Balance
  int userDiamonds = 5400;
  String activeFrame = "👑 Golden King Frame";
  
  bool isInPartyRoom = false;
  bool showAdminPanel = false;

  // Controllers for Coin Seller / Reseller Panel
  final TextEditingController targetUserIdController = TextEditingController();
  final TextEditingController coinAmountController = TextEditingController();

  // 15-Seater Voice Party Room with individual Mic Mute states
  final List<Map<String, dynamic>> partySeats = List.generate(15, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "Lovepreet (Owner)" : (index < 4 ? "User ${index + 1}" : null),
    "isMuted": false,
  });

  void _showVipShop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🛍️ VIP Avatar & Flag Shop", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            ListTile(
              leading: const Text("🐉", style: TextStyle(fontSize: 28)),
              title: const Text("Dragon Fire Frame", style: TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() => activeFrame = "🐉 Dragon Fire Frame");
                  Navigator.pop(context);
                },
                child: const Text("💎 800"),
              ),
            ),
            ListTile(
              leading: const Text("🇮🇳", style: TextStyle(fontSize: 28)),
              title: const Text("Indian Flag Pride", style: TextStyle(color: Colors.white)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  setState(() => activeFrame = "🇮🇳 Indian Flag Pride");
                  Navigator.pop(context);
                },
                child: const Text("💎 1200"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _transferCoinsToUser() {
    String targetId = targetUserIdController.text.trim();
    int? amount = int.tryParse(coinAmountController.text.trim());

    if (targetId.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Please enter valid User ID and Coin Amount!")),
      );
      return;
    }

    if (amount > totalAvailableCoins) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Insufficient coins in Seller Panel balance!")),
      );
      return;
    }

    setState(() {
      totalAvailableCoins -= amount;
      if (targetId == userId) {
        userDiamonds += amount;
      }
    });

    targetUserIdController.clear();
    coinAmountController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Successfully transferred $amount coins to User ID: $targetId")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isInPartyRoom) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("🎙️ 15-Seater Voice Party Room"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => isInPartyRoom = false),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("💎 $userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFF1E193D),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic, color: Colors.greenAccent, size: 16),
                  SizedBox(width: 6),
                  Text("Tap seat to Mute/Unmute Mic", style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  final seat = partySeats[index];
                  bool isOccupied = seat["user"] != null;
                  bool isMuted = seat["isMuted"];
                  
                  return GestureDetector(
                    onTap: () {
                      if (isOccupied) {
                        setState(() {
                          seat["isMuted"] = !seat["isMuted"];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Seat ${seat["seatNo"]} Mic ${seat["isMuted"] ? "Muted 🔇" : "Unmuted 🎙️"}"), duration: const Duration(milliseconds: 400)),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2456),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: index == 0 ? Colors.amber : Colors.purpleAccent, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: isOccupied ? Colors.pinkAccent : Colors.grey[800],
                                child: Text("${seat["seatNo"]}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                              if (isOccupied)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(
                                    isMuted ? Icons.mic_off : Icons.mic,
                                    size: 12,
                                    color: isMuted ? Colors.red : Colors.greenAccent,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isOccupied ? seat["user"].split(" ")[0] : "Empty",
                            style: TextStyle(fontSize: 9, color: isOccupied ? Colors.white : Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("PB", style: TextStyle(color: Colors.white))),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PB Live Club", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("👑 Super Owner ($userId)", style: const TextStyle(fontSize: 10, color: Colors.amber)),
              ],
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text("💎 $userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Owner Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 28, backgroundColor: Colors.amber, child: Icon(Icons.admin_panel_settings, size: 30, color: Colors.black)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 2),
                        const Text("Role: Super Admin / Coin Seller", style: TextStyle(color: Colors.grey, fontSize: 11)),
                        const SizedBox(height: 4),
                        Text("Frame: $activeFrame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Server Status Box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Icon(Icons.cloud_done, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text("Server: $serverUrl", style: const TextStyle(color: Colors.greenAccent, fontSize: 10), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // VIP Shop Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🛍️"),
              label: const Text("Open VIP Shop (Dragon & Flags)"),
              onPressed: () => _showVipShop(context),
            ),
            const SizedBox(height: 12),
            // Coin Seller / Reseller Panel Toggle Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6200EE), minimumSize: const Size(double.infinity, 45)),
              icon: const Text("🎛️"),
              label: Text(showAdminPanel ? "Hide Coin Seller Panel" : "Open Coin Seller / Reseller Panel"),
              onPressed: () => setState(() => showAdminPanel = !showAdminPanel),
            ),
            const SizedBox(height: 12),
            // Coin Seller Panel UI Box
            if (showAdminPanel) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E193D),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.pinkAccent, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⚡ Coin Seller Distribution Panel", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text("Pool Balance: 🪙 $totalAvailableCoins", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: targetUserIdController,
                      decoration: InputDecoration(
                        labelText: "Enter User ID (e.g. 0045)",
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        filled: true,
                        fillColor: const Color(0xFF141026),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: coinAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Coin/Diamond Amount",
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                        filled: true,
                        fillColor: const Color(0xFF141026),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 40)),
                      onPressed: _transferCoinsToUser,
                      child: const Text("Transfer Coins to User"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            // 15-Seater Voice Party Room Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Live Voice Party Room (15 Seats & Mic)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 40)),
                    onPressed: () => setState(() => isInPartyRoom = true),
                    child: const Text("Enter Party Room"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

