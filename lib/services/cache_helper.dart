import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static sharedInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences.getBool(key);
  }

  static Future setInt({
    required String key,
    required int value,
  }) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int? getInt({
    required String key,
  }) {
    return sharedPreferences.getInt(key);
  }
}
