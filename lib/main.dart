import 'package:flutter/material.dart';
import 'dart:math';

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
      home: const AuthScreen(),
    );
  }
}

class UserDatabase {
  static final Map<String, Map<String, dynamic>> users = {};

  static String generateUniquePBId() {
    final random = Random();
    int uniqueDigits = 100000 + random.nextInt(900000);
    return '20$uniqueDigits';
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginMode = true;
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  void _authenticate(BuildContext context) {
    String phone = _phoneController.text.trim();
    String pass = _passController.text.trim();

    if (phone.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Mobile Number and Password')),
      );
      return;
    }

    if (isLoginMode) {
      if (UserDatabase.users.containsKey(phone)) {
        if (UserDatabase.users[phone]!['password'] == pass) {
          var userData = UserDatabase.users[phone]!;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeScreen(
                phone: phone,
                pbId: userData['pbId'],
                userName: userData['name'],
                userGender: userData['gender'],
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Password!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Number not registered! Please Register first.')),
        );
      }
    } else {
      if (UserDatabase.users.containsKey(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This number is already registered! Please Login.')),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSetupScreen(phone: phone, password: pass),
          ),
        );
      }
    }
  }

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mic_rounded, size: 80, color: Colors.amber),
                  const SizedBox(height: 20),
                  const Text('PB Live Party', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text('Voice Chat & Live Rooms', style: TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF221133),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF221133),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _authenticate(context),
                      child: Text(
                        isLoginMode ? 'Login' : 'Next (Setup Profile)',
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => setState(() => isLoginMode = !isLoginMode),
                    child: Text(
                      isLoginMode ? "Don't have an account? Register" : "Already have an account? Login",
                      style: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class ProfileSetupScreen extends StatefulWidget {
  final String phone;
  final String password;

  const ProfileSetupScreen({super.key, required this.phone, required this.password});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  String _selectedGender = 'Boy';
  int _selectedAge = 20;

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
                const Text('Create Your Profile', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purpleAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
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
                      if (_nameController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your name')));
                        return;
                      }
                      if (_selectedAge < 18) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be 18 or older!')));
                        return;
                      }

                      String generatedPbId = UserDatabase.generateUniquePBId();

                      UserDatabase.users[widget.phone] = {
                        'password': widget.password,
                        'pbId': generatedPbId,
                        'name': _nameController.text.trim(),
                        'gender': _selectedGender,
                      };

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainHomeScreen(
                            phone: widget.phone,
                            pbId: generatedPbId,
                            userName: _nameController.text.trim(),
                            userGender: _selectedGender,
                          ),
                        ),
                        (route) => false,
                      );
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
  final String phone;
  final String pbId;
  final String userName;
  final String userGender;

  const MainHomeScreen({super.key, required this.phone, required this.pbId, required this.userName, required this.userGender});

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
      ProfileTab(pbId: widget.pbId, phone: widget.phone, userName: widget.userName, userGender: widget.userGender),
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
                    IconButton(
                      icon: const Icon(Icons.add_box, color: Colors.amber),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create Room Feature Triggered!')));
                      },
                    ),
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
  final String pbId;
  final String phone;
  final String userName;
  final String userGender;

  const ProfileTab({super.key, required this.pbId, required this.phone, required this.userName, required this.userGender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(radius: 45, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black)),
          const SizedBox(height: 15),
          Text(userName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PB ID: $pbId', style: const TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.copy, size: 16, color: Colors.white70),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PB ID Copied!')));
                },
              ),
            ],
          ),
          Text('Gender: $userGender', style: const TextStyle(color: Colors.white60, fontSize: 14)),
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
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text('Log Out', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

