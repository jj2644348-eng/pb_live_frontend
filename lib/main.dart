import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PBApp());
}

class PBApp extends StatelessWidget {
  const PBApp({super.key});
  @override Widget build(BuildContext context) => const MaterialApp(debugShowCheckedModeBanner: false, home: MainNav());
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [const HomeTab(), const RoomView(roomName: "PB Live Hub"), const WalletTab(), const AdminTab()][tab],
    bottomNavigationBar: BottomNavigationBar(currentIndex: tab, onTap: (v) => setState(() => tab = v), selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.white54, backgroundColor: const Color(0xFF1E193D), type: BottomNavigationBarType.fixed, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
      BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
      BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "Admin"),
    ]),
  );
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
    body: Center(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), icon: const Icon(Icons.mic), label: const Text("Join Party Room"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomView(roomName: "PB VIP Room")))))),
  );
}

class RoomView extends StatefulWidget {
  final String roomName;
  const RoomView({super.key, required this.roomName});
  @override State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("chats");
  final TextEditingController ctrl = TextEditingController();
  List<String> chatList = ["System: Connected to Firebase! 🚀"];

  @override void initState() {
    super.initState();
    dbRef.onChildAdded.listen((event) {
      if (event.snapshot.value != null) {
        setState(() => chatList.add(event.snapshot.value.toString()));
      }
    });
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 16)), backgroundColor: const Color(0xFF1E193D)),
    body: Column(children: [
      SizedBox(height: 180, child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 6, mainAxisSpacing: 6), itemCount: 15, itemBuilder: (c, i) => Container(
        decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(8), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i == 0 ? Icons.star : Icons.mic, size: 16, color: i == 0 ? Colors.amber : Colors.greenAccent), Text(i == 0 ? "Owner" : "Seat ${i+1}", style: const TextStyle(fontSize: 8, color: Colors.white70))]),
      ))),
      Expanded(child: ListView.builder(itemCount: chatList.length, itemBuilder: (c, i) => Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), child: Text(chatList[i], style: const TextStyle(color: Colors.white70, fontSize: 11))))),
      Container(padding: const EdgeInsets.all(8), color: Colors.black87, child: Row(children: [
        Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(hintText: "Say something...", filled: true, fillColor: Colors.white10, contentPadding: EdgeInsets.all(8), border: InputBorder.none))),
        IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () { if(ctrl.text.isNotEmpty) { dbRef.push().set("Lovepreet: ${ctrl.text}"); ctrl.clear(); } })
      ])),
    ]),
  );
}

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Wallet", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
    body: const Center(child: Text("Diamonds: 0 💎\n(Online Sync Active)", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14))),
  );
}

class AdminTab extends StatelessWidget {
  const AdminTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("👑 Owner & Reseller Panel", style: TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: const Color(0xFF1E193D)),
    body: Padding(padding: const EdgeInsets.all(16), child: ListView(children: const [
      TextField(decoration: InputDecoration(labelText: "Target User ID", filled: true, fillColor: Color(0xFF1E193D))),
      SizedBox(height: 10),
      TextField(decoration: InputDecoration(labelText: "Coins Amount", filled: true, fillColor: Color(0xFF1E193D))),
      SizedBox(height: 15),
      Text("🛡️ Owner Blue Tick & Reseller Rights Active", style: TextStyle(color: Colors.amber, fontSize: 12))
    ])),
  );
}

