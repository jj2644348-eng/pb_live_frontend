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
  bool _isProfileComplete = false;

  String userName = '';
  String userGender = 'Boy';
  int userAge = 18;

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final account = await _googleSignIn.signIn();
      setState(() {
        _currentUser = account;
        if (account != null) {
          userName = account.displayName ?? '';
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Error: $e')),
      );
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    setState(() {
      _currentUser = null;
      _isProfileComplete = false;
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
    if (!_isProfileComplete) {
      return ProfileSetupScreen(
        initialName: userName,
        onComplete: (name, gender, age) {
          setState(() {
            userName = name;
            userGender = gender;
            userAge = age;
            _isProfileComplete = true;
          });
        },
      );
    }
    return MainHomeScreen(
      userEmail: _currentUser!.email,
      userName: userName,
      userGender: userGender,
      onSignOut: _handleSignOut,
    );
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
                const Text('PB Live Party', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 10),
                const Text('Voice Chat & Live Rooms', style: TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: onSignIn,
                  icon: const Icon(Icons.login, color: Colors.black),
                  label: const Text('Sign in with Google', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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

class ProfileSetupScreen extends StatefulWidget {
  final String initialName;
  final Function(String, String, int) onComplete;

  const ProfileSetupScreen({super.key, required this.initialName, required this.onComplete});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  late TextEditingController _nameController;
  String _selectedGender = 'Boy';
  int _selectedAge = 20;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15082E),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Complete Your Profile', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(radius: 50, backgroundColor: Colors.purpleAccent, child: Icon(Icons.person, size: 50, color: Colors.white)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('DP upload simulated!')));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Your Name', style: TextStyle(color: Colors.white70)),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF221133),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Select Gender', style: TextStyle(color: Colors.white70)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Boy', style: TextStyle(color: Colors.white)),
                        value: 'Boy',
                        groupValue: _selectedGender,
                        onChanged: (val) => setState(() => _selectedGender = val!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Girl', style: TextStyle(color: Colors.white)),
                        value: 'Girl',
                        groupValue: _selectedGender,
                        onChanged: (val) => setState(() => _selectedGender = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Confirm Age (Must be 18+)', style: TextStyle(color: Colors.white70)),
                Slider(
                  value: _selectedAge.toDouble(),
                  min: 16,
                  max: 60,
                  divisions: 44,
                  activeColor: Colors.amber,
                  label: '$_selectedAge Years',
                  onChanged: (val) => setState(() => _selectedAge = val.toInt()),
                ),
                Center(child: Text('Age: $_selectedAge Years', style: const TextStyle(color: Colors.amber, fontSize: 16))),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.all(15)),
                    onPressed: () {
                      if (_selectedAge < 18) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be 18 or older to use PB Live!')));
                        return;
                      }
                      widget.onComplete(_nameController.text, _selectedGender, _selectedAge);
                    },
                    child: const Text('Save & Enter App', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
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
  final String userEmail;
  final String userName;
  final String userGender;
  final VoidCallback onSignOut;

  const MainHomeScreen({super.key, required this.userEmail, required this.userName, required this.userGender, required this.onSignOut});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      PartyHomeTab(userName: widget.userName),
      const Center(child: Text('Discover Rooms', style: TextStyle(color: Colors.white, fontSize: 18))),
      const Center(child: Text('Family & Clan', style: TextStyle(color: Colors.white, fontSize: 18))),
      const Center(child: Text('Messages', style: TextStyle(color: Colors.white, fontSize: 18))),
      ProfileTab(userName: widget.userName, userEmail: widget.userEmail, userGender: widget.userGender, onSignOut: widget.onSignOut),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      body: SafeArea(child: pages[_currentIndex]),
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
  final String userName;
  const PartyHomeTab({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello, $userName', style: const TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.add_box, color: Colors.amber), onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create Room Feature Triggered!')));
                    }),
                    IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF8E24AA)]),
              ),
              child: const Center(
                child: Text('💎 JEWELRY COLLECTOR EVENT 💎', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Live Rooms Online', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF221133),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.mic, color: Colors.black)),
                    title: Text('PB Party Room #${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Music, Chat & Fun Seating', style: TextStyle(color: Colors.white70)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Joining Room #${index + 1}...')));
                      },
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
}

class ProfileTab extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userGender;
  final VoidCallback onSignOut;

  const ProfileTab({super.key, required this.userName, required this.userEmail, required this.userGender, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(radius: 45, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
          const SizedBox(height: 15),
          Text(userName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(userEmail, style: const TextStyle(color: Colors.white60, fontSize: 14)),
          Text('Gender: $userGender', style: const TextStyle(color: Colors.amber, fontSize: 14)),
          const SizedBox(height: 30),
          ListTile(
            tileColor: const Color(0xFF221133),
            leading: const Icon(Icons.settings, color: Colors.amber),
            title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: const Color(0xFF221133),
            leading: const Icon(Icons.wallet, color: Colors.amber),
            title: const Text('My Wallet & Coins', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
            onTap: () {},
          ),
          const Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size(double.infinity, 50)),
            onPressed: onSignOut,
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text('Log Out', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

