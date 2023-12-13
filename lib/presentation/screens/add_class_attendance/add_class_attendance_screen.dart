import 'package:abosiefienapp/presentation/screens/add_class_attendance/add_class_attendance_provider.dart';
import 'package:abosiefienapp/presentation/widgets/search_section_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// SEGIL AL MAKHDOMEN
class AddClassAttendanceScreen extends StatefulWidget {
  const AddClassAttendanceScreen({super.key});

  @override
  State<AddClassAttendanceScreen> createState() => _AddClassAttendanceScreenState();
}

class _AddClassAttendanceScreenState extends State<AddClassAttendanceScreen> {
  @override
  void initState() {
    // CALL MAKHDOMS LIST
    callMyMakhdomsApi();
    super.initState();
  }

  callMyMakhdomsApi() async {
    Future.delayed(Duration.zero, () {
      Provider.of<AddClassAttendanceProvider>(context, listen: false)
          .myMakhdoms(context)
          .then((value) => printDone('Done'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddClassAttendanceProvider>(
        builder: (context, addclassattendanceprovider, child) {
      return Scaffold(
          bottomNavigationBar: Card(
            elevation: 10,
            shadowColor: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Container(
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: Text(
                "إجمالى العدد : ${addclassattendanceprovider.allMakhdoms.length}", //provider.allMakhdoms?.length
                style: AppStylesUtil.textRegularStyle(
                    20.0, Colors.black, FontWeight.w500),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              "إضافة حضور",
              style: AppStylesUtil.textRegularStyle(
                  20.0, Colors.black, FontWeight.w500),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // CALL LIST OF MAKHDOMS AGAIEN
                    addclassattendanceprovider.myMakhdoms(context);
                  })
            ],
          ),
          body: addclassattendanceprovider.listLength == 0
              ? Container()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      SearchSectionWidget(
                        attendanceProvider: addclassattendanceprovider,
                        filtervisibility: false,
                        searchonTap: () {
                          addclassattendanceprovider.filterSearchResults(
                              addclassattendanceprovider.searchController.text);
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            itemCount: addclassattendanceprovider.items.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                title: Text(
                                  (index + 1).toString() +
                                          ' -   ' +
                                          addclassattendanceprovider
                                              .items[index].name
                                              .toString() ??
                                      '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textScaleFactor: 0.97,
                                  style: AppStylesUtil.textBoldStyle(
                                      17.0, Colors.black, FontWeight.bold),
                                ),
                                leading: CupertinoSwitch(
                                  activeColor: Colors.blue,
                                  value: addclassattendanceprovider
                                      .makhdomsAttendance[index].value,
                                  onChanged: (newvalue) {
                                    addclassattendanceprovider
                                        .changeSwitchValue(index, newvalue);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 40.h),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Text('حــفظ',
                            style: AppStylesUtil.textRegularStyle(
                                20, Colors.white, FontWeight.bold)),
                        onPressed: () {
                          addclassattendanceprovider
                              .addAttendance(context)
                              .then((value) => {
                                    Navigator.pushReplacementNamed(context,
                                        AppRoutes.addClassAttendanceRouteName)
                                  });
                        },
                      ),
                    ],
                  ),
                ));
    });
  }
}
