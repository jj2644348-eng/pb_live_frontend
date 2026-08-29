import 'package:flutter/material.dart';
import 'screens/live_room_screen.dart';
import 'controllers/room_controller.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20),
      appBar: AppBar(
        title: const Text("Official Tech Love PB"),
        backgroundColor: const Color(0xFF1A1635),
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1E193D),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.mic, color: Colors.white),
              ),
              title: Text(
                "PB Live Party Room #${index + 1}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Live audio chatting & 8 Mic Seats",
                style: TextStyle(color: Colors.grey),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveRoomScreen(
                        roomTitle: "PB Live Party Room #${index + 1}",
                      ),
                    ),
                  );
                },
                child: const Text("Join", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
