import 'dart:convert';

import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/repositories/add_class_attendance_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../core/shared_prefrence/app_shared_prefrence.dart';
import '../core/utils/app_debug_prints.dart';
import '../model/AddAttendance/add_Attendance.dart';
import '../model/AddAttendance/data_State.dart';
import '../repositories/check_box_add_attendance_repo.dart';

class AddAttendanceProvider extends ChangeNotifier {
  final AddClassAttendanceRepo addClassAttendanceRepo =
      AddClassAttendanceRepo();
  final CheckBoxAddAttendanceRepository _repository =
      CheckBoxAddAttendanceRepository();
  CustomFunctions customFunctions = CustomFunctions();

  String errorMsg = '';
  final GlobalKey<FormState> attendanceformKey = GlobalKey();
  TextEditingController pointsController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  List<AllNamesModel> localAttendanceMakhdoms = []; // Use the model directly
  String get localAttendanceMakhdomsEncode =>
      jsonEncode(localAttendanceMakhdoms.map((e) => e.toJson()).toList());

  String attendanceDate = '';
  DataState _dataState = DataState.noData;
  List<String> _names = [];
  List<String> get names => _names;

  List<AllNamesModel> _data = [];
  List<AllNamesModel> get data => _data;

  String? foundName;
  int? foundId;
  bool isLoading = false;

  // Initialize and load data from SharedPreferences
  AddAttendanceProvider() {
    loadMakhdomsFromCache(); // Load previously searched data from cache
    loadNamesFromSharedPreferences(); // Load saved names from SharedPreferences
  }
  Future<void> saveNamesToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNames', _names);
    print('Names saved to SharedPreferences: $_names');
  }

  Future<void> loadNamesFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNames = prefs.getStringList('savedNames');

    if (savedNames != null && savedNames.isNotEmpty) {
      _names = savedNames;
      print('Names loaded from SharedPreferences: $_names');
      notifyListeners(); // Notify listeners to rebuild UI with the loaded data
    }
  }

  Future<void> findNameById(int id) async {
    Database db = await initializeDB();

    final List<Map<String, dynamic>> result = await db.query(
      'Data',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      foundName = result[0]['name'];
      foundId = result[0]['id'];

      AllNamesModel makhdom = AllNamesModel.fromJson(result[0]);

      // Store found name and id in localAttendanceMakhdoms (for UI and server submission)
      if (!localAttendanceMakhdoms.any((item) => item.id == foundId)) {
        localAttendanceMakhdoms.add(makhdom);

        // Save to SQLite as well
        await addMakhdom(makhdom.id, makhdom.name);

        // Save the updated localAttendanceMakhdoms list to SharedPreferences cache
        await saveMakhdomsToCache();
        notifyListeners();
      }
    } else {
      foundName = null;
      foundId = null;
      print('Name not found for id: $id');
    }

    notifyListeners();
  }

  Future<void> addMakhdom(int id, String name) async {
    Database db = await initializeDB();

    // Check if the name already exists
    final List<Map<String, dynamic>> existing = await db.query(
      'Data',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (existing.isEmpty) {
      // Insert the Makhdom in SQLite
      await db.insert(
        'Data',
        {'id': id, 'name': name},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Added Makhdom: $name with ID: $id');
    } else {
      print('Makhdom already exists with ID: $id');
    }

    notifyListeners(); // Refresh the UI
  }

  Future<void> saveMakhdomsToCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the localAttendanceMakhdoms list to JSON and save it
    String jsonList =
        jsonEncode(localAttendanceMakhdoms.map((e) => e.toJson()).toList());
    await prefs.setString('attendanceMakhdoms', jsonList);

    print('Searched data saved to cache: $jsonList');
  }

  Future<void> loadMakhdomsFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonList = prefs.getString('attendanceMakhdoms');
    if (jsonList != null) {
      List<dynamic> decodedList = jsonDecode(jsonList);
      localAttendanceMakhdoms =
          decodedList.map((item) => AllNamesModel.fromJson(item)).toList();

      print('Searched data loaded from cache: $localAttendanceMakhdoms');
      notifyListeners();
    }
  }

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
    isLoading = true; // Start loading
    notifyListeners(); // Notify the UI to show the loading state

    _dataState = DataState.loading;
    notifyListeners();

    Either<Failure, List<Map<String, dynamic>>> jsonData =
        await _repository.getAllNames();

    jsonData.fold(
      (Failure l) {
        print('Failed to fetch data from repository: $l');
        _dataState = DataState.noData;
        isLoading = false; // Stop loading
        notifyListeners();
      },
      (List<Map<String, dynamic>> r) async {
        if (r.isNotEmpty) {
          await insertJsonData(r);

          _names.clear(); // Clear previous names

          List<String> existingNames = []; // Collect existing names

          for (var item in r) {
            if (item['name'] != null && item['id'] != null) {
              existingNames.add(item['name'] as String);
            }
          }

          // Update _names only if there are new names
          if (existingNames.length > _names.length) {
            _names = existingNames.toList();
            await saveNamesToSharedPreferences(); // Save the updated names to SharedPreferences
          }

          await retrieveJsonData();
          isLoading = false; // Stop loading
          notifyListeners();
        } else {
          print('No data fetched from repository to insert into SQLite.');
          _dataState = DataState.noData;
          isLoading = false; // Stop loading
          notifyListeners();
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
      _data = maps.map((Map<String, dynamic> item) {
        return AllNamesModel.fromJson(item);
      }).toList();

      // Update localAttendanceMakhdoms from SQLite
      localAttendanceMakhdoms = _data;
      _names = _data.map((model) => model.name).toList();
      _dataState = DataState.loaded;
    } else {
      print('No data found in SQLite.');
      _dataState = DataState.noData;
    }

    notifyListeners();
  }

  void validate(BuildContext context) {
    if (attendanceformKey.currentState!.validate() &&
        attendanceDate.isNotEmpty) {
      printWarning('Code Is: ${int.parse(codeController.text)}');

      if (foundId != null && foundName != null) {
        // Pass foundId and foundName directly
        addMakhdom(
            foundId!, foundName!); // Found ID and Name passed as arguments
      } else {
        printError('Found ID or Name is null');
        customFunctions.showError(
            message: 'برجاء إدخال البيانات المطلوبة', context: context);
      }
    } else {
      printError('Not Validated');
      customFunctions.showError(
          message: 'برجاء إدخال البيانات المطلوبة', context: context);
    }
  }

  void setSelectedAttendanceDate(String? value) {
    attendanceDate = value!;
    notifyListeners();
  }

  void convertToDate() {
    DateTime dayToday = DateTime.now();
    String finalFormatedDate =
        intl.DateFormat('yyyy-MM-dd').format(dayToday).toString();
    printDone('finalFormatedDate $finalFormatedDate');
    attendanceDate = finalFormatedDate;
    notifyListeners();
  }

  void removeMakhdom(int id) async {
    printWarning('Removing Makhdom with ID: $id');
    localAttendanceMakhdoms.removeWhere((makhdom) => makhdom.id == id);

    // Remove from SQLite
    Database db = await initializeDB();
    await db.delete(
      'Data',
      where: 'id = ?',
      whereArgs: [id],
    );

    notifyListeners(); // Refresh the UI
  }

  void removeAllList() {
    localAttendanceMakhdoms = [];
    AppSharedPreferences.remove(
        SharedPreferencesKeys.KEY_LOCAL_ATTENDANCE_MAKHDOM_LIST);
    notifyListeners();
  }

  bool isLoadingAddAttendance = false;
  Future<bool> addAttendance(BuildContext context) async {
    convertToDate();
    customFunctions.showProgress(context);
    isLoadingAddAttendance = true;
    notifyListeners();

    // Get IDs from localAttendanceMakhdoms
    List<String> makhdomsIds =
        localAttendanceMakhdoms.map((m) => m.id.toString()).toList();

    Either<Failure, dynamic> response =
        await addClassAttendanceRepo.requestAddAttendance({
      "attendanceDate": attendanceDate,
      "makhdomsId": makhdomsIds,
    });

    bool result = response.fold(
      (Failure l) {
        final error = l.message ?? 'حدث خطأ';
        customFunctions.showError(message: error, context: context);
        return false;
      },
      (dynamic r) {
        customFunctions.showSuccess(
            message: 'تمت الإضافة بنجاح', context: context);
        return true;
      },
    );

    customFunctions.hideProgress();
    isLoading = false;
    notifyListeners();

    return result;
  }
}
