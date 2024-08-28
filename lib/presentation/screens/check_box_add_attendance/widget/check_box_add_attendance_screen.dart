import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controller/check_box_add_attendance_provder.dart';

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
    context.read<CheckBoxAddAttendanceProvider>().retrieveCheckBoxStates();
    context.read<CheckBoxAddAttendanceProvider>().retrieveJsonData();
    context.read<CheckBoxAddAttendanceProvider>().printDatabaseSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<CheckBoxAddAttendanceProvider>().clearCheckBoxes();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Consumer<CheckBoxAddAttendanceProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
              itemExtent: 80,
              itemCount: provider.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (provider.data.isEmpty) {
                  return Center(child: Text('No data found'));
                }

                final item = provider.data[index];

                return Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xffF8EDED),
                  ),
                  child: CheckboxListTile(
                      activeColor: const Color(0xff173B45),
                      dense: true,
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      value: item.isCheck,
                      secondary: const CircleAvatar(),
                      onChanged: (val) {
                        setState(() {
                          item.isCheck = val!;
                          provider.updateCheckBox(
                              item.userId, item.isCheck); // تحديث حالة Checkbox
                        });
                      }),
                );
              });
        },
      ),
    );
  }
}
