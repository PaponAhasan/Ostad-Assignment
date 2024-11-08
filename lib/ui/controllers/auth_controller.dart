import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/login_model/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user_data';

  static SharedPreferences? _prefs;
  static String? accessToken;
  static UserModel? userData;
  static ValueNotifier<UserModel?> userNotifier = ValueNotifier<UserModel?>(null);

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(String token) async {
    await _initPrefs();
    await _prefs!.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<void> saveUserData(UserModel userModel) async {
    await _initPrefs();
    await _prefs!.setString(_userDataKey, jsonEncode(userModel.toJson()));
    userNotifier.value = userModel;
    userData = userModel;
  }

  static Future<String?> getAccessToken() async {
    if (accessToken != null) {
      return accessToken;
    }
    await _initPrefs();
    accessToken = _prefs!.getString(_accessTokenKey);
    return accessToken;
  }

  static Future<UserModel?> getUserData() async {
    if (userData != null) {
      return userData;
    }
    await _initPrefs();
    String? userEncodedData = _prefs!.getString(_userDataKey);
    if(userEncodedData == null) {
      return null;
    }
    userData = UserModel.fromJson(jsonDecode(userEncodedData));
    userNotifier.value = userData;
    return userData;
  }

  static bool hasAccessToken() {
    return accessToken != null;
  }

  static Future<void> clearAuthDetails() async {
    await _initPrefs();
    await _prefs!.clear();
    accessToken = null;
    userData = null;
  }
}
