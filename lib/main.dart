import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF131124)), home: const Home());
}

class Home extends StatefulWidget { const Home({super.key}); @override State<Home> createState() => _HomeState(); }

class _HomeState extends State<Home> {
  int i = 0;
  final List<Widget> pages = [const HomeFeed(), const Center(child: Text("Active Rooms")), const Center(child: Text("Inbox")), const MeProfile()];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: const Color(0xFF1B182E), elevation: 0, title: const Text("PB Live Party", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), actions: [IconButton(icon: const Icon(Icons.admin_panel_settings, color: Colors.amber), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Admin())))]),
    body: pages[i > 2 ? i - 1 : i],
    bottomNavigationBar: BottomNavigationBar(currentIndex: i, selectedItemColor: const Color(0xFFFF2E93), unselectedItemColor: Colors.white54, type: BottomNavigationBarType.fixed, backgroundColor: const Color(0xFF1B182E), onTap: (idx) => idx == 2 ? Navigator.push(context, MaterialPageRoute(builder: (_) => const Room("Official PB Room"))) : setState(() => i = idx), items: const [BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"), BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"), BottomNavigationBarItem(icon: CircleAvatar(radius: 18, backgroundColor: Color(0xFFFF2E93), child: Icon(Icons.radio_button_on, color: Colors.white, size: 24)), label: ""), BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Message"), BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me")]),
  );
}

class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});
  final List<Map<String, String>> rooms = const [{"title": "👑✨DIL KA SUKOON✨👑", "count": "20", "tag": "💬 Chat", "sub": "3 seats left", "img": "https://picsum.photos/300/300?1"}, {"title": "🎵MUSIC POINT💖", "count": "14", "tag": "💓 Pick Me", "sub": "🏠 CASPER", "img": "https://picsum.photos/300/300?2"}, {"title": "145+ Follow vs Follow", "count": "135", "tag": "💬 Chat", "sub": "3 seats left", "img": "https://picsum.photos/300/300?3"}, {"title": "💔😭अपनों की झूठी मोहब्बत", "count": "29", "tag": "💬 Chat", "sub": "🏠 Reet 💔", "img": "https://picsum.photos/300/300?4"}];
  @override
  Widget build(BuildContext context) => Column(children: [
    SizedBox(height: 38, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), children: [_cat("Hot", true), _cat("Event", false), _cat("Date", false), _cat("Music", false), _cat("Game", false)])),
    Expanded(child: GridView.builder(padding: const EdgeInsets.all(10), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8), itemCount: rooms.length, itemBuilder: (ctx, idx) => InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Room(rooms[idx]["title"]!))), child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Container(color: const Color(0xFF221E38), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Stack(children: [Image.network(rooms[idx]["img"]!, width: double.infinity, height: double.infinity, fit: BoxFit.cover), Positioned(top: 6, right: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(rooms[idx]["count"]!, style: const TextStyle(color: Colors.white, fontSize: 10)))), Positioned(bottom: 6, left: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8)), child: Text(rooms[idx]["tag"]!, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))))])), Padding(padding: const EdgeInsets.all(6), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(rooms[idx]["title"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)), Text(rooms[idx]["sub"]!, maxLines: 1, style: const TextStyle(color: Colors.white54, fontSize: 10))]))]))))),
  ]);
  Widget _cat(String t, bool s) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4), decoration: BoxDecoration(color: s ? Colors.amber : const Color(0xFF26223D), borderRadius: BorderRadius.circular(16)), child: Text(t, style: TextStyle(color: s ? Colors.black : Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)));
}

class Room extends StatefulWidget { final String name; const Room(this.name, {super.key}); @override State<Room> createState() => _RoomState(); }

class _RoomState extends State<Room> {
  int seats = 12; bool muted = false; late List<String?> occupants; final List<String> msgs = ["System: Welcome to PB Live Party Room! 🎉"]; final TextEditingController msgCtrl = TextEditingController();
  @override void initState() { super.initState(); occupants = List.filled(16, null); occupants[0] = "Host"; }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF0F0C20),
    body: SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: Row(children: [IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)), const Text("Lv.1 Heart | No.99+", style: TextStyle(color: Colors.pinkAccent, fontSize: 10))]), const Spacer(), IconButton(icon: const Icon(Icons.grid_view_rounded, color: Colors.amber), onPressed: _seatSheet), IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {})])),
      Expanded(flex: 6, child: GridView.builder(physics: const NeverScrollableScrollPhysics(), padding: const EdgeInsets.symmetric(horizontal: 12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.82, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: seats, itemBuilder: (ctx, idx) { final u = occupants[idx]; return GestureDetector(onTap: () => setState(() => occupants[idx] = (u == null ? "You" : null)), child: Column(children: [CircleAvatar(radius: 24, backgroundColor: u != null ? Colors.amber : Colors.white12, child: Icon(u != null ? (idx == 0 ? Icons.person : Icons.mic) : Icons.add, color: Colors.white, size: 20)), const SizedBox(height: 3), Text(u ?? "NO.${idx + 1}", style: TextStyle(color: u != null ? Colors.amber : Colors.white60, fontSize: 10))])); })),
      Container(margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 2), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(10)), child: const Row(children: [Icon(Icons.stars, color: Colors.amber, size: 16), SizedBox(width: 6), Expanded(child: Text("Share room with friends to get coins & bonuses!", style: TextStyle(color: Colors.white70, fontSize: 10))), Icon(Icons.casino, color: Colors.pinkAccent, size: 20)])),
      Expanded(flex: 4, child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 14), itemCount: msgs.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.symmetric(vertical: 2), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)), child: Text(msgs[i], style: const TextStyle(color: Colors.white70, fontSize: 11))))),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), color: const Color(0xFF19162A), child: Row(children: [IconButton(icon: const Icon(Icons.add, color: Colors.white70), onPressed: () {}), Expanded(child: TextField(controller: msgCtrl, style: const TextStyle(color: Colors.white, fontSize: 12), decoration: InputDecoration(hintText: "Send message...", hintStyle: const TextStyle(color: Colors.white38, fontSize: 11), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), filled: true, fillColor: const Color(0xFF26223E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)), onSubmitted: (t) { if (t.isNotEmpty) { setState(() => msgs.add("You: $t")); msgCtrl.clear(); } })), IconButton(icon: Icon(muted ? Icons.mic_off : Icons.mic, color: muted ? Colors.redAccent : Colors.greenAccent), onPressed: () => setState(() => muted = !muted)), IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: _giftSheet)])),
    ])),
  );
  void _seatSheet() => showModalBottomSheet(context: context, backgroundColor: const Color(0xFF221E38), builder: (c) => Column(mainAxisSize: MainAxisSize.min, children: [ListTile(title: const Text("8 Seats"), onTap: () { setState(() => seats = 8); Navigator.pop(context); }), ListTile(title: const Text("12 Seats"), onTap: () { setState(() => seats = 12); Navigator.pop(context); }), ListTile(title: const Text("15 Seats"), onTap: () { setState(() => seats = 15); Navigator.pop(context); })]));
  void _giftSheet() => showModalBottomSheet(context: context, backgroundColor: const Color(0xFF1F1B33), builder: (c) => Container(padding: const EdgeInsets.all(12), height: 110, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_gBtn("🌹", "Rose"), _gBtn("🚀", "Rocket"), _gBtn("👑", "Crown"), _gBtn("🏎️", "Car")])));
  Widget _gBtn(String e, String n) => InkWell(onTap: () { Navigator.pop(context); setState(() => msgs.add("🎁 Sent $n")); }, child: Column(mainAxisSize: MainAxisSize.min, children: [Text(e, style: const TextStyle(fontSize: 24)), Text(n, style: const TextStyle(color: Colors.white70, fontSize: 10))]));
}

class MeProfile extends StatefulWidget { const MeProfile({super.key}); @override State<MeProfile> createState() => _MeProfileState(); }

class _MeProfileState extends State<MeProfile> {
  File? img; int coins = 5000;
  Future<void> _pick() async { final r = await ImagePicker().pickImage(source: ImageSource.gallery); if (r != null) setState(() => img = File(r.path)); }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(children: [
    Row(children: [GestureDetector(onTap: _pick, child: CircleAvatar(radius: 34, backgroundColor: Colors.pinkAccent, backgroundImage: img != null ? FileImage(img!) : null, child: img == null ? const Icon(Icons.camera_alt, color: Colors.white) : null)), const SizedBox(width: 12), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("PB Live Host", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(height: 2), Text("VIP 6 | ID: 10590491", style: TextStyle(color: Colors.amber, fontSize: 12))])]),
    const SizedBox(height: 14),
    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]), borderRadius: BorderRadius.circular(14)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Coins: 🪙 $coins", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black), onPressed: () => setState(() => coins += 1000), child: const Text("Top-up"))])),
    const SizedBox(height: 10),
    _tile(Icons.meeting_room, "My Voice Room"), _tile(Icons.workspace_premium, "VIP Center"), _tile(Icons.store, "Backpack / Store"), _tile(Icons.settings, "Settings"),
  ]));
  Widget _tile(IconData ic, String t) => Card(color: const Color(0xFF221E38), child: ListTile(leading: Icon(ic, color: Colors.pinkAccent), title: Text(t, style: const TextStyle(color: Colors.white, fontSize: 13)), trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white38)));
}

class Admin extends StatelessWidget {
  const Admin({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Super Admin Panel 👑")),
    body: Padding(padding: const EdgeInsets.all(16), child: ListView(children: [
      const TextField(decoration: InputDecoration(labelText: "Target ID", border: OutlineInputBorder())),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {}, child: const Text("Assign Admin / BD / VIP 10", style: TextStyle(color: Colors.black))),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {}, child: const Text("Generate Unlimited Coins")),
      const SizedBox(height: 10),
      Row(children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () {}, child: const Text("Ban ID"))), const SizedBox(width: 10), Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {}, child: const Text("Unban ID")))]),
    ])),
  );
}
    
