import 'package:flutter/material.dart';
void main() => runApp(const PBLiveApp());
class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, themeMode: ThemeMode.dark, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF141026), primaryColor: Colors.pinkAccent), home: const AuthScreen());
  }
}
class NeonBorderWrapper extends StatelessWidget {
  const NeonBorderWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent, width: 2), boxShadow: [BoxShadow(color: Colors.pinkAccent.withOpacity(0.4), blurRadius: 8, spreadRadius: 1)]), child: child);
  }
}
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  static final Map<String, String> userDb = {"609779353560": "0001"};
  void handleAuth() {
    String phone = phoneController.text.trim(), pass = passController.text.trim();
    if (phone.isEmpty || pass.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("कृपया नंबर और पासवर्ड भरें!"))); return; }
    if (userDb.containsKey(phone) && userDb[phone] != pass) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("गलत पासवर्ड!"))); return; }
    userDb[phone] = pass;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainContainer()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NeonBorderWrapper(child: Center(child: Padding(padding: const EdgeInsets.all(24.0), child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("PB Live Party 👑", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
      const SizedBox(height: 8), const Text("Owner WhatsApp: +91 9779353560", style: TextStyle(fontSize: 12, color: Colors.white54)), const SizedBox(height: 30),
      TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder())),
      const SizedBox(height: 15),
      TextField(controller: passController, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder())),
      const SizedBox(height: 25),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 48)), onPressed: handleAuth, child: const Text("Login / Continue", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    ]))))));
  }
}
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});
  @override
  State<MainContainer> createState() => _MainContainerState();
}
class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomeScreen(), const RoomsTabScreen(), const ProfileTabScreen(), const OwnerPanelTabScreen()];
  void _openCreateRoomDialog() {
    final TextEditingController nameController = TextEditingController();
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: const Color(0xFF1E193D), builder: (ctx) => Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text("Create Party Room 🎤", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 15),
      TextField(controller: nameController, decoration: const InputDecoration(labelText: "Room Name", border: OutlineInputBorder())), const SizedBox(height: 15),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 45)), onPressed: () { Navigator.pop(ctx); if(nameController.text.isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(roomName: nameController.text))); }, child: const Text("Launch Room", style: TextStyle(color: Colors.white))), const SizedBox(height: 20),
    ])));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NeonBorderWrapper(child: _pages[_currentIndex > 2 ? _currentIndex - 1 : _currentIndex]), bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.white54, backgroundColor: const Color(0xFF1E193D), type: BottomNavigationBarType.fixed, onTap: (index) {
      if (index == 2) { _openCreateRoomDialog(); } else { setState(() { _currentIndex = index; }); }
    }, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
      BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: Colors.pinkAccent, size: 36), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: "Inbox"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
    ]));
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("PB Live Home", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: Center(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), icon: const Icon(Icons.mic), label: const Text("Join Default Room"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PartyRoomScreen(roomName: "Official PB Room"))))));
  }
}
class RoomsTabScreen extends StatelessWidget {
  const RoomsTabScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: const Center(child: Text("Active rooms list")));
}
class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})]), body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
      Row(children: [
        CircleAvatar(radius: 35, backgroundColor: Colors.pinkAccent, child: const Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Lovepreet Singh", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Row(children: const [Text("ID10590491", style: TextStyle(color: Colors.white54, fontSize: 12)), SizedBox(width: 5), Icon(Icons.copy, size: 12, color: Colors.amber)]),
          const SizedBox(height: 6),
          Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3), borderRadius: BorderRadius.circular(10)), child: const Text("🇮🇳 India", style: TextStyle(fontSize: 10))), const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(10)), child: const Text("🛡️ Level 1", style: TextStyle(fontSize: 10)))]),
        ]),
      ]),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [
        Column(children: [Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), Text("Following", style: TextStyle(color: Colors.white54, fontSize: 12))]),
        Column(children: [Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), Text("Fans", style: TextStyle(color: Colors.white54, fontSize: 12))]),
        Column(children: [Text("0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), Text("Blocked User", style: TextStyle(color: Colors.white54, fontSize: 12))]),
      ]),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: const [Icon(Icons.diamond, color: Colors.amber, size: 28), SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("My Diamonds", style: TextStyle(color: Colors.white54, fontSize: 12)), Text("20K", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16))])]),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent), onPressed: () {}, child: const Text("My Wallet", style: TextStyle(color: Colors.white))),
      ])),
      const SizedBox(height: 15),
      ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), tileColor: const Color(0xFF1E193D), leading: const Icon(Icons.mic, color: Colors.amber), title: const Text("Become Host", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), subtitle: const Text("Turn your passion into profit", style: TextStyle(color: Colors.white54, fontSize: 11)), trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54), onTap: () {}),
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildFeatureCard(Icons.shield, "Agency Center"),
        _buildFeatureCard(Icons.supervisor_account, "BD Center"),
        _buildFeatureCard(Icons.mic_external_on, "Host Center"),
        _buildFeatureCard(Icons.workspace_premium, "Become VIP"),
      ]),
      const SizedBox(height: 15),
      ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), tileColor: const Color(0xFF1E193D), leading: const Icon(Icons.flash_on, color: Colors.amber), title: const Text("Offline Recharge"), trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54), onTap: () {}),
    ]))));
  }
  static Widget _buildFeatureCard(IconData icon, String title) {
    return Container(width: 75, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: Column(children: [Icon(icon, color: Colors.amber, size: 24), const SizedBox(height: 6), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.white70))]));
  }
}
class OwnerPanelTabScreen extends StatelessWidget {
  const OwnerPanelTabScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Owner Panel", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: const Padding(padding: EdgeInsets.all(16.0), child: Text("Super Admin Controls Active", style: TextStyle(color: Colors.pinkAccent, fontSize: 16))));
}
class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});
  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}
class _PartyRoomScreenState extends State<PartyRoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (i) => {"seatNo": i + 1, "user": i == 0 ? "0001 (Owner)" : null, "isMuted": false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF2A1B4E), Color(0xFF141026)])), child: Padding(padding: const EdgeInsets.all(12.0), child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: 15, itemBuilder: (context, index) {
      final seat = seats[index];
      return GestureDetector(onTap: () => setState(() => seat["user"] = seat["user"] != null ? null : "User"), child: Container(decoration: BoxDecoration(color: seat["user"] != null ? const Color(0xFF1E193D) : Colors.white10, borderRadius: BorderRadius.circular(10), border: Border.all(color: index == 0 ? Colors.amber : Colors.pinkAccent)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(index == 0 ? Icons.star : Icons.mic, color: index == 0 ? Colors.amber : Colors.greenAccent), const SizedBox(height: 5),
        Text(seat["user"] ?? "Seat ${index + 1}", style: const TextStyle(fontSize: 10, color: Colors.white70), overflow: TextOverflow.ellipsis),
      ])));
    }))));
  }
}

