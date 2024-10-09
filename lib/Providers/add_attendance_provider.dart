import 'dart:convert';

import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/repositories/add_class_attendance_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  String? foundName;
  int? foundId;
  bool isLoading = false;

  // Initialize and load data from SharedPreferences
  AddAttendanceProvider() {
    loadMakhdomsFromCache(); // Load cached data
    loadNamesFromSharedPreferences(); // Load saved names
    updateStoredDataCount(); // Update the stored data count
  }

  Future<void> saveNamesToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNames', _names);
    print('Names saved to SharedPreferences: ${_names.length}');
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

      // Add to localAttendanceMakhdoms only after a successful search
      if (!localAttendanceMakhdoms.any((item) => item.id == foundId)) {
        localAttendanceMakhdoms.add(makhdom);
        await saveMakhdomsToCache(); // Save the updated list to cache
        notifyListeners(); // Update the UI with the found data
      }
    } else {
      foundName = null;
      foundId = null;
      print('Name not found for id: $id');
    }

    notifyListeners(); // Notify listeners to update the UI after search
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
    String jsonList =
        jsonEncode(localAttendanceMakhdoms.map((e) => e.toJson()).toList());
    await prefs.setString('attendanceMakhdoms', jsonList);
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
    Batch batch = db.batch(); // Use batch to reduce overhead

    for (var item in data) {
      batch.insert(
        'Data',
        {
          'id': item['id'], // Store 'id' as an integer
          'name': item['name']
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Avoid duplication
      );
    }

    await batch.commit(); // Execute all inserts in a batch
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

          // Store data without updating the UI
          List<String> existingNames = [];
          for (Map<String, dynamic> item in r) {
            if (item['name'] != null && item['id'] != null) {
              existingNames.add(item['name'] as String);
            }
          }

          await saveNamesToSharedPreferences(); // Save names to cache

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

  Future<int> getStoredDataCount() async {
    // Initialize the database
    Database db = await initializeDB();

    // Fetch all data from the SQLite 'Data' table
    final List<Map<String, dynamic>> maps = await db.query('Data');

    // Convert the data to a list of strings (for example, names)
    List<String> storedNames =
        maps.map((data) => data['name'] as String).toList();

    // Return the length of the list, which represents the number of stored entries
    return storedNames.length;
    notifyListeners();
  }

  int storedDataCount = 0;

  Future<void> updateStoredDataCount() async {
    storedDataCount = await getStoredDataCount();
    notifyListeners(); // Notify UI about the change
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
        addMakhdom(foundId!, foundName!);
      } else {
        printError('Found ID or Name is null');
        customFunctions.showError(
            message:
                'الاسم الذي تبحث عنه غير موجودة قد يكون تم اضافته حديثا تاكد من اتصالك بي الانترنت ثم قم باعادة تحميل الاسماء من الانترنت',
            context: context);
      }
    } else {
      printError('Not Validated');
      customFunctions.showError(
          message: 'يرجى ملء الحقول المطلوبة', context: context);
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

    List<String> makhdomsIds = localAttendanceMakhdoms
        .map((AllNamesModel m) => m.id.toString())
        .toList();

    Either<Failure, dynamic> response =
        await addClassAttendanceRepo.requestAddAttendance({
      "attendanceDate": attendanceDate,
      "makhdomsId": makhdomsIds,
      "points": pointsController.text,
    });

    bool result = response.fold(
      (Failure l) {
        final error = l.message ?? 'An error occurred';
        customFunctions.showError(message: error, context: context);
        return false;
      },
      (dynamic r) {
        customFunctions.showSuccess(
            message: 'تمت إضافة الحضور بنجاح', context: context);
        return true;
      },
    );

    customFunctions.hideProgress();
    isLoading = false;
    notifyListeners();

    return result;
  }

  String scanResult = "";
  Future<void> scanCode() async {
    String barCodeScanRes;
    try {
      barCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barCodeScanRes = 'حدث خطأ ما برجاء المحاولة مرة اخري';
    }
    scanResult = barCodeScanRes;
    codeController.text = barCodeScanRes;
    printDone('scanResult $scanResult');
    notifyListeners();
  }
}
