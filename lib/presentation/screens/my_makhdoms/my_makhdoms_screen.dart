import 'package:abosiefienapp/presentation/screens/home_screen/home_screen_provider.dart';
import 'package:abosiefienapp/presentation/screens/my_makhdoms/my_makhdoms_provider.dart';
import 'package:abosiefienapp/presentation/widgets/mkhdom_list.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// SEGIL AL MAKHDOMEN
class MyMakhdomsScreen extends StatefulWidget {
  const MyMakhdomsScreen({super.key});

  @override
  State<MyMakhdomsScreen> createState() => _MyMakhdomsScreenState();
}

class _MyMakhdomsScreenState extends State<MyMakhdomsScreen> {
  @override
  void initState() {
    // CALL MAKHDOMS LIST
    callMyMakhdomsApi();
    super.initState();
  }

  callMyMakhdomsApi() async {
    Future.delayed(Duration.zero, () {
      Provider.of<MyMakhdomsProvider>(context, listen: false)
          .myMakhdoms(context)
          .then((value) => printDone('Done'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyMakhdomsProvider>(
        builder: (context, mymakhdomsprovider, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "سجل المخدومين",
              style: AppStylesUtil.textRegularStyle(
                  20.0, Colors.white, FontWeight.w500),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // CALL LIST OF MAKHDOMS AGAIEN
                    mymakhdomsprovider.myMakhdoms(context);
                  })
            ],
          ),
          body: mymakhdomsprovider.listLength == 0
              ? Container()
              // Center(
              //     child: Text(
              //       'لا يوجد مخدومين',
              //       style: AppStylesUtil.textRegularStyle(
              //           20.0, Colors.black, FontWeight.w500),
              //       textAlign: TextAlign.center,
              //     ),
              //   )
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: mymakhdomsprovider.allMakhdoms
                              .length, //provider.allMakhdoms?.length,
                          itemBuilder: (ctx, index) {
                            return MakdomList(
                              mymakhdomsprovider.allMakhdoms[
                                  index], // provider.allMakhdoms![index],
                              Icons.phone,
                              () => launchUrl(Uri.parse(
                                  'tel://${mymakhdomsprovider.allMakhdoms[index].phone}')), //provider.allMakhdoms![index].phone
                              false,
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "إجمالى العدد : ${mymakhdomsprovider.allMakhdoms.length}", //provider.allMakhdoms?.length
                          style: AppStylesUtil.textRegularStyle(
                              20.0, Colors.black, FontWeight.w500),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    )
                  ],
                ));
    });
  }
}
