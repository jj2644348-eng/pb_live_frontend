import 'package:flutter/material.dart';

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
      // ऐप खुलते ही सीधी प्रोफ़ाइल स्क्रीन दिखेगी
      home: const ProfileScreen(), 
    );
  }
}

// ==================== PROFILE & NAVIGATION SCREEN ====================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- Demo Data ---
  String userName = "lij";
  String userId = "10350359";
  String country = "India";
  int userLevel = 1;
  int userAge = 18;
  int myDiamonds = 20000;
  bool isHost = false; 

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF100525);      // डार्क पर्पल बैकग्राउंड
    const Color cardColor = Color(0xFF1A0D33);    // कार्ड का रंग
    const Color accentColor = Color(0xFFFF00FF);  // पिंक हाइलाइट रंग

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              print("Settings Tapped");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Profile Header
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print("Edit Profile Picture Tapped");
                          },
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
                        Text(
                          userName,
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "ID:$userId",
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.copy, size: 12, color: Colors.grey),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildTag(Icons.location_on, country),
                            const SizedBox(width: 8),
                            _buildTag(Icons.star, "Level $userLevel"),
                            const SizedBox(width: 8),
                            _buildTag(Icons.male, "$userAge"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Stats
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Following", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Fans", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                  Column(children: [Text("0", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Blocked User", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                ],
              ),
              const SizedBox(height: 24),

              // 3. My Diamonds & Wallet
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
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
                      onPressed: () {
                        print("My Wallet Tapped");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("My Wallet", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. Become Host
              _buildActionCard(
                icon: Icons.mic,
                title: isHost ? "Live Studio" : "Become Host",
                subtitle: "Turn your passion into profit-become a host and start earning today.",
                onTap: () {
                  print("Host Action Tapped");
                },
              ),
              const SizedBox(height: 16),

              // 5. Grid Icons
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

              // 6. Offline Recharge
              _buildListTile(icon: Icons.flash_on, title: "Offline Recharge"),
              const SizedBox(height: 8),

              // 7. My Posts
              _buildListTile(icon: Icons.photo_album, title: "My Posts"),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // --- CUSTOM BOTTOM NAVIGATION BAR WITH PLUS BUTTON ---
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
            const Icon(Icons.home, color: Colors.grey, size: 30),
            const Icon(Icons.explore, color: Colors.grey, size: 30),
            
            // बीच में रूम क्रिएट करने का प्लस (+) बटन
            SizedBox(
              width: 55,
              height: 55,
              child: FloatingActionButton(
                onPressed: () {
                  _showCreateRoomDialog(context);
                },
                backgroundColor: accentColor,
                elevation: 4,
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
            
            const Icon(Icons.message, color: Colors.grey, size: 30),
            const Icon(Icons.person, color: accentColor, size: 30), // मी टैब सिलेक्टेड
          ],
        ),
      ),
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.grey),
          const SizedBox(width: 2),
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0D33),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildGridIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF1A0D33),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.amber, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildListTile({required IconData icon, required String title}) {
    return ListTile(
      onTap: () {},
      tileColor: const Color(0xFF1A0D33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }

  // प्लस बटन दबाने पर रूम क्रिएट करने का ऑप्शन पॉप-अप होगा
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
                leading: const Icon(Icons.mic, color: Colors.white),
                title: const Text("Audio Room", style: TextStyle(color: Colors.white)),
                onTap: () {
                   Navigator.pop(context);
                   print("Create Audio Room");
                },
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.white),
                title: const Text("Video Live", style: TextStyle(color: Colors.white)),
                onTap: () {
                   Navigator.pop(context);
                   print("Create Video Live");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

