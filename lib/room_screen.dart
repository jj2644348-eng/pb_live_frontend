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
      "user": i == 0 ? "Lovepreet (Owner)" : (i == 1 ? "Rani PB" : null),
      "id": i == 0 ? "10590491" : (i == 1 ? "2048501" : null),
      "isMuted": false,
    },
  );

  // यूजर प्रोफाइल और फॉलो/रिपोर्ट पॉपअप दिखाने के लिए
  void _showUserProfileModal(String userName, String userId) {
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
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.pinkAccent,
              child: Text(userName[0], style: const TextStyle(fontSize: 24, color: Colors.white)),
            ),
            const SizedBox(height: 10),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You are now following $userName")),
                    );
                  },
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                  icon: const Icon(Icons.report, color: Colors.red, size: 16),
                  label: const Text("Report / Block", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User reported to Admin")),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _handleSeatAction(int index) {
    setState(() {
      if (seats[index]["user"] == null) {
        seats[index]["user"] = "Lovepreet (Me)";
        seats[index]["id"] = "10590491";
        seats[index]["isMuted"] = false;
      } else {
        bool currentMute = seats[index]["isMuted"];
        seats[index]["isMuted"] = !currentMute;
      }
    });
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
              child: Row(
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.pinkAccent, size: 18),
                  SizedBox(width: 4),
                  Text("1.2K", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
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
            // रूम की ऊपर की पट्टी (Info & Notice)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.black45,
              child: Row(
                children: const [
                  CircleAvatar(radius: 16, backgroundColor: Colors.amber, child: Icon(Icons.mic, color: Colors.black, size: 16)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Welcome to PB Official Party! Respect everyone & enjoy music.",
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // 15 सीटर ग्रिड सिस्टम (प्रोफेशनल साइज में)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  bool isOccupied = seat["user"] != null;
                  bool isMuted = seat["isMuted"];

                  return GestureDetector(
                    onTap: () {
                      if (isOccupied) {
                        _showUserProfileModal(seat["user"], seat["id"] ?? "1000");
                      } else {
                        _handleSeatAction(index);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isOccupied ? const Color(0xFF1E193D) : Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: index == 0 ? Colors.amber : Colors.pinkAccent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: isOccupied ? Colors.pinkAccent.withOpacity(0.3) : Colors.white24,
                                child: Icon(
                                  index == 0 ? Icons.star : Icons.person,
                                  color: index == 0 ? Colors.amber : Colors.white,
                                  size: 22,
                                ),
                              ),
                              if (isMuted && isOccupied)
                                const CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.mic_off, size: 10, color: Colors.white),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            seat["user"] ?? "Seat ${index + 1}",
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
            // चैट और कमेंट एंट्री बॉक्स
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Say something to room...",
                        hintStyle: const TextStyle(fontSize: 12, color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.purpleAccent),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gifts: Rose, Car, Diamond opened!")),
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

