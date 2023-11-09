import 'package:abosiefienapp/presentation/screens/makhdom_details/makhdom_details_provider.dart';
import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_provider.dart';
import 'package:abosiefienapp/presentation/widgets/app_date_picker_widget.dart';
import 'package:abosiefienapp/presentation/widgets/arrange_section_widget.dart';
import 'package:abosiefienapp/presentation/widgets/gender.dart';
import 'package:abosiefienapp/presentation/widgets/multi_radio_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyMakhdomsProvider>(
        builder: (context, MyMakhdomsProvider, child) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ترتيب وفرز',
                      style: AppStylesUtil.textBoldStyle(
                          20, Colors.black, FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 26,
                        ))
                  ],
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
                MultiRadioWidget(
                    checkedIncome: false,
                    radioValue: MyMakhdomsProvider.sortValue,
                    title1: 'ترتيب',
                    title2: 'الإسم',
                    title3: 'الشارع',
                    title4: 'اخر حضور',
                    title5: '',
                    color: Colors.black,
                    onChanged: (value) {
                      MyMakhdomsProvider.setSelectedSortColumn(value ?? 1);
                      printDone(
                          'SORT COLUMN Updated ${MyMakhdomsProvider.sortCoulmn}');
                    }),
                const ArrangeSectionWidget(),
                const Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, bottom: 220.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'فرز',
                        textDirection: TextDirection.rtl,
                        style: AppStylesUtil.textBoldStyle(
                            20, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'تاريخ الغياب',
                        textDirection: TextDirection.rtl,
                        style: AppStylesUtil.textBoldStyle(
                            18, Colors.black, FontWeight.normal),
                      ),
                      // GenderSelect(
                      //     checkedIncome: true,
                      //     radioValue: MyMakhdomsProvider.filterValue,
                      //     title1: '',
                      //     title2: 'اخر حضور',
                      //     title3: 'اخر إفتقاد',
                      //     color: Colors.black,
                      //     onChanged: () {
                      //       // todo
                      //     }),
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              MyMakhdomsProvider.absentDate == ''
                                  ? 'اختر تاريخ الغياب'
                                  : MyMakhdomsProvider.absentDate,
                              style: AppStylesUtil.textBoldStyle(
                                12.sp,
                                Colors.black,
                                FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? selected =
                                    await customShowDatePicker(context);
                                MyMakhdomsProvider.setSelectedAbsentDate(
                                    intl.DateFormat('yyyy-MM-dd')
                                        .format(selected!));
                                printDone(
                                    'ABSENT DATE Updated ${MyMakhdomsProvider.absentDate}');
                              },
                              child: Icon(
                                Icons.date_range,
                                color: Colors.blue,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black26,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(400.w, 40.h),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Text('بحـث',
                        style: AppStylesUtil.textRegularStyle(
                            20, Colors.white, FontWeight.bold)),
                    onPressed: () {
                      MyMakhdomsProvider.myMakhdoms(context).then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
