import 'package:flutter/material.dart';
import '../models/user_session.dart';
import 'admin_panel.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onProfileUpdated;
  const ProfileScreen({super.key, required this.onProfileUpdated});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> avatarList = [
    "👑", "🦁", "🎧", "🌹", "⚡", "💎", "🔥", "👸", "🦸", "🎤"
  ];

  void _openAvatarPicker() {
    final nameCtrl = TextEditingController(text: CurrentUser.name);
    String selectedAvatar = CurrentUser.avatar;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🖼️ Edit Profile & DP Avatar",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                      child: Text(selectedAvatar, style: const TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Display Name / Nickname",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF161230),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Select VIP DP Icon:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: avatarList.map((emoji) {
                      final isSelected = selectedAvatar == emoji;
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = emoji),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFF007F) : const Color(0xFF2A2456),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.amber : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 24)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF007F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() {
                          CurrentUser.name = nameCtrl.text.trim().isEmpty ? CurrentUser.name : nameCtrl.text.trim();
                          CurrentUser.avatar = selectedAvatar;
                        });
                        widget.onProfileUpdated();
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile & DP updated successfully!"), backgroundColor: Colors.green),
                        );
                      },
                      child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: CurrentUser.isOwner ? Colors.amber : const Color(0xFFFF007F),
                    child: Text(CurrentUser.avatar, style: const TextStyle(fontSize: 34)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _openAvatarPicker,
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFFF007F),
                        child: Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CurrentUser.name, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    Text("ID: ${CurrentUser.id} (Super Owner)", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    const Text("👑 Master Admin Level", style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white70),
                onPressed: _openAvatarPicker,
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFF9C27B0)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("💎 Diamonds Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text("${CurrentUser.coins} 💎", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () => OfflineRechargeDialog.show(context),
                  child: const Text("Recharge", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.amber),
              title: const Text("👑 Super Owner Master Panel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text("Control Ban, Coins, Rooms & Alerts", style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
              onTap: () => AdminPanelScreen.open(context),
            ),
          ),
          Card(
            color: const Color(0xFF1E193D),
            child: ListTile(
              leading: const Icon(Icons.image, color: Colors.cyanAccent),
              title: const Text("Change DP & Nickname", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Customize profile picture & look", style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
              onTap: _openAvatarPicker,
            ),
          ),
        ],
      ),
    );
  }
}

