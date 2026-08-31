import 'package:flutter/material.dart';

class OwnerPanelScreen extends StatefulWidget {
  const OwnerPanelScreen({super.key});

  @override
  State<OwnerPanelScreen> createState() => _OwnerPanelScreenState();
}

class _OwnerPanelScreenState extends State<OwnerPanelScreen> {
  final TextEditingController _targetIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _performAction(String actionName) {
    String targetId = _targetIdController.text.trim();
    if (targetId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter target User ID!")),
      );
      return;
    }
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
        title: const Text("Official Owner Panel (ID: 0001)", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _targetIdController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Target User ID",
                labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E193D),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Coin / Diamond Amount",
                labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E193D),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildActionBtn("Make BD", Icons.supervisor_account, Colors.blue, () => _performAction("Assigned as BD")),
                _buildActionBtn("Make Admin", Icons.admin_panel_settings, Colors.purple, () => _performAction("Assigned as Admin")),
                _buildActionBtn("Coin Seller", Icons.store, Colors.amber, () => _performAction("Assigned as Coin Seller")),
                _buildActionBtn("Transfer Coins", Icons.send, Colors.green, () => _performAction("Coins Transferred")),
                _buildActionBtn("Ban User", Icons.block, Colors.red, () => _performAction("User Banned")),
                _buildActionBtn("Unban User", Icons.check_circle, Colors.teal, () => _performAction("User Unbanned")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(String title, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color, width: 1),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 18),
      label: Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

