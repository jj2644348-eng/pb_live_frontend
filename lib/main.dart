import 'package:flutter/material.dart';
void main() => runApp(const App());
class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const Home());
}
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int i = 0;
  final p = const [
    Center(child: Text("PB Live Home 👑", style: TextStyle(fontSize: 20, color: Colors.amber))),
    Center(child: Text("Active Rooms List")),
    Center(child: Text("Messages Inbox")),
    Center(child: Text("Profile (VIP 6 / ID: 10590491)")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Party"), actions: [
        IconButton(icon: const Icon(Icons.admin_panel_settings, color: Colors.amber), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Admin())))
      ]),
      body: p[i > 2 ? i - 1 : i],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) {
          if (idx == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Room("Official PB Room")));
          } else {
            setState(() => i = idx);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.radio_button_on, color: Colors.pinkAccent, size: 32), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}
class Admin extends StatelessWidget {
  const Admin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Super Admin Panel 👑")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Target ID", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {}, child: const Text("Assign Admin / BD / VIP 10", style: TextStyle(color: Colors.black))),
            const SizedBox(height: 10),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {}, child: const Text("Generate Unlimited Coins")),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () {}, child: const Text("Ban ID"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {}, child: const Text("Unban ID"))),
            ]),
          ],
        ),
      ),
    );
  }
}
class Room extends StatelessWidget {
  final String name;
  const Room(this.name, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 15,
        itemBuilder: (c, idx) => Container(
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10), border: Border.all(color: idx == 0 ? Colors.amber : Colors.pinkAccent)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(idx == 0 ? Icons.star : Icons.mic, color: idx == 0 ? Colors.amber : Colors.green),
            const SizedBox(height: 5),
            Text(idx == 0 ? "Owner" : "Seat ${idx + 1}", style: const TextStyle(fontSize: 10)),
          ]),
        ),
      ),
    );
  }
}

