import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Official Tech Love PB",
    home: LoginAuthScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// ---------------- CURRENT USER SESSION ----------------
class CurrentUser {
  static String id = "";
  static String name = "";
  static String email = "";
  static int coins = 0;
  static bool isOwner = false;

  // Master Owner Configuration
  static const String masterOwnerId = "0001";
}

// ---------------- LOGIN / AUTH SCREEN ----------------
class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({super.key});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController customIdController = TextEditingController();
  bool isMasterLogin = false;

  void handleLogin(bool isGoogle) {
    String enteredName = nameController.text.trim();
    if (enteredName.isEmpty) {
      enteredName = isGoogle ? "Google User" : "Tech Love Guest";
    }

    if (isMasterLogin) {
      // MASTER OWNER LOGIN (ID: 0001)
      CurrentUser.id = CurrentUser.masterOwnerId;
      CurrentUser.name = "Love Party Owner (Super Master)";
      CurrentUser.coins = 99999999;
      CurrentUser.isOwner = true;
    } else {
      // NORMAL USER LOGIN (Auto 8-Digit ID)
      CurrentUser.id = (10000000 + Random().nextInt(90000000)).toString();
      CurrentUser.name = enteredName;
      CurrentUser.coins = 1000; // Starting welcome bonus
      CurrentUser.isOwner = false;
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
                radius: 45,
                backgroundColor: Color(0xFF1E193D),
                child: Text("👑", style: TextStyle(fontSize: 45)),
              ),
              const SizedBox(height: 16),
              const Text(
                "Official Tech Love PB",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "VIP Voice Party & Live Club",
                style: TextStyle(color: Colors.pinkAccent, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),

              // Normal Name Input
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Nickname / Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E193D),
                  prefixIcon: const Icon(Icons.person, color: Colors.pinkAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              // Google Login Button (Simulated / Ready for Auth)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                  label: const Text("Sign in with Google", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15)),
                  onPressed: () => handleLogin(true),
                ),
              ),
              const SizedBox(height: 12),

              // Quick Guest Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF007F)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => handleLogin(false),
                  child: const Text("Guest Fast Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),

              // Super Owner Login Switch
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
                    const Text("👑 Master Owner Mode (ID: 0001)", style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
                    Switch(
                      value: isMasterLogin,
                      activeColor: Colors.amber,
                      onChanged: (val) => setState(() => isMasterLogin = val),
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

// ---------------- MAIN NAVIGATION ----------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {"name": "Tech Love PB Official Club", "host": "Love Party Owner", "hostId": "0001", "active": "8/8 Full", "avatar": "👑"},
    {"name": "Punjabi Beats & Shayari", "host": "Aman Deep", "hostId": "88451290", "active": "7/8 Live", "avatar": "🎤"},
    {"name": "Friends Gossip & Chill", "host": "Riya Sharma", "hostId": "55219034", "active": "4/8 Live", "avatar": "🎧"},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildHomeScreen(),
      _buildFamilyScreen(),
      _buildMeScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF161230),
        selectedItemColor: const Color(0xFFFF007F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Club"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1635),
              border: Border(bottom: BorderSide(color: Color(0xFF2A2456), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Official Tech Love PB", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("User ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Text("💎 ", style: TextStyle(fontSize: 12)),
                      Text("${CurrentUser.coins}", style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final r = rooms[index];
                return Card(
                  color: const Color(0xFF1E193D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.pinkAccent.withOpacity(0.3), child: Text(r["avatar"] as String)),
                    title: Text(r["name"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("Host: ${r["host"]} (ID: ${r["hostId"]})", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Joined Voice Room!"), backgroundColor: Colors.green));
                      },
                      child: const Text("Join", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyScreen() {
    return const Center(
      child: Text("👥 Official PB Family\nLevel 5 Club Members", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
    );
  }

  Widget _buildMeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: CurrentUser.isOwner ? Colors.amber : Colors.pinkAccent,
                  child: Text(CurrentUser.isOwner ? "👑" : "👤", style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("User ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      CurrentUser.isOwner ? "Role: Super Master Owner" : "Role: Club Member",
                      style: TextStyle(color: CurrentUser.isOwner ? Colors.amberAccent : Colors.grey, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // Coin Balance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Diamonds Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SUPER OWNER PANEL (Visible ONLY if CurrentUser.isOwner is true)
            if (CurrentUser.isOwner)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF007F), Color(0xFF7928CA)]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 28),
                  title: const Text("👑 Super Owner Panel (0001)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text("Send Unlimited Coins to Any User ID", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                  onTap: () {
                    _openCoinTransferDialog();
                  },
                ),
              ),

            // Logout Button
            ListTile(
              tileColor: const Color(0xFF1E193D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Logout Account", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginAuthScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCoinTransferDialog() {
    final targetIdCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Master Coin Transfer", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: targetIdCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Receiver 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Coins Amount", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Transferred ${amountCtrl.text} Coins to ID: ${targetIdCtrl.text}"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Send", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

