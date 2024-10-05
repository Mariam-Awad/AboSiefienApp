import 'package:flutter/material.dart';

import '../../core/theming/app_styles_util.dart';

class MakhdomDetailsWidget extends StatelessWidget {
  final String title;
  final String value;
  final Function(String?)? handleChange;
  final int type; // 1 textbox(string),2 textbox(int),3 datepicker,4 multiline
  final bool isRequired;

  MakhdomDetailsWidget(
      this.title, this.value, this.handleChange, this.type, this.isRequired);

  TextInputType getKeyboardType() {
    switch (type) {
      case 1:
        return TextInputType.text;
      case 2:
        return TextInputType.number;
      case 4:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                style: AppStylesUtil.textRegularStyle(
                    18.0, Colors.black, FontWeight.w500),
                minLines: type == 4 ? 5 : 1,
                maxLines: type == 4 ? 6 : 2,
                textDirection: TextDirection.rtl,
                initialValue: value ?? "",
                keyboardType: getKeyboardType(),
                validator: (value) {
                  if (value!.isEmpty && isRequired) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onSaved: handleChange,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: AppStylesUtil.textRegularStyle(
                  18.0, Colors.black, FontWeight.w500),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
