import 'package:abosiefienapp/Providers/add_attendance_provider.dart';
import 'package:abosiefienapp/presentation/widgets/app_date_picker_widget.dart';
import 'package:abosiefienapp/presentation/widgets/input_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../core/theming/app_styles_util.dart';

class AddAttendanceScreen extends StatelessWidget {
  const AddAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAttendanceProvider>(builder: (context, provider, child) {
      return Scaffold(
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${provider.localAttendanceMakhdoms.length}',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width / 1.5, 30.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 0.0.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0.r),
                    ),
                  ),
                ),
                child: Text('Send Attendance',
                    style: AppStylesUtil.textRegularStyle(
                        18.sp, Colors.white, FontWeight.w500)),
                onPressed: () async {
                  bool success = await provider.addAttendance(context);
                  if (success) {
                    provider.removeAllList(); // Clear cache on success
                  }
                },
              ),
            ],
          ),
        ],
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Add Attendance',
                style: AppStylesUtil.textRegularStyle(
                    20.0, Colors.black, FontWeight.w500),
              ),
              const Spacer(),
              provider.isLoading
                  ? const CircularProgressIndicator(color: Colors.blue)
                  : Text("${provider.names.length}")
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                provider.saveJsonData(); // Load names into local SQLite cache
              },
              icon: const Icon(Icons.download, color: Colors.blue),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
          child: Column(
            children: [
              Form(
                key: provider.attendanceformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InputFieldWidget(
                          labeltext: 'Points',
                          width: 136.w,
                          height: 40,
                          controller: provider.pointsController,
                          keyboardType: TextInputType.number,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? selected =
                                await customShowDatePicker(context);
                            if (selected != null) {
                              provider.setSelectedAttendanceDate(
                                  intl.DateFormat('yyyy-MM-dd')
                                      .format(selected));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.date_range,
                                  color: Colors.blue, size: 25.sp),
                              10.horizontalSpace,
                              Text(
                                provider.attendanceDate == ''
                                    ? 'Select Date'
                                    : provider.attendanceDate,
                                style: AppStylesUtil.textRegularStyle(
                                    17.sp, Colors.black, FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InputFieldWidget(
                          labeltext: 'ID',
                          width: 136.w,
                          height: 40,
                          controller: provider.codeController,
                          keyboardType: TextInputType.number,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(126.w, 30.h),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                          child: Text('Add',
                              style: AppStylesUtil.textRegularStyle(
                                  18.sp, Colors.white, FontWeight.w500)),
                          onPressed: () async {
                            int? code =
                                int.tryParse(provider.codeController.text);
                            if (code != null) {
                              await provider.findNameById(code);
                            }
                            provider.validate(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: ListView.builder(
                    itemCount: provider.localAttendanceMakhdoms
                        .length, // Display only searched data
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 2.0,
                        child: ListTile(
                          title: Text(
                              'ID: ${provider.localAttendanceMakhdoms[index].id}'),
                          subtitle: Text(
                              'Name: ${provider.localAttendanceMakhdoms[index].name}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.removeMakhdom(
                                  provider.localAttendanceMakhdoms[index].id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
