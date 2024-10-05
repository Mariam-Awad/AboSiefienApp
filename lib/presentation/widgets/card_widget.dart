import 'package:flutter/material.dart';

import '../../core/theming/app_styles_util.dart';

class CardWidget extends StatelessWidget {
  final String screenTitle;
  final void Function()? handleTap;
  final IconData _iconData;
  CardWidget(this.screenTitle, this.handleTap, this._iconData);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.blueGrey,
        onTap: handleTap,
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(20),
          width: 300,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Icon(
                  _iconData,
                  size: 30,
                ),
              ),
              Text(
                screenTitle,
                style: AppStylesUtil.textBoldStyle(
                    20, Colors.black, FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
