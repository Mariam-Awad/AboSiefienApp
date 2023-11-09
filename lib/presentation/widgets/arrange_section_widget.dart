import 'package:abosiefienapp/model/default_model.dart';
import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_provider.dart';
import 'package:abosiefienapp/presentation/widgets/custom_container_widget.dart';
import 'package:abosiefienapp/presentation/widgets/custom_dropdown_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ArrangeSectionWidget extends StatelessWidget {
  const ArrangeSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyMakhdomsProvider>(
      builder: (context, MyMakhdomsProvider, child) {
        printError('my ${MyMakhdomsProvider.sortValue.value}');
        return CustomContainerWidget(
            headline: 'رتب حسب',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 100.h,
                  child: CustomDropdownWidget(
                    hintText: 'رتب حسب',
                    items: [
                      DefaultModel(id: 1, name: 'تصاعدى'),
                      DefaultModel(id: 2, name: 'تنازلى'),
                    ],
                    value: MyMakhdomsProvider.sortDirection,
                    onChanged: (val) {
                      MyMakhdomsProvider.setSelectedSortDir(val ?? 1);

                      printDone(
                          'Sort Direction updated ${MyMakhdomsProvider.sortDirection}');
                    },
                  ),
                )),
              ],
            ));
      },
    );
  }
}
