import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const PBPartyApp());

class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black, primaryColor: Colors.pinkAccent), home: const MainNav());
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [const HomeTab(), const RoomScreen(roomName: "PB Live Audio Room"), const WalletTab(), const ProfileTab()][tab],
    bottomNavigationBar: BottomNavigationBar(currentIndex: tab, onTap: (v) => setState(() => tab = v), selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.grey, backgroundColor: Colors.black, type: BottomNavigationBarType.fixed, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
      BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ]),
  );
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("PB Live Audio Room 👑", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
    body: ListView(padding: const EdgeInsets.all(12), children: [
      Container(height: 140, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pinkAccent, Colors.deepPurple]), borderRadius: BorderRadius.circular(12)), child: const Center(child: Text("🔥 Live Audio Party Kit\nZego & Audio Room Integrated", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)))),
      const SizedBox(height: 15),
      const Text("Active Audio Rooms", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
      const SizedBox(height: 10),
      ListTile(tileColor: const Color(0xFF111111), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), leading: const CircleAvatar(backgroundColor: Colors.pinkAccent, child: Icon(Icons.mic, color: Colors.white)), title: const Text("PB VIP Audio Room #1"), subtitle: const Text("Host ID: 001 (Lovepreet) | 12/15 Seats"), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomScreen(roomName: "PB VIP Audio Room #1"))), child: const Text("Join")))
    ]),
  );
}

class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});
  @override State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (i) => {"user": i == 0 ? "Lovepreet\nID: 001 🛡️" : (i == 1 ? "Rani PB\nID: 482910" : null), "muted": false});
  final List<String> feed = ["System: Connected to Audio Room!", "Rani (ID: 482910) joined seat 2."];
  final TextEditingController msgCtrl = TextEditingController();

  void _manageSeat(int idx) {
    showModalBottomSheet(context: context, backgroundColor: const Color(0xFF111111), builder: (ctx) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Seat ${idx + 1} Controls", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 15),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {
          Navigator.pop(context);
          setState(() {
            if (seats[idx]["user"] == null) {
              seats[idx]["user"] = "Lovepreet\nID: 001";
              feed.add("Lovepreet (ID: 001) took Seat ${idx + 1}");
            } else {
              seats[idx]["muted"] = !seats[idx]["muted"];
              feed.add("Seat ${idx + 1} mic ${seats[idx]["muted"] ? 'muted' : 'unmuted'}");
            }
          });
        }, child: Text(seats[idx]["user"] == null ? "Take Seat" : (seats[idx]["muted"] ? "Unmute Mic" : "Mute Mic"))),
      ]),
    ));
  }

  void _sendGift(String name, int price) {
    Navigator.pop(context);
    setState(() => feed.add("🎁 Lovepreet (ID: 001) sent $name ($price Coins)!"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sent $name successfully!")));
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: Colors.black),
    body: Column(children: [
      SizedBox(height: 200, child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: 15, itemBuilder: (c, i) {
        bool occ = seats[i]["user"] != null;
        return InkWell(onTap: () => _manageSeat(i), child: Container(
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent, width: 1.5)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i == 0 ? Icons.verified : (seats[i]["muted"] ? Icons.mic_off : Icons.mic), size: 16, color: i == 0 ? Colors.amber : (occ ? Colors.pinkAccent : Colors.grey)),
            const SizedBox(height: 2),
            Text(seats[i]["user"] ?? "Seat ${i+1}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 7, color: Colors.white70), overflow: TextOverflow.ellipsis, maxLines: 2)
          ]),
        ));
      })),
      Expanded(child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(8)), child: ListView.builder(itemCount: feed.length, itemBuilder: (c, i) => Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text(feed[i], style: const TextStyle(color: Colors.white70, fontSize: 11)))))),
      Container(padding: const EdgeInsets.all(8), color: Colors.black, child: Row(children: [
        Expanded(child: TextField(controller: msgCtrl, decoration: InputDecoration(hintText: "Say something...", filled: true, fillColor: const Color(0xFF1A1A1A), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)))),
        IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent), onPressed: () => showModalBottomSheet(context: context, backgroundColor: const Color(0xFF111111), builder: (ctx) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("Send Luxury Gift", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _sendGift("🌹 Rose", 10), child: const Text("Rose\n(10)", textAlign: TextAlign.center)),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _sendGift("🏎️ Car", 500), child: const Text("Car\n(500)", textAlign: TextAlign.center)),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _sendGift("🏰 Castle", 5000), child: const Text("Castle\n(5000)", textAlign: TextAlign.center)),
            ]),
          ]),
        ))),
        IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () { if(msgCtrl.text.isNotEmpty) { setState(() => feed.add("Lovepreet (ID: 001): ${msgCtrl.text}")); msgCtrl.clear(); } })
      ])),
    ]),
  );
}

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Wallet & ID: 001", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Icon(Icons.wallet, size: 60, color: Colors.pinkAccent),
      SizedBox(height: 15),
      Text("Diamonds: 1,250 💎 | Coins: 500 🪙", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      SizedBox(height: 10),
      Text("Owner ID: 001 (Reseller Panel Active)", style: TextStyle(color: Colors.amber, fontSize: 13))
    ])),
  );
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Profile (ID: 001)", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      Center(child: Stack(children: [
        CircleAvatar(radius: 50, backgroundColor: Colors.pinkAccent, backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null, child: _imageFile == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null),
        Positioned(bottom: 0, right: 0, child: CircleAvatar(backgroundColor: Colors.amber, radius: 18, child: IconButton(icon: const Icon(Icons.camera_alt, size: 16, color: Colors.black), onPressed: _pickImage)))
      ])),
      const SizedBox(height: 15),
      const Text("Lovepreet Singh", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 5),
      const Text("PB ID: 001 🛡️ (Owner & Main Creator)", style: TextStyle(color: Colors.amber, fontSize: 14)),
      const SizedBox(height: 25),
      ListTile(tileColor: const Color(0xFF111111), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), leading: const Icon(Icons.verified, color: Colors.blue), title: const Text("Verified Blue Tick Active"), trailing: const Text("ON", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
      const SizedBox(height: 10),
      ListTile(tileColor: const Color(0xFF111111), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), leading: const Icon(Icons.admin_panel_settings, color: Colors.pinkAccent), title: const Text("Reseller & Coin Transfer Rights"), trailing: const Text("Active", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
    ])),
  );
}

