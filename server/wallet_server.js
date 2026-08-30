const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// इन-मेमोरी सुरक्षित डेटाबेस (Server Wallet Database)
const userWallets = {
  "0001": { name: "Love Party Owner (Super Owner)", diamonds: 10000000, isOwner: true, isSeller: false },
  "20884512": { name: "Aman Deep (Official Seller)", diamonds: 50000, isOwner: false, isSeller: true },
  "20552190": { name: "Riya Sharma", diamonds: 2500, isOwner: false, isSeller: false },
};

// ट्रांजेक्शन हिस्ट्री लॉग
const transactionHistory = [];

// 1. यूजर का लाइव बैलेंस चेक करने का API
app.get('/api/wallet/:userId', (req, res) => {
  const { userId } = req.params;
  const wallet = userWallets[userId];

  if (!wallet) {
    return res.status(404).json({ success: false, message: "User ID not found" });
  }

  res.json({
    success: true,
    userId,
    name: wallet.name,
    diamonds: wallet.diamonds,
    isOwner: wallet.isOwner,
    isSeller: wallet.isSeller
  });
});

// 2. सुपर ओनर डायरेक्ट कॉइन जनरेटर API (Zero Balance Deduction for Owner)
app.post('/api/wallet/owner-generate', (req, res) => {
  const { ownerId, targetUserId, amount } = req.body;
  const numAmount = parseInt(amount, 10);

  if (ownerId !== "0001" || !userWallets[ownerId]?.isOwner) {
    return res.status(403).json({ success: false, message: "Unauthorized! Only Super Owner (ID: 0001) can generate coins." });
  }

  if (!numAmount || numAmount <= 0) {
    return res.status(400).json({ success: false, message: "Invalid diamond amount" });
  }

  if (!userWallets[targetUserId]) {
    userWallets[targetUserId] = { name: `User_${targetUserId}`, diamonds: 0, isOwner: false, isSeller: false };
  }

  // कॉइन जमा करो (+ Credit)
  userWallets[targetUserId].diamonds += numAmount;

  const logEntry = {
    type: "OWNER_GENERATE",
    senderId: ownerId,
    receiverId: targetUserId,
    amount: numAmount,
    timestamp: new Date().toISOString()
  };
  transactionHistory.push(logEntry);

  res.json({
    success: true,
    message: `Successfully added ${numAmount} diamonds to ID: ${targetUserId}`,
    targetUserBalance: userWallets[targetUserId].diamonds,
    transaction: logEntry
  });
});

// 3. सेलर कॉइन ट्रांसफर API (Debit from Seller -> Credit to Receiver)
app.post('/api/wallet/transfer', (req, res) => {
  const { senderId, receiverId, amount } = req.body;
  const numAmount = parseInt(amount, 10);

  if (!numAmount || numAmount <= 0) {
    return res.status(400).json({ success: false, message: "Invalid amount" });
  }

  const sender = userWallets[senderId];
  if (!sender) {
    return res.status(404).json({ success: false, message: "Sender wallet not found" });
  }

  // चेक करो कि भेजने वाले के पास पर्याप्त कॉइन हैं
  if (sender.diamonds < numAmount) {
    return res.status(400).json({
      success: false,
      message: `Insufficient balance! Sender has only ${sender.diamonds} diamonds.`
    });
  }

  if (!userWallets[receiverId]) {
    userWallets[receiverId] = { name: `User_${receiverId}`, diamonds: 0, isOwner: false, isSeller: false };
  }

  // 1. भेजने वाले से घटाओ (- DEBIT)
  sender.diamonds -= numAmount;

  // 2. पाने वाले में जोड़ो (+ CREDIT)
  userWallets[receiverId].diamonds += numAmount;

  const logEntry = {
    type: "PEER_TRANSFER",
    senderId,
    receiverId,
    amount: numAmount,
    senderRemainingBalance: sender.diamonds,
    receiverNewBalance: userWallets[receiverId].diamonds,
    timestamp: new Date().toISOString()
  };
  transactionHistory.push(logEntry);

  res.json({
    success: true,
    message: `Successfully transferred ${numAmount} 💎 from ${senderId} to ${receiverId}!`,
    senderBalance: sender.diamonds,
    receiverBalance: userWallets[receiverId].diamonds,
    transaction: logEntry
  });
});

// 4. रूम गिफ़्टिंग डिडक्शन API
app.post('/api/wallet/gift-deduct', (req, res) => {
  const { gifterId, hostId, giftCost, giftName, count } = req.body;
  const totalCost = parseInt(giftCost, 10);

  const gifter = userWallets[gifterId];
  if (!gifter || gifter.diamonds < totalCost) {
    return res.status(400).json({ success: false, message: "Insufficient diamonds for gifting!" });
  }

  // गिफ़्टर से काटो
  gifter.diamonds -= totalCost;

  // होस्ट को 50% शेयर दो
  if (userWallets[hostId]) {
    const hostShare = Math.floor(totalCost * 0.5);
    userWallets[hostId].diamonds += hostShare;
  }

  res.json({
    success: true,
    message: `Sent ${count}x ${giftName} (-${totalCost} 💎)`,
    remainingBalance: gifter.diamonds
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Live Voice & Diamond Wallet Engine running on port ${PORT}`);
});

