import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ==================== MAIN APP WITH BOTTOM NAV ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 4; // डिफ़ॉल्ट 'Me' टैब खुला रहेगा

  final List<Widget> _screens = [
    const Center(child: Text("Home Screen", style: TextStyle(color: Colors.white, fontSize: 20))),
    const Center(child: Text("Explore/Discover", style: TextStyle(color: Colors.white, fontSize: 20))),
    const SizedBox.shrink(), // बीच का प्लस बटन (अलग से हैंडल होगा)
    const Center(child: Text("Messages", style: TextStyle(color: Colors.white, fontSize: 20))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFFF00FF);

    return Scaffold(
      backgroundColor: const Color(0xFF100525),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF1A0D33),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home, color: _currentIndex == 0 ? accentColor : Colors.grey, size: 30), onPressed: () => setState(() => _currentIndex = 0)),
            IconButton(icon: Icon(Icons.explore, color: _currentIndex == 1 ? accentColor : Colors.grey, size: 30), onPressed: () => setState(() => _currentIndex = 1)),
            
            // बीच का प्लस (+) बटन - रूम क्रिएट करने के लिए
            SizedBox(
              width: 55,
              height: 55,
              child: FloatingActionButton(
                onPressed: () => _showCreateRoomDialog(context),
                backgroundColor: accentColor,
                elevation: 4,
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
            
            IconButton(icon: Icon(Icons.message, color: _currentIndex == 3 ? accentColor : Colors.grey, size: 30), onPressed: () => setState(() => _currentIndex = 3)),
            IconButton(icon: Icon(Icons.person, color: _currentIndex == 4 ? accentColor : Colors.grey, size: 30), onPressed: () => setState(() => _currentIndex = 4)),
          ],
        ),
      ),
    );
  }

  void _showCreateRoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A0D33),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Create a Room", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.mic, color: Colors.pinkAccent),
                title: const Text("12-Seat Audio Room", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TwelveSeatRoomScreen()),
                  );
                },
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.pinkAccent),
                title: const Text("Video Live", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==================== PROFILE SCREEN ====================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "lij";
  String userId = "10350359";
  File? _imageFile; // प्रोफाइल डीपी के लिए फाइल वेरिएबल

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFF1A0D33);
    const Color accentColor = Color(0xFFFF00FF);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header with DP Change Option
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage, // यहाँ क्लिक करने से गैलरी खुलेगी और फोटो बदलेगी
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: accentColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("ID:$userId", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildTag(Icons.location_on, "India"),
                            const SizedBox(width: 8),
                            _buildTag(Icons.star, "Level 1"),
                            const SizedBox(width: 8),
                            _buildTag(Icons.male, "18"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Following", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Fans", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Blocked User", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.amber, size: 28),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My Diamonds", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text("20K", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: accentColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child: const Text("My Wallet", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildListTile(Icons.mic, "Become Host", "Turn your passion into profit."),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildGridIcon(Icons.handshake, "Agency Center"),
                  _buildGridIcon(Icons.people_alt, "BD Center"),
                  _buildGridIcon(Icons.mic_external_on, "Host Center"),
                  _buildGridIcon(Icons.workspace_premium, "Become VIP"),
                ],
              ),
              const SizedBox(height: 16),
              _buildSimpleTile(Icons.flash_on, "Offline Recharge"),
              const SizedBox(height: 8),
              _buildSimpleTile(Icons.photo_album, "My Posts"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
      child: Row(children: [Icon(icon, size: 12, color: Colors.grey), const SizedBox(width: 2), Text(text, style: const TextStyle(color: Colors.grey, fontSize: 10))]),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A0D33), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber, size: 40),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12))])),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildGridIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFF1A0D33), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.amber, size: 28)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildSimpleTile(IconData icon, String title) {
    return ListTile(
      onTap: () {},
      tileColor: const Color(0xFF1A0D33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }
}

// ==================== 12-SEAT ROOM SCREEN ====================
class TwelveSeatRoomScreen extends StatelessWidget {
  const TwelveSeatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120826),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Official Party Room (12 Seats)", style: TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 12 सीट्स का ग्रिड (4 कॉलम और 3 पंक्तियाँ)
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // एक लाइन में 4 सीटें
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.pinkAccent, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text("Mic Open", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  );
                },
              ),
            ),
            // नीचे चैट और गिफ़्ट भेजने का ऑप्शन
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              color: Colors.black26,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Say something...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent, size: 30),
                    onPressed: () {},
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

