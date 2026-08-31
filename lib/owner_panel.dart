import 'package:flutter/material.dart';

class OwnerPanelScreen extends StatefulWidget {
  const OwnerPanelScreen({super.key});

  @override
  State<OwnerPanelScreen> createState() => _OwnerPanelScreenState();
}

class _OwnerPanelScreenState extends State<OwnerPanelScreen> {
  final TextEditingController targetIdController = TextEditingController();
  final TextEditingController vipController = TextEditingController();
  final TextEditingController coinController = TextEditingController();

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner ID: 0001 Super Panel", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber, width: 1.5),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.pinkAccent, child: Icon(Icons.star, size: 35, color: Colors.amber)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Lovepreet Singh (Owner)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 4),
                      Text("ID: 0001 🇮🇳 | VIP 40 (Max)", style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text("Super-Admin Controls", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 15),
            TextField(
              controller: targetIdController,
              decoration: const InputDecoration(labelText: "Target User ID or Phone", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: vipController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Assign VIP Level (e.g. 1 to 40)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: coinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Coin Amount to Transfer", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                    onPressed: () => showMsg("VIP Level assigned successfully!"),
                    child: const Text("Set VIP", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => showMsg("Coins transferred successfully!"),
                    child: const Text("Send Coins", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

