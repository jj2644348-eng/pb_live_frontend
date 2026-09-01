import 'package:flutter/material.dart';

void main() => runApp(const PBApp());

class PBApp extends StatelessWidget {
  const PBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DesktopLayout(),
    );
  }
}

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 220,
            color: const Color(0xFF1E193D),
            child: Column(
              children: [
                const DrawerHeader(
                  child: Text("PB Live Party 👑", style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
                ),
                ListTile(leading: const Icon(Icons.home), title: const Text("Home"), onTap: () => setState(() => tabIndex = 0)),
                ListTile(leading: const Icon(Icons.mic), title: const Text("Rooms"), onTap: () => setState(() => tabIndex = 1)),
                ListTile(leading: const Icon(Icons.message), title: const Text("Messages"), onTap: () => setState(() => tabIndex = 2)),
                ListTile(leading: const Icon(Icons.person), title: const Text("Profile"), onTap: () => setState(() => tabIndex = 3)),
                ListTile(leading: const Icon(Icons.admin_panel_settings, color: Colors.amber), title: const Text("Admin Panel"), onTap: () => setState(() => tabIndex = 4)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF141026),
              child: _getPage(tabIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text("Welcome to PB Live Home (Laptop View)", style: TextStyle(fontSize: 22, color: Colors.amber)));
      case 1:
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: 8,
          itemBuilder: (c, i) => Container(
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.pinkAccent)),
            child: Center(child: Text("Room ${i + 1}", style: const TextStyle(color: Colors.white))),
          ),
        );
      case 2:
        return ListView(children: const [ListTile(title: Text("Liyana"), subtitle: Text("Hi there!"))]);
      case 3:
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("ID: 10590491 | 🛡️ Official Admin", style: TextStyle(color: Colors.white54)),
              SizedBox(height: 20),
              Text("Diamonds: 99,99,999 (Unlimited)", style: TextStyle(color: Colors.amber)),
            ],
          ),
        );
      case 4:
        return const AdminWindowPanel();
      default:
        return const SizedBox.shrink();
    }
  }
}

class AdminWindowPanel extends StatelessWidget {
  const AdminWindowPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          const Text("Super Admin & Owner Control Panel 👑", style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "Target User ID", border: OutlineInputBorder(), filled: true, fillColor: Color(0xFF1E193D))),
          const SizedBox(height: 15),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {}, child: const Text("Assign Admin / BD / VIP 10", style: TextStyle(color: Colors.black))),
          const SizedBox(height: 15),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {}, child: const Text("Generate Unlimited Coins")),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () {}, child: const Text("Ban ID"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {}, child: const Text("Unban ID"))),
            ],
          ),
        ],
      ),
    );
  }
}
