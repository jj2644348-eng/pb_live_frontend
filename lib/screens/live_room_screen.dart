import 'package:flutter/material.dart';
import '../controllers/room_controller.dart';
import '../models/gift_model.dart';

class LiveRoomScreen extends StatefulWidget {
  final String roomTitle;
  const LiveRoomScreen({super.key, required this.roomTitle});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final List<String> messages = ['Room active! Welcome to PB Live Party.'];
  final TextEditingController msgController = TextEditingController();

  void showGiftDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final gifts = Gift.getGiftList();
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Send Gifts", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: gifts.length,
                  itemBuilder: (context, index) {
                    final gift = gifts[index];
                    return InkWell(
                      onTap: () {
                        if (RoomController.sendGift(gift.cost)) {
                          setState(() {
                            messages.add("🎁 Sent ${gift.name} (${gift.cost} 💎)");
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sent ${gift.name}!"), backgroundColor: Colors.purple),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Not enough diamonds!"), backgroundColor: Colors.red),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2456),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(gift.icon, style: const TextStyle(fontSize: 28)),
                            Text(gift.name, style: const TextStyle(color: Colors.white, fontSize: 12)),
                            Text("${gift.cost} 💎", style: const TextStyle(color: Colors.amber, fontSize: 11)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        title: Text(widget.roomTitle),
        backgroundColor: const Color(0xFF1A1635),
        actions: [
          IconButton(
            icon: Icon(RoomController.areSeatsLocked ? Icons.lock : Icons.lock_open),
            onPressed: () {
              setState(() {
                RoomController.toggleSeatLock();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(RoomController.areSeatsLocked ? "Seats Locked" : "Seats Unlocked")),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 8 Mic Seats Grid
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B163A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: index == 0 ? Colors.pinkAccent : Colors.deepPurple,
                      width: index == 0 ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0 ? Icons.star : Icons.mic_none,
                        color: index == 0 ? Colors.amber : Colors.white70,
                        size: 26,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        index == 0 ? "Host" : "Seat ${index + 1}",
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Room Chat List
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF161230),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    messages[index],
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Bar (Mic, Gift, Message Input)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFF161230),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    RoomController.isMicOn ? Icons.mic : Icons.mic_off,
                    color: RoomController.isMicOn ? Colors.green : Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      RoomController.toggleMic();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.card_giftcard, color: Colors.amber),
                  onPressed: showGiftDialog,
                ),
                Expanded(
                  child: TextField(
                    controller: msgController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    if (msgController.text.trim().isNotEmpty) {
                      setState(() {
                        messages.add("💬 You: ${msgController.text.trim()}");
                        msgController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

