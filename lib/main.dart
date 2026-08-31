import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AdminPanelScreen(),
    );
  }
}

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  // ओनर का वॉलेट और डेटाबेस
  int myCoins = 100000000; // 10 करोड़ कॉइन्स
  final Map<String, int> userWallets = {"1001": 5000, "1002": 10000};
  final List<String> coinSellers = [];
  final List<String> bannedUsers = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // कॉइन्स ट्रांसफर / ऐड करने का फंक्शन (कटने और बढ़ने का हिसाब)
  void transferCoins(bool isSellerAction) {
    String id = idController.text.trim();
    int amount = int.tryParse(amountController.text) ?? 0;

    if (id.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया सही ID और अमाउंट डालें!")),
      );
      return;
    }

    if (!isSellerAction && myCoins < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("आपके पास पर्याप्त कॉइन्स नहीं हैं!")),
      );
      return;
    }

    setState(() {
      if (!isSellerAction) {
        myCoins -= amount; // ओनर के कॉइन्स कटे
      }
      userWallets[id] = (userWallets[id] ?? 0) + amount; // यूजर के कॉइन्स बढ़े
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("सफलतापूर्वक ID: $id को 🪙 $amount कॉइन्स भेज दिए गए!")),
    );
    idController.clear();
    amountController.clear();
  }

  // कॉइन सेलर बनाने का फंक्शन
  void toggleSeller(String id) {
    setState(() {
      if (coinSellers.contains(id)) {
        coinSellers.remove(id);
      } else {
        coinSellers.add(id);
      }
    });
  }

  // बैन / अनबैन फंक्शन
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
        title: const Text("PB Live - Super Admin Panel", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ओनर बैलेंस कार्ड
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "My Owner Coins: 🪙 $myCoins",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 20),
            
            // कॉइन्स भेजने और काटने का फॉर्म
            const Text("User Coin Recharge / Transfer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "Target User ID (e.g. 1001)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Coin Amount", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => transferCoins(false),
                  child: const Text("Send Coins (Cut & Add)"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => transferCoins(true),
                  child: const Text("Seller Recharge"),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // सेलर और बैन लिस्ट मैनेजर
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
                          tooltip: "Toggle Seller",
                        ),
                        IconButton(
                          icon: Icon(isBanned ? Icons.lock_open : Icons.lock, color: isBanned ? Colors.green : Colors.red),
                          onPressed: () => toggleBan(userId),
                          tooltip: "Ban/Unban",
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

