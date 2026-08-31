import 'package:flutter/material.dart';

class OwnerPanelScreen extends StatefulWidget {
  const OwnerPanelScreen({super.key});

  @override
  State<OwnerPanelScreen> createState() => _OwnerPanelScreenState();
}

class _OwnerPanelScreenState extends State<OwnerPanelScreen> {
  final TextEditingController _targetIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // एक्शन परफॉर्म करने का फंक्शन (जैसे कॉइन भेजना, बैन करना, बीडी बनाना)
  void _performAction(String actionName) {
    String targetId = _targetIdController.text.trim();
    if (targetId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter target User ID!")),
      );
      return;
    }

    // यहाँ सर्वर या डेटाबेस की रिक्वेस्ट लगेगी
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Success: $actionName executed for ID: $targetId")),
    );
    _targetIdController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141026),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("Official Owner Panel", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // हेडिंग नोटिस
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
              ),
              child: const Text(
                "Super Admin / Owner Controls: Manage BDs, Coin Sellers, Direct Transfers, and User Bans securely.",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),

            // टारगेट यूजर आईडी इनपुट फील्ड
            TextField(
              controller: _targetIdController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Target User ID (e.g. ID10590491)",
                labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E193D),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),

            // कॉइन अमाउंट (सिर्फ कॉइन ट्रांसफर के लिए)
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Diamond/Coin Amount (For Transfer)",
                labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E193D),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 25),

            const Text("Management Actions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),

            // एक्शन बटन्स ग्रिड
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildActionButton("Make BD", Icons.supervisor_account, Colors.blue, () => _performAction("Assigned as BD")),
                _buildActionButton("Make Admin", Icons.admin_panel_settings, Colors.purple, () => _performAction("Assigned as Admin")),
                _buildActionButton("Coin Seller", Icons.store, Colors.amber, () => _performAction("Assigned as Coin Seller")),
                _buildActionButton("Transfer Coins", Icons.send, Colors.green, () => _performAction("Coins Transferred")),
                _buildActionButton("Ban User", Icons.block, Colors.red, () => _performAction("User Banned")),
                _buildActionButton("Unban User", Icons.check_circle, Colors.teal, () => _performAction("User Unbanned")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.styleFrom(
      backgroundColor: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 1),
      ),
    ).icon(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 18),
      label: Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

