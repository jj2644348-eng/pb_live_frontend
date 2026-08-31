import 'package:flutter/material.dart';

class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  final int seatCount;
  const PartyRoomScreen({super.key, required this.roomName, required this.seatCount});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  late List<Map<String, dynamic>> seats;
  final List<String> roomMessages = ["Welcome to the party room! 🎉"];
  final TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    seats = List.generate(widget.seatCount, (index) => {
      "seatNo": index + 1,
      "user": index == 0 ? "0001 (Owner)" : null,
      "isMuted": false,
    });
  }

  void sendMessage() {
    if (chatController.text.trim().isNotEmpty) {
      setState(() {
        roomMessages.add("You: ${chatController.text.trim()}");
      });
      chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.music_note, color: Colors.amber),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Offline Music Player Playing!"))),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2A1B4E), Color(0xFF141026)]),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemCount: widget.seatCount,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: index == 0 ? Colors.amber : Colors.white24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(index == 0 ? Icons.star : Icons.mic, color: index == 0 ? Colors.amber : Colors.white70),
                          const SizedBox(height: 4),
                          Text(seat["user"] ?? "Seat ${index + 1}", style: const TextStyle(fontSize: 10, color: Colors.white70), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.black26,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: roomMessages.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(roomMessages[index], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatController,
                            decoration: const InputDecoration(hintText: "Say something to everyone...", hintStyle: TextStyle(color: Colors.white38)),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: sendMessage),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

