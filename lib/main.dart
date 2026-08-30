import 'package:flutter/material.dart';
import 'services/url_launcher_service.dart';
import 'services/social_auth_service.dart';
import 'screens/referral_invite_system.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUserId = "GUEST";
  String currentUserName = "Tap to Login";
  bool isOwner = false;
  int userDiamonds = 1200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFFF007F),
              child: Text("PB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
          // 💎 Wallet & Diamonds
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
            // 🎉 Event & Social Banner (Clickable Links)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFFFF007F)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🔥 Official Tech Love PB Event", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text("Join our live chat rooms, watch YouTube guides, and win huge diamond rewards!", style: TextStyle(color: Colors.white75, fontSize: 11)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        icon: const Icon(Icons.play_arrow, size: 16),
                        label: const Text("YouTube", style: TextStyle(fontSize: 11)),
                        onPressed: () => ExternalLinkService.openYouTube(context),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white),
                        icon: const Icon(Icons.camera_alt, size: 16),
                        label: const Text("Instagram", style: TextStyle(fontSize: 11)),
                        onPressed: () => ExternalLinkService.openInstagram(context),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        icon: const Icon(Icons.support_agent, size: 16),
                        label: const Text("Support", style: TextStyle(fontSize: 11)),
                        onPressed: () => ExternalLinkService.openWhatsApp(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🎁 Invite & Referral Section Banner
            GestureDetector(
              onTap: () {
                ReferralSystemSheet.showReferralCenter(
                  context: context,
                  currentUserId: currentUserId,
                  currentDiamonds: userDiamonds,
                  onRewardClaimed: (newBal) => setState(() => userDiamonds = newBal),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2456),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.amber, width: 1),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("🎁", style: TextStyle(fontSize: 24)),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Invite Friends & Earn 10% Commission", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            Text("Get 1,000 Diamonds + Lifetime Bonus", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🪑 15-Seats Voice Party Room Access Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎙️ Live Voice Party Room (15 Seats)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text("Experience multi-seat audio streaming with custom controls and gifting.", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF007F),
                      minimumSize: const Size(double.infinity, 42),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("🚀 Entering 15-Seater Voice Room..."), backgroundColor: Colors.purple),
                      );
                    },
                    child: const Text("Enter Party Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔐 Login / Account Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.login, size: 18),
                label: Text(currentUserId == "GUEST" ? "Login with Google / Phone" : "Logged in as $currentUserName", style: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  SocialLoginSheet.show(context, (userData) {
                    setState(() {
                      currentUserId = userData["userId"];
                      currentUserName = userData["name"];
                      isOwner = userData["isOwner"] ?? false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("✅ Welcome back, $currentUserName!"), backgroundColor: Colors.green),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

