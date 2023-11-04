import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustomLabelTextFormField extends StatelessWidget {
  final String? prefixText;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final String? suffixIcon;
  final double? suffixIconSize;
  final String? prefixIcon;
  final void Function()? suffixOnTap;
  final void Function()? onTap;
  final bool? obscureText;
  final bool? readOnly;
  final int? maxLine;
  final String? Function(String?)? validator;
  final AutovalidateMode validateType;
  final TextInputType? keyboardType;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? suffixIconColor;
  final double? hintSize;

  const CustomLabelTextFormField({
    Key? key,
    this.prefixText,
    this.controller,
    this.labelText = '',
    this.hintText,
    this.hintTextColor,
    this.textColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixOnTap,
    this.onTap,
    this.obscureText,
    this.readOnly,
    this.maxLine,
    this.validator,
    this.validateType = AutovalidateMode.onUserInteraction,
    this.keyboardType,
    this.prefixWidget,
    this.suffixWidget,
    this.suffixIconSize,
    this.suffixIconColor,
    this.hintSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: controller,
        //  focusNode: _focusNode,
        validator: validator,
        autovalidateMode: validateType,
        obscureText: obscureText ?? false,
        maxLines: maxLine ?? 1,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        onTap: onTap,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: TextStyle(
              color: Colors.blue,
            ),
            hintText: hintText,
            hintStyle: AppStylesUtil.textRegularStyle(
                18, Colors.black, FontWeight.normal),
            label: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              child: Text(
                '${labelText}',
                style: AppStylesUtil.textRegularStyle(
                    18, Colors.black, FontWeight.normal),
              ),
            ),
            prefixIcon: prefixIcon == null
                ? (prefixText != null
                    ? Container(
                        width: 18,
                        height: 2,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(start: 3),
                        child: Text(
                          prefixText ?? '',
                          style: AppStylesUtil.textRegularStyle(
                              18, Colors.black, FontWeight.normal),
                        ),
                      )
                    : null)
                : Container(
                    padding: EdgeInsets.all(6 * 0.7),
                    child: SvgPicture.asset(prefixIcon ?? '',
                        fit: BoxFit.contain, color: Colors.blue)),
            suffixIcon: suffixIcon == null
                ? suffixWidget
                : InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: suffixOnTap,
                    child: Container(
                        padding: EdgeInsets.all(suffixIconSize ?? 3),
                        child: SvgPicture.asset(suffixIcon ?? '',
                            fit: BoxFit.contain, color: Colors.blue)),
                  ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 3, vertical: 2.0)),
        style:
            AppStylesUtil.textRegularStyle(18, Colors.black, FontWeight.normal),
      ),
    );
  }
}
