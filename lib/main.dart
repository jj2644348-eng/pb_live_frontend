import 'package:flutter/material.dart';

// ग्लोबल स्टेट डेटा (ओनर आईडी 0001, कॉइन्स, डायमंड्स और सेलर/बीडी मैनेजमेंट)
class AppData extends ChangeNotifier {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  int myCoins = 100000000; // 10 करोड़ कॉइन्स (अनलिमिटेड जनरेटर)
  int myDiamonds = 50000000; // 5 करोड़ डायमंड्स
  bool isOwner = true; // आईडी 0001 ऑफिशियल ओनर
  List<String> coinSellers = [];
  List<String> bdAdmins = [];
  List<String> bannedUsers = [];

  void addCoins(int amount) {
    myCoins += amount;
    notifyListeners();
  }

  void addDiamonds(int amount) {
    myDiamonds += amount;
    notifyListeners();
  }

  void assignSeller(String userId) {
    if (!coinSellers.contains(userId)) {
      coinSellers.add(userId);
      notifyListeners();
    }
  }

  void assignBDAdmin(String userId) {
    if (!bdAdmins.contains(userId)) {
      bdAdmins.add(userId);
      notifyListeners();
    }
  }
}

void main() {
  runApp(const PBLivePartyApp());
}

class PBLivePartyApp extends StatelessWidget {
  const PBLivePartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Party',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFF3F2B96),
        colorScheme: const ColorScheme.dark(
          primary: Colors.pinkAccent,
          secondary: Colors.amber,
          surface: Color(0xFF1E193D),
        ),
      ),
      home: const PBLiveMainContainer(),
    );
  }
}

class PBLiveMainContainer extends StatefulWidget {
  const PBLiveMainContainer({super.key});

  @override
  State<PBLiveMainContainer> createState() => _PBLiveMainContainerState();
}

class _PBLiveMainContainerState extends State<PBLiveMainContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PBLiveHomeScreen(),
    const PBLivePartyRoomsListScreen(),
    const PBLiveMessagesScreen(),
    const PBLiveProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mic_rounded), label: 'Party Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

// 1. Home Screen (स्क్రీన్शॉट जैसा हूबहू लेआउट)
class PBLiveHomeScreen extends StatelessWidget {
  const PBLiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("PB Live Party", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.emoji_events, color: Colors.amber), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // शॉर्टकट बबल्स
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickBubble("My Room", Icons.home, Colors.pinkAccent, context),
                  _buildQuickBubble("Quick Join", Icons.bolt, Colors.blueAccent, context),
                  _buildQuickBubble("Boss Babe", Icons.star, Colors.amber, context),
                  _buildQuickBubble("Cozy Corner", Icons.favorite, Colors.purpleAccent, context),
                ],
              ),
              const SizedBox(height: 15),
              // Find Your Vibe बैनर
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF3F2B96), Color(0xFFE91E63)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Find Your Vibe 🎉", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("Join live party rooms & chat", style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                    Icon(Icons.mic_external_on, color: Colors.white, size: 36),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // लाइव रूम्स लिस्ट
              const Text("Live Rooms", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> roomNames = ["The Glam Room ✨", "Pink Palace 👑", "Moon Lounge 🛋️", "Doll House 👗"];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PartyRoomScreen(roomName: roomNames[index])),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E193D),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 28, backgroundColor: Colors.pink, child: Icon(Icons.mic, color: Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(roomNames[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 4),
                                const Text("Welcome! Tap to join 15-seater room.", style: TextStyle(color: Colors.white60, fontSize: 11)),
                                const SizedBox(height: 6),
                                Row(
                                  children: const [
                                    Icon(Icons.local_fire_department, color: Colors.amber, size: 14),
                                    SizedBox(width: 4),
                                    Text("96", style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.pinkAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                            child: const Text("Public Room", style: TextStyle(color: Colors.pinkAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickBubble(String title, IconData icon, Color color, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PartyRoomScreen(roomName: "Official VIP Room")),
        );
      },
      child: Column(
        children: [
          CircleAvatar(radius: 26, backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color, size: 24)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 2. 15-Seater Party Room Screen (माइक और गिफ्टिंग के साथ)
class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "0001 (Owner)" : null,
    "isMuted": false,
    "isLocked": false,
  });

  void _showGiftsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Send Party Gifts 🎁", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGiftItem("🌹 Rose", "💎 10", Colors.red),
                _buildGiftItem("🚗 Sports Car", "💎 500", Colors.blue),
                _buildGiftItem("🏰 Castle", "💎 5000", Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Close", style: TextStyle(color: Colors.white54)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftItem(String name, String price, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully sent $name!")));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Colors.amber, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A1B4E), Color(0xFF141026)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      final seat = seats[index];
                      bool isOccupied = seat["user"] != null;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: index == 0 ? Colors.amber : Colors.white24, width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              index == 0 ? Icons.star : Icons.mic,
                              color: index == 0 ? Colors.amber : Colors.white70,
                              size: 22,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isOccupied ? seat["user"] : "${index + 1}",
                              style: const TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.black38,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Say something...",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent, size: 28),
                      onPressed: _showGiftsDialog,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. Party Rooms List Screen Tab
class PBLivePartyRoomsListScreen extends StatelessWidget {
  const PBLivePartyRoomsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("Party Rooms Grid", style: TextStyle(color: Colors.amber))),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PartyRoomScreen(roomName: "Live Party Room #1")));
          },
          child: const Text("Join 15-Seater Room Now", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

// 4. Messages Screen Placeholder
class PBLiveMessagesScreen extends StatelessWidget {
  const PBLiveMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("Messages", style: TextStyle(color: Colors.amber))),
      body: const Center(child: Text("Chats & Notifications", style: TextStyle(color: Colors.white))),
    );
  }
}

// 5. Profile Screen (Owner ID 0001, ब्लू टिक और ओनर पैनल)
class PBLiveProfileScreen extends StatelessWidget {
  const PBLiveProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("My Profile", style: TextStyle(color: Colors.amber))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(radius: 35, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 40, color: Colors.white)),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("Lovepreet Singh", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6),
                        Icon(Icons.verified, color: Colors.blue, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("ID: 0001 (Official Owner)", style: TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.admin_panel_settings, fontWeight: FontWeight.bold),
              label: const Text("Open Owner Super-Admin Panel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerPanelScreen()));
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circu
