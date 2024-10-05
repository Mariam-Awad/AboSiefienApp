import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/app_styles_util.dart';

class LocalAttendanceMakhdomWidget extends StatelessWidget {
  final int makhdomCode;
  final void Function()? removePress;

  const LocalAttendanceMakhdomWidget(
      {super.key, required this.makhdomCode, this.removePress});

  @override
  Widget build(BuildContext context) {
    // final MyMakhdomsProvider provider =
    //     Provider.of<MyMakhdomsProvider>(context);
    return makhdomCode != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Card(
              color: Colors.white,
              elevation: 6.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: removePress,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          )),
                    ),
                    Text(
                      makhdomCode.toString(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      textScaleFactor: 0.97,
                      style: AppStylesUtil.textBoldStyle(
                          22.0, Colors.black, FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
