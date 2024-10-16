import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'access_token';
  static const String _userEmailKey = 'user_email';
  static const String _userFirstNameKey = 'user_first_name';
  static const String _userLastNameKey = 'user_last_name';
  static const String _userPhoneKey = 'user_phone';

  static String? _accessToken;
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(String token) async {
    await _initPrefs();
    await _prefs!.setString(_accessTokenKey, token);
    _accessToken = token;
  }

  static Future<void> saveUserEmail(String email) async {
    await _initPrefs();
    await _prefs!.setString(_userEmailKey, email);
  }

  static Future<void> saveUserFirstName(String firstName) async {
    await _initPrefs();
    await _prefs!.setString(_userFirstNameKey, firstName);
  }

  static Future<void> saveUserLastName(String lastName) async {
    await _initPrefs();
    await _prefs!.setString(_userLastNameKey, lastName);
  }

  static Future<void> saveUserPhone(String phone) async {
    await _initPrefs();
    await _prefs!.setString(_userPhoneKey, phone);
  }

  static Future<String?> getAccessToken() async {
    if (_accessToken != null) {
      return _accessToken;
    }
    await _initPrefs();
    _accessToken = _prefs!.getString(_accessTokenKey);
    return _accessToken;
  }

  static bool hasAccessToken() {
    return _accessToken != null;
  }

  static Future<String?> getUserEmail() async {
    await _initPrefs();
    return _prefs!.getString(_userEmailKey);
  }

  static Future<String?> getUserFirstName() async {
    await _initPrefs();
    return _prefs!.getString(_userFirstNameKey);
  }

  static Future<String?> getUserLastName() async {
    await _initPrefs();
    return _prefs!.getString(_userLastNameKey);
  }

  static Future<String?> getUserPhone() async {
    await _initPrefs();
    return _prefs!.getString(_userPhoneKey);
  }

  static Future<void> clearUserDetails() async {
    await _initPrefs();
    await _prefs!.clear();
    _accessToken = null;
  }
}
