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
    RocketGameView(),
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
      body: _pages[_idx],
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
            IconButton(icon: Icon(Icons.rocket_launch, color: _idx == 2 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 2)),
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
                  onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RoomView())),
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

String globalName = "Lovepreet Singh";
String? globalDpPath;
String globalUserId = "98234105";
int globalCoins = 99999999;
bool isOwner = true;
bool isMerchant = true;

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
      globalName = prefs.getString('p_name') ?? "Lovepreet Singh";
      globalDpPath = prefs.getString('p_dp');
      globalUserId = prefs.getString('p_uid') ?? _generateUniqueId();
      globalCoins = prefs.getInt('p_coins') ?? 99999999;
    });
  }

  String _generateUniqueId() {
    final random = Random();
    String id = (10000000 + random.nextInt(90000000)).toString();
    SharedPreferences.getInstance().then((p) => p.setString('p_uid', id));
    return id;
  }

  Future<void> _pickDP() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('p_dp', picked.path);
      setState(() => globalDpPath = picked.path);
    }
  }

  void _showCoinTransferDialog() {
    final TextEditingController targetIdController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0D33),
        title: const Text("Transfer Coins / Diamonds", style: TextStyle(color: Colors.amber, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: targetIdController, decoration: const InputDecoration(labelText: "Enter User 8-Digit ID")),
            TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Amount")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF00FF)),
            onPressed: () {
              int transferAmt = int.tryParse(amountController.text) ?? 0;
              if (transferAmt > 0 && globalCoins >= transferAmt) {
                setState(() => globalCoins -= transferAmt);
                Navigator.pop(context);
              }
            },
            child: const Text("Transfer", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
                        if (isOwner) const Icon(Icons.verified, color: Colors.blueAccent, size: 18),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text("ID: $globalUserId", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 2),
                    if (isOwner)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                        child: const Text("Official Owner", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.diamond, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text("Coins: $globalCoins", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  if (isOwner || isMerchant)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: pink, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                      onPressed: _showCoinTransferDialog,
                      child: const Text("Transfer Coins", style: TextStyle(color: Colors.white, fontSize: 11)),
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

class RocketGameView extends StatefulWidget {
  const RocketGameView({super.key});
  @override
  State<RocketGameView> createState() => _RocketGameState();
}

class _RocketGameState extends State<RocketGameView> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🚀 Rocket Crash Game", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 30),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFF110723), borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "${_multiplier.toStringAsFixed(2)}x",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: _isPlaying ? Colors.greenAccent : Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (!_isPlaying)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
                onPressed: _startRocket,
                child: const Text("Start Rocket", style: TextStyle(fontSize: 16, color: Colors.white)),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
                onPressed: () => setState(() => _forceCrash = true),
                child: const Text("Crash Now (Owner Control)", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
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

  void _toggleMic(int index) {
    if (_seats[index] != null) {
      setState(() {
        _seats[index]!['isMuted'] = !_seats[index]!['isMuted'];
      });
    }
  }

  void _showGiftsDialog(BuildContext context) {
    final List<Map<String, dynamic>> gifts = [
      {"name": "Red Rose 🌹", "price": "10 💎"},
      {"name": "Star Magic ✨", "price": "50 💎"},
      {"name": "Birthday Cake 🎂", "price": "200 💎"},
      {"name": "Luxury Sports Car 🚗", "price": "500 💎"},
      {"name": "Royal Crown 👑", "price": "1000 💎"},
      {"name": "PB DJ Party 🎊", "price": "2500 💎"},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0D33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Send Room Party Gifts",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: gifts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2A1548)),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Sent ${gifts[index]['name']} successfully! 🎉")),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gifts[index]['name'], style: const TextStyle(fontSize: 11, color: Colors.white)),
                        Text(gifts[index]['price'], style: const TextStyle(fontSize: 9, color: Colors.amber)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120826),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("PB Live 12-Seat Party Room", style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (ctx, i) {
                  bool occ = _seats[i] != null;
                  String? dp = occ ? _seats[i]!['dp'] : null;
                  bool validImg = dp != null && File(dp).existsSync();
                  bool isMuted = occ ? _seats[i]!['isMuted'] : false;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (occ) {
                          _seats[i] = null;
                        } else {
                          _seats[i] = {
                            'name': globalName,
                            'dp': globalDpPath,
                            'isMuted': false,
                          };
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: occ ? Colors.purple : Colors.white10,
                                border: Border.all(color: const Color(0xFFFF00FF), width: 2),
                                image: validImg ? DecorationImage(image: FileImage(File(dp!)), fit: BoxFit.cover) : null,
                              ),
                              child: Center(
                                child: (!validImg)
                                    ? Text(
                                        occ ? _seats[i]!['name']!.substring(0, 1).toUpperCase() : "${i + 1}",
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      )
                                    : null,
                              ),
                            ),
                            if (occ)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => _toggleMic(i),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: isMuted ? Colors.red : Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(isMuted ? Icons.mic_off : Icons.mic, size: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          occ ? _seats[i]!['name']! : "Seat ${i + 1}",
                          style: const TextStyle(color: Colors.grey, fontSize: 10),
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
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF1A0D33),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Say something in room...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.card_giftcard, color: Color(0xFFFF00FF)),
                  onPressed: () => _showGiftsDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
