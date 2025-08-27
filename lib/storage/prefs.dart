import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String _accessToken = 'access_token';
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
 static initCheck() async {
  print('shared preferences initialized');
  }
  static Future <void >setAccessToken(String token) async {
    await _preferences.setString(_accessToken, token);
  }
  static Future <String?> getAccessToken() async {
    return _preferences.getString(_accessToken);
  }
 static Future<void> removeAccessToken() async {
    await _preferences.remove(_accessToken);
  }
}
