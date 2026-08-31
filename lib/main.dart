import 'package:flutter/material.dart';

// ============================================================
// GLOBAL APP DATA
// ============================================================

class AppData extends ChangeNotifier {
  static final AppData _instance = AppData._internal();

  factory AppData() => _instance;

  AppData._internal();

  // Owner balance
  int myCoins = 100000000;
  int myDiamonds = 50000000;

  // Owner status
  bool isOwner = true;

  // Role management
  final List<String> coinSellers = [];
  final List<String> bdAdmins = [];
  final List<String> bannedUsers = [];

  // Add coins
  void addCoins(int amount) {
    if (amount <= 0) return;

    myCoins += amount;
    notifyListeners();
  }

  // Add diamonds
  void addDiamonds(int amount) {
    if (amount <= 0) return;

    myDiamonds += amount;
    notifyListeners();
  }

  // Assign coin seller
  void assignSeller(String userId) {
    if (userId.trim().isEmpty) return;

    if (!coinSellers.contains(userId)) {
      coinSellers.add(userId);
      notifyListeners();
    }
  }

  // Assign BD/Admin
  void assignBDAdmin(String userId) {
    if (userId.trim().isEmpty) return;

    if (!bdAdmins.contains(userId)) {
      bdAdmins.add(userId);
      notifyListeners();
    }
  }

  // Ban user
  void banUser(String userId) {
    if (userId.trim().isEmpty) return;

    if (!bannedUsers.contains(userId)) {
      bannedUsers.add(userId);
      notifyListeners();
    }
  }
}

// ============================================================
// MAIN
// ============================================================

void main() {
  runApp(const PBLivePartyApp());
}

// ============================================================
// MAIN APP
// ============================================================

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E193D),
          elevation: 0,
        ),
      ),
      home: const PBLiveMainContainer(),
    );
  }
}

// ============================================================
// MAIN CONTAINER
// ============================================================

class PBLiveMainContainer extends StatefulWidget {
  const PBLiveMainContainer({super.key});

  @override
  State<PBLiveMainContainer> createState() =>
      _PBLiveMainContainerState();
}

class _PBLiveMainContainerState
    extends State<PBLiveMainContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PBLiveHomeScreen(),
    PBLivePartyRoomsScreen(),
    PBLiveMessagesScreen(),
    PBLiveProfileScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_rounded),
            label: 'Party Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class PBLiveHomeScreen extends StatelessWidget {
  const PBLiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PB Live Party",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.emoji_events,
              color: Colors.amber,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.person_search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QUICK BUBBLES
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickBubble(
                    "My Room",
                    Icons.home,
                    Colors.pinkAccent,
                  ),
                  _buildQuickBubble(
                    "Quick Join",
                    Icons.bolt,
                    Colors.blueAccent,
                  ),
                  _buildQuickBubble(
                    "Boss Babe",
                    Icons.star,
                    Colors.amber,
                  ),
                  _buildQuickBubble(
                    "Cozy Corner",
                    Icons.favorite,
                    Colors.purpleAccent,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // FIND YOUR VIBE
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3F2B96),
                      Color(0xFFE91E63),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Your Vibe 🎉",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Join live party rooms & chat",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.mic_external_on,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Live Rooms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // LIVE ROOMS
              ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final roomNames = [
                    "The Glam Room ✨",
                    "Pink Palace 👑",
                    "Moon Lounge 🛋️",
                    "Doll House 👗",
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PartyRoomScreen(
                            roomName: roomNames[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E193D),
                        borderRadius:
                            BorderRadius.circular(15),
                        border: Border.all(
                          color:
                              Colors.pinkAccent.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.pink,
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  roomNames[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Welcome! Drop your mic and enjoy.",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .local_fire_department,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "96",
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 11,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent
                                  .withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Public Room",
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
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

  Widget _buildQuickBubble(
    String title,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PARTY ROOMS SCREEN
// ============================================================

class PBLivePartyRoomsScreen extends StatelessWidget {
  const PBLivePartyRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      "Punjab Live 🔥",
      "Music Zone 🎵",
      "Friends Room ❤️",
      "Night Party 🌙",
      "Chill Room 😎",
      "VIP Lounge 👑",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Party Rooms",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: rooms.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.05,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PartyRoomScreen(
                    roomName: rooms[index],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.pinkAccent.withOpacity(0.25),
                ),
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.pinkAccent,
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    rooms[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "15 Seats",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// PARTY ROOM
// ============================================================

class PartyRoomScreen extends StatefulWidget {
  final String roomName;

  const PartyRoomScreen({
    super.key,
    required this.roomName,
  });

  @override
  State<PartyRoomScreen> createState() =>
      _PartyRoomScreenState();
}

class _PartyRoomScreenState
    extends State<PartyRoomScreen> {
  bool micOn = false;

  final List<bool> seats =
      List<bool>.filled(15, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roomName,
          style: const TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),

          const Text(
            "15 Seat Party Room",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // SEATS
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 15,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 18,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      seats[index] = !seats[index];
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: seats[index]
                            ? Colors.pinkAccent
                            : const Color(0xFF29234D),
                        child: Icon(
                          seats[index]
                              ? Icons.person
                              : Icons.mic_none,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Seat ${index + 1}",
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // BOTTOM CONTROLS
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E193D
