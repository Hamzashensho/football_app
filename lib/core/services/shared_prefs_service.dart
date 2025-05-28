import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late final SharedPrefsService instance;
  late final SharedPreferences _prefs;

  SharedPrefsService._internal();

  static Future<void> init() async {
    instance = SharedPrefsService._internal();
    instance._prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
