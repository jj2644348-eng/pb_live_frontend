import 'package:flutter/material.dart';

class ExtraFeaturesScreen extends StatelessWidget {
  const ExtraFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PB Live Extra Features", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color(0xFF1E193D),
      ),
      body: const Center(
        child: Text(
          "New file connected successfully! 🚀",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

