import 'dart:io';

import 'package:abosiefienapp/core/shared_prefrence/app_shared_prefrence.dart';
import 'package:abosiefienapp/core/widget/toast_m.dart';
import 'package:abosiefienapp/model/AllNamesModel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../core/errors/failures.dart';
import '../core/utils/app_debug_prints.dart';
import '../core/utils/custom_function.dart';
import '../repositories/add_class_attendance_repo.dart';
import '../repositories/check_box_add_attendance_repo.dart';

enum DataState { loading, noData, loaded }

class CheckBoxAddAttendanceProvider with ChangeNotifier {
  final CheckBoxAddAttendanceRepository _repository =
      CheckBoxAddAttendanceRepository();
  AddClassAttendanceRepo addClassAttendanceRepo = AddClassAttendanceRepo();
  CustomFunctions customFunctions = CustomFunctions();
  String errorMsg = '';

  List<AllNamesModel> _data = [];

  List<AllNamesModel> get data => _data;

  DataState _dataState = DataState.noData;

  DataState get dataState => _dataState;

  Map<String, bool> _checkboxStates = {};

  Map<String, bool> get checkboxStates => _checkboxStates;

  List<String> _names = [];

  List<String> get names => _names;

  List<int> _ids = [];

  List<int> get ids => _ids;

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Data (id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveCheckboxState(String stateCheckBox, bool value) async {
    _checkboxStates[stateCheckBox] = value;
    await AppSharedPreferences.setBool(stateCheckBox, value);
    notifyListeners();
  }

  Future<void> loadCheckboxStates() async {
    _checkboxStates = {};
    for (String id in _ids.map((id) => id.toString())) {
      bool? state = await AppSharedPreferences.getBool(id);
      _checkboxStates[id] = state ?? false;
    }
    notifyListeners();
  }

  Future<void> insertJsonData(List<Map<String, dynamic>> data) async {
    Database db = await initializeDB();
    for (var item in data) {
      await db.insert(
        'Data',
        {
          'id': item['id'], // Store 'id' as an integer
          'name': item['name']
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    final List<Map<String, dynamic>> insertedData = await db.query('Data');
    print('Data inserted into SQLite: $insertedData');
  }

  Future<void> saveJsonData() async {
    _dataState = DataState.loading;
    notifyListeners();

    Either<Failure, List<Map<String, dynamic>>> jsonData =
        await _repository.getAllNames();

    jsonData.fold(
      (Failure l) {
        print('Failed to fetch data from repository: $l');
        _dataState = DataState.noData;
        notifyListeners();
      },
      (List<Map<String, dynamic>> r) async {
        if (r.isNotEmpty) {
          await insertJsonData(r);

          _names.clear();
          _ids.clear();
          _checkboxStates.clear();

          for (var item in r) {
            if (item['name'] != null && item['id'] != null) {
              _names.add(item['name'] as String);
              _ids.add(item['id'] as int); // Handle id as an integer
              _checkboxStates[item['id'].toString()] = false;
            }
          }

          await retrieveJsonData();
        } else {
          print('No data fetched from repository to insert into SQLite.');
          _dataState = DataState.noData;
        }
      },
    );
  }

  Future<void> retrieveJsonData() async {
    _dataState = DataState.loading;
    notifyListeners();

    Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Data');

    if (maps.isNotEmpty) {
      print('Data retrieved from SQLite: ${maps.length}');
      List<String> namesData = [];
      List<int> idsData = [];

      _data = maps.map((Map<String, dynamic> item) {
        print('Mapping item: ${item['name']}');
        namesData.add(item['name']);
        idsData.add(item['id']);
        return AllNamesModel.fromJson(item);
      }).toList();

      _names = namesData;
      _ids = idsData;
      await loadCheckboxStates();

      _dataState = DataState.loaded;
    } else {
      print('No data found in SQLite.');
      _dataState = DataState.noData;
    }

    notifyListeners();
  }

  Future<void> clearCheckboxStates() async {
    for (String id in _ids.map((id) => id.toString())) {
      await AppSharedPreferences.remove(id);
    }
    _checkboxStates.clear();
    notifyListeners();
  }

  Future<void> loadDataOnStart() async {
    _dataState = DataState.loading;
    notifyListeners();

    await retrieveJsonData();

    if (_names.isEmpty) {
      await saveJsonData();
    }

    if (_names.isNotEmpty) {
      _dataState = DataState.loaded;
    } else {
      _dataState = DataState.noData;
    }

    notifyListeners();
  }

  Future<void> printAllDataFromSQLite() async {
    Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Data');

    if (maps.isEmpty) {
      print('No data found in SQLite.');
    } else {
      print('Data from SQLite:');
      List<String> namesList = [];
      maps.forEach((map) {
        namesList.add(map['name']);
        print(map);
      });
      _names = namesList;
      notifyListeners();
    }
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

  String? attendanceDate;

  void setSelectedAttendanceDate(String value) {
    attendanceDate = value;
    notifyListeners();
  }

  convertToDate() {
    DateTime dayToday = DateTime.now();
    String finalFormattedDate =
        intl.DateFormat('yyyy-MM-dd').format(dayToday).toString();
    printDone('finalFormattedDate $finalFormattedDate');
    attendanceDate = finalFormattedDate;
    notifyListeners();
  }

  Future<bool> addAttendance(BuildContext context) async {
    convertToDate();
    customFunctions.showProgress(context);

    List<int> selectedIds = _checkboxStates.entries
        .where((entry) => entry.value == true)
        .map((entry) => int.parse(entry.key))
        .toList();

    Either<Failure, dynamic> response =
        await addClassAttendanceRepo.requestAddAttendance({
      "attendanceDate": attendanceDate,
      "makhdomsId": selectedIds, // Send selected IDs as integers
      "points": 0,
    });

    printDone('response $response');
    notifyListeners();

    response.fold(
      (Failure l) {
        printError(l.message);
        ToastM.show(l.message);
        customFunctions.showError(
            message: 'An error occurred, please try again', context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (r) {
        if (r != null && r['success'] == true) {
          errorMsg = r["errorMsg"] ?? '';
          // customFunctions.showSuccess(message: r['data'], context: context);
          customFunctions.hideProgress();
          clearCheckboxStates();
          notifyListeners();
          return true;
        } else if (r != null && r['success'] == false) {
          customFunctions.showError(
              message: r["errorMsg"].toString(), context: context);
          customFunctions.hideProgress();
          notifyListeners();
          return false;
        }
      },
    );

    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }
}
