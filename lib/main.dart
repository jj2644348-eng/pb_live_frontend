import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    SizedBox.shrink(),
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.mic, color: Color(0xFFFF00FF)),
              title: const Text(
                "12-Seat Party Audio Room",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  ctx,
                  MaterialPageRoute(builder: (_) => const RoomView()),
                );
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
            IconButton(
              icon: Icon(Icons.home, color: _idx == 0 ? pink : Colors.grey),
              onPressed: () => setState(() => _idx = 0),
            ),
            IconButton(
              icon: Icon(Icons.message, color: _idx == 1 ? pink : Colors.grey),
              onPressed: () => setState(() => _idx = 1),
            ),
            FloatingActionButton(
              backgroundColor: pink,
              mini: true,
              onPressed: () => _openRoom(context),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                Icons.leaderboard,
                color: _idx == 3 ? pink : Colors.grey,
              ),
              onPressed: () => setState(() => _idx = 3),
            ),
            IconButton(
              icon: Icon(Icons.person, color: _idx == 4 ? pink : Colors.grey),
              onPressed: () => setState(() => _idx = 4),
            ),
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
            const Text(
              "Official PB Live Rooms",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () => Navigator.push(
                    ctx,
                    MaterialPageRoute(builder: (_) => const RoomView()),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A0D33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mic,
                          size: 40,
                          color: Color(0xFFFF00FF),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Party Room #${i + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "12 Seats • Live",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
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
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text("Messages & Chats Panel", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class RankView extends StatelessWidget {
  const RankView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          "Leaderboard & Rich List",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

String globalName = "Official Tech Love";
String? globalDpPath;

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
      globalName = prefs.getString('p_name') ?? "Official Tech Love";
      globalDpPath = prefs.getString('p_dp');
    });
  }

  Future<void> _pickDP() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('p_dp', picked.path);
      setState(() => globalDpPath = picked.path);
    }
  }

  // व्हाट्सएप पर ऑफलाइन रिचार्ज पेज ओपन करने का फंक्शन
  void _openWhatsAppRecharge(int amount, int diamonds) async {
    final url = Uri.parse(
        "https://wa.me/919779353560?text=Hello%20Official%20Tech%20Love%20PB,%20I%20want%20to%20recharge%20%E2%82%B9$amount%20for%20$diamonds%20Diamonds%20in%20PB%20Live.%20Here%20is%20my%20payment%20details.");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showRechargeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0D33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Offline Diamond Recharge",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 5),
            const Text(
              "Select a pack to chat on WhatsApp (+919779353560)",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            _rechargeTile("₹50 - 5,000 Diamonds", 50, 5000),
            _rechargeTile("₹100 - 10,000 Diamonds", 100, 10000),
            _rechargeTile("₹250 - 26,000 Diamonds", 250, 26000),
            _rechargeTile("₹500 - 55,000 Diamonds", 500, 55000),
            _rechargeTile("₹1,000 - 1,15,000 Diamonds", 1000, 115000),
          ],
        ),
      ),
    );
  }

  Widget _rechargeTile(String title, int amt, int dia) {
    return ListTile(
      leading: const Icon(Icons.diamond, color: Colors.amber),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Text("Buy via WA", style: TextStyle(color: Color(0xFFFF00FF), fontSize: 12)),
      onTap: () {
        Navigator.pop(context);
        _openWhatsAppRecharge(amt, dia);
      },
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
                      backgroundImage:
                          (globalDpPath != null &&
                                  File(globalDpPath!).existsSync())
                              ? FileImage(File(globalDpPath!)) as ImageProvider
                              : null,
                      child:
                          (globalDpPath == null ||
                                  !File(globalDpPath!).existsSync())
                              ? const Icon(Icons.person, size: 45)
                              : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickDP,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: pink,
                            shape: BoxShape.circle,
                          ),
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
                    Text(
                      globalName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "ID: 10350359",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _showRechargeDialog(context),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          "Recharge Diamonds (Offline)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text("WhatsApp >", style: TextStyle(color: pink)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handshake, color: Colors.amber),
                    Text("Agency", style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_alt, color: Colors.amber),
                    Text("BD Center", style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, color: Colors.amber),
                    Text("Host", style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.workspace_premium, color: Colors.amber),
                    Text("VIP", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            const ListTile(
              leading: Icon(Icons.flash_on),
              title: Text("Offline Recharge Support"),
            ),
            const ListTile(
              leading: Icon(Icons.photo_album),
              title: Text("My Posts"),
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

  // गिफ्ट भेजने का पैनल
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
        title: const Text(
          "PB Live 12-Seat Party Room",
          style: TextStyle(fontSize: 16),
        ),
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
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                border: Border.all(
                                  color: const Color(0xFFFF00FF),
                                  width: 2,
                                ),
                                image: validImg
                                    ? Decoration
