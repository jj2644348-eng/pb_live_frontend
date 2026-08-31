import 'package:flutter/material.dart';

class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  const PartyRoomScreen({super.key, required this.roomName});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(8, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "0001 (Owner)" : null,
    "isMuted": false,
    "isLocked": false,
  });

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
              title: const Text("Give the Mic", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(ctx),
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
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(backgroundColor: Colors.amber, radius: 18, child: Icon(Icons.person, color: Colors.black)),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("0001 (Owner)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            Text("Official Room", style: TextStyle(color: Colors.white60, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    bool isOccupied = seat["user"] != null;
                    bool isLocked = seat["isLocked"];

                    return GestureDetector(
                      onTap: () => _showMicOptions(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: index == 0 ? Colors.amber : Colors.white24, width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isLocked ? Icons.lock : (index == 0 ? Icons.star : Icons.mic),
                              color: isLocked ? Colors.redAccent : (index == 0 ? Colors.amber : Colors.white70),
                              size: 26,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isOccupied ? seat["user"] : "${index + 1}",
                              style: const TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

