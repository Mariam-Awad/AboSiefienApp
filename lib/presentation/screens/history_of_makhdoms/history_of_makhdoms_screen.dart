import 'package:abosiefienapp/Providers/home_screen_provider.dart';
import 'package:abosiefienapp/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/theming/app_styles_util.dart';

class HistoryOfMakhdomsScreen extends StatelessWidget {
  const HistoryOfMakhdomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "المخدومين",
            style:
                AppStylesUtil.textBoldStyle(22, Colors.black, FontWeight.w500),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(14),
          width: double.infinity,
          child: Column(
            children: [
              CardWidget(
                "مخدومينى",
                () {
                  Navigator.pushNamed(context, AppRoutes.myMakhdomsRouteName);
                },
                Icons.person_search,
              ),
              Visibility(
                visible: homeScreenProvider.hasaddclassattendancePermission,
                child: CardWidget(
                  "إضافة حضور",
                  () {
                    Navigator.pushNamed(
                        context, AppRoutes.addClassAttendanceRouteName);
                  },
                  Icons.edit,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
