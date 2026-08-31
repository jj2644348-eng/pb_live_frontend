import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainContainer(),
    );
  }
}

// बॉटम नेविगेशन के साथ मेन कंटेनर
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const PartyRoomsScreen(),
    const AdminPanelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Party Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "Admin Panel"),
        ],
      ),
    );
  }
}

// 1. Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PB Live Party", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: const Center(
        child: Text(
          "Welcome to PB Live Party! 🎉\nTap 'Party Rooms' to join live mic.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
    );
  }
}

// 2. Party Rooms Screen
class PartyRoomsScreen extends StatelessWidget {
  const PartyRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Party Rooms", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1E193D),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.mic, color: Colors.white)),
              title: Text("Party Room #${index + 1} 🎤", style: const TextStyle(color: Colors.white)),
              subtitle: const Text("15-Seater Voice Room", style: TextStyle(color: Colors.white54)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                onPressed: () {},
                child: const Text("Join"),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. Super Admin Panel (कॉइन्स और सेलर/बैन मैनेजमेंट)
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int myCoins = 100000000;
  final Map<String, int> userWallets = {"1001": 5000, "1002": 10000};
  final List<String> coinSellers = [];
  final List<String> bannedUsers = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void transferCoins(bool isSellerAction) {
    String id = idController.text.trim();
    int amount = int.tryParse(amountController.text) ?? 0;

    if (id.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("कृपया सही ID और अमाउंट डालें!")));
      return;
    }

    if (!isSellerAction && myCoins < amount) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("पर्याप्त कॉइन्स नहीं हैं!")));
      return;
    }

    setState(() {
      if (!isSellerAction) myCoins -= amount;
      userWallets[id] = (userWallets[id] ?? 0) + amount;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ID: $id को 🪙 $amount कॉइन्स भेज दिए गए!")));
    idController.clear();
    amountController.clear();
  }

  void toggleSeller(String id) {
    setState(() {
      if (coinSellers.contains(id)) {
        coinSellers.remove(id);
      } else {
        coinSellers.add(id);
      }
    });
  }

  void toggleBan(String id) {
    setState(() {
      if (bannedUsers.contains(id)) {
        bannedUsers.remove(id);
      } else {
        bannedUsers.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Admin Panel", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(12)),
              child: Text("My Owner Coins: 🪙 $myCoins", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
            ),
            const SizedBox(height: 20),
            const Text("User Coin Recharge / Transfer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            const SizedBox(height: 10),
            TextField(controller: idController, decoration: const InputDecoration(labelText: "Target User ID (e.g. 1001)", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Coin Amount", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => transferCoins(false),
                  child: const Text("Send Coins"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => transferCoins(true),
                  child: const Text("Seller Recharge"),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text("Manage Sellers & Bans", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userWallets.keys.length,
              itemBuilder: (context, index) {
                String userId = userWallets.keys.elementAt(index);
                bool isSeller = coinSellers.contains(userId);
                bool isBanned = bannedUsers.contains(userId);

                return Card(
                  color: const Color(0xFF1E193D),
                  child: ListTile(
                    title: Text("ID: $userId | Balance: 🪙 ${userWallets[userId]}", style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      isBanned ? "Status: Banned ❌" : (isSeller ? "Status: Coin Seller ⭐" : "Status: Normal User"),
                      style: TextStyle(color: isBanned ? Colors.red : (isSeller ? Colors.amber : Colors.white70)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(isSeller ? Icons.star : Icons.star_border, color: Colors.amber),
                          onPressed: () => toggleSeller(userId),
                        ),
                        IconButton(
                          icon: Icon(isBanned ? Icons.lock_open : Icons.lock, color: isBanned ? Colors.green : Colors.red),
                          onPressed: () => toggleBan(userId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

