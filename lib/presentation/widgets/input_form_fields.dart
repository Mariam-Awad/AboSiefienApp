import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final bool obscure;
  final double? height;
  final double width;
  final int lines;
  final Widget? suffix;
  final Widget? prefix;
  final String? hinttext;
  final String? labeltext;
  final String? initialvalue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextStyle? hintstyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? validation;
  final String? validationText;
  void Function(String)? onChanged;

  void Function()? onChangedCompleted;
  dynamic disable;
  bool? isDisable = true;

  InputFieldWidget({
    Key? key,
    required this.obscure,
    this.height,
    required this.width,
    required this.lines,
    this.controller,
    this.suffix,
    this.keyboardType,
    this.initialvalue,
    this.hinttext,
    this.labeltext,
    this.hintstyle,
    this.labelStyle,
    this.style,
    this.textAlign,
    this.validation,
    this.validationText,
    this.onChanged,
    this.onChangedCompleted,
    this.prefix,
    this.disable,
    this.isDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          initialValue: initialvalue,
          // autovalidate:true,
          //  onChanged: onchanged,
          onEditingComplete: onChangedCompleted,
          onChanged: onChanged,
          autocorrect: true,
          // onEditingComplete: onchanged,
          controller: controller,
          maxLines: lines,
          enabled: isDisable,
          cursorColor: Colors.blue,
          textAlign: textAlign != null ? textAlign! : TextAlign.start,
          //textDirection: TextDirection.rtl,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: style != null
              ? style
              : AppStylesUtil.textRegularStyle(
                  16, Colors.black, FontWeight.normal),
          validator: (value) {
            if (validation == false && validation != null) {
              return validationText;
            } else if (value!.isEmpty) {
              return validationText;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: hinttext,
            labelText: labeltext,
            hintStyle: hintstyle ??
                AppStylesUtil.textRegularStyle(
                    16, Colors.black, FontWeight.w500),
            labelStyle: labelStyle ??
                AppStylesUtil.textRegularStyle(
                    16, Colors.black, FontWeight.w500),
            contentPadding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            prefixIcon: suffix,
            suffixIcon: prefix,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isDisable == false ? Colors.white : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isDisable == false ? Colors.white : Colors.blue,
                  width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isDisable == false ? Colors.white : Colors.blue,
                  width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isDisable == false ? Colors.white : Colors.blue,
                  width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: isDisable == false ? Colors.white : Colors.blue,
                  width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
