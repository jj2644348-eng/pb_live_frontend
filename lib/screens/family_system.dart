import 'package:flutter/material.dart';

class FamilyModel {
  String id;
  String name;
  String leaderName;
  String leaderId;
  String logo;
  int level;
  int diamondsContributed;
  List<String> memberIds;
  List<String> memberNames;

  FamilyModel({
    required this.id,
    required this.name,
    required this.leaderName,
    required this.leaderId,
    required this.logo,
    this.level = 1,
    this.diamondsContributed = 5000,
    required this.memberIds,
    required this.memberNames,
  });
}

class FamilySystemController {
  static List<FamilyModel> allFamilies = [
    FamilyModel(
      id: "FAM101",
      name: "PB Tigers Official",
      leaderName: "Love Party Owner",
      leaderId: "0001",
      logo: "👑",
      level: 5,
      diamondsContributed: 850000,
      memberIds: ["0001", "20884512", "20552190"],
      memberNames: ["Love Party Owner (Leader)", "Aman Deep (Co-Leader)", "Riya Sharma (Member)"],
    ),
    FamilyModel(
      id: "FAM102",
      name: "Royal Punjabi Club",
      leaderName: "Aman Deep",
      leaderId: "20884512",
      logo: "🦁",
      level: 3,
      diamondsContributed: 320000,
      memberIds: ["20884512"],
      memberNames: ["Aman Deep (Leader)"],
    ),
  ];

  static void showFamilyManagerSheet({
    required BuildContext context,
    required String currentUserId,
    required String currentUserName,
    required int userDiamonds,
    required Function(int newDiamondsBalance, String userFamilyName) onUpdate,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setFamState) {
          FamilyModel? myFamily;
          try {
            myFamily = allFamilies.firstWhere((f) => f.memberIds.contains(currentUserId));
          } catch (_) {
            myFamily = null;
          }

          return Container(
            padding: const EdgeInsets.all(16),
            height: 520,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("👥 PB Family Club Center", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("💎 $userDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                if (myFamily == null)
                  _buildNoFamilyCard(context, currentUserId, currentUserName, userDiamonds, (cost, newFam) {
                    setFamState(() {
                      allFamilies.insert(0, newFam);
                      userDiamonds -= cost;
                    });
                    onUpdate(userDiamonds, newFam.name);
                  })
                else
                  _buildMyFamilyCard(context, myFamily, currentUserId, setFamState),
                const Divider(color: Colors.white24, height: 20),
                const Text("🏆 TOP RANKING CLUBS (LEADERBOARD)", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: allFamilies.length,
                    itemBuilder: (context, idx) {
                      final f = allFamilies[idx];
                      return Card(
                        color: const Color(0xFF2A2456),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: idx == 0 ? Colors.amber : Colors.purpleAccent,
                            child: Text(f.logo, style: const TextStyle(fontSize: 20)),
                          ),
                          title: Text("${idx + 1}. ${f.name}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          subtitle: Text("Leader: ${f.leaderName} • ${f.memberIds.length} Members", style: const TextStyle(color: Colors.grey, fontSize: 10)),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Lv.${f.level} 👑", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 11)),
                              Text("💎 ${f.diamondsContributed}", style: const TextStyle(color: Colors.amber, fontSize: 9)),
                            ],
                          ),
                          onTap: () => _showFamilyDetails(context, f, currentUserId, setFamState),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget _buildNoFamilyCard(BuildContext context, String uId, String uName, int coins, Function(int cost, FamilyModel newFam) onCreated) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFFFF007F)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You don't have a Family!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              Text("Create Official Club for 5,000 💎", style: TextStyle(color: Colors.amberAccent, fontSize: 10)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () => _openCreateDialog(context, uId, uName, coins, onCreated),
            child: const Text("Create +", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
          )
        ],
      ),
    );
  }

  static Widget _buildMyFamilyCard(BuildContext context, FamilyModel fam, String currentUserId, StateSetter setFamState) {
    bool isLeader = fam.leaderId == currentUserId;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E88E5), Color(0xFF9C27B0)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("👑 ${fam.name} (Lv.${fam.level})", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text("ID: ${fam.id}", style: const TextStyle(color: Colors.amberAccent, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 4),
          Text("Leader: ${fam.leaderName} • ${fam.memberIds.length} Members", style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 8),
          Row(
            children: [
              if (isLeader)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
                  icon: const Icon(Icons.person_add, color: Colors.black, size: 14),
                  label: const Text("Add Member by ID", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                  onPressed: () => _openAddMemberDialog(context, fam, setFamState),
                ),
            ],
          )
        ],
      ),
    );
  }

  static void _openCreateDialog(BuildContext context, String uId, String uName, int coins, Function(int cost, FamilyModel newFam) onCreated) {
    final nameCtrl = TextEditingController();
    String selectedBadge = "👑";

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (c, setD) => AlertDialog(
          backgroundColor: const Color(0xFF1E193D),
          title: const Text("👥 Create New Official Family", style: TextStyle(color: Colors.white, fontSize: 15)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Fee: 5,000 Diamonds 💎", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Family Name", labelStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 8),
              const Text("Select Family Emblem:", style: TextStyle(color: Colors.white70, fontSize: 11)),
              Wrap(
                spacing: 8,
                children: ["👑", "🦁", "⚡", "💎", "🔥", "🌹"].map((e) => InkWell(
                  onTap: () => setD(() => selectedBadge = e),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: selectedBadge == e ? Colors.pink : Colors.transparent,
                    child: Text(e, style: const TextStyle(fontSize: 20)),
                  ),
                )).toList(),
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
              onPressed: () {
                if (coins >= 5000) {
                  final fn = nameCtrl.text.trim().isEmpty ? "$uName's Tigers" : nameCtrl.text.trim();
                  final newFam = FamilyModel(
                    id: "FAM${100 + allFamilies.length + 1}",
                    name: fn,
                    leaderName: uName,
                    leaderId: uId,
                    logo: selectedBadge,
                    memberIds: [uId],
                    memberNames: ["$uName (Leader)"],
                  );
                  Navigator.pop(ctx);
                  onCreated(5000, newFam);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You need 5,000 💎 to create family!"), backgroundColor: Colors.red));
                }
              },
              child: const Text("Create (5,000 💎)", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  static void _openAddMemberDialog(BuildContext context, FamilyModel fam, StateSetter setFamState) {
    final idCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: const Text("➕ Add Member to Family", style: TextStyle(color: Colors.white, fontSize: 15)),
        content: TextField(
          controller: idCtrl,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: "Target 8-Digit User ID", labelStyle: TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
            onPressed: () {
              final targetId = idCtrl.text.trim();
              if (targetId.isNotEmpty) {
                setFamState(() {
                  fam.memberIds.add(targetId);
                  fam.memberNames.add("User_$targetId (Member)");
                  fam.diamondsContributed += 1000;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ User $targetId added to '${fam.name}'!"), backgroundColor: Colors.green));
              }
            },
            child: const Text("Add Member", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  static void _showFamilyDetails(BuildContext context, FamilyModel fam, String currentUserId, StateSetter setFamState) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: Text("${fam.logo} ${fam.name} (Lv.${fam.level})", style: const TextStyle(color: Colors.white, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leader: ${fam.leaderName} (ID: ${fam.leaderId})", style: const TextStyle(color: Colors.pinkAccent, fontSize: 12)),
            Text("Total Exp / 💎 Score: ${fam.diamondsContributed}", style: const TextStyle(color: Colors.amber, fontSize: 12)),
            const Divider(color: Colors.white24),
            const Text("Members List:", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...fam.memberNames.map((m) => Text("• $m", style: const TextStyle(color: Colors.white, fontSize: 11))).toList(),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close")),
        ],
      ),
    );
  }
}

