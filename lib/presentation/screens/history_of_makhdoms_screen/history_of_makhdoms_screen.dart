import 'package:abosiefienapp/presentation/widgets/card_widget.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';

class HistoryOfMakhdomsScreen extends StatelessWidget {
  const HistoryOfMakhdomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المخدومين",
          style: AppStylesUtil.textBoldStyle(22, Colors.white, FontWeight.w500),
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
                // Navigator.pushNamed(context, RegisterOfMakhdomen.routeName);
              },
              Icons.person_search,
            ),
            CardWidget(
              "سجل الغياب",
              () {
                // Navigator.pushNamed(context, KhademAbsent.routeName);
              },
              Icons.person_add_disabled,
            )
          ],
        ),
      ),
    );
  }
}
