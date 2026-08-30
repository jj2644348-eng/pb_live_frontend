import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String title;
  final String myId;

  const RoomScreen({super.key, required this.title, required this.myId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isMic = false;
  final List<String> chats = ["💬 Welcome to Party Room!"];
  final TextEditingController chatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1635),
        title: Text(widget.title, style: const TextStyle(fontSize: 14)),
      ),
      body: Column(
        children: [
          // 8 Mic Seats
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemCount: 8,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B163A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: i == 0 ? Colors.pinkAccent : Colors.deepPurple),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(i == 0 ? Icons.star : Icons.mic_none, color: i == 0 ? Colors.amber : Colors.white70),
                      const SizedBox(height: 4),
                      Text(i == 0 ? "Host" : "Seat ${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
          // Chat List
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF161230), borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (c, idx) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(chats[idx], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
              ),
            ),
          ),
          // Bottom Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFF161230),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(isMic ? Icons.mic : Icons.mic_off, color: isMic ? Colors.green : Colors.red),
                  onPressed: () => setState(() => isMic = !isMic),
                ),
                Expanded(
                  child: TextField(
                    controller: chatCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(hintText: "Type chat...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: () {
                    if (chatCtrl.text.trim().isNotEmpty) {
                      setState(() => chats.add("💬 You: ${chatCtrl.text.trim()}"));
                      chatCtrl.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

