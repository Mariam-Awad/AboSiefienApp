import 'package:abosiefienapp/Providers/add_attendance_provider.dart';
import 'package:abosiefienapp/core/utils/validator.dart';
import 'package:abosiefienapp/presentation/widgets/app_date_picker_widget.dart';
import 'package:abosiefienapp/presentation/widgets/input_form_fields.dart';
import 'package:abosiefienapp/presentation/widgets/local_attendance_makhdom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/theming/app_styles_util.dart';
import '../../../core/utils/app_debug_prints.dart';

// SEGIL AL MAKHDOMEN
class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  @override
  void initState() {
    // CALL MAKHDOMS LIST
    callMyMakhdomsApi();
    super.initState();
  }

  callMyMakhdomsApi() async {
    Future.delayed(Duration.zero, () {
      // Provider.of<AddClassAttendanceProvider>(context, listen: false)
      //     .myMakhdoms(context)
      //     .then((value) => printDone('Done'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAttendanceProvider>(
        builder: (context, addattendanceprovider, child) {
      return Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: 16.0, top: 0.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(MediaQuery.of(context).size.width, 30.h),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
              child: Text('حـــفظ',
                  style: AppStylesUtil.textRegularStyle(
                      18.sp, Colors.white, FontWeight.w500)),
              onPressed: () {
                addattendanceprovider.addAttendance(context).then((value) => {
                      if (value == true) {addattendanceprovider.removeAllList()}
                    });
              },
            ),
          ),
          appBar: AppBar(
            title: Text(
              'إضافة حضور',
              style: AppStylesUtil.textRegularStyle(
                  20.0, Colors.black, FontWeight.w500),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppRoutes.checkBoxAddAttendanceScreen);
                  },
                  icon: const Icon(Icons.checklist))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
            child: Column(
              children: [
                Form(
                  key: addattendanceprovider.attendanceformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InputFieldWidget(
                            labeltext: 'النقاط',
                            width: 136.w,
                            height: 40,
                            controller: addattendanceprovider.pointsController,
                            keyboardType: TextInputType.number,
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              addattendanceprovider.pointsController.text =
                                  value ?? '';
                            },
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? selected =
                                  await customShowDatePicker(context);
                              addattendanceprovider.setSelectedAttendanceDate(
                                  intl.DateFormat('yyyy-MM-dd')
                                      .format(selected!));
                              printDone(
                                  'Attendance DATE Updated ${addattendanceprovider.attendanceDate}');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                  size: 25.sp,
                                ),
                                10.horizontalSpace,
                                Text(
                                  addattendanceprovider.attendanceDate == ''
                                      ? 'تاريخ الإضافة'
                                      : addattendanceprovider.attendanceDate,
                                  style: AppStylesUtil.textRegularStyle(
                                    17.sp,
                                    Colors.black,
                                    FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              fixedSize: Size(126.w, 30.h),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                            ),
                            child: Text('إضافة',
                                style: AppStylesUtil.textRegularStyle(
                                    18.sp, Colors.white, FontWeight.w500)),
                            onPressed: () {
                              addattendanceprovider.validate(context);
                            },
                          ),
                          InputFieldWidget(
                            labeltext: 'كود المخدوم',
                            width: 136.w,
                            height: 40,
                            controller: addattendanceprovider.codeController,
                            keyboardType: TextInputType.number,
                            validation:
                                addattendanceprovider.codeController.isEmpty(),
                            validationText: 'يجب كتابة كود المخدوم',
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              addattendanceprovider.codeController.text = value;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: GridView.builder(
                      itemCount:
                          addattendanceprovider.localAttendanceMakhdoms.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 1,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4),
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: LocalAttendanceMakhdomWidget(
                            makhdomCode: addattendanceprovider
                                .localAttendanceMakhdoms[index],
                            removePress: () {
                              addattendanceprovider.removeMakhdom(
                                  addattendanceprovider
                                      .localAttendanceMakhdoms[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
