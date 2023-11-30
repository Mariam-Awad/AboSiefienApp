import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_provider.dart';
import 'package:abosiefienapp/utils/app_assets_util.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../model/mymakhdoms_model.dart';

// ignore: must_be_immutable
class MakdomList extends StatelessWidget {
  final Data makhdom;
  final IconData actionIcon;
  final void Function()? handlePress;
  final bool addAttendance;

  MakdomList(
      this.makhdom, this.actionIcon, this.handlePress, this.addAttendance);

  @override
  Widget build(BuildContext context) {
    final MyMakhdomsProvider provider =
        Provider.of<MyMakhdomsProvider>(context);
    return makhdom.name != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: InkWell(
                onTap: () {
                  printWarning('Check Parse $makhdom');
                  printWarning('makhdomDetails Navigate');
                  Navigator.pushNamed(
                    context,
                    AppRoutes.makhdomDetailsRouteName,
                    arguments: makhdom,
                  );
                },
                child: Card(
                  color: Colors.white.withOpacity(0.9), // Color(0xFFE3F2FD),
                  shadowColor: const Color(0xFFE3F2FD),
                  elevation: 6.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28.0,
                              backgroundColor: const Color(0xFFE3F2FD),
                              child: makhdom.genderId == 1
                                  ? Image.asset(
                                      AppAssetsUtil.maleAvatar,
                                      width: 50.0,
                                      height: 50.0,
                                    )
                                  : Image.asset(
                                      AppAssetsUtil.femaleAvatar,
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  makhdom.name ?? "",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textScaleFactor: 0.97,
                                  style: AppStylesUtil.textBoldStyle(
                                      17.0, Colors.black, FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      makhdom.phone ?? "",
                                      textAlign: TextAlign.center,
                                      style: AppStylesUtil.textRegularStyle(
                                          20.0, Colors.black, FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 14.0,
                                    ),
                                    Visibility(
                                      visible:
                                          makhdom.phone != null ? true : false,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            splashColor:
                                                const Color(0xFFE3F2FD),
                                            highlightColor:
                                                const Color(0xFFE3F2FD),
                                            iconSize: 20.0,
                                            icon: Icon(
                                              makhdom.phone != "" ||
                                                      addAttendance
                                                  ? actionIcon
                                                  : Icons.call_end,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20,
                                            ),
                                            onPressed: handlePress,
                                          ),
                                          IconButton(
                                            splashColor:
                                                const Color(0xFFF1F8E9),
                                            highlightColor:
                                                const Color(0xFFF1F8E9),
                                            iconSize: 25.0,
                                            icon: const FaIcon(
                                              FontAwesomeIcons.whatsapp,
                                              size: 25,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              provider.sendWhatsAppMessage(
                                                context: context,
                                                phone: makhdom.phone!,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${makhdom.id ?? 'لا يوجد'}',
                                style: AppStylesUtil.textRegularStyle(
                                    12, Colors.blue, FontWeight.bold),
                              ),
                              Text(
                                makhdom.lastAttendanceDate == null
                                    ? 'اخر حضور: لا يوجد'
                                    : 'اخر حضور: ${provider.convertToDate(makhdom.lastAttendanceDate ?? '')}',
                                style: AppStylesUtil.textRegularStyle(
                                    12, Colors.green, FontWeight.bold),
                              ),
                              // const SizedBox(
                              //   width: 35.0,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
