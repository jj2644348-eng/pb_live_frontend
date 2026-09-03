import 'package:flutter/material.dart';
void main() => runApp(const PBApp());
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
    body: [const HomeTab(), const RoomView(), const WalletTab()][tab],
    bottomNavigationBar: BottomNavigationBar(currentIndex: tab, onTap: (v) => setState(() => tab = v), selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.white54, backgroundColor: const Color(0xFF1E193D), type: BottomNavigationBarType.fixed, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
      BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Room"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
    ]),
  );
}
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(title: const Text("Love Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF0D0B18)),
    body: ListView(padding: const EdgeInsets.all(12), children: [
      Container(height: 90, padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF8B2284), Color(0xFFE040FB)]), borderRadius: BorderRadius.circular(16)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("✨ Find Your Vibe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), SizedBox(height: 4), Text("Join live dating & party rooms", style: TextStyle(fontSize: 11, color: Colors.white70))])),
      const SizedBox(height: 15),
      ListTile(tileColor: const Color(0xFF221E3F), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), leading: const Icon(Icons.mic, color: Colors.pinkAccent), title: const Text("The Glam Room ✨", style: TextStyle(color: Colors.amber)), subtitle: const Text("Welcome to The Glam Room... 🔥 38"), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomView())), child: const Text("Join")))
    ]),
  );
}
class RoomView extends StatefulWidget {
  const RoomView({super.key});
  @override State<RoomView> createState() => _RoomViewState();
}
class _RoomViewState extends State<RoomView> {
  final List<Map<String, String?>> seats = List.generate(15, (i) => i == 0 ? {"name": "Love Party Owner", "dp": "001"} : null);
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(title: const Text("The Glam Room ✨", style: TextStyle(color: Colors.amber, fontSize: 16)), backgroundColor: const Color(0xFF0D0B18)),
    body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: 15, itemBuilder: (c, i) {
      final s = seats[i];
      return Container(decoration: BoxDecoration(color: const Color(0xFF221E3F), borderRadius: BorderRadius.circular(10), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i == 0 ? Icons.star : Icons.mic, size: 18, color: i == 0 ? Colors.amber : Colors.white70),
        Text(s != null ? s["name"]! : "Seat ${i+1}", style: const TextStyle(fontSize: 8, color: Colors.white), overflow: TextOverflow.ellipsis)
      ]));
    }),
  );
}
class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(title: const Text("Love Party Owner - ID: 001", style: TextStyle(color: Colors.amber, fontSize: 14)), backgroundColor: const Color(0xFF0D0B18)),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF221E3F), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
        Text("Diamonds Wallet: 5000000 💎", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
        Text("Active", style: TextStyle(color: Colors.amber))
      ]))
    ])),
  );
}

