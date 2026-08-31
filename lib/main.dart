import 'package:flutter/material.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Party Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFFFF007F),
      ),
      home: const PBLiveMainScaffold(),
    );
  }
}

class PBLiveMainScaffold extends StatefulWidget {
  const PBLiveMainScaffold({super.key});

  @override
  State<PBLiveMainScaffold> createState() => _PBLiveMainScaffoldState();
}

class _PBLiveMainScaffoldState extends State<PBLiveMainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ClubHomeScreen(),
    const FamilyScreen(),
    const MeProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF141026),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Club'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

// 1. CLUB SCREEN (Rooms List)
class ClubHomeScreen extends StatelessWidget {
  const ClubHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> rooms = [
      "PB Live Party Room #1",
      "PB Live Party Room #2",
      "PB Live Party Room #3",
      "PB Live Party Room #4",
      "PB Live Party Room #5",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141026),
        title: const Text("PB Party Club", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                children: const [
                  Icon(Icons.diamond, color: Colors.cyanAccent, size: 18),
                  SizedBox(width: 4),
                  Text("5000000", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E193D),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  child: Icon(Icons.mic, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rooms[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      const Text("Live audio chatting & 8 Mic Seats", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartyRoomScreen(roomName: rooms[index])));
                  },
                  child: const Text("Join"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 2. 8-SEATER PARTY ROOM SCREEN
class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(8, (index) => {
    "seatNo": index + 1,
    "isMuted": false,
  });
  bool isMicMutedGlobal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Text(widget.roomName),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.lock_open, color: Colors.grey),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // 8 Seats Grid (1 Host + 7 Seats)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                bool isHost = index == 0;
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2456),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isHost ? Colors.amber : Colors.purpleAccent, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isHost ? Icons.star : Icons.mic,
                        color: isHost ? Colors.amber : Colors.white70,
                        size: 28,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isHost ? "Host" : "Seat ${index + 1}",
                        style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1E193D),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(isMicMutedGlobal ? Icons.mic_off : Icons.mic, color: isMicMutedGlobal ? Colors.red : Colors.greenAccent),
                  onPressed: () => setState(() => isMicMutedGlobal = !isMicMutedGlobal),
                ),
                const Icon(Icons.card_giftcard, color: Colors.amber),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                      filled: true,
                      fillColor: const Color(0xFF141026),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.purpleAccent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. FAMILY SCREEN
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF141026), title: const Text("Family Club")),
      body: const Center(child: Text("Family Community Rooms", style: TextStyle(color: Colors.grey))),
    );
  }
}

// 4. ME PROFILE SCREEN (With Super Reseller Panel & Offline Recharge)
class MeProfileScreen extends StatefulWidget {
  const MeProfileScreen({super.key});

  @override
  State<MeProfileScreen> createState() => _MeProfileScreenState();
}

class _MeProfileScreenState extends State<MeProfileScreen> {
  int diamondsBalance = 5000000;

  void _showOfflineRechargeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.diamond, color: Colors.cyanAccent),
            SizedBox(width: 8),
            Text("Offline Recharge", style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("User ID: 78451290", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Packs:", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            const Text("₹10 = 100 💎", style: TextStyle(color: Colors.white)),
            const Text("₹50 = 550 💎", style: TextStyle(color: Colors.white)),
            const Text("₹100 = 1,200 💎", style: TextStyle(color: Colors.white)),
            const Text("₹500 = 6,500 💎", style: TextStyle(color: Colors.white)),
            const Divider(color: Colors.grey),
            const SizedBox(height: 4),
            const Text("WhatsApp Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _showMasterTransferDialog() {
    final TextEditingController idController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Text("👑", style: TextStyle(fontSize: 22)),
            SizedBox(width: 8),
            Text("Master Transfer", style: TextStyle(color: Colors.amber, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "User ID", labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Diamonds", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              int? amt = int.tryParse(amountController.text);
              if (amt != null && amt > 0) {
                setState(() => diamondsBalance -= amt);
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("✅ Transfer Successful!")),
              );
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141026),
        title: const Text("My Profile"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text("💎 $diamondsBalance", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Card
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.pinkAccent),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Love Party Owner", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("ID: 78451290 (VIP 10)", style: TextStyle(color: Colors.amberAccent, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Diamonds Wallet Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber, size: 28),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Diamonds Balance", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text("$diamondsBalance 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    onPressed: _showOfflineRechargeDialog,
                    child: const Text("Recharge", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Super Reseller Panel Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, color: Colors.pinkAccent, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("👑 Super Reseller Panel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 2),
                        Text("Transfer Coins by 8-digit ID", style: TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    onPressed: _showMasterTransferDialog,
                    child: const Text("Open"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

