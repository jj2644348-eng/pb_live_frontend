import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(const PBPartyApp());

class PBPartyApp extends StatelessWidget {
  const PBPartyApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF131124),
      primaryColor: Colors.pinkAccent,
    ),
    home: const MainNav(),
  );
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int tab = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: [
      const HomePage(),
      const Center(child: Text("Family & Squads", style: TextStyle(color: Colors.white70, fontSize: 16))),
      const Center(child: Text("My Profile & Wallet", style: TextStyle(color: Colors.white70, fontSize: 16))),
    ][tab],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tab,
      onTap: (v) => setState(() => tab = v),
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.white54,
      backgroundColor: const Color(0xFF0D0B18),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Club"),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
      ],
    ),
  );
}

