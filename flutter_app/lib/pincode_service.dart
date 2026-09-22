import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PincodeService {
  static Map<String, dynamic>? _data;

  // JSON फाइल लोड करें (एक बार)
  static Future<void> loadData() async {
    if (_data != null) return;
    final raw = await rootBundle.loadString('assets/pincode_demo.json');
    _data = json.decode(raw);
  }

  // PIN कोड से City निकालें
  static String getCity(String pin) {
    if (_data == null || !_data!.containsKey(pin)) return '';
    return _data![pin]['city'] ?? '';
  }

  // PIN कोड से State निकालें
  static String getState(String pin) {
    if (_data == null || !_data!.containsKey(pin)) return '';
    return _data![pin]['state'] ?? '';
  }

  // PIN कोड से गाँवों की लिस्ट निकालें
  static List<String> getVillages(String pin) {
    if (_data == null || !_data!.containsKey(pin)) return [];
    return List<String>.from(_data![pin]['villages'] ?? []);
  }

  // PIN कोड वैलिड है या नहीं
  static bool isValid(String pin) {
    return _data != null && _data!.containsKey(pin);
  }
}
