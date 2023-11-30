import 'package:abosiefienapp/presentation/screens/add_attendance/add_attendance_provider.dart';
import 'package:abosiefienapp/presentation/widgets/search_section_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      Provider.of<AddAttendanceProvider>(context, listen: false)
          .myMakhdoms(context)
          .then((value) => printDone('Done'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAttendanceProvider>(
        builder: (context, addattendanceprovider, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "إضافة حضور",
              style: AppStylesUtil.textRegularStyle(
                  20.0, Colors.white, FontWeight.w500),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // CALL LIST OF MAKHDOMS AGAIEN
                    addattendanceprovider.myMakhdoms(context);
                  })
            ],
          ),
          body: addattendanceprovider.listLength == 0
              ? Container()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      SearchSectionWidget(
                        attendanceProvider: addattendanceprovider,
                        filtervisibility: false,
                        searchonTap: () {
                          addattendanceprovider.myMakhdoms(context);
                        },
                      ),
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListView.builder(
                              itemCount: addattendanceprovider.items.length,
                              itemBuilder: (ctx, index) {
                                return CheckboxListTile(
                                    title: Text(
                                      (index + 1).toString() +
                                              ' -   ' +
                                              addattendanceprovider
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
                                    value: true,
                                    onChanged: (bool? val) {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "إجمالى العدد : ${addattendanceprovider.allMakhdoms.length}", //provider.allMakhdoms?.length
                            style: AppStylesUtil.textRegularStyle(
                                20.0, Colors.black, FontWeight.w500),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      )
                    ],
                  ),
                ));
    });
  }
}
