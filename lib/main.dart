import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/app_providers/app_providers.dart';
import 'core/network/dio_helper.dart';
import 'core/route/app_routes.dart';
import 'core/route/route_manager.dart';
import 'core/shared_prefrence/app_shared_prefrence.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  DioHelper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              title: "App Siefien App",
              theme: ThemeData(
                //  primarySwatch: Colors.purple,
                primaryColor: Colors.purple,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const MyHomePage(title: ''),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
      title: "رعية الله",
      initialRoute:
          AppSharedPreferences.getString(SharedPreferencesKeys.accessToken) !=
                  null
              ? AppRoutes.homeRouteName
              : AppRoutes.loginScreenRouteName,
    );
  }
}
