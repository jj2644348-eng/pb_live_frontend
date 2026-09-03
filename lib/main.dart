import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100525),
        useMaterial3: true,
      ),
      home: const MainNav(),
    );
  }
}

// ग्लोबल यूजर और ओनर स्टेट (ओनर आईडी: 000, फिक्स)
String globalName = "Official Owner";
String? globalDpPath;
String globalUserId = "000";
int globalCoins = 99999999;
bool isOwner = true;
bool isMerchant = true;
int vipLevel = 40;
int freeLevel = 100;
bool isFollowing = false;
bool isFloatingRoomActive = false;

// ग्लोबल रूम सॉन्ग स्टेट
bool isRoomSongActive = false;
String activeSongTitle = "No Song Playing";

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _idx = 0;
  final List<Widget> _pages = const [
    HomeView(),
    MsgView(),
    GamesView(),
    RankView(),
    ProfileView(),
  ];

  void _openRoom(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1A0D33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Create Live Room",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.mic, color: Color(0xFFFF00FF)),
              title: const Text("12-Seat Party Audio Room", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => isFloatingRoomActive = true);
                Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RoomView()));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xFFFF00FF);
    return Scaffold(
      body: Stack(
        children: [
          _pages[_idx],
          if (isFloatingRoomActive && (_idx != 0))
            Positioned(
              top: 40,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomView())),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade900,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: pink, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 6)],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mic, color: Colors.greenAccent, size: 16),
                      const SizedBox(width: 6),
                      const Text("Live Room", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() => isFloatingRoomActive = false),
                        child: const Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Color(0xFF1A0D33),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home, color: _idx == 0 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 0)),
            IconButton(icon: Icon(Icons.message, color: _idx == 1 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 1)),
            FloatingActionButton(
              backgroundColor: pink,
              mini: true,
              onPressed: () => _openRoom(context),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            IconButton(icon: Icon(Icons.casino, color: _idx == 2 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 2)),
            IconButton(icon: Icon(Icons.leaderboard, color: _idx == 3 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 3)),
            IconButton(icon: Icon(Icons.person, color: _idx == 4 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 4)),
          ],
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Official PB Live Rooms", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () {
                    isFloatingRoomActive = true;
                    Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RoomView()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A0D33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mic, size: 40, color: Color(0xFFFF00FF)),
                        const SizedBox(height: 8),
                        Text("Party Room #${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Text("12 Seats • Live", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgView extends StatelessWidget {
  const MsgView({super.key});
  @override
  Widget build(BuildContext context) => const SafeArea(child: Center(child: Text("Messages & Chats Panel", style: TextStyle(fontSize: 18))));
}

class RankView extends StatelessWidget {
  const RankView({super.key});
  @override
  Widget build(BuildContext context) => const SafeArea(child: Center(child: Text("Leaderboard & Rich List", style: TextStyle(fontSize: 18))));
}
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      globalName = prefs.getString('p_name') ?? "Official Owner";
      globalDpPath = prefs.getString('p_dp');
      globalUserId = prefs.getString('p_uid') ?? "000";
      globalCoins = prefs.getInt('p_coins') ?? 99999999;
      vipLevel = prefs.getInt('p_vip') ?? 40;
      freeLevel = prefs.getInt('p_free_lvl') ?? 100;
    });
  }

  void _showGoogleAccountPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0D33),
        title: const Text("Choose Google Account", style: TextStyle(color: Colors.amber, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.red, child: Text("O", style: TextStyle(color: Colors.white))),
              title: const Text("owner.pb@gmail.com"),
              subtitle: const Text("Official Owner (ID: 000)"),
              onTap: () {
                setState(() {
                  globalName = "Lovepreet Singh";
                  globalUserId = "000";
                  isOwner = true;
                  vipLevel = 40;
                  freeLevel = 100;
                  globalCoins = 99999999;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged in as Owner (ID: 000) Successfully! ✅")));
              },
            ),
            ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.blue, child: Text("U", style: TextStyle(color: Colors.white))),
              title: const Text("user.pblive@gmail.com"),
              subtitle: const Text("Regular User"),
              onTap: () {
                final random = Random();
                setState(() {
                  globalName = "PB User";
                  globalUserId = "20" + (100000 + random.nextInt(900000)).toString();
                  isOwner = false;
                  vipLevel = 1;
                  freeLevel = 5;
                  globalCoins = 500;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged in as User Successfully! ✅")));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDP() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('p_dp', picked.path);
      setState(() => globalDpPath = picked.path);
    }
  }

  void _mintOwnerCoins() {
    if (globalUserId == "000" || isOwner) {
      setState(() {
        globalCoins += 500000;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("👑 Owner Minted +500,000 Coins Successfully! 🎉")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Only Owner (ID: 000) can mint coins!"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF1A0D33);
    const pink = Color(0xFFFF00FF);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                      backgroundImage: (globalDpPath != null && File(globalDpPath!).existsSync())
                          ? FileImage(File(globalDpPath!)) as ImageProvider
                          : null,
                      child: (globalDpPath == null || !File(globalDpPath!).existsSync()) ? const Icon(Icons.person, size: 45) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickDP,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: pink, shape: BoxShape.circle),
                          child: const Icon(Icons.edit, size: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(globalName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        if (isOwner || globalUserId == "000") const Icon(Icons.verified, color: Colors.blueAccent, size: 18),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text("ID: $globalUserId", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(4)),
                          child: Text("VIP $vipLevel", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4)),
                          child: Text("Free Lvl $freeLevel", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 42)),
              onPressed: _showGoogleAccountPicker,
              icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
              label: const Text("Sign in with Google", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.diamond, color: Colors.amber),
                          const SizedBox(width: 8),
                          Text("Coins: $globalCoins", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      if (globalUserId == "000")
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                          onPressed: _mintOwnerCoins,
                          child: const Text("+ Mint Coins", style: TextStyle(color: Colors.white, fontSize: 11)),
                        )
                      else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: pink, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please purchase coins from store!")));
                          },
                          child: const Text("Buy Coins", style: TextStyle(color: Colors.white, fontSize: 11)),
                        ),
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
}

class GamesView extends StatefulWidget {
  const GamesView({super.key});
  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  double _multiplier = 1.00;
  bool _isPlaying = false;
  bool _forceCrash = false;

  void _startRocket() {
    setState(() {
      _isPlaying = true;
      _multiplier = 1.00;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted || !_isPlaying) return false;
      setState(() => _multiplier += 0.15);
      if (_forceCrash || _multiplier > 5.0) {
        _isPlaying = false;
        _forceCrash = false;
      }
      return _isPlaying;
    });
  }

  void _showGameDialog(String gameName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0D33),
        title: Text("$gameName Live Table", style: const TextStyle(color: Colors.amber)),
        content: Text("Welcome to $gameName! Place bets and win diamonds.", style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF00FF)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You won 5,000 diamonds in $gameName! 🪙")));
            },
            child: const Text("Play & Win", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🎮 Real Party Games", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _gameCard("Kredi Game", Icons.casino, () => _showGameDialog("Kredi"))),
                const SizedBox(width: 10),
                Expanded(child: _gameCard("Teen Patti", Icons.style, () => _showGameDialog("Teen Patti"))),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _gameCard("Treasure Hunt", Icons.gps_fixed, () => _showGameDialog("Treasure Hunt"))),
                const SizedBox(width: 10),
                Expanded(child: _gameCard("Lucky Wheel", Icons.rotate_right, () => _showGameDialog("Lucky Wheel"))),
              ],
            ),
            const SizedBox(height: 25),
            const Text("🚀 Rocket Crash Game (Owner Control)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFF110723), borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "${_multiplier.toStringAsFixed(2)}x",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: _isPlaying ? Colors.greenAccent : Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (!_isPlaying)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 45)),
                onPressed: _startRocket,
                child: const Text("Start Rocket", style: TextStyle(fontSize: 16, color: Colors.white)),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 45)),
                onPressed: () => setState(() => _forceCrash = true),
                child: const Text("Crash Now (Owner Control)", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(color: const Color(0xFF1A0D33), borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: const Color(0xFFFF00FF)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class RoomView extends StatefulWidget {
  const RoomView({super.key});
  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final List<Map<String, dynamic>?> _seats = List.generate(12, (_) => null);
  final List<String> _roomMessages = ["Welcome to PB Live Party Room! 🎉"];
  final TextEditingController _msgController = TextEditingController();
  bool isRoomLocked = false;
  bool isRoomPublic = true;

  void _sendMessage() {
    if (_msgController.text.trim().isNotEmpty) {
      setState(() {
        _roomMessages.add("$globalName: ${_msgController.text.trim()}");
        _msgController.clear();
      });
    }
  }

  void _handleSeatTap(int index) {
    setState(() {
      if (_seats[index] == null) {
        _seats[index] = {
          'name': globalName,
          'dp': globalDpPath,
          'uid': globalUserId,
          'isMuted': false,
        };
      } else {
        _showSeatControlDialog(_seats[index]!, index);
      }
    });
  }

  void _showSeatControlDialog(Map<String, dynamic> seatUser, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0D33),
        title: Text(seatUser['name'], style: const TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("ID: ${seatUser['uid']}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: isFollowing ? Colors.grey : const Color(0xFFFF00FF)),
              onPressed: () {
                setState(() => isFollowing = !isFollowing);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(isFollowing ? "Successfully Followed! 🤝" : "Unfollowed!")),
                );
              },
              child: Text(isFollowing ? "Following ✓" : "Follow +", style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700),
              onPressed: () {
                setState(() => seatUser['isMuted'] = !seatUser['isMuted']);
                Navigator.pop(context);
              },
              child: Text(seatUser['isMuted'] ? "Unmute Mic" : "Mute Mic", style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() => _seats[index] = null);
                Navigator.pop(context);
              },
              child: const Text("Get Off Seat", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }

  // रूम सॉन्ग प्लेयर फंक्शन
  void _playRoomSong(String songTitle) {
    setState(() {
      isRoomSongActive = true;
      activeSongTitle = songTitle;
      _roomMessages.add("🎵 Now Playing in Room: $songTitle 🎶");
    });
  }

  void _stopRoomSong() {
    setState(() {
      isRoomSongActive = false;
      activeSongTitle = "No Song Playing";
      _roomMessages.add("⏹️ Music stopped by admin.");
    });
  }

  void _showSongSelector(BuildContext context) {
    final List<String> playlist = [
      "PB Anthem Official Rap 🎧",
      "Punjabi Party Beat 💃",
      "Romantic Qawwali Mix 🌹",
      "Club DJ Remix 2026 🪩",
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0D33),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Room Music Player 🎶", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 5),
            Text("Active Song: $activeSongTitle", style: const TextStyle(fontSize: 11, color: Colors.greenAccent)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.music_note, color: Color(0xFFFF00FF)),
                    title: Text(playlist[index], style: const TextStyle(color: Colors.white, fontSize: 12)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700),
                      onPressed: () {
                        Navigator.pop(context);
                        _playRoomSong(playlist[index]);
                      },
                      child: const Text("Play", style: TextStyle(fontSize: 10)),
                    ),
                  );
                },
              ),
            ),
            if (isRoomSongActive)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 35)),
                onPressed: () {
                  Navigator.pop(context);
                  _stopRoomSong();
                },
                icon: const Icon(Icons.stop, size: 16),
                label: const Text("Stop Music"),
              ),
          ],
        ),
      ),
    );
  }

  void _showRoomPlusMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0D33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize
