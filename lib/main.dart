import 'dart:io';
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
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF100525), useMaterial3: true),
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
  final List<Widget> _pages = const [HomeView(), MsgView(), SizedBox.shrink(), RankView(), ProfileView()];

  void _openRoom(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1A0D33),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Create Live Room", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
        decoration: const BoxDecoration(color: Color(0xFF1A0D33), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home, color: _idx == 0 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 0)),
            IconButton(icon: Icon(Icons.message, color: _idx == 1 ? pink : Colors.grey), onPressed: () => setState(() => _idx = 1)),
            FloatingActionButton(backgroundColor: pink, mini: true, onPressed: () => _openRoom(context), child: const Icon(Icons.add, color: Colors.white)),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85),
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RoomView())),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFF1A0D33), borderRadius: BorderRadius.circular(12)),
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

String globalName = "lij";
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
      globalName = prefs.getString('p_name') ?? "lij";
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
                      backgroundImage: (globalDpPath != null && File(globalDpPath!).existsSync()) ? FileImage(File(globalDpPath!)) as ImageProvider : null,
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
                    Text(globalName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("ID: 10350359", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(14)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [Icon(Icons.diamond, color: Colors.amber), SizedBox(width: 8), Text("Diamonds: 20K", style: TextStyle(fontWeight: FontWeight.bold))]),
                  Text("Wallet >", style: TextStyle(color: pink)),
                ],
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.handshake, color: Colors.amber), Text("Agency", style: TextStyle(fontSize: 10))]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.people_alt, color: Colors.amber), Text("BD Center", style: TextStyle(fontSize: 10))]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mic, color: Colors.amber), Text("Host", style: TextStyle(fontSize: 10))]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.workspace_premium, color: Colors.amber), Text("VIP", style: TextStyle(fontSize: 10))]),
              ],
            ),
            const ListTile(leading: Icon(Icons.flash_on), title: Text("Offline Recharge")),
            const ListTile(leading: Icon(Icons.photo_album), title: Text("My Posts")),
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
  final List<Map<String, String?>> _seats = List.generate(12, (_) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120826),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("12-Seat Party Room", style: TextStyle(fontSize: 16)),
        actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.8),
                itemBuilder: (ctx, i) {
                  bool isOccupied = _seats[i] != null;
                  String? seatDp = isOccupied ? _seats[i]!['dp'] : null;
                  bool hasValidImage = seatDp != null && File(seatDp).existsSync();

                  return GestureDetector(
                    onTap: () => setState(() => _seats[i] = isOccupied ? null : {'name': globalName, 'dp': globalDpPath}),
                    child: Column(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isOccupied ? Colors.purple : Colors.white10,
                            border: Border.all(color: const Color(0xFFFF00FF)),
                            image: hasValidImage ? DecorationImage(image: FileImage(File(seatDp)), fit: BoxFit.cover) : null,
                          ),
                          child: Center(
                            child: (!hasValidImage) ? Text(isOccupied ? _seats[i]!['name']!.substring(0, 1).toUpperCase() : "${i + 1}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)) : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(isOccupied ? _seats[i]!['name']! : "Open", style: const TextStyle(color: Colors.grey, fontSize: 10), overflow: TextOverflow.ellipsis),
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
            child: const Row(
              children: [
                Expanded(child: TextField(decoration: InputDecoration(hintText: "Say something in room...", border: InputBorder.none))),
                Icon(Icons.card_giftcard, color: Color(0xFFFF00FF)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

