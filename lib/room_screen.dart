import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  // 15 सीटर पार्टी रूम का डेटा (सीट नंबर और यूजर)
  final List<Map<String, dynamic>> seats = List.generate(
    15,
    (i) => {
      "seatNo": i + 1,
      "user": i == 0 ? "Lovepreet (Owner)" : null,
      "isMuted": false,
      "isLocked": false,
    },
  );

  void _onSeatTap(int index) {
    setState(() {
      if (seats[index]["user"] == null) {
        // खाली सीट पर बैठना
        seats[index]["user"] = "User ID: 1059";
      } else {
        // सीट खाली करना (Leave Seat)
        seats[index]["user"] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.amber),
            onPressed: () {
              // रूम सेटिंग्स या एडमिन कंट्रोल्स
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Room Admin Settings Opened")),
              );
            },
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
            // रूम परफोर्मेंस / बैनर इन्फो
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: const [
                  CircleAvatar(radius: 20, backgroundColor: Colors.pinkAccent, child: Icon(Icons.mic, color: Colors.white)),
                  SizedBox(width: 10),
                  Text("PB Official Party\nID: 10590491", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            // 15 सीटर ग्रिड सिस्टम (BoloHi स्टाइल)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  bool isOccupied = seat["user"] != null;
                  return GestureDetector(
                    onTap: () => _onSeatTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isOccupied ? const Color(0xFF1E193D) : Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: index == 0 ? Colors.amber : Colors.pinkAccent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            index == 0 ? Icons.star : Icons.mic,
                            color: index == 0 ? Colors.amber : (isOccupied ? Colors.greenAccent : Colors.white54),
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            seat["user"] ?? "Seat ${index + 1}",
                            style: const TextStyle(fontSize: 10, color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // नीचे चैट और गिफ्टिंग बार
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Say something to party...",
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.pinkAccent),
                    onPressed: () {},
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

