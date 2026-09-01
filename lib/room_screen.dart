import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  // यहाँ से आप सीट्स की संख्या बदल सकते हैं (जैसे 8, 15 या 20)
  final int totalSeats = 15; 
  late List<Map<String, dynamic>> seats;

  // लाइव चैट और एंट्री का डेटा
  final List<String> chatMessages = [
    "System: Welcome to PB Official Party! 🎉",
    "Rani PB entered the room.",
    "Lovepreet: Hello everyone! Welcome."
  ];
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    seats = List.generate(
      totalSeats,
      (i) => {
        "seatNo": i + 1,
        "user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "Rani PB" : null),
        "id": i == 0 ? "10590491" : (i == 1 ? "2048501" : null),
        "isMuted": false,
      },
    );
  }

  // यूजर प्रोफाइल और गिफ्ट/फॉलो मेनू
  void _showUserModal(String userName, String userId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            Text("ID: $userId | VIP 6", style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  icon: const Icon(Icons.person_add, size: 16),
                  label: const Text("Follow"),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Followed $userName")));
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                  icon: const Icon(Icons.card_giftcard, size: 16),
                  label: const Text("Send Gift"),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showGiftingDialog(userName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // गिफ्टिंग सेंड करने का डायलॉग बॉक्स
  void _showGiftingDialog(String targetUser) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E193D),
        title: Text("Send Gift to $targetUser", style: const TextStyle(color: Colors.amber, fontSize: 16)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _giftItem("🌹 Rose", "10 Coins", targetUser),
            _giftItem("🏎️ Sports Car", "500 Coins", targetUser),
            _giftItem("💎 Diamond", "1000 Coins", targetUser),
          ],
        ),
      ),
    );
  }

  Widget _giftItem(String name, String price, String target) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          chatMessages.add("🎁 Lovepreet sent $name to $target!");
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sent $name successfully!")));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 5),
          Text(price, style: const TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_msgController.text.trim().isNotEmpty) {
      setState(() {
        chatMessages.add("Lovepreet: ${_msgController.text.trim()}");
        _msgController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber, fontSize: 16)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("Seats: $totalSeats", style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1B4E), Color(0xFF141026)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // कॉम्पैक्ट सीट्स ग्रिड (छोटा और साफ़ साइज)
            SizedBox(
              height: 240,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: totalSeats > 10 ? 5 : 4, // सीट्स के हिसाब से कॉलम सेट होंगे
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemCount: totalSeats,
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  bool occupied = seat["user"] != null;
                  return GestureDetector(
                    onTap: () {
                      if (occupied) {
                        _showUserModal(seat["user"], seat["id"]);
                      } else {
                        setState(() {
                          seats[index]["user"] = "Lovepreet (Me)";
                          seats[index]["id"] = "10590491";
                          chatMessages.add("Lovepreet took Seat ${index + 1}");
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: occupied ? const Color(0xFF1E193D) : Colors.white10,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: index == 0 ? Colors.amber : Colors.pinkAccent, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            index == 0 ? Icons.star : Icons.mic,
                            color: index == 0 ? Colors.amber : (occupied ? Colors.greenAccent : Colors.white38),
                            size: 20,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            seat["user"] ?? "${index + 1}",
                            style: const TextStyle(fontSize: 8, color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // लाइव चैट और एंट्री फीड (बीच का स्पेस)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        chatMessages[index],
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    );
                  },
                ),
              ),
            ),

            // नीचे माइक, चैट और गिफ्टिंग बार
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black87,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.greenAccent),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Main Mic Toggled")));
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: "Say something...",
                        hintStyle: const TextStyle(fontSize: 11, color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent),
                    onPressed: () => _showGiftingDialog("Room General"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.pinkAccent),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

