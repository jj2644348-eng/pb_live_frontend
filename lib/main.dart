import 'package:flutter/material.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: const Color(0xFFFF007F),
      ),
      home: const PBLiveHomeScreen(),
    );
  }
}

class PBLiveHomeScreen extends StatefulWidget {
  const PBLiveHomeScreen({super.key});

  @override
  State<PBLiveHomeScreen> createState() => _PBLiveHomeScreenState();
}

class _PBLiveHomeScreenState extends State<PBLiveHomeScreen> {
  // User State & Owner Details
  String currentUserId = "0001";
  String currentUserName = "Lovepreet Singh (Owner)";
  String currentUserEmail = "lp5006352@gmail.com";
  bool isOwner = true;
  int userDiamonds = 5400;
  String activeFrame = "🐉 Dragon Fire Frame";
  int invitedCount = 12;

  // 1. Google / Social Login Dialog
  void _showLoginDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Welcome to PB Live Club", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("Choose your account to sign in", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            
            // Google Login Button (Auto detects your owner email)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  currentUserId = "0001";
                  currentUserName = "Lovepreet Singh (Owner)";
                  currentUserEmail = "lp5006352@gmail.com";
                  isOwner = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("👑 Super Owner Logged In (lp5006352@gmail.com)!"), backgroundColor: Colors.green),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Continue with Google (Gmail)", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Facebook Login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  currentUserId = "FB9921";
                  currentUserName = "Facebook Creator";
                  currentUserEmail = "user@fb.com";
                  isOwner = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Logged in via Facebook!"), backgroundColor: Colors.blue),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, size: 20),
                  SizedBox(width: 8),
                  Text("Continue with Facebook", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. VIP Shop & Flag Mall Sheet
  void _showVipShopSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setShopState) => Container(
          padding: const EdgeInsets.all(20),
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  const Text("🛍️ VIP Avatar Shop & Flag Mall", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(12)),
                    child: Text("💎 $userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    _buildShopItem("🐉 Dragon Fire Frame", "7 Days - 3D Glowing Effect", 800, "🐉", Colors.redAccent, () {
                      if (userDiamonds >= 800) {
                        setState(() {
                          userDiamonds -= 800;
                          activeFrame = "🐉 Dragon Fire Frame";
                        });
                        setShopState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Purchased Dragon Fire Frame!")));
                      }
                    }),
                    _buildShopItem("🇮🇳 Indian Flag Pride", "30 Days - Tricolor Border", 1200, "🇮🇳", Colors.green, () {
                      if (userDiamonds >= 1200) {
                        setState(() {
                          userDiamonds -= 1200;
                          activeFrame = "🇮🇳 Indian Flag Pride";
                        });
                        setShopState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Purchased Indian Flag Frame!")));
                      }
                    }),
                    _buildShopItem("🦁 Royal Lion Crown", "30 Days - VIP Badge", 1500, "🦁", Colors.amber, () {
                      if (userDiamonds >= 1500) {
                        setState(() {
                          userDiamonds -= 1500;
                          activeFrame = "🦁 Royal Lion Crown";
                        });
                        setShopState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 Purchased Lion Crown Frame!")));
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopItem(String title, String subtitle, int price, String emoji, Color color, VoidCallback onBuy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 32)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
          onPressed: onBuy,
          child: Text("💎 $price", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ),
    );
  }

  // 3. Invite & Referral System Sheet
  void _showInviteSheet() {
    final inviteCode = "PB$currentUserId";
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🎁 Invite Friends & Earn 10% Commission", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFFFF007F)]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Your Unique Invite Code", style: TextStyle(color: Colors.white70, fontSize: 10)),
                      const SizedBox(height: 2),
                      Text(inviteCode, style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w900, fontSize: 18)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Invite code copied!")));
                    },
                    child: const Text("Copy", style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text("• Total Invited Friends: $invitedCount Users\n• Lifetime 10% Recharge Commission Enabled", style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(backgroundColor: Color(0xFFFF007F), child: Text("PB", style: TextStyle(color: Colors.white))),
                Positioned(bottom: 0, right: 0, child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)))
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PB Live Club", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(isOwner ? "👑 Super Owner (0001)" : "ID: $currentUserId", style: const TextStyle(fontSize: 10, color: Colors.amber)),
              ],
            ),
          ],
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Text("💎 ", style: TextStyle(fontSize: 12)),
                  Text("$userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Banner Card with Active Frame
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 3),
                    ),
                    child: const Center(child: Icon(Icons.person, size: 35, color: Colors.white)),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUserName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 3),
                      Text(currentUserEmail, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text("Frame: $activeFrame", style: const TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // VIP Shop & Flag Mall Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF007F),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Text("🛍️", style: TextStyle(fontSize: 18)),
              label: const Text("Open VIP Shop (Dragon & Flag Frames)", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: _showVipShopSheet,
            ),
            const SizedBox(height: 12),

            // Invite & Earn Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6200EE),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Text("🎁", style: TextStyle(fontSize: 18)),
              label: const Text("Invite Friends & Earn Commission", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: _showInviteSheet,
            ),
            const SizedBox(height: 16),

            // Live 15-Seat Voice Room Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Live Voice Party Room (15 Seats)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text("Multi-seat audio streaming, gifting, and admin seat controls.", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 40)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🚀 Entering 15-Seater Voice Room...")));
                    },
                    child: const Text("Enter Party Room", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Account Login / Switch Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                icon: const Icon(Icons.login),
                label: const Text("Switch Account / Login", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _showLoginDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

