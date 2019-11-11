import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static haveKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool have = prefs.containsKey(key);
    return have;
  }

  static get(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    return value;
  }

  static save(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static remove(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}