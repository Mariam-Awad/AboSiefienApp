import 'package:abosiefienapp/Providers/home_screen_provider.dart';
import 'package:abosiefienapp/core/extension_method/extension_navigation.dart';
import 'package:abosiefienapp/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/shared_prefrence/app_shared_prefrence.dart';
import '../../../core/theming/app_styles_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeScreenProvider>(context, listen: false)
          .getStoredUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, homescreenprovider, child) {
        return WillPopScope(
          onWillPop: () async {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "برنامج المخدومين",
                textDirection: TextDirection.rtl,
                style: AppStylesUtil.textBoldStyle(
                    22, Colors.black, FontWeight.w500),
              ),
              // automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      AppSharedPreferences.clear();
                      context.pushNamedAndRemoveUntil(
                          AppRoutes.loginScreenRouteName,
                          predicate: (route) => false);
                      // SystemChannels.platform
                      //     .invokeMethod('SystemNavigator.pop');
                    })
              ],
              // leading: Text("data"),
            ),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: homescreenprovider.hasGetMakhdomsPermission,
                  child: CardWidget(
                    "سجل المخدومين",
                    () {
                      Navigator.pushNamed(
                          context, AppRoutes.historyOfMakhdomsRouteName);
                    },
                    Icons.person,
                  ),
                ),
                Visibility(
                  visible:
                      true, //homescreenprovider.hasManageMakhdomsPermission,
                  child: CardWidget(
                    "إدارة المخدومين",
                    () {
                      context.pushNamed(
                        routeName: AppRoutes.manageOfMakhdomsRouteName,
                      );
                    },
                    Icons.person_pin_sharp,
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
