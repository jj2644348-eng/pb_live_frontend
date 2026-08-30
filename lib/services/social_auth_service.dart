import 'package:flutter/material.dart';

class SocialAuthService {
  // 👑 Super Owner Official Details
  static const String superOwnerEmail = "lp5006352@gmail.com";
  static const String superOwnerMasterId = "0001";

  static bool isOwner(String email) {
    return email.toLowerCase() == superOwnerEmail.toLowerCase();
  }
}

class SocialLoginSheet extends StatelessWidget {
  final Function(Map<String, dynamic> userData) onLoginSuccess;

  const SocialLoginSheet({super.key, required this.onLoginSuccess});

  static void show(BuildContext context, Function(Map<String, dynamic> userData) onSuccess) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SocialLoginSheet(onLoginSuccess: onSuccess),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          const Text("Welcome to PB Live Club", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Choose your login method", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 20),

          // 🔴 1. GOOGLE LOGIN (Gmail Picker & Owner Check)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              bool ownerMatched = SocialAuthService.isOwner("lp5006352@gmail.com");
              onLoginSuccess({
                "userId": ownerMatched ? "0001" : "88521099",
                "name": ownerMatched ? "Lovepreet Singh (Owner)" : "Google User",
                "email": "lp5006352@gmail.com",
                "authType": "Google",
                "isOwner": ownerMatched,
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                SizedBox(width: 8),
                Text("Continue with Google (Gmail)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 🔵 2. FACEBOOK LOGIN
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1877F2),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              onLoginSuccess({
                "userId": "FB992810",
                "name": "Facebook User",
                "email": "fb_user@app.com",
                "authType": "Facebook",
                "isOwner": false,
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, size: 22),
                SizedBox(width: 8),
                Text("Continue with Facebook", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 📱 3. PHONE NUMBER OTP LOGIN
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF007F),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              onLoginSuccess({
                "userId": "98765432",
                "name": "Phone User",
                "email": "phone@user.com",
                "authType": "Phone",
                "isOwner": false,
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_android, size: 20),
                SizedBox(width: 8),
                Text("Continue with Mobile OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

