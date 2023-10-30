import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  static AppCache get instance {
    return _instance;
  }

  SharedPreferences? _prefs;

  static final String _KEY_TOKEN = "token";

  AppCache._private();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setApiToken(String? token) async {
    if (token == null) return;
    await _prefs!.setString(_KEY_TOKEN, token);
  }

  String? getApiToken() {
    String? token = _prefs!.get(_KEY_TOKEN) as String?;
    return token;
  }
}
