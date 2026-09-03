import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- Demo Data (यह डेटा Backend/API से आएगा) ---
  String userName = "lij";
  String userId = "10350359";
  String country = "India";
  int userLevel = 1;
  int userAge = 18;
  int followingCount = 0;
  int fansCount = 0;
  int blockedCount = 0;
  int myDiamonds = 20000;
  bool isHost = false; // यह लॉजिक तय करेगा कि "Become Host" दिखाना है या "Live Studio"
  // --------------------------------------------

  @override
  Widget build(BuildContext context) {
    // स्क्रीन का ओवरऑल बैकग्राउंड कलर
    const Color bgColor = Color(0xFF100525);
    // कार्ड्स और कंटेनर्स का बैकग्राउंड कलर
    const Color cardColor = Color(0xFF1A0D33);
    // हाइलाइट कलर (डायमंड और प्लस बटन के लिए)
    const Color accentColor = Color(0xFFFF00FF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // वापस जाएं
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // सेटिंग स्क्रीन पर जाएं
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
              // 1. Profile Header (Image, Name, ID, Level)
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        // यहाँ नेटवर्क इमेज आएगी: NetworkImage(userProfilePicUrl)
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // एडिट प्रोफाइल लॉजिक
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
                            GestureDetector(
                              onTap: () {
                                // आईडी कॉपी करें
                                print("Copy ID Tapped");
                              },
                              child: const Icon(Icons.copy, size: 12, color: Colors.grey),
                            ),
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

              // 2. Stats (Following, Fans, Blocked)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("$followingCount", "Following"),
                  _buildStatItem("$fansCount", "Fans"),
                  _buildStatItem("$blockedCount", "Blocked User"),
                ],
              ),
              const SizedBox(height: 24),

              // 3. My Diamonds & Wallet Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/diamond_icon.png', width: 24, height: 24), // अपना एसेट इमेज लगाएं
                        const SizedBox(width: 8),
                        const Column(
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
                        // My Wallet पर जाएं
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

              // 4. Become Host / Live Studio
              _buildActionCard(
                icon: Icons.mic,
                title: isHost ? "Live Studio" : "Become Host",
                subtitle: isHost ? "Start your live stream now." : "Turn your passion into profit-become a host and start earning today.",
                onTap: () {
                  print("Host Action Tapped");
                },
              ),
              const SizedBox(height: 16),

              // 5. Grid Icons (Agency Center, BD Center, Host Center, Become VIP)
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildGridIcon(Icons.handshake, "Agency Center", () => print("Agency")),
                  _buildGridIcon(Icons.people_alt, "BD Center", () => print("BD")),
                  _buildGridIcon(Icons.mic_external_on, "Host Center", () => print("Host")),
                  _buildGridIcon(Icons.workspace_premium, "Become VIP", () => print("VIP")),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Offline Recharge
              _buildListTile(
                icon: Icons.flash_on,
                title: "Offline Recharge",
                onTap: () {
                  print("Offline Recharge Tapped");
                },
              ),
              const SizedBox(height: 8),

              // 7. My Posts
              _buildListTile(
                icon: Icons.photo_album,
                title: "My Posts",
                onTap: () {
                  print("My Posts Tapped");
                },
              ),
              const SizedBox(height: 30), // Bottom padding
            ],
          ),
        ),
      ),

      // --- CUSTOM BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF1A0D33), // Dark bottom bar background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // होम टैब (अन-सेलेक्टेड)
            _buildNavItem(Icons.home, false),
            // डिस्कवर टैब (अन-सेलेक्टेड)
            _buildNavItem(Icons.explore, false),
            
            // --- CENTER CREATE ROOM BUTTON (PLUS) ---
            SizedBox(
              width: 60, 
              height: 60,
              child: FloatingActionButton(
                onPressed: () {
                  // "Room Create" लॉजिक
                  print("Create Room Plus Button Tapped");
                  _showCreateRoomDialog(context);
                },
                backgroundColor: accentColor,
                elevation: 4,
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
            
            // मैसेज टैब (अन-सेलेक्टेड)
            _buildNavItem(Icons.message, false),
            // मी टैब (सेलेक्टेड)
            _buildNavItem(Icons.person, true),
          ],
        ),
      ),
    );
  }

  // Helper Widgets

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

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
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
            Icon(icon, color: const Color(0xFFFFD700), size: 40), // Host microphone color
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

  Widget _buildGridIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1A0D33),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFFFD700), size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      tileColor: const Color(0xFF1A0D33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    const Color iconActive = Color(0xFFFF00FF); // Pink
    const Color iconInactive = Colors.grey;

    return GestureDetector(
      onTap: () {
        // Navigation Logic here - e.g., Navigator.pushNamed(context, '/home');
        print("Nav Item Tapped: $icon");
      },
      child: Icon(
        icon,
        color: isSelected ? iconActive : iconInactive,
        size: 30,
      ),
    );
  }
  
  // Dialog to show Room Creation options (Audio/Video) when PLUS button is clicked
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
                   // Logic to open Audio Room Creation Screen
                   print("Create Audio Room");
                },
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.white),
                title: const Text("Video Live", style: TextStyle(color: Colors.white)),
                onTap: () {
                   Navigator.pop(context);
                   // Logic to open Video Live Creation Screen
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


