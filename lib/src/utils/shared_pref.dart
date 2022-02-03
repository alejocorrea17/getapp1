// ignore_for_file: public_member_api_docs
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void save(String key2, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key2, json.encode(value));
  }

  Future<dynamic> read(String key2) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key2) == null) return null;

    return json.decode(prefs.getString(key2).toString());
  }

  Future<bool> contains(String key2) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key2);
  }

  Future<bool> remove(String key2) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key2);
  }

  // void logout(String? idUser) async {
  //   await remove('user');
  // }
}
