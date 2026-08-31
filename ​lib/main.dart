import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'owner_panel_screen.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Official Tech Love PB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF141026),
        primarySwatch: Colors.purple,
      ),
      home: const MainContainerScreen(),
    );
  }
}

class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({super.key});

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Chats Screen", style: TextStyle(color: Colors.white, fontSize: 18))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E193D),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      // ओनर पैनल खोलने के लिए स्पेशल बटन
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.admin_panel_settings, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OwnerPanelScreen()),
          );
        },
      ),
    );
  }
}

