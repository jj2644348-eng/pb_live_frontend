import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const PBPartyApp());

class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF131124),
      primaryColor: Colors.pinkAccent,
    ),
    home: const MainNav(),
  );
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [const HomeTab(), const RoomView(), const WalletTab()][tab],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tab,
      onTap: (v) => setState(() => tab = v),
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.white54,
      backgroundColor: const Color(0xFF0D0B18),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
        BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Room"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      ],
    ),
  );
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool claimedToday = false;

  void _showDailyRewardDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("🎁 7-Day Free Login Rewards", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Claim free coins & diamonds daily!", style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _rewardBox("Day 1", "100 🪙", true),
                  _rewardBox("Day 2", "200 🪙", false),
                  _rewardBox("Day 3", "500 🪙", false),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _rewardBox("Day 4", "1000 🪙", false),
                  _rewardBox("Day 5", "2000 🪙", false),
                  _rewardBox("Day 7", "1000 💎", false),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => claimedToday = true);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully claimed Day 1 Reward: 100 Coins! 🪙")));
            },
            child: Text(claimedToday ? "Claimed Today ✅" : "Claim Day 1 Reward", style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _rewardBox(String day, String reward, bool active) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? Colors.pinkAccent.withOpacity(0.3) : const Color(0xFF131124),
        border: Border.all(color: active ? Colors.pinkAccent : Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(day, style: const TextStyle(fontSize: 10, color: Colors.white54)),
          const SizedBox(height: 4),
          Text(reward, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber)),
        ],
      ),
    );
  }

  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(
      title: const Text("Love Party 👑", style: TextStyle(color: Colors.amber)),
      backgroundColor: const Color(0xFF0D0B18),
      actions: [
        IconButton(
          icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent),
          onPressed: _showDailyRewardDialog,
          tooltip: "Daily Rewards",
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        GestureDetector(
          onTap: _showDailyRewardDialog,
          child: Container(
            height: 90,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF8B2284), Color(0xFFE040FB)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("🎁 7-Day Login Bonus Active", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 4),
                Text("Tap here to claim your daily free coins & diamonds!", style: TextStyle(fontSize: 11, color: Colors.white70)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        ListTile(
          tileColor: const Color(0xFF221E3F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const Icon(Icons.mic, color: Colors.pinkAccent),
          title: const Text("The Glam Room ✨", style: TextStyle(color: Colors.amber)),
          subtitle: const Text("Welcome to The Glam Room... 🔥 38"),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {
              // Switch to Room tab smoothly
              final mainNavState = context.findAncestorStateOfType<_MainNavState>();
              mainNavState?.setState(() => mainNavState.tab = 1);
            },
            child: const Text("Join"),
          ),
        ),
      ],
    ),
  );
}

class RoomView extends StatefulWidget {
  const RoomView({super.key});
  @override State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final List<Map<String, String?>> seats = List.generate(15, (i) => i == 0 ? {"name": "Love Party Owner", "dp": "001"} : null);
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(title: const Text("The Glam Room ✨ (15 Seats)", style: TextStyle(color: Colors.amber, fontSize: 16)), backgroundColor: const Color(0xFF0D0B18)),
    body: GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: 15,
      itemBuilder: (c, i) {
        final s = seats[i];
        return Container(
          decoration: BoxDecoration(color: const Color(0xFF221E3F), borderRadius: BorderRadius.circular(10), border: Border.all(color: i == 0 ? Colors.amber : Colors.pinkAccent)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(i == 0 ? Icons.star : Icons.mic, size: 18, color: i == 0 ? Colors.amber : Colors.white70),
              Text(s != null ? s["name"]! : "Seat ${i+1}", style: const TextStyle(fontSize: 8, color: Colors.white), overflow: TextOverflow.ellipsis),
            ],
          ),
        );
      },
    ),
  );
}

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF131124),
    appBar: AppBar(title: const Text("Love Party Owner - ID: 001", style: TextStyle(color: Colors.amber, fontSize: 14)), backgroundColor: const Color(0xFF0D0B18)),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF221E3F), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Diamonds Wallet: 5,000,000 💎", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                Text("Super Owner", style: TextStyle(color: Colors.amber)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

