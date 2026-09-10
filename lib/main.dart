import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PB Live party',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      setState(() {
        _currentUser = account;
      });
    } catch (error) {
      print('Sign-in failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PB Live party - Google Login')),
      body: Center(
        child: _currentUser == null
            ? ElevatedButton.icon(
                onPressed: _handleSignIn,
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_currentUser!.displayName ?? ''}'),
                  Text(_currentUser!.email),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _googleSignIn.signOut(),
                    child: const Text('Logout'),
                  ),
                ],
              ),
      ),
    );
  }
}

