import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  static const String _userKey = 'token';

  static Future<void> addUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userToken);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString(_userKey);
    print("INI DATA TOKEN: $userToken");
    if (userToken != null && userToken.isNotEmpty == true) {
      print("INI berjalan");
      return userToken;
    }
    return null;
  }

  static Future<void> deleteUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
