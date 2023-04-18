import 'package:hdc_remake/app_dependencies.dart';

class SharedPreferencesManager {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<bool> isFirstTime() async {
    final prefs = await _prefs;
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    await prefs.setBool('isFirstTime', false);
    return isFirstTime;
  }
}
