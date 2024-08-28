import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../repositories/check_box_add_attendance_repo.dart';

class CheckBoxAddAttendanceProvider with ChangeNotifier {
  final CheckBoxAddAttendanceRepository _repository =
      CheckBoxAddAttendanceRepository();

  List<CheckBoxListTileModel> _data = [];

  List<CheckBoxListTileModel> get data => _data;

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Data (id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> retrieveJsonData() async {
    Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Data');
  }

  Future<void> insertJsonData(List<Map<String, dynamic>> data) async {
    Database db = await initializeDB();
    for (var item in data) {
      await db.insert(
        'Data',
        item,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  void saveJsonData() async {
    Database db = await initializeDB();
    List<Map<String, dynamic>> jsonData = await _repository.getFakeData();
    print('Data saved to database is ${jsonData}');
    await insertJsonData(jsonData);
  }

  Future<void> retrieveCheckBoxStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _data = CheckBoxListTileModel.getUsers();

    for (CheckBoxListTileModel item in _data) {
      item.isCheck = prefs.getBool('checkbox_${item.userId}') ?? false;
    }

    notifyListeners();
  }

  Future<void> updateCheckBox(int userId, bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkbox_$userId', isCheck);
    notifyListeners();
  }

  Future<void> clearCheckBoxes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> printDatabaseSize() async {
    int size = await getDatabaseSize();
    print('Database size: $size bytes');
  }

  Future<int> getDatabaseSize() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'data.db');
    File file = File(dbPath);
    return await file.length();
  }
}

class CheckBoxListTileModel {
  int userId;
  String title;
  bool isCheck;

  CheckBoxListTileModel({
    required this.userId,
    required this.title,
    required this.isCheck,
  });

  static List<CheckBoxListTileModel> getUsers() {
    return List.generate(
      100,
      (index) {
        return CheckBoxListTileModel(
            userId: index, title: "Item $index", isCheck: false);
      },
    );
  }
}
