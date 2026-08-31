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

// नियॉन बॉर्डर वाइब रैपर
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

// 1. मोबाइल लॉगिन और पासवर्ड स्क्रीन
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("गलत पासवर्ड!")));
      }
    } else {
      userDb[phone] = pass;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("नया पासवर्ड सेट हो गया!")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
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

// अस्थायी होम स्क्रीन (चेक करने के लिए)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PB Live Home", style: TextStyle(color: Colors.amber)), backgroundColor: const Color(0xFF1E193D)),
      body: const Center(child: Text("Login Successful! Next step loading...", style: TextStyle(color: Colors.white70))),
    );
  }
}

