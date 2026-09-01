import 'package:flutter/material.dart';

void main() => runApp(const PBPartyApp());

class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: Colors.pinkAccent,
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [HomeTab(), RoomsTab(), MessageTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Party 👑", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
          icon: const Icon(Icons.mic),
          label: const Text("Join Official Party Room", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartyRoomScreen(roomName: "PB VIP Lounge"))),
        ),
      ),
    );
  }
}

class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Audio Rooms", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: 4,
        itemBuilder: (c, i) => InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PartyRoomScreen(roomName: "Party Room #${i + 1}"))),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pinkAccent)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mic_external_on, color: Colors.amber, size: 36), SizedBox(height: 8), Text("Voice Party Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          ),
        ),
      ),
    );
  }
}

class MessageTab extends StatelessWidget {
  const MessageTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: ListView(children: const [ListTile(leading: CircleAvatar(backgroundColor: Colors.pinkAccent, child: Text("S")), title: Text("System Notice"), subtitle: Text("Welcome to PB Party. Check out the admin panels!"))]),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(children: const [
              CircleAvatar(radius: 35, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 40)),
              SizedBox(width: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Lovepreet Singh", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("ID: 10590491 | 🛡️ Super Owner", style: TextStyle(color: Colors.white54, fontSize: 12)),
              ]),
            ]),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E193D), padding: const EdgeInsets.all(14)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text("My Wallet (Diamonds: 0)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
              ]),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.all(14)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerAdminPanel())),
              child: const Text("👑 Owner & Reseller Control Panel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
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
  final int totalSeats = 15;
  late List<Map<String, dynamic>> seats;
  final List<String> liveFeed = ["System: Welcome to the live party room!", "Rani PB entered the room."];
  final TextEditingController _msgCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    seats = List.generate(totalSeats, (i) => {
      "user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "Rani PB" : null),
      "id": i == 0 ? "10590491" : "20485",
    });
  }

  void _showGiftingModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("Send Luxury Gift", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _giftItem("🌹 Rose", "10"),
            _giftItem("🏎️ Sports Car", "500"),
            _giftItem("🏰 Castle", "5000"),
          ]),
        ]),
      ),
    );
  }

  Widget _giftItem(String name, String price) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
      onPressed: () {
        Navigator.pop(context);
        setState(() => liveFeed.add("🎁 Lovepreet sent $name ($price Coins)!"));
      },
      child: Text("$name\n($price Coins)", textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 16)), backgroundColor: const Color(0xFF1E193D)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2A1B4E), Color(0xFF141026)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 6, mainAxisSpacing: 6, childAspectRatio: 0.85),
                itemCount: totalSeats,
                itemBuilder: (c, i) {
                  final seat = seats[i];
                  bool occ = seat["user"] != null;
                  return Container(
                    decoration: BoxDecoration(
                      color: occ ? const Color(0xFF1E193D) : Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(i == 0 ? Icons.star : Icons.mic, color: i == 0 ? Colors.amber : (occ ? Colors.greenAccent : Colors.white38), size: 18),
                      const SizedBox(height: 2),
                      Text(seat["user"] ?? "Seat ${i + 1}", style: const TextStyle(fontSize: 8, color: Colors.white70), overflow: TextOverflow.ellipsis),
                    ]),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8)),
                child: ListView.builder(
                  itemCount: liveFeed.length,
                  itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(liveFeed[i], style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black87,
              child: Row(children: [
                Expanded(child: TextField(
                  controller: _msgCtrl,
                  decoration: InputDecoration(hintText: "Say something...", filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                  onSubmitted: (val) {
                    if (val.trim().isNotEmpty) {
                      setState(() => liveFeed.add("Lovepreet: $val"));
                      _msgCtrl.clear();
                    }
                  },
                )),
                IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent), onPressed: _showGiftingModal),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wallet", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: const Center(
        child: Text("Diamonds Balance: 0 💎\n(No Free Coins. Recharge via Owner/Reseller Panel Only)", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ),
    );
  }
}

class OwnerAdminPanel extends StatefulWidget {
  const OwnerAdminPanel({super.key});

  @override
  State<OwnerAdminPanel> createState() => _OwnerAdminPanelState();
}

class _OwnerAdminPanelState extends State<OwnerAdminPanel> {
  bool blueTickActive = true;
  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _coinCtrl = TextEditingController();

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("👑 Owner & Reseller Control Panel", style: TextStyle(color: Colors.amber, fontSize: 15)), backgroundColor: const Color(0xFF1E193D)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Owner Verified Blue Tick 🛡️", style: TextStyle(fontWeight: FontWeight.bold)),
              Switch(value: blueTickActive, activeColor: Colors.blue, onChanged: (v) => setState(() => blueTickActive = v)),
            ]),
          ),
          const SizedBox(height: 15),
          TextField(controller: _idCtrl, decoration: const InputDecoration(labelText: "Target User ID (e.g., 10590491)", filled: true, fillColor: Color(0xFF1E193D))),
          const SizedBox(height: 10),
          TextField(controller: _coinCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Coins Amount to Transfer", filled: true, fillColor: Color(0xFF1E193D))),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () => _idCtrl.text.isNotEmpty && _coinCtrl.text.isNotEmpty ? _snack("Successfully transferred ${_coinCtrl.text} coins to ID: ${_idCtrl.text} 💎") : _snack("Enter User ID & Amount!"),
            child: const Text("Send Coins / Recharge ID", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () => _snack("Assigned Reseller Rights to ID: ${_idCtrl.text}"), child: const Text("Make Reseller", style: TextStyle(fontSize: 11)))),
            const SizedBox(width: 8),
            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent), onPressed: () => _snack("Assigned Official Badge ⭐ to ID: ${_idCtrl.text}"), child: const Text("Official Tag", style: TextStyle(fontSize: 11)))),
          ]),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => _snack("Unique ID & Number Updated Successfully!"),
            child: const Text("Update / Change Unique ID Number", style: TextStyle(fontSize: 12)),
          ),
        ]),
      ),
    );
  }
}

