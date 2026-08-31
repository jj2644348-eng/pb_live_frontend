import 'package:flutter/material.dart';

class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  // कुल 15 माइक सीटें
  final List<Map<String, dynamic>> seats = List.generate(15, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "0001 (Owner)" : null,
    "isMuted": false,
    "isLocked": false,
  });

  // गिफ्ट भेजने वाला पॉप-अप सिस्टम
  void _showGiftsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Send Party Gifts 🎁", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGiftItem("🌹 Rose", "💎 10", Colors.red),
                _buildGiftItem("🚗 Sports Car", "💎 500", Colors.blue),
                _buildGiftItem("🏰 Castle", "💎 5000", Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Close", style: TextStyle(color: Colors.white54)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftItem(String name, String price, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully sent $name!")),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Colors.amber, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // सीट कंट्रोल ऑप्शन
  void _showMicOptions(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 15),
            ListTile(
              title: const Text("Take the Mic", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => seats[index]["user"] = "You");
              },
            ),
            ListTile(
              title: Text(seats[index]["isLocked"] ? "Unlock the Mic" : "Lock the Mic", style: const TextStyle(color: Colors.white)),
              onTap: () {
                setState(() => seats[index]["isLocked"] = !seats[index]["isLocked"]);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(seats[index]["isMuted"] ? "Unmute" : "Mute", style: const TextStyle(color: Colors.white)),
              onTap: () {
                setState(() => seats[index]["isMuted"] = !seats[index]["isMuted"]);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E193D),
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A1B4E), Color(0xFF141026)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 15 सीटर ग्रिड
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      final seat = seats[index];
                      bool isOccupied = seat["user"] != null;
                      bool isLocked = seat["isLocked"];

                      return GestureDetector(
                        onTap: () => _showMicOptions(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: index == 0 ? Colors.amber : Colors.white24, width: 1.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isLocked ? Icons.lock : (index == 0 ? Icons.star : Icons.mic),
                                color: isLocked ? Colors.redAccent : (index == 0 ? Colors.amber : Colors.white70),
                                size: 22,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isOccupied ? seat["user"] : "${index + 1}",
                                style: const TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // बॉटम चैट और गिफ्ट बटन
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.black38,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Say something...",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent, size: 28),
                      onPressed: _showGiftsDialog,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
