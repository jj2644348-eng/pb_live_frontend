// ==============================================================
// 🏆 OFFICIAL TECH LOVE PB - FAMILY AUTO & MANUAL REWARD ENGINE
// ==============================================================

const express = require('express');
const router = express.Router();

// रैंकिंग प्राइज़ स्लैब (Weekly / Event Prizes)
const REWARD_TIERS = {
  RANK_1: { diamonds: 50000, badge: "👑 Gold Crown Family" },
  RANK_2: { diamonds: 25000, badge: "🥈 Silver Star Family" },
  RANK_3: { diamonds: 10000, badge: "🥉 Bronze Shield Family" },
};

// फैमिली डेटाबेस (In-Memory Reference)
let families = [
  { id: "FAM101", name: "PB Tigers Official", leaderId: "0001", leaderName: "Love Party Owner", members: ["0001", "20884512", "20552190"], totalGiftingScore: 850000, rank: 1, familyVault: 50000 },
  { id: "FAM102", name: "Royal Punjabi Club", leaderId: "20884512", leaderName: "Aman Deep", members: ["20884512"], totalGiftingScore: 320000, rank: 2, familyVault: 25000 },
  { id: "FAM103", name: "Desi Beats Squad", leaderId: "20552190", leaderName: "Riya Sharma", members: ["20552190"], totalGiftingScore: 110000, rank: 3, familyVault: 10000 },
];

// 1. 🤖 सर्वर ऑटोमैटिक सेटलमेंट (Auto-Distribution Engine)
// यह हर हफ्ते की रैंकिंग चेक करके Rank 1, 2, 3 को खुद डायमंड्स बाँटता है
function runWeeklyFamilySettlement(userWalletsDatabase) {
  console.log("⚡ Running Weekly Family Ranking Auto-Settlement...");

  // स्कोर के हिसाब से सॉर्ट करो (Highest Score -> Rank 1)
  families.sort((a, b) => b.totalGiftingScore - a.totalGiftingScore);

  families.forEach((fam, index) => {
    fam.rank = index + 1;
    let prize = 0;
    let badge = "";

    if (fam.rank === 1) {
      prize = REWARD_TIERS.RANK_1.diamonds;
      badge = REWARD_TIERS.RANK_1.badge;
    } else if (fam.rank === 2) {
      prize = REWARD_TIERS.RANK_2.diamonds;
      badge = REWARD_TIERS.RANK_2.badge;
    } else if (fam.rank === 3) {
      prize = REWARD_TIERS.RANK_3.diamonds;
      badge = REWARD_TIERS.RANK_3.badge;
    }

    if (prize > 0) {
      // 50% सीधे फैमिली लीडर के खाते में
      const leaderShare = Math.floor(prize * 0.5);
      // 50% फैमिली फंड/वॉल्ट में
      const vaultShare = prize - leaderShare;

      fam.familyVault += vaultShare;

      if (userWalletsDatabase && userWalletsDatabase[fam.leaderId]) {
        userWalletsDatabase[fam.leaderId].diamonds += leaderShare;
      }

      console.log(`🎉 [AUTO REWARD] Rank #${fam.rank} '${fam.name}' won ${prize} 💎! (Leader +${leaderShare} 💎, Vault +${vaultShare} 💎)`);
    }
  });

  return { success: true, message: "Weekly settlement completed successfully", leaderboard: families };
}

// 2. 👑 सुपर ओनर डायरेक्ट फैमिली रिवॉर्ड API (Manual Reward Endpoint)
router.post('/api/family/owner-reward', (req, res) => {
  const { ownerId, familyId, rewardAmount, customNote } = req.body;
  const numReward = parseInt(rewardAmount, 10);

  if (ownerId !== "0001") {
    return res.status(403).json({ success: false, message: "Unauthorized! Only Super Owner (0001) can distribute rewards." });
  }

  const fam = families.find(f => f.id === familyId || f.name.toLowerCase() === familyId.toLowerCase());
  if (!fam) {
    return res.status(404).json({ success: false, message: "Family not found with given ID/Name" });
  }

  if (!numReward || numReward <= 0) {
    return res.status(400).json({ success: false, message: "Invalid reward diamond amount" });
  }

  // 50% लीडर और 50% फैमिली वॉल्ट में क्रेडिट
  const leaderShare = Math.floor(numReward * 0.5);
  const vaultShare = numReward - leaderShare;

  fam.familyVault += vaultShare;
  fam.totalGiftingScore += numReward;

  res.json({
    success: true,
    message: `🏆 Super Owner rewarded ${numReward} 💎 to '${fam.name}'!`,
    familyId: fam.id,
    familyName: fam.name,
    leaderReward: leaderShare,
    vaultBalance: fam.familyVault,
    note: customNote || "Official Event Victory Bonus"
  });
});

// 3. लाइव फैमिली रैंकिंग लिस्ट API (Live Leaderboard Endpoint)
router.get('/api/family/leaderboard', (req, res) => {
  families.sort((a, b) => b.totalGiftingScore - a.totalGiftingScore);
  res.json({ success: true, count: families.length, leaderboard: families });
});

module.exports = { router, runWeeklyFamilySettlement, families };
            
