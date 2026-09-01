import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String roomName;
  const RoomScreen({super.key, required this.roomName});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  // 15 सीटर पार्टी रूम का डेटा
  final List<Map<String, dynamic>> seats = List.generate(
    15,
    (i) => {
      "seatNo": i + 1,
      "user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "User 1059" : null),
      "isMuted": false,
    },
  );

  // सीट पर क्लिक करने पर एक्शन (बैठना, माइक ऑन/ऑफ करना)
  void _handleSeatAction(int index) {
    setState(() {
      if (seats[index]["user"] == null) {
        // खाली सीट पर बैठना
        seats[index]["user"] = "My ID: 1059";
        seats[index]["isMuted"] = false;
      } else {
        // अगर पहले से बैठे हैं, तो माइक ऑन/ऑफ टॉगल करें या सीट छोड़ें
        bool currentMute = seats[index]["isMuted"];
        seats[index]["isMuted"] = !currentMute;
      }
    });
  }

  // एडमिन द्वारा किसी का भी माइक बंद (Force Mute) करना
  void _adminForceMute(int index) {
    setState(() {
      if (seats[index]["user"] != null) {
        seats[index]["isMuted"] = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Admin muted Seat ${index + 1}")),
        );
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
            icon: const Icon(Icons.mic, color: Colors.greenAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Main Mic Toggled")),
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
            // रूम की ऊपर की पट्टी (Info & Rules)
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black45,
              child: Row(
                children: const [
                  CircleAvatar(radius: 18, backgroundColor: Colors.pinkAccent, child: Icon(Icons.spatial_audio, color: Colors.white, size: 18)),
                  SizedBox(width: 8),
                  Text("PB Official Party Hub\nID: 10590491", style: TextStyle(fontSize: 11, color: Colors.white70)),
                  Spacer(),
                  Chip(
                    backgroundColor: Colors.amber,
                    label: Text("VIP 6 Room", style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            // 15 सीटर ग्रिड सिस्टम
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
                  bool isMuted = seat["isMuted"];

                  return GestureDetector(
                    onTap: () => _handleSeatAction(index),
                    onLongPress: () => _adminForceMute(index), // एडमिन लॉन्ग-प्रेस करके किसी को भी म्यूट कर सकता है
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
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(
                                index == 0 ? Icons.star : Icons.mic,
                                color: index == 0 ? Colors.amber : (isOccupied ? (isMuted ? Colors.red : Colors.greenAccent) : Colors.white54),
                                size: 28,
                              ),
                              if (isMuted && isOccupied)
                                const Icon(Icons.mic_off, color: Colors.red, size: 14),
                            ],
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gift Panel Opened (Rose, Car, Diamond)")),
                      );
                    },
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

