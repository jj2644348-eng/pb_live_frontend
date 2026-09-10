import 'package:flutter/material.dart';
import 'dart:math';

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

// User Model with Gallery Image Path support
class UserModel {
  String phone;
  String password;
  String pbId;
  String name;
  String gender;
  String profileImagePath; // Gallery image path
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
      // Fix: Direct strict matching for login
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

