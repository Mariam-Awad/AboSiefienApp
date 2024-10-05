import 'package:abosiefienapp/Providers/my_makhdoms_provider.dart';
import 'package:abosiefienapp/model/dropdown_model.dart';
import 'package:abosiefienapp/presentation/widgets/custom_container_widget.dart';
import 'package:abosiefienapp/presentation/widgets/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_debug_prints.dart';

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
                      DropdownModel(id: 1, name: 'تصاعدى'),
                      DropdownModel(id: 2, name: 'تنازلى'),
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
