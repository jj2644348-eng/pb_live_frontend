import 'package:flutter/material.dart';
import 'admin_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminWindowPanel()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Header
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.pinkAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Lovepreet Singh (VIP 6)",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ID: 10590491 | 🛡️ Official Admin",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Social Stats Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatItem("Following", "120"),
                _StatItem("Fans", "4.5K"),
                _StatItem("Blocked", "0"),
              ],
            ),
            const SizedBox(height: 20),
            // Wallet & Economy
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E193D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Diamonds: 99,99,999",
                    style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                  Text("My Wallet", style: TextStyle(color: Colors.pinkAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Management & Business Centers
            const Text("Management Hubs", style: TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 10),
            const _MenuTile(icon: Icons.group, title: "Agency Center", subtitle: "Manage hosts & team"),
            const _MenuTile(icon: Icons.business_center, title: "BD Center", subtitle: "Business developer controls"),
            const _MenuTile(icon: Icons.live_tv, title: "Host Center", subtitle: "Live hours & earnings"),
            const _MenuTile(icon: Icons.workspace_premium, title: "VIP Center", subtitle: "Exclusive badges & effects"),
            const SizedBox(height: 20),
            // Admin Panel Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminWindowPanel()),
              ),
              child: const Text(
                "Super Admin & Owner Panel",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, count;
  const _StatItem(this.label, this.count);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _MenuTile({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E193D),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
        onTap: () {},
      ),
    );
  }
}

