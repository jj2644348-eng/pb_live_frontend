import 'package:flutter/material.dart';
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
    body: [const HomeTab(), const RoomScreen(roomName: "PB VIP Audio Lounge"), const WalletTab(), const AdminTab()][tab],
    bottomNavigationBar: BottomNavigationBar(currentIndex: tab, onTap: (v) => setState(() => tab = v), selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.grey, backgroundColor: Colors.black, type: BottomNavigationBarType.fixed, items: const [
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
    appBar: AppBar(title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
    body: ListView(padding: const EdgeInsets.all(12), children: [
      Container(height: 140, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pinkAccent, Colors.deepPurple]), borderRadius: BorderRadius.circular(12)), child: const Center(child: Text("🔥 PB Audio Party Carnival\nJoin Featured Rooms Now!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)))),
      const SizedBox(height: 15),
      const Text("Live Party Rooms", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
      const SizedBox(height: 10),
      ListTile(tileColor: const Color(0xFF111111), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), leading: const CircleAvatar(backgroundColor: Colors.pinkAccent, child: Icon(Icons.mic, color: Colors.white)), title: const Text("PB VIP Lounge #1"), subtitle: const Text("Host: Lovepreet | 12/15 Seats Filled"), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomScreen(roomName: "PB VIP Lounge #1"))), child: const Text("Join")))
    ]),
  );
}
class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});
  @override State<RoomScreen> createState() => _RoomScreenState();
}
class _RoomScreenState extends State<RoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (i) => {"user": i == 0 ? "Lovepreet 🛡️" : (i == 1 ? "Rani PB" : null), "muted": false});
  final List<String> feed = ["System: Welcome to PB Party Room!", "Rani took seat 2."];
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
              seats[idx]["user"] = "Lovepreet";
              feed.add("Lovepreet took Seat ${idx + 1}");
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
    setState(() => feed.add("🎁 Lovepreet sent luxury $name ($price Coins)!"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully sent $name!")));
  }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: Colors.black),
    body: Column(children: [
      SizedBox(height: 200, child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: 15, itemBuilder: (c, i) {
        bool occ = seats[i]["user"] != null;
        return InkWell(onTap: () => _manageSeat(i), child: Container(
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent, width: 1.5)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i == 0 ? Icons.verified : (seats[i]["muted"] ? Icons.mic_off : Icons.mic), size: 18, color: i == 0 ? Colors.amber : (occ ? Colors.pinkAccent : Colors.grey)),
            const SizedBox(height: 4),
            Text(seats[i]["user"] ?? "Seat ${i+1}", style: const TextStyle(fontSize: 8, color: Colors.white70), overflow: TextOverflow.ellipsis)
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
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _sendGift("🏎️ Sports Car", 500), child: const Text("Car\n(500)", textAlign: TextAlign.center)),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _sendGift("🏰 Royal Castle", 5000), child: const Text("Castle\n(5000)", textAlign: TextAlign.center)),
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
    appBar: AppBar(title: const Text("My Wallet & Earnings", style: TextStyle(color: Colors.amber)), backgroundColor: Colors.black),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Icon(Icons.wallet, size: 60, color: Colors.pinkAccent),
      SizedBox(height: 15),
      Text("Diamonds Balance: 1,250 💎", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      SizedBox(height: 5),
      Text("Coins Balance: 500 🪙", style: TextStyle(fontSize: 14, color: Colors.grey)),
      SizedBox(height: 15),
      Text("(Recharge & Cashout via Reseller Panel)", style: TextStyle(color: Colors.amber, fontSize: 12))
    ])),
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
    appBar: AppBar(title: const Text("👑 Owner & Reseller Dashboard", style: TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: Colors.black),
    body: Padding(padding: const EdgeInsets.all(16), child: ListView(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Verified Blue Tick Badge 🛡️", style: TextStyle(fontWeight: FontWeight.bold)), Switch(value: blueTick, activeColor: Colors.pinkAccent, onChanged: (v) => setState(() => blueTick = v))]),
      const SizedBox(height: 15),
      TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "Target PB User ID", filled: true, fillColor: Color(0xFF1A1A1A))),
      const SizedBox(height: 10),
      TextField(controller: coinCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Coins / Diamonds Amount", filled: true, fillColor: Color(0xFF1A1A1A))),
      const SizedBox(height: 15),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {
        if(idCtrl.text.isNotEmpty && coinCtrl.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully transferred ${coinCtrl.text} to ID: ${idCtrl.text} 💎")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill User ID and Amount!")));
        }
      }, child: const Text("Transfer Coins / Recharge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ])),
  );
}

