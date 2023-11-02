import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_provider.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
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
              child: Card(
                color: Colors.white.withOpacity(0.9), // Color(0xFFE3F2FD),
                shadowColor: const Color(0xFFE3F2FD),
                elevation: 6.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30.0,
                              backgroundColor: const Color(0xFFE3F2FD),
                              child: Icon(
                                Icons.person,
                                size: 30.0,
                                color: Theme.of(context).primaryColor,
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // _makhdoms.addnew = false;
                                  // printWarning('makhdom ${_makhdoms.addnew}');
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   MakhdomDetailsScreen.routeName,
                                  //   arguments: makhdom,
                                  // );
                                },
                                child: Text(
                                  makhdom.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: AppStylesUtil.textBoldStyle(
                                      20.0, Colors.black, FontWeight.w500),
                                ),
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
                                          splashColor: const Color(0xFFE3F2FD),
                                          highlightColor:
                                              const Color(0xFFE3F2FD),
                                          iconSize: 20.0,
                                          icon: Icon(
                                            makhdom.phone != "" || addAttendance
                                                ? actionIcon
                                                : Icons.call_end,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 20,
                                          ),
                                          onPressed: handlePress,
                                        ),
                                        IconButton(
                                          splashColor: const Color(0xFFF1F8E9),
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
                                                phone: makhdom.phone!);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'اخر حضور: ${makhdom.lastAttendanceDate ?? 'لا يوجد'}',
                            style: AppStylesUtil.textRegularStyle(
                                12, Colors.green, FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 35.0,
                          ),
                          Text(
                            'اخر إفتقاد: ${makhdom.lastCallDate ?? 'لا يوجد'}',
                            style: AppStylesUtil.textRegularStyle(
                                12, Colors.red, FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
