import 'package:flutter/material.dart';

void main() => runApp(const PBLiveApp());

class PBLiveApp extends StatelessWidget {
  const PBLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141026),
        primaryColor: Colors.pinkAccent,
      ),
      home: const AuthScreen(),
    );
  }
}

class NeonBorderWrapper extends StatelessWidget {
  const NeonBorderWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pinkAccent, width: 2),
        boxShadow: [BoxShadow(color: Colors.pinkAccent.withOpacity(0.4), blurRadius: 8, spreadRadius: 1)],
      ),
      child: child,
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String countryCode = "+91";
  static final Map<String, String> userDb = {"609779353560": "0001"};

  void handleAuth() {
    String phone = phoneController.text.trim();
    String pass = passController.text.trim();
    if (phone.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("कृपया मोबाइल नंबर और पासवर्ड भरें!")));
      return;
    }
    if (userDb.containsKey(phone)) {
      if (userDb[phone] == pass) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainContainer()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("गलत पासवर्ड!")));
      }
    } else {
      userDb[phone] = pass;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MainContainer()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeonBorderWrapper(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("PB Live Party 👑", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
                  const SizedBox(height: 8),
                  const Text("Official Owner WhatsApp: +91 9779353560", style: TextStyle(fontSize: 12, color: Colors.white54)),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: countryCode,
                        dropdownColor: const Color(0xFF1E193D),
                        items: const [DropdownMenuItem(value: "+91", child: Text("🇮🇳 +91")), DropdownMenuItem(value: "+1", child: Text("🇺🇸 +1"))],
                        onChanged: (val) => setState(() => countryCode = val!),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder()))),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(controller: passController, obscureText: true, decoration: const InputDecoration(labelText: "Password / New Password", border: OutlineInputBorder())),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 48)),
                    onPressed: handleAuth,
                    child: const Text("Continue / Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomeScreen(), const ProfileScreen(), const OwnerPanelScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeonBorderWrapper(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "Owner Panel"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Home", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          icon: const Icon(Icons.mic, color: Colors.white),
          label: const Text("Join 15-Seater Party Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PartyRoomScreen())),
        ),
      ),
    );
  }
}

class PartyRoomScreen extends StatefulWidget {
  const PartyRoomScreen({super.key});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  final List<Map<String, dynamic>> seats = List.generate(15, (index) => {
    "seatNo": index + 1,
    "user": index == 0 ? "0001 (Owner)" : null,
    "isMuted": false,
  });

  void toggleMic(int index) {
    setState(() => seats[index]["isMuted"] = !seats[index]["isMuted"]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Seat ${index + 1} Mic: ${seats[index]["isMuted"] ? "Muted 🔇" : "Unmuted 🎙️"}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Party Room (15 Seats)", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2A1B4E), Color(0xFF141026)])),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
            itemCount: 15,
            itemBuilder: (context, index) {
              final seat = seats[index];
              final bool isOccupied = seat["user"] != null;
              return GestureDetector(
                onTap: () {
                  if (isOccupied) {
                    toggleMic(index);
                  } else {
                    setState(() => seat["user"] = "User ${index + 1}");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isOccupied ? const Color(0xFF1E193D) : Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: index == 0 ? Colors.amber : Colors.pinkAccent, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(index == 0 ? Icons.star : (seat["isMuted"] ? Icons.mic_off : Icons.mic), color: index == 0 ? Colors.amber : (seat["isMuted"] ? Colors.redAccent : Colors.greenAccent), size: 28),
                      const SizedBox(height: 6),
                      Text(seat["user"] ?? "Empty ${index + 1}", style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lovepreet Singh", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 5),
            Text("ID: 0001 | VIP 40", style: TextStyle(color: Colors.amberAccent)),
          ],
        ),
      ),
    );
  }
}

class OwnerPanelScreen extends StatelessWidget {
  const OwnerPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Owner ID: 0001 Super Panel", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Super Admin Controls Active", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            SizedBox(height: 10),
            Text("Manage VIP levels, diamond recharges, and room moderation here.", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

