import 'package:abosiefienapp/presentation/widgets/card_widget.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';

class ManageOfMakhdoms extends StatelessWidget {
  const ManageOfMakhdoms({super.key});

  @override
  Widget build(BuildContext context) {
    //final makhdom = Provider.of<Makhdoms>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إدارة المخدومين',
          style: AppStylesUtil.textBoldStyle(22, Colors.white, FontWeight.w500),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Visibility(
              // todo add permission
              visible: true,
              child: CardWidget(
                'إضافة المخدومين',
                () {
                  Navigator.pushNamed(context, AppRoutes.addMakhdomRouteName);
                },
                Icons.person_add_alt_1,
              ),
            ),
            // CardWidget("المخدومين الجدد", () {
            //   // Navigator.pushNamed(context, NewMakhdomList.routeName);
            // }, Icons.list_alt),
            // CardWidget(
            //   "إضافة حضور ب (الكود)",
            //   () {
            //     //Navigator.pushNamed(context, AddAttendanceByCode.routeName);
            //   },
            //   Icons.edit_location_outlined,
            // ),
            // CardWidget(
            //   "إضافة حضور ب (الاسم)",
            //   () {
            //     //Navigator.pushNamed(context, AddAttendance.routeName);
            //   },
            //   Icons.edit_location_outlined,
            // ),
          ],
        ),
      ),
    );
  }
}
