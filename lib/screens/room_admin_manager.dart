import 'package:flutter/material.dart';

class RoomSeatModel {
  int index;
  bool isLocked;
  bool isMuted;
  Map<String, dynamic>? user;

  RoomSeatModel({
    required this.index,
    this.isLocked = false,
    this.isMuted = false,
    this.user,
  });
}

class AdminManagerSheet {
  static List<String> roomAdmins = ["0001"]; // Max 5 admins
  static String roomOwnerId = "0001";
  static int currentSeatCapacity = 8; // Default 8 seats (Option for 8, 12, 15)

  // Check if a user is Admin or Owner
  static bool isAdminOrOwner(String userId) {
    return userId == roomOwnerId || roomAdmins.contains(userId);
  }

  // 1. Admin Management & Dynamic Seat Switcher (8, 12, 15 Seats)
  static void showAdminManager({
    required BuildContext context,
    required String currentUserId,
    required Function(int newCapacity) onCapacityChanged,
    required Function() onRefresh,
  }) {
    final idCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setSheet) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("🛡️ Room Admin & Seat Layout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("${roomAdmins.length}/5 Admins", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),

              // 💺 Dynamic Seat Capacity Selector (8, 12, 15 Seats)
              if (isAdminOrOwner(currentUserId)) ...[
                const Text("Select Room Seat Capacity (Grid Layout):", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [8, 12, 15].map((cnt) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selectedColor: const Color(0xFFFF007F),
                      label: Text("$cnt Seats", style: TextStyle(color: currentSeatCapacity == cnt ? Colors.white : Colors.white70, fontWeight: FontWeight.bold, fontSize: 11)),
                      selected: currentSeatCapacity == cnt,
                      onSelected: (selected) {
                        if (selected) {
                          setSheet(() => currentSeatCapacity = cnt);
                          onCapacityChanged(cnt);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Room updated to $cnt Seats layout!"), backgroundColor: Colors.green));
                        }
                      },
                    ),
                  )).toList(),
                ),
                const Divider(color: Colors.white24, height: 20),
              ],

              if (currentUserId == roomOwnerId) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: idCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: "Enter 8-Digit User ID", hintStyle: TextStyle(color: Colors.grey), isDense: true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                      onPressed: () {
                        final tid = idCtrl.text.trim();
                        if (tid.isNotEmpty) {
                          if (roomAdmins.length >= 5) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Max 5 Admins allowed!"), backgroundColor: Colors.red));
                          } else if (roomAdmins.contains(tid)) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User is already an Admin!"), backgroundColor: Colors.orange));
                          } else {
                            setSheet(() => roomAdmins.add(tid));
                            onRefresh();
                            idCtrl.clear();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ ID $tid promoted to Room Admin!"), backgroundColor: Colors.green));
                          }
                        }
                      },
                      child: const Text("+ Add"),
                    )
                  ],
                ),
                const SizedBox(height: 12),
              ],
              const Text("Current Admins:", style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 6),
              ...roomAdmins.map((admId) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(radius: 14, backgroundColor: Colors.cyan, child: Icon(Icons.shield, color: Colors.black, size: 14)),
                title: Text(admId == roomOwnerId ? "👑 Room Owner (ID: $admId)" : "🛡️ Admin (ID: $admId)", style: const TextStyle(color: Colors.white, fontSize: 13)),
                trailing: (currentUserId == roomOwnerId && admId != roomOwnerId)
                    ? IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          setSheet(() => roomAdmins.remove(admId));
                          onRefresh();
                        },
                      )
                    : null,
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // 2. Seat Control Actions for Admins (Lock/Unlock, Kick from Mic, Mute)
  static void showSeatAdminActionSheet({
    required BuildContext context,
    required RoomSeatModel seat,
    required String currentUserId,
    required Function() onSeatUpdated,
  }) {
    bool hasPower = isAdminOrOwner(currentUserId);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("🎙️ Seat ${seat.index + 1} Controls", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),
            if (hasPower) ...[
              ListTile(
                leading: Icon(seat.isLocked ? Icons.lock_open : Icons.lock, color: Colors.amber),
                title: Text(seat.isLocked ? "Unlock Seat (Open for All)" : "Lock Seat (Admin Only)", style: const TextStyle(color: Colors.white)),
                onTap: () {
                  seat.isLocked = !seat.isLocked;
                  onSeatUpdated();
                  Navigator.pop(ctx);
                },
              ),
              if (seat.user != null) ...[
                ListTile(
                  leading: Icon(seat.isMuted ? Icons.mic : Icons.mic_off, color: Colors.orange),
                  title: Text(seat.isMuted ? "Unmute Mic" : "Mute Mic", style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    seat.isMuted = !seat.isMuted;
                    onSeatUpdated();
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_remove, color: Colors.redAccent),
                  title: const Text("Kick Off Mic", style: TextStyle(color: Colors.redAccent)),
                  onTap: () {
                    seat.user = null;
                    onSeatUpdated();
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ] else ...[
              const Text("🔒 Only Room Admins can lock or manage this seat.", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]
          ],
        ),
      ),
    );
  }
}

