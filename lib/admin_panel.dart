import 'package:flutter/material.dart';

class AdminWindowPanel extends StatelessWidget {
  const AdminWindowPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          const Text("Super Admin & Owner Control Panel 👑", style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "Target User ID", border: OutlineInputBorder(), filled: true, fillColor: Color(0xFF1E193D))),
          const SizedBox(height: 15),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: () {}, child: const Text("Assign Admin / BD / VIP 10", style: TextStyle(color: Colors.black))),
          const SizedBox(height: 15),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), onPressed: () {}, child: const Text("Generate Unlimited Coins")),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () {}, child: const Text("Ban ID"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {}, child: const Text("Unban ID"))),
            ],
          ),
        ],
      ),
    );
  }
}

