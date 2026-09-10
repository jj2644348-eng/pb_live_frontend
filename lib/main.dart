import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

class UserModel {
  String phone;
  String password;
  String pbId;
  String name;
  String gender;
  String profileImagePath;
  int coins;

  UserModel({
    required this.phone,
    required this.password,
    required this.pbId,
    required this.name,
    required this.gender,
    this.profileImagePath = '',
    this.coins = 0,
  });
}

class UserDatabase {
  static final Map<String, UserModel> users = {};

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
        if (UserDatabase.users[phone]!.password == pass) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeScreen(currentUserPhone: phone),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Password! Please check.')),
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
  String _imagePath = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
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
                const Text('Create Your Profile', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.purpleAccent,
                        backgroundImage: _imagePath.isNotEmpty ? FileImage(File(_imagePath)) : null,
                        child: _imagePath.isEmpty ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
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

                      UserDatabase.users[widget.phone] = UserModel(
                        phone: widget.phone,
                        password: widget.password,
                        pbId: generatedPbId,
                        name: _nameController.text.trim(),
                        gender: _selectedGender,
                        profileImagePath: _imagePath,
                        coins: 0,
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainHomeScreen(currentUserPhone: widget.phone),
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

class WalletScreen extends StatelessWidget {
  final String phone;
  const WalletScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    UserModel user = UserDatabase.users[phone]!;

    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B2E),
        title: const Text('My Wallet & Coins', style: TextStyle(color: Colors.amber)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF221133),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      SizedBox(height: 5),
                      Text('PB Coins', style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber, size: 30),
                      const SizedBox(width: 8),
                      Text('${user.coins}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recharge Official Partner', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    tileColor: const Color(0xFF221133),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    leading: const Icon(Icons.phone_android, color: Colors.amber),
                    title: const Text('Recharge Helpline (WhatsApp / Call)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: const Text('9779353560', style: TextStyle(color: Colors.amberAccent, fontSize: 16)),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contact Official Number: 9779353560 for Coin Recharge')),
                        );
                      },
                      child: const Text('Contact', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CreateRoomScreen extends StatefulWidget {
  final String roomOwnerName;
  const CreateRoomScreen({super.key, required this.roomOwnerName});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _roomNameController = TextEditingController();
  String _selectedTheme = '🎵 Music & Chill Party';

  final List<String> themes = [
    '🎵 Music & Chill Party',
    '💬 Shayari & Gossip',
    '🎉 Weekend Dhamaka',
    '🎤 Singing Battle'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B2E),
        title: const Text('Create Live Room', style: TextStyle(color: Colors.amber)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Room Name / Title', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: _roomNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'e.g. PB Official Party Hub',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF221133),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select Room Theme / Banner', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTheme,
              dropdownColor: const Color(0xFF221133),
              style: const TextStyle(color: Colors.white),
              items: themes.map((theme) {
                return DropdownMenuItem(value: theme, child: Text(theme));
              }).toList(),
              onChanged: (val) => setState(() => _selectedTheme = val!),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF221133),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.all(15)),
                onPressed: () {
                  String roomName = _roomNameController.text.trim();
                  if (roomName.isEmpty) {
                    roomName = "${widget.roomOwnerName}'s Party Room";
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveRoomScreen(roomTitle: roomName, roomTheme: _selectedTheme),
                    ),
                  );
                },
                child: const Text('Go Live Now', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveRoomScreen extends StatefulWidget {
  final String roomTitle;
  final String roomTheme;

  const LiveRoomScreen({super.key, required this.roomTitle, required this.roomTheme});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  bool isPlayingMusic = false;
  String currentSong = 'No Song Playing';

  final List<String> phoneSongs = [
    'Desi Punjabi Beat.mp3',
    'Romantic Love Mashup.mp3',
    'Party Night Club Mix.mp3',
    'Sad Lo-Fi Beats.mp3'
  ];

  void _showSongPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF221133),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Song from Phone Storage', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                itemCount: phoneSongs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.music_note, color: Colors.amber),
                    title: Text(phoneSongs[index], style: const TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.play_arrow, color: Colors.white),
                    onTap: () {
                      setState(() {
                        currentSong = phoneSongs[index];
                        isPlayingMusic = true;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playing: ${phoneSongs[index]} in Room')));
                    },
                  );
                },
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
      backgroundColor: const Color(0xFF0F051D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B2E),
        title: Text(widget.roomTitle, style: const TextStyle(color: Colors.amber, fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(isPlayingMusic ? Icons.music_note : Icons.music_off, color: isPlayingMusic ? Colors.amberAccent : Colors.white54),
            onPressed: _showSongPicker,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF221133), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.spatial_audio, color: Colors.amber),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Theme: ${widget.roomTheme}\nNow Playing: $currentSong', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ),
                  if (isPlayingMusic)
                    IconButton(
                      icon: const Icon(Icons.stop, color: Colors.redAccent),
                      onPressed: () => setState(() {
                        isPlayingMusic = false;
                        currentSong = 'Stopped';
                      }),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('Mic Seating (9 Seats)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF221133),
                      shape: BoxShape.circle,
                      border: Border.all(color: index == 0 ? Colors.amber : Colors.purpleAccent, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(index == 0 ? Icons.mic : Icons.mic_none, color: index == 0 ? Colors.amber : Colors.white54, size: 28),
                        const SizedBox(height: 4),
                        Text(index == 0 ? 'Owner' : 'Seat ${index + 1}', style: const TextStyle(color: Colors.white60, fontSize: 10)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: _showSongPicker,
                    icon: const Icon(Icons.library_music, color: Colors.black),
                    label: const Text('Play Phone Music', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  final String currentUserPhone;
  const MainHomeScreen({super.key, required this.currentUserPhone});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserModel user = UserDatabase.users[widget.currentUserPhone]!;

    final List<Widget> pages = [
      PartyHomeTab(userPhone: widget.currentUserPhone, userName: user.name),
      const Center(child: Text('Discover Rooms', style: TextStyle(color: Colors.white, fontSize: 18))),
      const Center(child: Text('Family & Clan', style: TextStyle(color: Colors.white, fontSize: 18))),
      const Center(child: Text('Messages', style: TextStyle(color: Colors.white, fontSize: 18))),
      ProfileTab(userPhone: widget.currentUserPhone),
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
  final String userPhone;
  final String userName;
  const PartyHomeTab({super.key, required this.userPhone, required this.userName});

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateRoomScreen(roomOwnerName: userName),
                          ),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LiveRoomScreen(roomTitle: 'PB Party Room #${index + 1}', roomTheme: 'General Voice Chat'),
                          ),
                        );
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

class ProfileTab extends StatefulWidget {
  final String userPhone;
  const ProfileTab({super.key, required this.userPhone});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<void> _changeProfilePic() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        UserDatabase.users[widget.userPhone]!.profileImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = UserDatabase.users[widget.userPhone]!;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.amber,
                backgroundImage: user.profileImagePath.isNotEmpty ? FileImage(File(user.profileImagePath)) : null,
                child: user.profileImagePath.isEmpty ? const Icon(Icons.person, size: 50, color: Colors.black) : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.purpleAccent,
                  radius: 16,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    onPressed: _changeProfilePic,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(user.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PB ID: ${user.pbId}', style: const TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.copy, size: 16, color: Colors.white70),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PB ID Copied!')));
                },
              ),
            ],
          ),
          Text('Gender: ${user.gender}', style: const TextStyle(color: Colors.white60, fontSize: 14)),
          const SizedBox(height: 25),
          ListTile(
            tileColor: const Color(0xFF221133),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.wallet, color: Colors.amber),
            title: const Text('My Wallet & Coins', style: TextStyle(color: Colors.white)),
            subtitle: Text('${user.coins} Coins Available', style: const TextStyle(color: Colors.white60)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScreen(phone: widget.userPhone)),
              ).then((_) => setState(() {}));
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: const Color(0xFF221133),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.settings, color: Colors.amber),
            title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
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

