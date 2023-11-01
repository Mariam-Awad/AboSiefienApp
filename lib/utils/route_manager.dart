import 'package:abosiefienapp/presentation/screens/auth/login_screen.dart';
import 'package:abosiefienapp/presentation/screens/history_of_makhdoms_screen/history_of_makhdoms_screen.dart';
import 'package:abosiefienapp/presentation/screens/home_screen/home_screen.dart';
import 'package:abosiefienapp/presentation/screens/manage_of_makhdoms/manage_of_makhdoms_screen.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';

class AppRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case AppRoutes.homeRouteName:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case AppRoutes.historyOfMakhdomsRouteName:
        return MaterialPageRoute(
          builder: (context) => const HistoryOfMakhdomsScreen(),
        );
      case AppRoutes.manageOfMakhdomsRouteName:
        return MaterialPageRoute(
          builder: (context) => ManageOfMakhdoms(),
        );
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              "هذه الصفحة غير متوفرة الاّن",
              style: AppStylesUtil.textRegularStyle(
                  20, Colors.black, FontWeight.bold),
            ),
          ),
        ),
      );
}
