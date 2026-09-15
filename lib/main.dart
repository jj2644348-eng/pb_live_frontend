import 'package:flutter/material.dart';

void main() {
  runApp(const OfficialTechApp());
}

class OfficialTechApp extends StatelessWidget {
  const OfficialTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Official Tech PB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primarySwatch: Colors.pink,
      ),
      home: const VoiceRoomHomePage(),
    );
  }
}
class VoiceRoomHomePage extends StatelessWidget {
  const VoiceRoomHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech PB - Voice Room'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.mic, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Official Tech Love PB',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aapka apna live voice chat room application',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  _buildRoomCard(context, 'Official Tech PB Live Room', 'Active • 5 Speakers'),
                  _buildRoomCard(context, 'Punjabi Music & Shayari', 'Active • 3 Speakers'),
                  _buildRoomCard(context, 'Masti & Fun Club', 'Active • 8 Speakers'),
                ],
              ),
            ),
                        SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Create Voice Room',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(Icons.radio, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.pinkAccent),
        onTap: () {},
      ),
    );
  }
}
