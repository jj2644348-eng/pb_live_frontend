import 'package:flutter/material.dart';
void main() => runApp(const PBLiveApp());
class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, themeMode: ThemeMode.dark, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF141026)), home: const AuthScreen());
}
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = TextEditingController();
    return Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("PB Live Party 👑", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
      const SizedBox(height: 20),
      TextField(controller: c, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder())),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 48)), onPressed: () { if(c.text.isNotEmpty) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen())); }, child: const Text("Direct Home", style: TextStyle(color: Colors.white))),
    ]))));
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int idx = 0;
  final pages = [const HomeTab(), const RoomsTab(), const AudioLiveSetup(), const MsgTab(), const ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[idx > 2 ? idx - 1 : idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.white54, backgroundColor: const Color(0xFF1E193D), type: BottomNavigationBarType.fixed, onTap: (i) { if(i == 2) { Navigator.push(context, MaterialPageRoute(builder: (_) => const AudioLiveSetup())); } else { setState(() => idx = i); } }, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
        BottomNavigationBarItem(icon: Icon(Icons.radio_button_on, color: Colors.pinkAccent, size: 36), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      ]),
    );
  }
}
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Audio Live Home", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: Center(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomScreen(name: "PB Official"))), child: const Text("Join Room"))));
}
class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: const Center(child: Text("Active Rooms")));
}
class MsgTab extends StatelessWidget {
  const MsgTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Message", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: ListView(children: const [ListTile(leading: CircleAvatar(), title: Text("Liyana"), subtitle: Text("Hi there!"))]));
}
class AudioLiveSetup extends StatefulWidget {
  const AudioLiveSetup({super.key});
  @override
  State<AudioLiveSetup> createState() => _AudioLiveSetupState();
}
class _AudioLiveSetupState extends State<AudioLiveSetup> {
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: const Text("Audio Live", style: TextStyle(color: Colors.amber))),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Center(child: Container(width: 80, height: 80, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.pinkAccent), child: const Icon(Icons.add_a_photo, color: Colors.white))),
        const SizedBox(height: 20),
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Room Name", filled: true, fillColor: Color(0xFF1E193D))),
        const SizedBox(height: 20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 45)), onPressed: () { if(nameCtrl.text.isNotEmpty) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RoomScreen(name: nameCtrl.text))); }, child: const Text("Go Live", style: TextStyle(color: Colors.white))),
      ])),
    );
  }
}
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [IconButton(icon: const Icon(Icons.admin_panel_settings), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPanel())))]),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        const Row(children: [CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 35)), SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), Text("ID: 10590491 | 🛡️ Official Admin", style: TextStyle(fontSize: 10, color: Colors.white54))])]),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Diamonds: 99,99,999 (Unlimited)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)), Text("My Wallet", style: TextStyle(color: Colors.pinkAccent))])),
        const SizedBox(height: 20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 40)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPanel())), child: const Text("Super Admin & Seller Panel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ])),
    );
  }
}
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final idCtrl = TextEditingController();
    final coinCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Super Admin Panel 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Padding(padding: const EdgeInsets.all(16), child: ListView(children: [
        TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "Target User ID", filled: true, fillColor: Color(0xFF1E193D))),
        const SizedBox(height: 10),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Role Assigned (Admin/BD/Seller) Successfully!"))), child: const Text("Assign Admin / BD (VIP 10) / Seller", style: TextStyle(color: Colors.black))),
        const SizedBox(height: 20),
        TextField(controller: coinCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Generate Coins Amount", filled: true, fillColor: Color(0xFF1E193D))),
        const SizedBox(height: 10),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unlimited Coins Generated!"))), child: const Text("Add Coins / Unlimited Gen")),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ID Banned"))), child: const Text("Ban ID"))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ID Unbanned"))), child: const Text("Unban ID"))),
        ]),
      ])),
    );
  }
}
class RoomScreen extends StatelessWidget {
  final String name;
  const RoomScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name, style: const TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
      body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: 8, itemBuilder: (c, i) => Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.amber)), child: Center(child: Text("${i+1}", style: const TextStyle(color: Colors.white))))),
    );
  }
}

