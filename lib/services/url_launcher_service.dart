import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinkService {
  // 🔴 आपका असली YouTube चैनल लिंक
  static const String youtubeChannelUrl = "https://youtube.com/@xenalivechat?si=7jStijgbiv3qgwFM";

  // 📸 आपका असली Instagram प्रोफाइल लिंक
  static const String instagramUrl = "https://www.instagram.com/techlovepb?igsi=MXUxYzRkNzZtcjZoYg==";

  // 💬 आपका WhatsApp सपोर्ट लिंक
  static const String whatsappSupportUrl = "https://wa.me/919779353560?text=Hello%20PB%20Party%20Support";

  // 🎉 लाइव इवेंट लिंक (चैनल पर रीडायरेक्ट)
  static const String currentEventUrl = "https://youtube.com/@xenalivechat?si=7jStijgbiv3qgwFM";

  /// किसी भी लिंक को सीधे ऐप (YouTube/Instagram/WhatsApp) में खोलने का सिस्टम
  static Future<void> openUrl(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open link!"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  /// 1-क्लिक YouTube चैनल ओपनर
  static void openYouTube(BuildContext context) {
    openUrl(context, youtubeChannelUrl);
  }

  /// 1-क्लिक Instagram ओपनर
  static void openInstagram(BuildContext context) {
    openUrl(context, instagramUrl);
  }

  /// 1-क्लिक WhatsApp सपोर्ट ओपनर
  static void openWhatsApp(BuildContext context) {
    openUrl(context, whatsappSupportUrl);
  }

  /// 1-क्लिक इवेंट लिंक ओपनर
  static void openEvent(BuildContext context) {
    openUrl(context, currentEventUrl);
  }
}

