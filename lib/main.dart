import 'package:flutter/material.dart';

void main() => runApp(const PBApp());

class PBApp extends StatelessWidget {
  const PBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141026),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int idx = 0;
  final screens = const [HomeTab(), RoomsTab(), MessageTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
          icon: const Icon(Icons.mic),
          label: const Text("Join Official Party Room"),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomView("PB Official Hub"))),
        ),
      ),
    );
  }
}

class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 4,
        itemBuilder: (c, i) => InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoomView("Party Room ${i + 1}"))),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pinkAccent)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mic, color: Colors.amber, size: 36), SizedBox(height: 8), Text("Audio Live Room", style: TextStyle(color: Colors.white))]),
          ),
        ),
      ),
    );
  }
}

class MessageTab extends StatelessWidget {
  const MessageTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: ListView(children: const [ListTile(leading: CircleAvatar(child: Text("L")), title: Text("Liyana"), subtitle: Text("Hi there! 👋"))]),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: const [CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 35)), SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), Text("ID: 10590491 | 🛡️ Admin", style: TextStyle(color: Colors.white54, fontSize: 12))])]),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Diamonds: 99,99,999", style: TextStyle(color: Colors.amber)), Text("Wallet", style: TextStyle(color: Colors.pinkAccent))])),
        ]),
      ),
    );
  }
}

class RoomView extends StatefulWidget {
  final String name;
  const RoomView(this.name, {super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final List<Map<String, dynamic>> seats = List.generate(
    15,
    (i) => {
      "user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "Rani PB" : null),
      "id": i == 0 ? "10590491" : (i == 1 ? "2048501" : null),
      "isMuted": false,
    },
  );

  void _showUserModal(String userName, String userId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            Text("ID: $userId | VIP 6", style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  icon: const Icon(Icons.person_add, size: 16),
                  label: const Text("Follow"),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Followed $userName")));
                  },
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                  icon: const Icon(Icons.report, color: Colors.red, size: 16),
                  label: const Text("Report / Block", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Reported")));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name, style: const TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2A1B4E), Color(0xFF141026)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black45,
              child: const Row(children: [Icon(Icons.mic, color: Colors.amber, size: 16), SizedBox(width: 8), Text("Welcome to PB Party! Respect everyone.", style: TextStyle(fontSize: 11, color: Colors.white70))]),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9),
                itemCount: 15,
                itemBuilder: (c, i) {
                  final seat = seats[i];
                  bool occupied = seat["user"] != null;
                  return GestureDetector(
                    onTap: () {
                      if (occupied) {
                        _showUserModal(seat["user"], seat["id"]);
                      } else {
                        setState(() {
                          seats[i]["user"] = "Lovepreet (Me)";
                          seats[i]["id"] = "10590491";
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(color: occupied ? const Color(0xFF1E193D) : Colors.white10, borderRadius: BorderRadius.circular(10), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(i == 0 ? Icons.star : Icons.mic, color: i == 0 ? Colors.amber : (occupied ? Colors.greenAccent : Colors.white54)),
                        const SizedBox(height: 4),
                        Text(seat["user"] ?? "Seat ${i + 1}", style: const TextStyle(fontSize: 10, color: Colors.white70), overflow: TextOverflow.ellipsis),
                      ]),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(hintText: "Say something...", filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)))),
                  IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Gifts: Rose, Car, Diamond!")))),
                  IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

