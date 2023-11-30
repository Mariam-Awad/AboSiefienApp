import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List? items;
  final int? value;
  final String? hintText;
  final String? labelText;
  final void Function(int?)? onChanged;
  final String? prefixIcon;
  final double? fontSize;
  final double? horizontalPadding;

  const CustomDropdownWidget(
      {Key? key,
      this.items,
      this.value,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.prefixIcon,
      this.fontSize,
      this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStylesUtil.textRegularStyle(
              18, Colors.black, FontWeight.normal),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 0.5.w),
            child: Text(
              labelText ?? '',
              style: AppStylesUtil.textBoldStyle(
                  18, Colors.black, FontWeight.w500),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: horizontalPadding ?? 6.h * 0.6,
          ),
        ),
        items: (items ?? [])
            .map((item) => DropdownMenuItem<int>(
                  alignment: Alignment.centerRight,
                  value: item.id,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name.toString(),
                          textDirection: TextDirection.rtl,
                          style: AppStylesUtil.textRegularStyle(
                              16, Colors.black, FontWeight.normal),
                        ),
                        Text(
                          item.extratext != null
                              ? item.extratext.toString()
                              : '',
                          textDirection: TextDirection.rtl,
                          style: AppStylesUtil.textRegularStyle(
                              16, Colors.black, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 25,
        ),
        style:
            AppStylesUtil.textRegularStyle(18, Colors.black, FontWeight.normal),
      ),
    );
  }
}
