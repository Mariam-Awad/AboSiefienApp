import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/presentation/screens/auth/login_provider.dart';
import 'package:abosiefienapp/presentation/screens/history_of_makhdoms_screen/history_of_makhdoms_screen.dart';
import 'package:abosiefienapp/presentation/screens/home_screen/home_screen.dart';
import 'package:abosiefienapp/presentation/screens/home_screen/home_screen_provider.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/route_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppCache.instance.init().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: "App Siefien App",
        theme: ThemeData(
          //  primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          AppRoutes.homeRouteName: (ctx) => HomeScreen(),
          AppRoutes.historyOfMakhdomsRouteName: (ctx) => const HistoryOfMakhdomsScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: AppRoutes.loginScreenRouteName,
      onGenerateRoute: AppRouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
      title: "رعية الله",
    );
  }
}
