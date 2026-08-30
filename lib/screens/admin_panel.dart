import 'package:flutter/material.dart';
import '../models/user_session.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  static void open(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => const AdminPanelScreen()),
    );
  }

  void _showActionDialog(BuildContext context, String title, String fieldLabel, String successMsg) {
    final textC = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: Text(title, style: const TextStyle(color: Colors.amber, fontSize: 16)),
        content: TextField(
          controller: textC,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: fieldLabel, labelStyle: const TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$successMsg: ${textC.text}"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Execute", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _showTransferDialog(BuildContext context) {
    final idC = TextEditingController();
    final amtC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Add / Transfer Diamonds", style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Target 8-Digit ID", labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: amtC, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Diamonds Amount", labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Transferred ${amtC.text} 💎 to ID: ${idC.text}"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Send 💎", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildControlCard(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return Card(
      color: const Color(0xFF1E193D),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: const Text("👑 Super Owner Master Dashboard", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFFFF007F)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 24, backgroundColor: Colors.amber, child: Text("👑", style: TextStyle(fontSize: 24))),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    Text("Super Master ID: ${CurrentUser.id} (100% Control)", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("APP & USER CONTROLS", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 10),
          _buildControlCard(
            context,
            icon: Icons.monetization_on,
            title: "Recharge / Transfer Coins",
            subtitle: "Send Diamonds to any User by 8-Digit ID",
            color: Colors.amber,
            onTap: () => _showTransferDialog(context),
          ),
          _buildControlCard(
            context,
            icon: Icons.block,
            title: "Ban / Blacklist User",
            subtitle: "Block abusive user by ID from entire App",
            color: Colors.redAccent,
            onTap: () => _showActionDialog(context, "🚫 Ban User Account", "Enter User ID to Ban", "Banned User"),
          ),
          _buildControlCard(
            context,
            icon: Icons.campaign,
            title: "Global Club Announcement",
            subtitle: "Broadcast system message to all live rooms",
            color: Colors.cyanAccent,
            onTap: () => _showActionDialog(context, "📢 Send Global Announcement", "Type Announcement Message", "Broadcasted Message"),
          ),
          _buildControlCard(
            context,
            icon: Icons.verified,
            title: "Assign VIP / Official Host",
            subtitle: "Grant verified blue tick or gold badge",
            color: Colors.greenAccent,
            onTap: () => _showActionDialog(context, "⭐ Grant Official Badge", "Enter Target User ID", "Granted Badge to ID"),
          ),
          _buildControlCard(
            context,
            icon: Icons.meeting_room,
            title: "Force Close / Reset Room",
            subtitle: "Close any live room violating club policies",
            color: Colors.orangeAccent,
            onTap: () => _showActionDialog(context, "🎙️ Force Close Room", "Enter Room ID or Name", "Closed Room"),
          ),
        ],
      ),
    );
  }
}

class OfflineRechargeDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("💎 Offline Recharge", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your ID: ${CurrentUser.id}", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Packs:\n₹10 = 100 💎\n₹50 = 550 💎\n₹100 = 1,200 💎\n₹500 = 6,500 💎", style: TextStyle(color: Colors.white70)),
            const Divider(color: Colors.white24),
            const Text("WhatsApp Official Support:\n+91 97793 53560", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close", style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}

