// ignore_for_file: prefer_if_null_operators

import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/app_styles_util.dart';
import '../../core/utils/app_debug_prints.dart';

class GenderSelect extends StatefulWidget {
  RadioButtonModel radioValue;
  String title1;
  String title2;
  String title3;
  bool? checkedIncome;
  Color? color;
  dynamic onChanged;

  GenderSelect(
      {required this.radioValue,
      required this.title1,
      required this.title2,
      required this.title3,
      this.color,
      this.checkedIncome,
      this.onChanged});

  @override
  _GenderSelectState createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  @override
  Widget build(BuildContext context) {
    int _value = widget.radioValue.value;
    printWarning('_value $_value');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title1 == '' ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                widget.title1,
                style: AppStylesUtil.textRegularStyle(
                    16,
                    widget.color != null ? widget.color! : Colors.white,
                    FontWeight.normal),
              ),
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.only(right: 40.w, left: 40.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _value,
                        fillColor: widget.checkedIncome == true
                            ? MaterialStateProperty.all(Colors.blue)
                            : MaterialStateProperty.all(Colors.grey),
                        onChanged: (dynamic value) {
                          setState(() {
                            _value = value;
                            widget.radioValue.value = value;
                            widget.onChanged(value);
                          });
                        },
                      ),
                      Text(widget.title2,
                          style: AppStylesUtil.textRegularStyle(
                              16,
                              widget.color != null
                                  ? widget.color!
                                  : Colors.white,
                              FontWeight.normal)),
                    ],
                  ),
                  25.horizontalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          value: 2,
                          groupValue: _value,
                          fillColor: widget.checkedIncome == true
                              ? MaterialStateProperty.all(Colors.blue)
                              : MaterialStateProperty.all(
                                  const Color(0xffEDEDED)),
                          onChanged: (dynamic value) {
                            setState(() {
                              _value = value;
                              widget.radioValue.value = value;
                              widget.onChanged(value);
                            });
                          }),
                      Text(widget.title3,
                          style: AppStylesUtil.textRegularStyle(
                              16,
                              widget.color != null
                                  ? widget.color!
                                  : Colors.white,
                              FontWeight.normal)),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
