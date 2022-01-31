import 'package:shared_preferences/shared_preferences.dart';

class LogData {
  static Future<void> toStore(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  static Future<Map<String, String>> getFromStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'email': (prefs.getString('email') ?? ''),
      'password': (prefs.getString('password') ?? ''),
    };
  }

  static Future<void> removeFromStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
  }
}
