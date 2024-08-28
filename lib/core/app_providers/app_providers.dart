import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../Providers/add_attendance_provider.dart';
import '../../Providers/add_class_attendance_provider.dart';
import '../../Providers/add_makhdom_provider.dart';
import '../../Providers/home_screen_provider.dart';
import '../../Providers/login_provider.dart';
import '../../Providers/makhdom_details_provider.dart';
import '../../Providers/my_makhdoms_provider.dart';
import '../../presentation/screens/check_box_add_attendance/controller/check_box_add_attendance_provder.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[...independentServices];
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (context) => CheckBoxAddAttendanceProvider()),
  ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
  ChangeNotifierProvider(create: (context) => MyMakhdomsProvider()),
  ChangeNotifierProvider(create: (context) => MakhdomDetailsProvider()),
  ChangeNotifierProvider(create: (context) => AddMakhdomProvider()),
  ChangeNotifierProvider(create: (context) => AddClassAttendanceProvider()),
  ChangeNotifierProvider(
    create: (context) => AddAttendanceProvider(),
  ),
];
