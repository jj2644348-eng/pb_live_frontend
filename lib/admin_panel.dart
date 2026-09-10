import 'package:flutter/material.dart';

// Admin Panel Web App for PB Live Party
class PBAdminPanelApp extends StatelessWidget {
  const PBAdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0214),
        primarySwatch: Colors.amber,
      ),
      home: const AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _adminUserCtrl = TextEditingController(text: 'admin');
  final _adminPassCtrl = TextEditingController(text: 'pb9779');

  void _loginAdmin() {
    if (_adminUserCtrl.text == 'admin' && _adminPassCtrl.text == 'pb9779') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Admin Credentials!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0B2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.admin_panel_settings, size: 70, color: Colors.amber),
              const SizedBox(height: 15),
              const Text('PB Live Web Admin', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 25),
              TextField(
                controller: _adminUserCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Admin Username', filled: true, fillColor: Color(0xFF2E134D)),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _adminPassCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Admin Password', filled: true, fillColor: Color(0xFF2E134D)),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.all(15)),
                  onPressed: _loginAdmin,
                  child: const Text('Login to Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _searchIdCtrl = TextEditingController();
  final _coinsCtrl = TextEditingController();
  String selectedFrame = '👑 Golden Royal Frame';
  bool isBanned = false;

  // Mock user searched result data
  bool userFound = false;
  String searchedName = '';
  String searchedPbId = '';
  int currentCoins = 0;

  void _searchUser() {
    String id = _searchIdCtrl.text.trim();
    if (id.isEmpty) return;

    // Simulating database lookup for PB ID
    setState(() {
      userFound = true;
      searchedName = 'Lovepreet Singh';
      searchedPbId = id;
      currentCoins = 1500;
    });
  }

  void _updateUserData() {
    int addCoins = int.tryParse(_coinsCtrl.text) ?? 0;
    setState(() {
      currentCoins += addCoins;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully added $addCoins coins and assigned $selectedFrame to ID: $searchedPbId!')),
    );
    _coinsCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B2E),
        title: const Text('PB Live Control Panel (Chrome Web)', style: TextStyle(color: Colors.amber)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminLoginScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side: Search & Manage User
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF1A0B2E), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Manage User by PB ID', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _searchIdCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(labelText: 'Enter 8-digit PB ID (e.g. 204589)', filled: true, fillColor: Color(0xFF2E134D)),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: _searchUser,
                      child: const Text('Search User ID', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 25),
                    if (userFound) ...[
                      Text('User: $searchedName', style: const TextStyle(color: Colors.white, fontSize: 16)),
                      Text('PB ID: $searchedPbId', style: const TextStyle(color: Colors.amberAccent, fontSize: 16)),
                      Text('Current Coins: 🪙 $currentCoins', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 20),
                      const Text('Add Coins to Wallet', style: TextStyle(color: Colors.white70)),
                      TextField(
                        controller: _coinsCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(labelText: 'Enter Coins Amount', filled: true, fillColor: Color(0xFF2E134D)),
                      ),
                      const SizedBox(height: 15),
                      const Text('Assign VIP Frame / Badge', style: TextStyle(color: Colors.white70)),
                      DropdownButton<String>(
                        value: selectedFrame,
                        dropdownColor: const Color(0xFF2E134D),
                        style: const TextStyle(color: Colors.white),
                        items: ['👑 Golden Royal Frame', '💎 Diamond Sparkle Frame', '🔥 Fire Rider Badge'].map((val) {
                          return DropdownMenuItem(value: val, child: Text(val));
                        }).toList(),
                        onChanged: (val) => setState(() => selectedFrame = val!),
                      ),
                      const SizedBox(height: 15),
                      SwitchListTile(
                        title: const Text('Ban / Block Account', style: TextStyle(color: Colors.redAccent)),
                        value: isBanned,
                        onChanged: (val) => setState(() => isBanned = val),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: _updateUserData,
                          child: const Text('Save Changes to User ID', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Right Side: Global App Stats & Controls
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF1A0B2E), borderRadius: BorderRadius.circular(16)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Global Platform Stats', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    ListTile(
                      tileColor: Color(0xFF2E134D),
                      leading: Icon(Icons.people, color: Colors.amber),
                      title: Text('Total Registered Users'),
                      trailing: Text('1,240', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      tileColor: Color(0xFF2E134D),
                      leading: Icon(Icons.mic, color: Colors.amber),
                      title: Text('Active Live Rooms'),
                      trailing: Text('48', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      tileColor: Color(0xFF2E134D),
                      leading: Icon(Icons.monetization_on, color: Colors.amber),
                      title: Text('Total Coins Circulated'),
                      trailing: Text('450,000', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

