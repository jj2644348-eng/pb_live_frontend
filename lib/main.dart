import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: LoginAuthScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ================= GLOBAL STATE & SESSION =================
class CurrentUser {
  static String id = "0001";
  static String name = "Love Party Owner";
  static String avatar = "👑";
  static int coins = 5000000;
  static bool isOwner = true;
  static const String masterOwnerId = "0001";
}

List<Map<String, dynamic>> globalRooms = [
  {
    "id": "101",
    "name": "👑 Tech Love PB Official Club",
    "host": "Love Party Owner",
    "hostId": "0001",
    "active": "8/8 Full",
    "avatar": "👑"
  },
  {
    "id": "102",
    "name": "🔥 Punjabi Beats & Shayari",
    "host": "Aman Deep",
    "hostId": "88451290",
    "active": "5/8 Live",
    "avatar": "🎤"
  },
  {
    "id": "103",
    "name": "🌹 Friends Gossip & Chill",
    "host": "Riya Sharma",
    "hostId": "55219034",
    "active": "3/8 Live",
    "avatar": "🎧"
  },
];

// ================= LOGIN SCREEN =================
class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({super.key});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  bool isMaster = true;

  void executeLogin() {
    String enteredName = nameCtrl.text.trim();
    if (isMaster) {
      CurrentUser.id = "0001";
      CurrentUser.name = enteredName.isEmpty ? "Love Party Owner" : enteredName;
      CurrentUser.coins = 99999999;
      CurrentUser.isOwner = true;
      CurrentUser.avatar = "👑";
    } else {
      CurrentUser.id = (10000000 + Random().nextInt(90000000)).toString();
      CurrentUser.name = enteredName.isEmpty ? "Club Member" : enteredName;
      CurrentUser.coins = 2000;
      CurrentUser.isOwner = false;
      CurrentUser.avatar = "👤";
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 46,
                backgroundColor: Color(0xFF1E193D),
                child: Text("👑", style: TextStyle(fontSize: 48)),
              ),
              const SizedBox(height: 14),
              const Text(
                "Official Tech Love PB",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "VIP Live Party & Voice Rooms",
                style: TextStyle(color: Colors.pinkAccent, fontSize: 13),
              ),
              const SizedBox(height: 35),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Your Display Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E193D),
                  prefixIcon: const Icon(Icons.person, color: Colors.pinkAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: executeLogin,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF007F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: executeLogin,
                  child: const Text(
                    "Fast Guest Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1635),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "👑 Super Master Mode (ID: 0001)",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: isMaster,
                      activeColor: Colors.amber,
                      onChanged: (val) => setState(() => isMaster = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MAIN NAVIGATION =================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Controller: Create Room Dialog (+ button)
  void openCreateRoomModal() {
    final titleCtrl = TextEditingController();
    String selectedAvatar = "🔥";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🎙️ Create Live Party Room",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Room Name / Topic",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF161230),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Choose Room Icon:",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["🔥", "👑", "🎤", "🌹", "💎", "⚔️"].map((emoji) {
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedAvatar == emoji
                                ? Colors.pinkAccent
                                : const Color(0xFF2A2456),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 22)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF007F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final roomName = titleCtrl.text.trim().isEmpty
                            ? "${CurrentUser.name}'s Room"
                            : titleCtrl.text.trim();
                        final newRoom = {
                          "id": Random().nextInt(99999).toString(),
                          "name": roomName,
                          "host": CurrentUser.name,
                          "hostId": CurrentUser.id,
                          "active": "1/8 Live",
                          "avatar": selectedAvatar,
                        };
                        setState(() {
                          globalRooms.insert(0, newRoom);
                        });
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => LiveAudioRoomScreen(
                              roomData: newRoom,
                              onUpdate: () => setState(() {}),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Go Live Now 🚀",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Controller: Edit Profile
  void openEditProfileDialog() {
    final editCtrl = TextEditingController(text: CurrentUser.name);
    String selAvatar = CurrentUser.avatar;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDState) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Display Name",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["👑", "👤", "🎧", "🌹", "⚡", "🔥"].map((a) {
                  return InkWell(
                    onTap: () => setDState(() => selAvatar = a),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: selAvatar == a
                            ? Colors.pinkAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(a, style: const TextStyle(fontSize: 22)),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF007F),
              ),
              onPressed: () {
                setState(() {
                  CurrentUser.name = editCtrl.text.trim().isEmpty
                      ? CurrentUser.name
                      : editCtrl.text.trim();
                  CurrentUser.avatar = selAvatar;
                });
                Navigator.pop(ctx);
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  // Controller: Master Owner Transfer Coins (ID: 0001)
  void openTransferDialog() {
    final idCtrl = TextEditingController();
    final amtCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text(
          "💎 Master Coin Transfer",
          style: TextStyle(color: Colors.amber),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Target 8-Digit User ID",
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amtCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Diamonds Amount",
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF007F),
            ),
            onPressed: () {
              final target = idCtrl.text.trim();
              final amt = int.tryParse(amtCtrl.text.trim()) ?? 0;
              if (target.isEmpty || amt <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter valid ID & Amount!"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Successfully sent $amt 💎 to User ID: $target!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Transfer", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // Controller: Offline WhatsApp Recharge Dialog
  void openOfflineRechargeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.diamond, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              "Offline Recharge",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your User ID: ${CurrentUser.id}",
              style: const TextStyle(
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Recharge Rate: 100 💎 = ₹10\nPayment Method: GooglePay / PhonePe / Paytm",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const Divider(color: Colors.white24, height: 20),
            const Text(
              "📱 WhatsApp Official Support:\n+91 97793 53560",
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Connecting to WhatsApp: +91 97793 53560..."),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Chat on WhatsApp",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return Card(
      color: const Color(0xFF1E193D),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing:
