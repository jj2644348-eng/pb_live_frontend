import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PBPartyApp());
}

class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PB Party',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090811),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ============================================================
// MAIN SCREEN
// ============================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    GamePage(),
    CreateRoomPage(),
    MessagesPage(),
    MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF171620),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Party',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
            label: 'Game',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline, size: 30),
            selectedIcon: Icon(Icons.add_circle, size: 30),
            label: 'Room',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0B0912),
            floating: true,
            title: const Text(
              'PB PARTY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: UserSearchDelegate(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
          ),

          // EVENT BANNER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: EventBanner(),
            ),
          ),

          SliverToBoxAdapter(
            child: sectionTitle('Popular Rooms'),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 145,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PartyRoomPage(
                            roomName: 'Popular Room ${index + 1}',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4B1675),
                            Color(0xFF15112A),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Room ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '🔥 LIVE',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: sectionTitle('Country Rooms'),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final countries = [
                  '🇮🇳 India Party',
                  '🇵🇭 Philippines Party',
                  '🇮🇩 Indonesia Party',
                  '🌎 International',
                ];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      countries[index].substring(0, 2),
                    ),
                  ),
                  title: Text(countries[index]),
                  subtitle: const Text('Live voice chat • Join now'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PartyRoomPage(
                          roomName: countries[index],
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 10),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Text(
            'View all',
            style: TextStyle(color: Colors.purpleAccent),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EVENT BANNER
// ============================================================

class EventBanner extends StatefulWidget {
  const EventBanner({super.key});

  @override
  State<EventBanner> createState() => _EventBannerState();
}

class _EventBannerState extends State<EventBanner> {
  int page = 0;

  final events = [
    '🎁 Daily Gift Event',
    '💎 Double Coin Bonus',
    '👑 VIP Party Night',
    '🔥 Top Gifter Event',
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (mounted) {
          setState(() {
            page = (page + 1) % events.length;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7415A5),
            Color(0xFFEF147F),
            Color(0xFFFFA000),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(.4),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.campaign,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                events[page],
                key: ValueKey(page),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

// ============================================================
// ROOM
// ============================================================

class PartyRoomPage extends StatefulWidget {
  final String roomName;

  const PartyRoomPage({
    super.key,
    required this.roomName,
  });

  @override
  State<PartyRoomPage> createState() => _PartyRoomPageState();
}

class _PartyRoomPageState extends State<PartyRoomPage> {
  final List<String?> seats = List.filled(12, null);

  int? mySeat;
  int coins = 100000;

  String? giftName;
  IconData? giftIcon;
  bool showGiftAnimation = false;

  @override
  void initState() {
    super.initState();

    // Demo user पहले से seat 1 पर
    seats[0] = 'Love PB';
  }

  void takeSeat(int index) {
    setState(() {
      if (mySeat != null) {
        seats[mySeat!] = null;
      }

      seats[index] = 'Love PB';
      mySeat = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('आप NO.${index + 1} सीट पर बैठ गए'),
      ),
    );
  }

  void leaveSeat() {
    if (mySeat == null) return;

    setState(() {
      seats[mySeat!] = null;
      mySeat = null;
    });
  }

  void sendGift(
    String name,
    IconData icon,
    int price,
  ) {
    if (coins < price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coins कम हैं'),
        ),
      );
      return;
    }

    setState(() {
      coins -= price;
      giftName = name;
      giftIcon = icon;
      showGiftAnimation = true;
    });

    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (mounted) {
          setState(() {
            showGiftAnimation = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080711),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFF38204E),
                  Color(0xFF100C19),
                  Color(0xFF07070C),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // TOP BAR
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          widget.roomName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.share),
                      const SizedBox(width: 15),
                      const Icon(Icons.menu),
                    ],
                  ),
                ),

                // ROOM INFO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        '99+',
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                      const SizedBox(width: 8),
                      const Text('Lv. 1 Heart'),
                      const Spacer(),
                      Text(
                        '💎 $coins',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // SEATS
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(18),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 12,
                      childAspectRatio: .72,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final occupied = seats[index] != null;

                      return GestureDetector(
                        onTap: () {
                          if (!occupied) {
                            takeSeat(index);
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: occupied
                                    ? Colors.deepPurple
                                    : Colors.white24,
                                border: Border.all(
                                  color: occupied
                                      ? Colors.amber
                                      : Colors.white24,
                                  width: 3,
                                ),
                              ),
                              child: occupied
                                  ? const Icon(
                                      Icons.person,
                                      size: 42,
                                    )
                                  : const Icon(
                                      Icons.add,
                                      size: 38,
                                      color: Colors.white54,
                                    ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              occupied
                                  ? seats[index]!
                                  : 'NO.${index + 1}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (occupied)
                              TextButton(
                                onPressed: () {
                                  showGiftPanel(
                                    context,
                                    index,
                                  );
                                },
                                child: const Text(
                                  '🎁 Gift',
                                  style: TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ROOM CONTROLS
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF171620),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Send a message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.music_note),
                        onPressed: () {
                          showMusicPanel(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.card_giftcard,
                          color: Colors.amber,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          showGiftPanel(
                            context,
                            mySeat ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // GIFT ANIMATION
          if (showGiftAnimation)
            Positioned.fill(
              child: IgnorePointer(
                child: GiftAnimationOverlay(
            
