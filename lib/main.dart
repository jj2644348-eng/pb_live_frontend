import 'package:flutter/material.dart';
void main() => runApp(const PBPartyApp());
class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});
  @override Widget build(BuildContext context) => const MaterialApp(debugShowCheckedModeBanner: false, home: MainNav());
}
class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}
class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [const HomeTab(), const RoomScreen(roomName: "PB VIP Lounge"), const WalletTab(), const AdminTab()][tab],
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
    body: Center(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), icon: const Icon(Icons.mic), label: const Text("Enter Party Room"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomScreen(roomName: "PB VIP Lounge"))))),
  );
}
class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});
  @override State<RoomScreen> createState() => _RoomScreenState();
}
class _RoomScreenState extends State<RoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (i) => {"user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "Rani PB" : null), "muted": false});
  final List<String> feed = ["System: Welcome to PB Party! 🎉", "Rani took seat 2."];
  final TextEditingController msgCtrl = TextEditingController();

  void _onSeatTap(int index) {
    showModalBottomSheet(context: context, backgroundColor: const Color(0xFF1E193D), builder: (ctx) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(seats[index]["user"] == null ? "Seat ${index + 1} is Empty" : "Manage Seat ${index + 1}", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {
          Navigator.pop(context);
          setState(() {
            if (seats[index]["user"] == null) {
              seats[index]["user"] = "Lovepreet";
              feed.add("Lovepreet took seat ${index + 1}");
            } else {
              seats[index]["muted"] = !seats[index]["muted"];
              feed.add("Seat ${index + 1} mic is ${seats[index]["muted"] ? 'Muted' : 'Unmuted'}");
            }
          });
        }, child: Text(seats[index]["user"] == null ? "Take This Seat" : (seats[index]["muted"] ? "Unmute Mic" : "Mute Mic"))),
      ]),
    ));
  }

  void _sendGift(String name, int cost) {
    Navigator.pop(context);
    setState(() => feed.add("🎁 Lovepreet sent $name ($cost Coins)!"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully sent $name!")));
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 16)), backgroundColor: const Color(0xFF1E193D)),
    body: Column(children: [
      SizedBox(height: 190, child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 6, mainAxisSpacing: 6), itemCount: 15, itemBuilder: (c, i) {
        bool occ = seats[i]["user"] != null;
        return InkWell(onTap: () => _onSeatTap(i), child: Container(
          decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(8), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i == 0 ? Icons.star : (seats[i]["muted"] ? Icons.mic_off : Icons.mic), size: 16, color: i == 0 ? Colors.amber : (occ ? Colors.greenAccent : Colors.white38)),
            Text(seats[i]["user"] ?? "Seat ${i+1}", style: const TextStyle(fontSize: 8, color: Colors.white70), overflow: TextOverflow.ellipsis)
          ]),
        ));
      })),
      Expanded(child: ListView.builder(itemCount: feed.length, itemBuilder: (c, i) => Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), child: Text(feed[i], style: const TextStyle(color: Colors.white70, fontSize: 11))))),
      Container(padding: const EdgeInsets.all(8), color: Colors.black87, child: Row(children: [
        Expanded(child: TextField(controller: msgCtrl, decoration: const InputDecoration(hintText: "Say something...", filled: true, fillColor: Colors.white10, contentPadding: EdgeInsets.all(8), border: InputBorder.none))),
        IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent), onPressed: () => showModalBottomSheet(context: context, backgroundColor: const Color(0xFF1E193D), builder: (ctx) => Padding(
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
        IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () { if(msgCtrl.text.isNotEmpty) { setState(() => feed.add("Lovepreet: ${msgCtrl.text}")); msgCtrl.clear(); } })
      ])),
    ]),
  );
}
class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Wallet", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
    body: const Center(child: Text("Diamonds Balance: 0 💎\n(Recharge restricted to Owner & Reseller Panel)", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14))),
  );
}
class AdminTab extends StatefulWidget {
  const AdminTab({super.key});
  @override State<AdminTab> createState() => _AdminTabState();
}
class _AdminTabState extends State<AdminTab> {
  bool blueTick = true;
  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController coinCtrl = TextEditingController();
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("👑 Owner & Reseller Panel", style: TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: const Color(0xFF1E193D)),
    body: Padding(padding: const EdgeInsets.all(16), child: ListView(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Verified Blue Tick 🛡️", style: TextStyle(fontWeight: FontWeight.bold)), Switch(value: blueTick, activeColor: Colors.blue, onChanged: (v) => setState(() => blueTick = v))]),
      const SizedBox(height: 10),
      TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "Target User ID", filled: true, fillColor: Color(0xFF1E193D))),
      const SizedBox(height: 10),
      TextField(controller: coinCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Coins Amount", filled: true, fillColor: Color(0xFF1E193D))),
      const SizedBox(height: 15),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {
        if(idCtrl.text.isNotEmpty && coinCtrl.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transferred ${coinCtrl.text} coins to ID: ${idCtrl.text} 💎")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill User ID and Coins!")));
        }
      }, child: const Text("Transfer Coins / Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ])),
  );
}

