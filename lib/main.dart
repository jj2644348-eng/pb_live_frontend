import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "PB Live Party",
    home: MainNavigationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- MAIN NAVIGATION (HOME, PK, FAMILY, ME) ----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  int userCoins = 1000000;

  final List<Map<String, dynamic>> rooms = [
    {
      "name": "🔥 Punjabi Beats & Shayari",
      "host": "Aman Deep",
      "tag": "Music & Fun",
      "active": "7/8 Live",
      "avatar": "🎤",
      "color": Colors.deepPurple
    },
    {
      "name": "👑 Tech Love PB Official",
      "host": "Love Party Owner",
      "tag": "Official Room",
      "active": "8/8 Full",
      "avatar": "👑",
      "color": Colors.pink
    },
    {
      "name": "🌹 Late Night Talks & Chill",
      "host": "Riya Sharma",
      "tag": "Chatting",
      "active": "4/8 Live",
      "avatar": "🎧",
      "color": Colors.indigo
    },
    {
      "name": "⚔️ PK Battle Arena",
      "host": "Vikram PB",
      "tag": "PK Contest",
      "active": "6/8 Live",
      "avatar": "⚔️",
      "color": Colors.deepOrange
    },
    {
      "name": "💎 VIP Wealth Club",
      "host": "Karan Singhania",
      "tag": "Gifting & Fun",
      "active": "5/8 Live",
      "avatar": "💎",
      "color": Colors.purple
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
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "PK & Games"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  // 1. HOME SCREEN (LIVE PARTY ROOMS)
  Widget _buildHomeScreen() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1635),
              borderBottom: BorderSide(color: Color(0xFF2A2456)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Official Tech Love PB",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                        "$userCoins",
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
                            roomTitle: r["name"],
                            hostName: r["host"],
                            initialCoins: userCoins,
                            onCoinsUpdate: (c) => setState(() => userCoins = c),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: (r["color"] as Color).withOpacity(0.3),
                            child: Text(r["avatar"], style: const TextStyle(fontSize: 26)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r["name"],
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("Host: ${r["host"]}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.pink.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(r["tag"], style: const TextStyle(color: Colors.pinkAccent, fontSize: 10)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.equalizer, color: Colors.greenAccent, size: 14),
                                    const SizedBox(width: 4),
                                    Text(r["active"], style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E676),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveAudioRoomScreen(
                                    roomTitle: r["name"],
                                    hostName: r["host"],
                                    initialCoins: userCoins,
                                    onCoinsUpdate: (c) => setState(() => userCoins = c),
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
            const Text("⚔️ PK Battles & Games", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("🔥 Live PK Room 1 vs 1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("👑 Team A\nScore: 1,450", textAlign: TextAlign.center, style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                        Text("VS", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("🛡️ Team B\nScore: 980", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
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
                title: const Text("Lucky Coin Toss", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text("Bet 100 💎 and win 200 💎", style: TextStyle(color: Colors.grey)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                  onPressed: () {
                    setState(() {
                      if (userCoins >= 100) {
                        bool win = DateTime.now().millisecond % 2 == 0;
                        userCoins += win ? 100 : -100;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(win ? "🎉 You Won 100 💎!" : "😢 You Lost 100 💎"),
                            backgroundColor: win ? Colors.green : Colors.red,
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
                      Text("PB Official Family", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Level 5 • 128 Members", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              tileColor: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.leaderboard, color: Colors.amber),
              title: const Text("Family Ranking", style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
            ),
          ],
        ),
      ),
    );
  }

  // 4. ME (PROFILE & WALLET) SCREEN
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
                  children: const [
                    Text("Love Party Owner", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("ID: 777 • VIP 10", style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold)),
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
                      const Text("💎 Diamond Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("$userCoins", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      setState(() => userCoins += 500000);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added 500,000 💎 Virtual Coins!"), backgroundColor: Colors.green),
                      );
                    },
                    child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileMenu(Icons.wallet, "My Wallet"),
            _buildProfileMenu(Icons.card_giftcard, "Received Gifts"),
            _buildProfileMenu(Icons.shield, "Safety & Moderation"),
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

// ---------------- LIVE AUDIO ROOM SCREEN (WITH BACK & SEATS) ----------------
class LiveAudioRoomScreen extends StatefulWidget {
  final String roomTitle;
  final String hostName;
  final int initialCoins;
  final Function(int) onCoinsUpdate;

  const LiveAudioRoomScreen({
    super.key,
    required this.roomTitle,
    required this.hostName,
    required this.initialCoins,
    required this.onCoinsUpdate,
  });

  @override
  State<LiveAudioRoomScreen> createState() => _LiveAudioRoomScreenState();
}

class _LiveAudioRoomScreenState extends State<LiveAudioRoomScreen> {
  bool isMicOn = false;
  bool isLocked = false;
  late int coins;
  final List<String> messages = [];
  final TextEditingController msgController = TextEditingController();

  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose", "cost": 10, "icon": "🌹"},
    {"name": "Microphone", "cost": 100, "icon": "🎤"},
    {"name": "Crown", "cost": 500, "icon": "👑"},
    {"name": "Sports Car", "cost": 2000, "icon": "🏎️"},
    {"name": "Rocket", "cost": 10000, "icon": "🚀"},
    {"name": "Castle", "cost": 50000, "icon": "🏰"},
  ];

  @override
  void initState() {
    super.initState();
    coins = widget.initialCoins;
    messages.add("👑 ${widget.hostName} is Hosting");
    messages.add("💬 System: Welcome to ${widget.roomTitle}!");
  }

  void sendGift(Map<String, dynamic> gift) {
    if (coins >= gift["cost"]) {
      setState(() {
        coins -= (gift["cost"] as int);
        messages.add("🎁 You sent ${gift["icon"]} ${gift["name"]} (-${gift["cost"]} 💎)");
      });
      widget.onCoinsUpdate(coins);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sent ${gift["name"]}!"), backgroundColor: Colors.purple, duration: const Duration(seconds: 1)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Not enough diamonds!"), backgroundColor: Colors.red),
      );
    }
  }

  void openGiftSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Send Gift", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("💎 $coins", style: c
