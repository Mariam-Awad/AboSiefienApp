import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/presentation/screens/home_screen/home_screen_provider.dart';
import 'package:abosiefienapp/presentation/widgets/card_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeScreenProvider>(context, listen: false).getStoredUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, homescreenprovider, child) {
        //printWarning(homescreenprovider.permisions);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "برنامج المخدومين",
              style: AppStylesUtil.textBoldStyle(
                  22, Colors.white, FontWeight.w500),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    AppCache.instance.removeToken();
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.loginScreenRouteName);
                  })
            ],
            //leading: Text("data"),
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
                visible: true, //homescreenprovider.hasManageMakhdomsPermission,
                child: CardWidget(
                  "إدارة المخدومين",
                  () {
                    Navigator.pushNamed(
                        context, AppRoutes.manageOfMakhdomsRouteName);
                  },
                  Icons.person_pin_sharp,
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
