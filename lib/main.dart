import 'package:flutter/material.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PB Live Party',
      theme: ThemeData.dark(),
      home: const LiveRoomsPage(),
    );
  }
}

class LiveRoomsPage extends StatelessWidget {
  const LiveRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech Love PB'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.mic, color: Colors.white),
              ),
              title: Text('PB Live Party Room #${index + 1}'),
              subtitle: const Text('Live audio chatting & room active...'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text('Join'),
              ),
            ),
          );
        },
      ),
    );
  }
}
