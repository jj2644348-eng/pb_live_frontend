import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralSystemSheet {
  static void showReferralCenter({
    required BuildContext context,
    required String currentUserId,
    required int currentDiamonds,
    required Function(int newDiamondsBalance) onRewardClaimed,
  }) {
    final inviteCode = "PB$currentUserId";
    int invitedCount = 12;
    int earnedCommission = 14500;
    int referralLevel = 3;

    final redeemCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setSheet) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("🎁 Invite & Earn Diamonds", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
                      child: Text("Agent Lv.$referralLevel 👑", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 1. User's Personal Referral Code Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF6200EE), Color(0xFFFF007F)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your Unique Invite Code", style: TextStyle(color: Colors.white70, fontSize: 10)),
                          const SizedBox(height: 2),
                          Text(inviteCode, style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w900, fontSize: 18)),
                        ],
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                        icon: const Icon(Icons.copy, size: 14),
                        label: const Text("Copy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: inviteCode));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Invite code copied!"), backgroundColor: Colors.green));
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 2. Earnings & Commission Stats (10% on User Recharge)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const Text("Invited Friends", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            const SizedBox(height: 4),
                            Text("$invitedCount Users", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const Text("10% Recharge Bonus", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            const SizedBox(height: 4),
                            Text("💎 $earnedCommission", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white24, height: 20),

                // 3. Redeem Friend's Code Section (For New Users)
                const Text("Have a Friend's Invite Code?", style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: redeemCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Paste Invite Code (e.g. PB0001)",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E676)),
                      onPressed: () {
                        final code = redeemCtrl.text.trim();
                        if (code.isNotEmpty) {
                          onRewardClaimed(currentDiamonds + 500);
                          redeemCtrl.clear();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("🎉 500 💎 Welcome Bonus Added to Wallet!"), backgroundColor: Colors.green),
                          );
                        }
                      },
                      child: const Text("Claim 500 💎", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                    )
                  ],
                ),
                const SizedBox(height: 12),

                // 4. Reward Rules Explanation
                const Text("📜 Referral Rules:", style: TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("• Get 1,000 💎 for every new friend registered.\n• Earn 10% instant diamond commission on every recharge done by your invited friends.\n• Higher agent level unlocks VIP gifts & profile borders.", style: TextStyle(color: Colors.white60, fontSize: 10, height: 1.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

