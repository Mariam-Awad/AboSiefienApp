import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String accessToken = 'accessToken';
  static const String KEY_USER = 'user';
  static const String KEY_MYMAKHDOMS = 'mymakhdoms';
  static const String KEY_khadem = 'khadem';
  static const String KEY_LOCAL_ATTENDANCE_MAKHDOM_LIST =
      'localattendancemakhdomlist';

  static const String userModel = 'userData';
}

class AppSharedPreferences {
  static late SharedPreferences pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    try {
      return pref.getString(key);
    } catch (e) {
      return null;
    }
  }

  static List<String>? getStringList(String key) {
    try {
      return pref.getStringList(key);
    } catch (e) {
      return null;
    }
  }

  static int? getInt(String key) {
    try {
      return pref.getInt(key);
    } catch (e) {
      return null;
    }
  }

  static bool? getBool(String key) {
    try {
      return pref.getBool(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setString(String key, String value) async {
    try {
      return pref.setString(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setStringList(String key, List<String> value) async {
    try {
      return pref.setStringList(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setInt(String key, int value) async {
    try {
      return pref.setInt(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      return await pref.setBool(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> remove(String key) async {
    try {
      return await pref.remove(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> clear() async {
    try {
      return await pref.clear();
    } catch (e) {
      return null;
    }
  }

  static printAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Set<String> keys = prefs.getKeys();

    if (keys.isEmpty) {
      print('No shared preferences found.');
    } else {
      for (String key in keys) {
        print('$key: ${prefs.get(key)}');
      }
    }
  }
}
