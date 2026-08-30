import 'package:flutter/material.dart';

class MusicPlayerSheet {
  static void show(BuildContext context) {
    bool isPlaying = false;
    String currentTrack = "None";
    final tracks = ["🎧 Punjabi Club Beat", "🔥 DJ Bass Boost", "🌹 Romantic Melody", "🎤 Acoustic Guitar"];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setM) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("🎵 Room DJ Music Player", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.pinkAccent, size: 30),
                    onPressed: () {
                      if (currentTrack != "None") {
                        setM(() => isPlaying = !isPlaying);
                      }
                    },
                  )
                ],
              ),
              Text("Now Playing: $currentTrack", style: const TextStyle(color: Colors.amber, fontSize: 12)),
              const Divider(color: Colors.white24, height: 20),
              ...tracks.map((t) => ListTile(
                dense: true,
                leading: Icon(currentTrack == t ? Icons.equalizer : Icons.music_note, color: currentTrack == t ? Colors.greenAccent : Colors.white70),
                title: Text(t, style: TextStyle(color: currentTrack == t ? Colors.greenAccent : Colors.white, fontWeight: currentTrack == t ? FontWeight.bold : FontWeight.normal)),
                trailing: TextButton(
                  child: Text(currentTrack == t && isPlaying ? "Pause" : "Play", style: const TextStyle(color: Colors.pinkAccent)),
                  onPressed: () {
                    setM(() {
                      currentTrack = t;
                      isPlaying = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("🎶 Playing: $t for the room!"), backgroundColor: Colors.purple));
                  },
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class GiftingControlSheet {
  static void show({
    required BuildContext context,
    required int userCoins,
    required List<String?> seats,
    required Function(String giftIcon, String giftName, int totalCost, String targetName, int count) onSendSuccess,
  }) {
    int selectedGiftIndex = 0;
    int giftCount = 1;
    bool sendToSelf = false;
    bool sendToAll = false;
    final countPacks = [1, 10, 66, 99, 520, 1314];

    final gifts = [
      {"n": "Rose", "c": 10, "i": "🌹"},
      {"n": "Coffee", "c": 50, "i": "☕"},
      {"n": "Mic", "c": 100, "i": "🎤"},
      {"n": "Crown", "c": 500, "i": "👑"},
      {"n": "Car", "c": 1200, "i": "🏎️"},
      {"n": "Rocket", "c": 6500, "i": "🚀"},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setG) {
          final selG = gifts[selectedGiftIndex];
          int mult = sendToAll ? seats.where((s) => s != null).length : 1;
          mult = mult == 0 ? 1 : mult;
          int totalCost = (selG["c"] as int) * giftCount * mult;

          return Container(
            padding: const EdgeInsets.all(14),
            height: 440,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("🎁 Send Gifts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("💎 Balance: $userCoins", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FilterChip(
                      selected: sendToSelf,
                      label: const Text("Self 👤", style: TextStyle(fontSize: 10)),
                      onSelected: (v) => setG(() { sendToSelf = v; if (v) sendToAll = false; }),
                    ),
                    const SizedBox(width: 6),
                    FilterChip(
                      selected: sendToAll,
                      label: const Text("All Mic 🚀", style: TextStyle(fontSize: 10)),
                      onSelected: (v) => setG(() { sendToAll = v; if (v) sendToSelf = false; }),
                    ),
                  ],
                ),
                const Divider(color: Colors.white24, height: 14),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 6, mainAxisSpacing: 6),
                    itemCount: gifts.length,
                    itemBuilder: (_, i) {
                      final isSelected = selectedGiftIndex == i;
                      return InkWell(
                        onTap: () => setG(() => selectedGiftIndex = i),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFF007F).withOpacity(0.3) : const Color(0xFF2A2456),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: isSelected ? Colors.pinkAccent : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(gifts[i]["i"] as String, style: const TextStyle(fontSize: 22)),
                              Text(gifts[i]["n"] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                              Text("${gifts[i]['c']} 💎", style: const TextStyle(color: Colors.amber, fontSize: 9)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: countPacks.map((cnt) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text("x$cnt", style: const TextStyle(fontSize: 10)),
                        selected: giftCount == cnt,
                        onSelected: (_) => setG(() => giftCount = cnt),
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selected: ${selG['i']} x$giftCount", style: const TextStyle(color: Colors.white, fontSize: 12)),
                        Text("Total: $totalCost 💎", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                      onPressed: () {
                        if (userCoins >= totalCost) {
                          String target = sendToSelf ? "Self" : sendToAll ? "All Mics" : "Host";
                          Navigator.pop(ctx);
                          onSendSuccess(selG["i"] as String, selG["n"] as String, totalCost, target, giftCount);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insufficient diamonds!"), backgroundColor: Colors.red));
                        }
                      },
                      child: const Text("SEND 🚀", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

