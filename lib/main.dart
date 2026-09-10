import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const PBLiveApp());
}

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live party',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0F051D),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSignIn();
  }

  Future<void> _checkSignIn() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account != null) {
        setState(() {
          _currentUser = account;
        });
      }
    } catch (e) {
      print('Silent sign in error: $e');
    }
  }

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final account = await _googleSignIn.signIn();
      setState(() {
        _currentUser = account;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Sign in failed: $e');
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.amber)),
      );
    }
    if (_currentUser == null) {
      return LoginScreen(onSignIn: _handleSignIn);
    }
    return MainHomeScreen(user: _currentUser!, onSignOut: _handleSignOut);
  }
}

class LoginScreen extends StatelessWidget {
  final VoidCallback onSignIn;
  const LoginScreen({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A0845), Color(0xFF6441A5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mic_rounded, size: 80, color: Colors.amber),
                const SizedBox(height: 20),
                const Text(
                  'PB Live Party',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Voice Chat & Live Rooms',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: onSignIn,
                  icon: const Icon(Icons.login, color: Colors.black),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class MainHomeScreen extends StatefulWidget {
  final GoogleSignInAccount user;
  final VoidCallback onSignOut;

  const MainHomeScreen({super.key, required this.user, required this.onSignOut});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PartyHomeTab(),
    const Center(child: Text('Discover Rooms', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Family & Clan', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Messages', style: TextStyle(color: Colors.white))),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1A0B2E),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Party'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

class PartyHomeTab extends StatelessWidget {
  const PartyHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Party', style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Banner Card
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF8E24AA)]),
              ),
              child: const Center(
                child: Text(
                  '💎 JEWELRY COLLECTOR 💎',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Rankings Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRankCard('Room Ranking', Colors.orange),
                _buildRankCard('CP Ranking', Colors.pinkAccent),
                _buildRankCard('Family', Colors.purpleAccent),
              ],
            ),
            const SizedBox(height: 20),
            // Room Cards Grid / List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF221133),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.mic, color: Colors.black)),
                    title: Text('PB Live Voice Room #${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Join audio party & music', style: TextStyle(color: Colors.white70)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: () {},
                      child: const Text('Join', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard(String title, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFF1F0D3D), borderRadius: BorderRadius.circular(10), border: Border.all(color: color)),
      child: Column(
        children: [
          Icon(Icons.emoji_events, color: color),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('User Profile & Settings', style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}

