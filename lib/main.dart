import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const SplashScreen(),
    );
  }
}

// स्प्लैश स्क्रीन (चेक करती है कि यूजर पहले से लॉगइन है या नहीं)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 1)); // हल्का सा लोड टाइम

    if (mounted) {
      if (isLoggedIn) {
        // अगर पहले से लॉगइन है, तो सीधा होम स्क्रीन पर जाओ (नंबर मांगने की जरूरत नहीं)
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        // अगर नया यूजर है, तो सिर्फ पहली बार लॉगिन स्क्रीन आएगी
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("PB Live Party 👑\nLoading...", textAlign: TextAlign.center, style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
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

// 1. मोबाइल नंबर और पासवर्ड लॉगिन स्क्रीन (सिर्फ पहली बार के लिए)
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
    "609779353560": "0001", // ओनर अकाउंट
  };

  void handleAuth() async {
    String phone = phoneController.text.trim();
    String pass = passController.text.trim();

    if (phone.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("कृपया मोबाइल नंबर और पासवर्ड भरें!")));
      return;
    }

    if (userDb.containsKey(phone)) {
      if (userDb[phone] != pass) {
        ScaffoldMessenger.info(context); // dummy check
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("गलत पासवर्ड!")));
        return;
      }
    } else {
      userDb[phone] = pass;
    }

    // लॉगिन सफल होने पर सेव कर लो ताकि दोबारा नंबर न मांगे
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userPhone', phone);

    if (mounted) {
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

// 2. होम स्क्रीन (लॉगिन के बाद हमेशा सीधे यही खुलेगी)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PB Live Home", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: NeonBorderWrapper(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Welcome to PB Live Party! 🎉\nAuto-Login Active (No need to enter number again).\n\nNext features coming up next!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}

