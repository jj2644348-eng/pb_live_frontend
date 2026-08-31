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
    const PBLivePartyRoomsScreen(),
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

// 1. Home Screen (स्क్రీన్शॉट 13434.jpg जैसा हूबहू डिजाइन)
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
              // शॉर्टकट बबल्स (My Room, Quick Join आदि)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickBubble("My Room", Icons.home, Colors.pinkAccent),
                  _buildQuickBubble("Quick Join", Icons.bolt, Colors.blueAccent),
                  _buildQuickBubble("Boss Babe", Icons.star, Colors.amber),
                  _buildQuickBubble("Cozy Corner", Icons.favorite, Colors.purpleAccent),
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
                  return Container(
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
                              const Text("Welcome! Drop your mic and enjoy.", style: TextStyle(color: Colors.white60, fontSize: 11)),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickBubble(String title, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(radius: 26, backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color, size: 24)),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// 2. Party Rooms Screen Placeholder
class PBLivePartyRoomsScreen extends StatelessWidget {
  const PBLivePartyRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("Party Rooms", style: TextStyle(color: Colors.amber))),
      body: const Center(child: Text("15-Seater Rooms Grid", style: TextStyle(color: Colors.white))),
    );
  }
}

// 3. Messages Screen Placeholder
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

// 4. Profile Screen (Owner ID 0001, ब्लू टिक और ओनर पैनल का बटन)
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
            // ओनर सुपर-एडमिन पैनल खोलने का बटन
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
            // ऑफलाइन रिचार्ज बॉक्स
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Official WhatsApp Recharge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 6),
                  Text("+91 9779353560", style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Owner Super-Admin Panel Screen (अनलिमिटेड कॉइन्स, सेलर और बीडी मेकर)
class OwnerPanelScreen extends StatefulWidget {
  const OwnerPanelScreen({super.key});

  @override
  State<OwnerPanelScreen> createState() => _OwnerPanelScreenState();
}

class _OwnerPanelScreenState extends State<OwnerPanelScreen> {
  final TextEditingController _targetIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appData = AppData();
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("Owner Super-Admin Panel", style: TextStyle(color: Colors.amber))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Owner Controls & Coin Generator", style: TextStyle(color: Colors.pinkAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text("My Balance: 🪙 ${appData.myCoins} | 💎 ${appData.myDiamonds}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    onPressed: () {
                      setState(() {
                        appData.addCoins(10000000); // 1 करोड़ और जोड़ें
                        appData.addDiamonds(5000000);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Generated 10M Coins & 5M Diamonds Successfully!")));
                    },
                    child: const Text("Generate Unlimited Coins (10M)", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Assign Roles & Coin Sellers", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _targetIdController,
              decoration: InputDecoration(
                hintText: "Enter User ID (e.g. 1005)",
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (_targetIdController.text.isNotEmpty) {
                      appData.assignSeller(_targetIdController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ID ${_targetIdController.text} Assigned as Coin Seller!")));
                    }
                  },
                  child: const Text("Make Coin Seller"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {
                    if (_targetIdController.text.isNotEmpty) {
                      appData.assignBDAdmin(_targetIdController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ID ${_targetIdController.text} Assigned as BD/Admin!")));
                    }
                  },
                  child: const Text("Make BD/Admin"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

