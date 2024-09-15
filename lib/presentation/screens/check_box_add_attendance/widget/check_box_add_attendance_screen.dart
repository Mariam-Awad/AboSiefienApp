import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../Providers/check_box_add_attendance_provder.dart';
import '../../../widgets/app_date_picker_widget.dart';

class CheckBoxAddAttendanceScreen extends StatefulWidget {
  @override
  CheckBoxAddAttendanceScreenState createState() =>
      CheckBoxAddAttendanceScreenState();
}

class CheckBoxAddAttendanceScreenState
    extends State<CheckBoxAddAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckBoxAddAttendanceProvider>().loadDataOnStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: Size(MediaQuery.of(context).size.width, 30.h),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 0.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0.r),
              ),
            ),
          ),
          onPressed: () {
            context
                .read<CheckBoxAddAttendanceProvider>()
                .addAttendance(context);
          },
          child: const Text(
            'Send',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              DateTime? selected = await customShowDatePicker(context);
              context
                  .read<CheckBoxAddAttendanceProvider>()
                  .setSelectedAttendanceDate(
                    intl.DateFormat('yyyy-MM-dd').format(selected!),
                  );
            },
            icon: Icon(
              Icons.date_range,
              color: Colors.blue,
              size: 25.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CheckBoxAddAttendanceProvider>().loadDataOnStart();
            },
            icon: const Icon(
              Icons.download,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Consumer<CheckBoxAddAttendanceProvider>(
        builder: (context, CheckBoxAddAttendanceProvider provider, child) {
          switch (provider.dataState) {
            case DataState.loading:
              return const Center(child: CircularProgressIndicator());
            case DataState.noData:
              return const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(color: Colors.teal),
                ),
              );
            case DataState.loaded:
              if (provider.names.isNotEmpty) {
                return ListView.builder(
                  itemExtent: 80,
                  itemCount: provider.names.length,
                  itemBuilder: (BuildContext context, int index) {
                    String name = provider.names[index];
                    String id = provider.ids[index]
                        .toString(); // Convert the id to a String

                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xffF8EDED),
                      ),
                      child: CheckboxListTile(
                        subtitle: Text(provider.attendanceDate ??
                            intl.DateFormat('yyyy-MM-dd')
                                .format(DateTime.now())
                                .toString()),
                        value: provider.checkboxStates[id] ??
                            false, // Use the ID as a string here
                        onChanged: (value) {
                          provider.saveCheckboxState(
                              id, value ?? false); // Save state with string ID
                        },
                        title: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No names available',
                    style: TextStyle(color: Colors.teal),
                  ),
                );
              }

            default:
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(color: Colors.red),
                ),
              );
          }
        },
      ),
    );
  }
}
