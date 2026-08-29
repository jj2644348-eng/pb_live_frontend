import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: MainNavigationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- GLOBAL DATA STORE ----------------
class AppData {
  static String myUserId = (10000000 + Random().nextInt(90000000)).toString();
  static String myUserName = "Love Party Owner";
  static bool isSuperAdmin = true;
  static bool isCoinSeller = true;
  static int myCoins = 5000000;

  static List<Map<String, dynamic>> sellers = [
    {"id": "77777777", "name": "Super Owner (You)", "role": "Master Admin"},
    {"id": "88451290", "name": "Aman Agency", "role": "Coin Reseller"},
  ];
}

// ---------------- MAIN NAVIGATION ----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      "name": "Tech Love PB Official Club",
      "host": "Love Party Owner",
      "hostId": "77777777",
      "tag": "Official Club",
      "active": "8/8 Full",
      "avatar": "👑",
      "color": Colors.pink
    },
    {
      "name": "Punjabi Beats & Shayari",
      "host": "Aman Deep",
      "hostId": "88451290",
      "tag": "Club Fun",
      "active": "7/8 Live",
      "avatar": "🎤",
      "color": Colors.deepPurple
    },
    {
      "name": "Friends Gossip & Chill",
      "host": "Riya Sharma",
      "hostId": "55219034",
      "tag": "Chatting",
      "active": "4/8 Live",
      "avatar": "🎧",
      "color": Colors.indigo
    },
    {
      "name": "PK Party Arena",
      "host": "Vikram PB",
      "hostId": "91823412",
      "tag": "Contest",
      "active": "6/8 Live",
      "avatar": "⚔️",
      "color": Colors.deepOrange
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildHomeScreen(),
      _buildPkScreen(),
      _buildFamilyScreen(),
      _buildMeScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Club"),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "PK & Games"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  // 1. HOME SCREEN
  Widget _buildHomeScreen() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1635),
              border: Border(
                bottom: BorderSide(color: Color(0xFF2A2456), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Official Tech Love PB",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "My ID: ${AppData.myUserId}",
                      style: const TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2456),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Text("💎 ", style: TextStyle(fontSize: 12)),
                      Text(
                        "${AppData.myCoins}",
                        style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveAudioRoomScreen(
                            roomTitle: r["name"] as String,
                            hostName: r["host"] as String,
                            hostId: r["hostId"] as String,
                            onUpdate: () => setState(() {}),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: (r["color"] as Color).withOpacity(0.3),
                            child: Text(r["avatar"] as String, style: const TextStyle(fontSize: 24)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r["name"] as String,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text("Host: ${r["host"]} (ID: ${r["hostId"]})", style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.equalizer, color: Colors.greenAccent, size: 14),
                                    const SizedBox(width: 4),
                                    Text(r["active"] as String, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E676),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveAudioRoomScreen(
                                    roomTitle: r["name"] as String,
                                    hostName: r["host"] as String,
                                    hostId: r["hostId"] as String,
                                    onUpdate: () => setState(() {}),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
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

  // 2. PK & GAMES SCREEN
  Widget _buildPkScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PK Battles & Games", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Live Club PK (1 vs 1)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Team A\n1,450 Diamonds", textAlign: TextAlign.center, style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                        Text("VS", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Team B\n980 Diamonds", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Text("🎲", style: TextStyle(fontSize: 28)),
                title: const Text("Club Coin Toss", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text("Play 100 Diamonds for fun", style: TextStyle(color: Colors.grey)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                  onPressed: () {
                    setState(() {
                      if (AppData.myCoins >= 100) {
                        bool win = DateTime.now().millisecond % 2 == 0;
                        AppData.myCoins += win ? 100 : -100;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(win ? "Won +100 Diamonds!" : "Lost -100 Diamonds"),
                            backgroundColor: win ? Colors.green : Colors.red,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text("Play", style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 3. FAMILY SCREEN
  Widget _buildFamilyScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  CircleAvatar(radius: 28, backgroundColor: Colors.pinkAccent, child: Text("👥", style: TextStyle(fontSize: 26))),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PB Royal Family", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Level 8 • 154 Club Members", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. ME SCREEN
  Widget _buildMeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.pinkAccent,
                  child: Text("👑", style: TextStyle(fontSize: 32)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppData.myUserName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("User ID: ${AppData.myUserId}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    const Text("Role: Super Owner & Master Reseller", style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
                  ],
                )
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
                      const Text("Diamond Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${AppData.myCoins}", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (AppData.isSuperAdmin || AppData.isCoinSeller)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF007F), Color(0xFF7928CA)]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 28),
                  title: const Text("Super Owner & Reseller Panel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text("Transfer Coins & Manage Resellers", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OwnerAdminPanelScreen()),
                    ).then((_) => setState(() {}));
                  },
                ),
              ),
            _buildProfileMenu(Icons.card_giftcard, "Received Party Gifts"),
            _buildProfileMenu(Icons.shield, "Community Safety Guidelines"),
            _buildProfileMenu(Icons.settings, "Settings"),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E193D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      ),
    );
  }
}

// ---------------- OWNER ADMIN PANEL SCREEN ----------------
class OwnerAdminPanelScreen extends StatefulWidget {
  const OwnerAdminPanelScreen({super.key});

  @override
  State<OwnerAdminPanelScreen> createState() => _OwnerAdminPanelScreenState();
}

class _OwnerAdminPanelScreenState extends State<OwnerAdminPanelScreen> {
  final TextEditingController targetIdController = TextEditingController();
  final TextEditingController coinsAmountController = TextEditingController();
  final TextEditingController newResellerIdController = TextEditingController();
  final TextEditingController newResellerNameController = TextEditingController();

  void transferCoins() {
    final String targetId = targetIdController.text.trim();
    final int? amount = int.tryParse(coinsAmountController.text.trim());

    if (targetId.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Target User ID must be exactly 8 digits!"), backgroundColor: Colors.red),
      );
      return;
    }
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid coin amount!"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      AppData.myCoins += amount;
    });

    targetIdController.clear();
    coinsAmountController.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("Transfer Successful", style: TextStyle(color: Colors.greenAccent)),
        content: Text("Successfully sent $amount Diamonds to User ID: $targetId", style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK", style: TextStyle(color: Colors.pinkAccent)),
          )
        ],
      ),
    );
  }

  void addReseller() {
    final String id = newResellerIdController.text.trim();
    final String name = newResellerNameController.text.trim();

    if (id.length != 8 || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 8-digit ID & Name!"), backgroundColor: C
