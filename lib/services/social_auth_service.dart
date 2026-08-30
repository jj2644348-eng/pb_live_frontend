import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 👑 Permanent Super Owner Official Details
  static const String superOwnerEmail = "lp5006352@gmail.com";
  static const String superOwnerMasterId = "0001";

  // Check if current user is the Super Owner
  static bool isSuperOwner(User? user) {
    if (user == null) return false;
    return user.email?.toLowerCase() == superOwnerEmail.toLowerCase() || user.uid == superOwnerMasterId;
  }

  // 1. 🔴 Official Google 1-Tap Account Chooser (Shows all Gmails on Device)
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Auto-assign Owner privileges if email matches lp5006352@gmail.com
      if (userCredential.user?.email?.toLowerCase() == superOwnerEmail.toLowerCase()) {
        debugPrint("👑 Super Owner Logged In: lp5006352@gmail.com (ID: 0001)");
      }

      return userCredential;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Error: $e"), backgroundColor: Colors.redAccent),
      );
      return null;
    }
  }

  // 2. 📱 Phone OTP Authentication System
  static Future<void> verifyPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(UserCredential user) onAutoVerified,
    required Function(String error) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCred = await _auth.signInWithCredential(credential);
          onAutoVerified(userCred);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? "Phone verification failed");
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  // 3. Submit SMS OTP Code
  static Future<UserCredential?> submitPhoneOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (_) {
      return null;
    }
  }

  // 4. Logout User
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

// -------------------------------------------------------------
// 🎨 REAL SOCIAL LOGIN UI SHEET (Google Account Picker & Phone)
// -------------------------------------------------------------
class SocialLoginSheet extends StatefulWidget {
  final Function(Map<String, dynamic> userData) onLoginSuccess;

  const SocialLoginSheet({super.key, required this.onLoginSuccess});

  static void show(BuildContext context, Function(Map<String, dynamic> userData) onSuccess) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SocialLoginSheet(onLoginSuccess: onSuccess),
    );
  }

  @override
  State<SocialLoginSheet> createState() => _SocialLoginSheetState();
}

class _SocialLoginSheetState extends State<SocialLoginSheet> {
  bool _isLoading = false;
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  String? _verificationId;

  void _handleGoogleLogin() async {
    setState(() => _isLoading = true);
    final userCred = await SocialAuthService.signInWithGoogle(context);
    setState(() => _isLoading = false);

    if (userCred != null && userCred.user != null) {
      final u = userCred.user!;
      final bool isOwner = SocialAuthService.isSuperOwner(u);

      Navigator.pop(context);
      widget.onLoginSuccess({
        "userId": isOwner ? "0001" : u.uid.substring(0, 8),
        "name": u.displayName ?? (isOwner ? "Lovepreet Singh (Owner)" : "PB User"),
        "email": u.email ?? "",
        "photoUrl": u.photoURL ?? "",
        "authType": "Google",
        "isOwner": isOwner,
      });
    }
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
          const Text("Select your account to continue", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 20),

          if (_isLoading)
            const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(color: Color(0xFFFF007F)))
          else ...[
            // 🔴 1. REAL GOOGLE SIGN-IN BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _handleGoogleLogin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network("https://img.icons8.com/color/48/google-logo.png", height: 22),
                  const SizedBox(width: 12),
                  const Text("Continue with Google (Choose Gmail)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 🔵 2. FACEBOOK BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
                widget.onLoginSuccess({
                  "userId": "FB889210",
                  "name": "Facebook User",
                  "email": "user@fb.com",
                  "photoUrl": "",
                  "authType": "Facebook",
                  "isOwner": false,
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text("Continue with Facebook", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Row(
              children: [
                Expanded(child: Divider(color: Colors.white24)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("OR PHONE", style: TextStyle(color: Colors.grey, fontSize: 10))),
                Expanded(child: Divider(color: Colors.white24)),
              ],
            ),
            const SizedBox(height: 12),

            // 📱 3. PHONE NUMBER LOGIN
            if (_verificationId == null) ...[
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixText: "+91 ",
                  prefixStyle: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
                  hintText: "Enter Mobile Number",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF2A2456),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF007F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 46),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final ph = phoneCtrl.text.trim();
                  if (ph.length >= 10) {
                    setState(() => _isLoading = true);
                    SocialAuthService.verifyPhoneNumber(
                      context: context,
                      phoneNumber: ph,
                      onCodeSent: (vId) => setState(() {
                        _verificationId = vId;
                        _isLoading = false;
                      }),
                      onAutoVerified: (cred) {
                        Navigator.pop(context);
                        widget.onLoginSuccess({
                          "userId": ph.substring(ph.length - 8),
                          "name": "User_$ph",
                          "email": "$ph@mobile.user",
                          "photoUrl": "",
                          "authType": "Phone",
                          "isOwner": false,
                        });
                      },
                      onError: (err) {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err), backgroundColor: Colors.red));
                      },
                    );
                  }
                },
                child: const Text("Send OTP Code", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ] else ...[
              TextField(
                controller: otpCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter 6-Digit SMS OTP",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF2A2456),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 46),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  final otp = otpCtrl.text.trim();
                  if (otp.length == 6 && _verificationId != null) {
                    setState(() => _isLoading = true);
                    final cred = await SocialAuthService.submitPhoneOtp(verificationId: _verificationId!, smsCode: otp);
                    setState(() => _isLoading = false);
                    if (cred != null && cred.user != null) {
                      Navigator.pop(context);
                      widget.onLoginSuccess({
                        "userId": cred.user!.uid.substring(0, 8),
                        "name": "User_${phoneCtrl.text}",
                        "email": "${phoneCtrl.text}@mobile.user",
                        "photoUrl": "",
                        "authType": "Phone",
                        "isOwner": false,
                      });
                    }
                  }
                },
                child: const Text("Verify OTP & Login", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]
          ]
        ],
      ),
    );
  }
}

