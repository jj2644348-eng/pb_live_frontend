import 'package:flutter/material.dart';

class AdminWindowPanel extends StatefulWidget {
  const AdminWindowPanel({super.key});

  @override
  State<AdminWindowPanel> createState() => _AdminWindowPanelState();
}

class _AdminWindowPanelState extends State<AdminWindowPanel> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _coinController = TextEditingController();
  
  bool isOwnerBlueTick = true; // ओनली ओनर के पास ब्लू टिक का एक्सक्लूसिव कंट्रोल
  String assignedRole = "Normal User";

  void _showMsg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👑 Super Owner & Reseller Panel", style: TextStyle(color: Colors.amber, fontSize: 16)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A1B4E), Color(0xFF141026)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // ओनर ब्लू टिक स्टेटस कार्ड
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF1E193D), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Owner Verified Blue Tick 🛡️", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Switch(
                      value: isOwnerBlueTick,
                      activeColor: Colors.blue,
                      onChanged: (val) => setState(() => isOwnerBlueTick = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // टारगेट यूजर आईडी इनपुट
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "Target User ID (e.g. 10590491)",
                  filled: true,
                  fillColor: const Color(0xFF1E193D),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              // कॉइन रिचार्ज / अनलिमिटेड सेंडिंग इनपुट
              TextField(
                controller: _coinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter Coins Amount (Unlimited)",
                  filled: true,
                  fillColor: const Color(0xFF1E193D),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 15),

              // कॉइन सेंड करने का बटन (ओनर या रीसेलर के लिए)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 45)),
                icon: const Icon(Icons.toll, color: Colors.black),
                label: const Text("Send Coins / Recharge ID", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (_idController.text.isNotEmpty && _coinController.text.isNotEmpty) {
                    _showMsg("Successfully sent ${_coinController.text} coins to ID: ${_idController.text} 💎");
                  } else {
                    _showMsg("Please enter User ID and Coin amount!");
                  }
                },
              ),
              const SizedBox(height: 15),

              // रीसेलर और यूनिक आईडी / टैग मैनेजमेंट
              const Text("Privilege & Tag Controls", style: TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      onPressed: () => _showMsg("Assigned Reseller Rights to ID: ${_idController.text}"),
                      child: const Text("Make Reseller", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                      onPressed: () => _showMsg("Applied Official Badge to ID: ${_idController.text} ⭐"),
                      child: const Text("Assign Official Tag", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size(double.infinity, 40)),
                onPressed: () => _showMsg("User ID & Unique Number Updated Successfully!"),
                child: const Text("Update / Change Unique ID", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
