import 'dart:convert';

import 'package:abosiefienapp/model/khadem_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  static AppCache get instance {
    return _instance;
  }

  SharedPreferences? _prefs;

  static final String _KEY_TOKEN = "token";
  static final String _KEY_USER = "user";
  static final String _KEY_MYMAKHDOMS = "mymakhdoms";
  static final String _KEY_khadem = "khadem";

  AppCache._private();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setApiToken(String? token) async {
    if (token == null) return;
    await _prefs!.setString(_KEY_TOKEN, token);
  }

  String? getApiToken() {
    String? token = _prefs!.getString(_KEY_TOKEN);
    printDone('storedToken id: $token');
    return token;
  }

  void removeToken() {
    _prefs!.remove(_KEY_TOKEN);
    _prefs!.clear();
  }

  void setUserModel(UserModel model) async {
    if (model == null) return;
    String json = jsonEncode(model.toJson());
    await _prefs!.setString(_KEY_USER, json);
    setApiToken(model.data!.token);
  }

  UserModel? getUserModel() {
    String? json = _prefs!.getString(_KEY_USER);
    return json == null ? null : UserModel.fromJson(jsonDecode(json));
  }

  void setMyMakhdomsModel(MyMakhdomsModel model) async {
    if (model == null) return;
    String json = jsonEncode(model.toJson());
    await _prefs!.setString(_KEY_MYMAKHDOMS, json);
  }

  MyMakhdomsModel? getMyMakhdomsModel() {
    String? json = _prefs!.getString(_KEY_MYMAKHDOMS);
    return json == null ? null : MyMakhdomsModel.fromJson(jsonDecode(json));
  }

  void setKhademModel(KhademModel model) async {
    if (model == null) return;
    String json = jsonEncode(model.toJson());
    await _prefs!.setString(_KEY_khadem, json);
  }

  KhademModel? getKhademModel() {
    String? json = _prefs!.getString(_KEY_khadem);
    return json == null ? null : KhademModel.fromJson(jsonDecode(json));
  }
}
