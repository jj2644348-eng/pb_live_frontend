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
  void handleAuth() {
    if (phoneController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("कृपया मोबाइल नंबर दर्ज करें!"))); return; }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainContainer()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NeonBorderWrapper(child: Center(child: Padding(padding: const EdgeInsets.all(24.0), child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("PB Live Party 👑", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
      const SizedBox(height: 8), const Text("Owner: Lovepreet Singh (+91 9779353560)", style: TextStyle(fontSize: 12, color: Colors.white54)), const SizedBox(height: 30),
      TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder())),
      const SizedBox(height: 25),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 48)), onPressed: handleAuth, child: const Text("Direct Login / Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
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
  final List<Widget> _pages = [const HomeScreen(), const RoomsTabScreen(), const MessagesTabScreen(), const ProfileTabScreen()];
  void _openAudioLiveScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (c) => const AudioLiveSetupScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NeonBorderWrapper(child: _pages[_currentIndex > 2 ? _currentIndex - 1 : _currentIndex]), bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, selectedItemColor: Colors.pinkAccent, unselectedItemColor: Colors.white54, backgroundColor: const Color(0xFF1E193D), type: BottomNavigationBarType.fixed, onTap: (index) {
      if (index == 2) { _openAudioLiveScreen(); } else { setState(() { _currentIndex = index; }); }
    }, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
      BottomNavigationBarItem(icon: Icon(Icons.radio_button_on, color: Colors.pinkAccent, size: 36), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
    ]));
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Audio Live Home", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: Center(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), icon: const Icon(Icons.mic), label: const Text("Join Live Room"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PartyRoomScreen(roomName: "Official PB Room"))))));
  }
}
class RoomsTabScreen extends StatelessWidget {
  const RoomsTabScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)), body: const Center(child: Text("Active rooms list")));
}
class MessagesTabScreen extends StatelessWidget {
  const MessagesTabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [IconButton(icon: const Icon(Icons.delete, color: Colors.pinkAccent), onPressed: () {})]),
      body: ListView(children: const [
        ListTile(leading: CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/150')), title: Text("Liyana"), subtitle: Text("Hi there! 👋"), trailing: Text("Just now", style: TextStyle(fontSize: 10, color: Colors.white54))),
        ListTile(leading: CircleAvatar(child: Text("D")), title: Text("Demo"), subtitle: Text("Loved your profile!"), trailing: Text("A moment ago", style: TextStyle(fontSize: 10, color: Colors.white54))),
        ListTile(leading: CircleAvatar(child: Text("A")), title: Text("Aaliyah"), subtitle: Text("New here—say hello!"), trailing: Text("5 mins ago", style: TextStyle(fontSize: 10, color: Colors.white54))),
      ]),
    );
  }
}
class AudioLiveSetupScreen extends StatefulWidget {
  const AudioLiveSetupScreen({super.key});
  @override
  State<AudioLiveSetupScreen> createState() => _AudioLiveSetupScreenState();
}
class _AudioLiveSetupScreenState extends State<AudioLiveSetupScreen> {
  bool isPublic = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF1E193D), title: Row(children: const [Text("Audio Live", style: TextStyle(color: Colors.amber)), SizedBox(width: 15), Text("Relite", style: TextStyle(color: Colors.white54)), SizedBox(width: 15), Text("Post", style: TextStyle(color: Colors.white54))])),
      body: Padding(padding: const EdgeInsets.all(16.0), child: ListView(children: [
        const Text("Select Room Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
        Center(child: Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pinkAccent.withOpacity(0.2), border: Border.all(color: Colors.pinkAccent, width: 2)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.add_a_photo, color: Colors.pinkAccent), Text("Upload Photo", style: TextStyle(fontSize: 10, color: Colors.white70))]))),
        const SizedBox(height: 20),
        const Text("Room Name", style: TextStyle(color: Colors.white70)), const SizedBox(height: 5),
        TextField(controller: nameController, decoration: const InputDecoration(hintText: "Enter your room name", filled: true, fillColor: Color(0xFF1E193D), border: OutlineInputBorder(borderSide: BorderSide.none))),
        const SizedBox(height: 15),
        const Text("Room Description", style: TextStyle(color: Colors.white70)), const SizedBox(height: 5),
        TextField(controller: descController, maxLines: 3, decoration: const InputDecoration(hintText: "Enter your room description", filled: true, fillColor: Color(0xFF1E193D), border: OutlineInputBorder(borderSide: BorderSide.none))),
        const SizedBox(height: 20),
        const Text("Room Type", style: TextStyle(color: Colors.white70)), const SizedBox(height: 10),
        Row(children: [
          Expanded(child: InkWell(onTap: () => setState(() => isPublic = true), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: Row(children: [const Icon(Icons.lock_open, color: Colors.white), const SizedBox(width: 8), const Text("Public"), const Spacer(), Radio(value: true, groupValue: isPublic, onChanged: (v) => setState(() => isPublic = v!))] ))),
          const SizedBox(width: 10),
          Expanded(child: InkWell(onTap: () => setState(() => isPublic = false), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: Row(children: [const Icon(Icons.lock, color: Colors.white), const SizedBox(width: 8), const Text("Private"), const Spacer(), Radio(value: false, groupValue: isPublic, onChanged: (v) => setState(() => isPublic = v!))] ))),
        ]),
        const SizedBox(height: 30),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), onPressed: () { if(nameController.text.isNotEmpty) Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(roomName: nameController.text))); }, child: const Text("Go Live", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
      ])),
    );
  }
}
class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [
        IconButton(icon: const Icon(Icons.settings), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SuperAdminPanelScreen())))
      ]),
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
        Row(children: [
          CircleAvatar(radius: 35, backgroundColor: Colors.pinkAccent, child: const Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(width: 15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Lovepreet Singh (VIP 6)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Row(children: const [Text("ID10590491", style: TextStyle(color: Colors.white54, fontSize: 12)), SizedBox(width: 5), Icon(Icons.copy, size: 12, color: Colors.amber)]),
            const SizedBox(height: 6),
            Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3), borderRadius: BorderRadius.circular(10)), child: const Text("🇮🇳 India", style: TextStyle(fontSize: 10))), const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(10)), child: const Text("🛡️ Official Admin", style: TextStyle(fontSize: 10)))]),
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
          Row(children: const [Icon(Icons.diamond, color: Colors.amber, size: 28), SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("My Diamonds", style: TextStyle(color: Colors.white54, fontSize: 12)), Text("99,99,999 (Unlimited)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14))])]),
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
        ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), tileColor: const Color(0xFF1E193D), leading: const Icon(Icons.admin_panel_settings, color: Colors.amber), title: const Text("Super Admin & Coin Seller Panel"), trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SuperAdminPanelScreen()))),
      ]))));
    }
  static Widget _buildFeatureCard(IconData icon, String title) {
    return Container(width: 75, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10)), child: Column(children: [Icon(icon, color: Colors.amber, size: 24), const SizedBox(height: 6), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.white70))]));
  }
}
class SuperAdminPanelScreen extends StatefulWidget {
  const SuperAdminPanelScreen({super.key});
  @override
  State<SuperAdminPanelScreen> createState() => _SuperAdminPanelScreenState();
}
class _SuperAdminPanelScreenState extends State<SuperAdminPanelScreen> {
  final TextEditingController targetIdController = TextEditingController();
  final TextEditingController coinController = TextEditingController();
  String selectedRole = "Admin (VIP 6)";
  void _executeAction(String actionName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success: $actionName for ID ${targetIdController.text}")));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Super Admin & Owner Control 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: ListView(children: [
        const Text("Target User ID / Phone", style: TextStyle(color: Colors.white70)), const SizedBox(height: 5),
        TextField(controller: targetIdController, decoration: const InputDecoration(hintText: "Enter User ID (e.g. 10590491)", filled: true, fillColor: Color(0xFF1E193D), border: OutlineInputBorder(borderSide: BorderSide.none))),
        const SizedBox(height: 15),
        const Text("Assign Role / Badge", style: TextStyle(color: Colors.white70)), const SizedBox(height: 5),
        DropdownButtonFormField<String>(value: selectedRole, dropdownColor: const Color(0xFF1E193D), items: const [
          DropdownMenuItem(value: "Admin (VIP 6)", child: Text("Make Admin (VIP 6 Tag)")),
          DropdownMenuItem(value: "BD Center (VIP 10)", child: Text("Make BD (VIP 10 Tag)")),
          DropdownMenuItem(value: "Coin Seller", child: Text("Make Coin Seller")),
        ], onChanged: (val) => setState(() => selectedRole = val!)),
        const SizedBox(height: 15),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () => _executeAction("Assigned $selectedRole"), child: const Text("Apply Role to User", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        const Divider(height: 30, color: Colors.white24),
        const Text("Coin & Diamond Generator", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
        TextField(controller: coinController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Enter Coin/Diamond Amount", filled: true, fillColor: Color(0xFF1E193D), border: OutlineInputBorder(borderSide: BorderSide.none))),
        const SizedBox(height: 10),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _executeAction("Added ${coinController.text} Coins"), child: const Text("Add Coins / Generate Unlimited", style: TextStyle(color: Colors.white))),
        const Divider(height: 30, color: Colors.white24),
        Row(children: [
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () => _executeAction("Banned User"), child: const Text("Ban ID"))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => _executeAction("Unbanned User"), child: const Text("Unban ID"))),
        ]),
      ])),
    );
  }
}
class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});
  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}
class _PartyRoomScreenState extends State<PartyRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D), actions: [
        IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context))
      ]),
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'), fit: BoxFit.cover)),
        child: Column(children: [
          Container(padding: const EdgeInsets.all(8), color: Colors.black54, child: Row(children: const [
            CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://via.placeholder.com/150')), SizedBox(width: 8),
            Text("hjj\nID10590491", style: TextStyle(fontSize: 10, color: Colors.white)), Spacer(),
            Chip(backgroundColor: Colors.blue, label: Text("No one Joined", style: TextStyle(fontSize: 10, color: Colors.white))),
          ])),
          Expanded(child: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: 8, itemBuild
