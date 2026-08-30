import 'dart:math';

class IdGeneratorService {
  // पहले से रजिस्टर्ड ID की लिस्ट (ताकि किसी को सेम ID न मिले)
  static final Set<String> _assignedIds = {
    "20100001",
    "20884512",
    "20552190",
  };

  /// नई 8-अंकों की ID जनरेट करेगा जो हमेशा '20' से शुरू होगी
  /// उदाहरण: 20 + 481923 = "20481923"
  static String generateUserId() {
    final random = Random();
    String newId;

    do {
      // 100000 से 999999 के बीच 6-अंकों का रैंडम नंबर
      int randomSixDigits = 100000 + random.nextInt(900000);
      newId = "20$randomSixDigits";
    } while (_assignedIds.contains(newId)); // अगर पहले से मौजूद है तो दोबारा बनाएगा

    _assignedIds.add(newId);
    return newId;
  }

  /// चेक करेगा कि डाली गई ID असली और सही फॉर्मेट (8 डिजिट & 20 से शुरू) में है या नहीं
  static bool isValidId(String id) {
    final trimmed = id.trim();
    if (trimmed.length != 8) return false;
    if (!trimmed.startsWith("20")) return false;
    return int.tryParse(trimmed) != null;
  }
}

