// ignore_for_file: prefer_if_null_operators

import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiRadioWidget extends StatefulWidget {
  RadioButtonModel radioValue;
  String title1;
  String title2;
  String title3;
  String title4;
  String title5;
  bool? checkedIncome;
  Color? color;
  dynamic onChanged;

  MultiRadioWidget(
      {required this.radioValue,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.title4,
      required this.title5,
      this.color,
      this.checkedIncome,
      this.onChanged});

  @override
  _MultiRadioWidgetState createState() => _MultiRadioWidgetState();
}

class _MultiRadioWidgetState extends State<MultiRadioWidget> {
  @override
  Widget build(BuildContext context) {
    int _value = widget.radioValue.value;
    printWarning('_value $_value');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Text(
              widget.title1,
              style: AppStylesUtil.textBoldStyle(
                  18,
                  widget.color != null ? widget.color! : Colors.white,
                  FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 10.0, left: 10, bottom: 20.0, top: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          value: 1,
                          groupValue: _value,
                          fillColor: MaterialStateProperty.all(Colors.blue),
                          onChanged: (dynamic value) {
                            _value = value;
                            widget.radioValue.value = value;
                            widget.onChanged(value);
                          }),
                      Text(widget.title2,
                          style: AppStylesUtil.textRegularStyle(
                              16,
                              widget.color != null
                                  ? widget.color!
                                  : Colors.white,
                              FontWeight.normal)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          value: 2,
                          groupValue: _value,
                          fillColor: MaterialStateProperty.all(Colors.blue),
                          onChanged: (dynamic value) {
                            _value = value;
                            widget.radioValue.value = value;
                            widget.onChanged(value);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          value: 3,
                          groupValue: _value,
                          fillColor: MaterialStateProperty.all(Colors.blue),
                          onChanged: (dynamic value) {
                            _value = value;
                            widget.radioValue.value = value;
                            widget.onChanged(value);
                          }),
                      Text(widget.title4,
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
          const SizedBox(
            height: 0.0,
          ),
        ],
      ),
    );
  }
}
