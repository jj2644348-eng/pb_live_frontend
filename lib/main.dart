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

// स्क्रीन के चारों ओर चमकती हुई नियॉन बॉर्डर लाइन
class NeonBorderWrapper extends StatelessWidget {
  const NeonBorderWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pinkAccent, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.pinkAccent.withOpacity(0.4), blurRadius: 8, spreadRadius: 1),
        ],
      ),
      child: child,
    );
  }
}

// 1. Auth / Login & New Password Screen
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String countryCode = "+91";

  static final Map<String, String> userDb = {
    "609779353560": "0001", // ओनर अकाउंट (ID 0001)
  };

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("नया पासवर्ड सेट हो गया! अकाउंट बन गया।")));
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
                        items: const [
                          DropdownMenuItem(value: "+91", child: Text("🇮🇳 +91")),
                          DropdownMenuItem(value: "+1", child: Text("🇺🇸 +1")),
                          DropdownMenuItem(value: "+44", child: Text("🇬🇧 +44")),
                        ],
                        onChanged: (val) => setState(() => countryCode = val!),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password / New Password", border: OutlineInputBorder()),
                  ),
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

// 2. Main Container with Bottom Navigation (अब Messages टैब के साथ)
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const PartyRoomsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
    const OwnerPanelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeonBorderWrapper(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1E193D),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "Inbox"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "Panel"),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> globalRooms = [];

// 3. Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openCreateRoomDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    bool isPublic = true;
    int seatCount = 15;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: StatefulBuilder(
          builder: (context, setStateModal) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Create Your Party Room 🎤", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Room Name", border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: descController, decoration: const InputDecoration(labelText: "Description (e.g. Welcome friends!)", border: OutlineInputBorder())),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Seating Capacity:", style: TextStyle(color: Colors.white70)),
                  DropdownButton<int>(
                    value: seatCount,
                    dropdownColor: const Color(0xFF141026),
                    items: const [
                      DropdownMenuItem(value: 10, child: Text("10 Seats")),
                      DropdownMenuItem(value: 12, child: Text("12 Seats")),
                      DropdownMenuItem(value: 15, child: Text("15 Seats")),
                    ],
                    onChanged: (val) => setStateModal(() => seatCount = val!),
                  ),
                ],
              ),
              SwitchListTile(
                title: const Text("Public Room (Visible on Home)", style: TextStyle(color: Colors.white)),
                value: isPublic,
                onChanged: (val) => setStateModal(() => isPublic = val),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: const Size(double.infinity, 45)),
                onPressed: () {
                  if (nameController.text.isNotEmpty && isPublic) {
                    globalRooms.add({
                      "name": nameController.text,
                      "desc": descController.text,
                      "seats": seatCount,
                    });
                  }
                  Navigator.pop(ctx);
                  (context as Element).markNeedsBuild();
                },
                child: const Text("Launch Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PB Live Party", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.pinkAccent, size: 28),
            onPressed: () => _openCreateRoomDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 85,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF3F2B96), Color(0xFFE91E63)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "💎 Official Recharge & Coin Seller WhatsApp: +91 9779353560\n✨ Contact for Reseller & Official Support",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Live Party Rooms", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            globalRooms.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text("No active rooms yet. Tap '+' icon above to create one!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white38)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: globalRooms.length,
                    itemBuilder: (context, index) {
                      final room = globalRooms[index];
                      return Card(
                        color: const Color(0xFF1E193D),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.mic, color: Colors.white)),
                          title: Text(room["name"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text("${room["desc"]} • Seats: ${room["seats"]}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (c) => PartyRoomScreen(roomName: room["name"], seatCount: room["seats"])));
                            },
                            child: const Text("Join"),
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

// 4. Party Room Screen (लाइव चैट और मैसेजिंग के साथ)
class PartyRoomScreen extends StatefulWidget {
  final String roomName;
  final int seatCount;
  const PartyRoomScreen({super.key, required this.roomName, required this.seatCount});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  late List<Map<String, dynamic>> seats;
  final List<String> roomMessages = ["Welcome to ${widgetRoomNameStatic ?? 'Room'}! 🎉"];
  static String? widgetRoomNameStatic;
  final TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widgetRoomNameStatic = widget.roomName;
    seats = List.generate(widget.seatCount, (index) => {
      "seatNo": index + 1,
      "user": index == 0 ? "0001 (Owner)" : null,
      "isMuted": false,
    });
  }

  void sendMessage() {
    if (chatController.text.trim().isNotEmpty) {
      setState(() {
        roomMessages.add("You: ${chatController.text.trim()}");
      });
      chatController.clear();
    }
  }

  void _showGiftsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E193D),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🎁 Lucky Gifting Center", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _giftItem("🌹 Rose", "💎 10"),
                _giftItem("🚗 Sports Car", "💎 500"),
                _giftItem("🏰 Castle", "💎 5000"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _giftItem(String name, String price) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
      onPressed: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully sent $name!")));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(color: Colors.amber, fontSize: 11)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName, style: const TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
        actions: [
          IconButton(
            icon: const Icon(Icons.music_note, color: Colors.amber),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Offline Music Playing!"))),
          ),
          IconButton(
            icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent),
            onPressed: () => _showGiftsDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2A1B4E), Color(0xFF141026)]),
        ),
        child: Column(
          children: [
            // सीट्स ग्रिड
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemCount: widget.seatCount,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    return GestureDetector(
                      onTap: () {
                        // प्रोफाइल देखने और DM करने का ऑप्शन
                        showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                            backgroundColor: const Color(0xFF1E193D),
                            title: Text("User Profile: ${seat["user"] ?? "Empty Seat ${index + 1}"}"),
                            content: const Text("Send a direct message or view profile details."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(c);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatDetailScreen(userName: "User on Seat")));
                                },
                                child: const Text("Send Message 💬", style: TextStyle(color: Colors.pinkAccent)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: index == 0 ? Colors.amber : Colors.white24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(index == 0 ? Icons.star : Icons.mic, color: index == 0 ? Colors.amber : Colors.white70),
                            const SizedBox(height: 4),
                            Text(seat["user"] ?? "Seat ${index + 1}", style: const TextStyle(fontSize: 10, color: Colors.white70), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // रूम लाइव चैट बॉक्स (सबको दिखने वाला मैसेज)
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.black26,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: roomMessages.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(roomMessages[index
