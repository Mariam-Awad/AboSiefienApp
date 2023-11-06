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
      printError('my ${MyMakhdomsProvider.sortValue.value}');
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
                    title5: 'اخر إفتقاد',
                    color: Colors.black,
                    onChanged: () {}),
                const ArrangeSectionWidget(),
                const Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'فرز',
                        textDirection: TextDirection.rtl,
                        style: AppStylesUtil.textBoldStyle(
                            20, Colors.black, FontWeight.bold),
                      ),
                      GenderSelect(
                          checkedIncome: true,
                          radioValue: MyMakhdomsProvider.filterValue,
                          title1: '',
                          title2: 'اخر حضور',
                          title3: 'اخر إفتقاد',
                          color: Colors.black,
                          onChanged: () {
                            // todo
                          }),
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
                              MyMakhdomsProvider.selectedLasrAttendanceDate ??
                                  'اخر حضور',
                              style: AppStylesUtil.textBoldStyle(
                                16.sp,
                                Colors.black,
                                FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? selected =
                                    await customShowDatePicker(context);
                                MyMakhdomsProvider
                                    .setSelectedLastAttendanceDate(
                                        intl.DateFormat('yyyy-MM-dd')
                                            .format(selected!));
                                printWarning(
                                    'LAST ATTENDANCE ${MyMakhdomsProvider.selectedLasrAttendanceDate ?? ''}');
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
