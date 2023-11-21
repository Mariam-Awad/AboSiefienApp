import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/presentation/screens/add_makhdom/add_makhdom_screen.dart';
import 'package:abosiefienapp/presentation/screens/auth/login_screen.dart';
import 'package:abosiefienapp/presentation/screens/history_of_makhdoms/history_of_makhdoms_screen.dart';
import 'package:abosiefienapp/presentation/screens/home_screen/home_screen.dart';
import 'package:abosiefienapp/presentation/screens/makhdom_details/makhdom_details_screen.dart';
import 'package:abosiefienapp/presentation/screens/manage_of_makhdoms/manage_of_makhdoms_screen.dart';
import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_screen.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';

class AppRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    printDone('arge $args');
    switch (settings.name) {
      case AppRoutes.loginScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppRoutes.homeRouteName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppRoutes.historyOfMakhdomsRouteName:
        return MaterialPageRoute(
          builder: (context) => const HistoryOfMakhdomsScreen(),
        );
      case AppRoutes.manageOfMakhdomsRouteName:
        return MaterialPageRoute(
          builder: (context) => const ManageOfMakhdoms(),
        );
      case AppRoutes.myMakhdomsRouteName:
        return MaterialPageRoute(
          builder: (context) => const MyMakhdomsScreen(),
        );
      case AppRoutes.makhdomDetailsRouteName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args),
          builder: (context) => MakhdomDetailsScreen(
            makhdom: args as Data,
          ),
        );
      case AppRoutes.addMakhdomRouteName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args),
          builder: (context) => const AddMakhdomScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ); //_undefinedRoute();
    }
  }

  // static Route<dynamic> _undefinedRoute() => MaterialPageRoute(
  //       builder: (context) => Scaffold(
  //         body: Center(
  //           child: Text(
  //             "هذه الصفحة غير متوفرة الاّن",
  //             style: AppStylesUtil.textRegularStyle(
  //                 20, Colors.black, FontWeight.bold),
  //           ),
  //         ),
  //       ),
  //     );
}
