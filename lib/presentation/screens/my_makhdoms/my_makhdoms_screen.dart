import 'package:abosiefienapp/Providers/my_makhdoms_provider.dart';
import 'package:abosiefienapp/presentation/widgets/mkhdom_list.dart';
import 'package:abosiefienapp/presentation/widgets/search_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theming/app_styles_util.dart';
import '../../../core/utils/app_debug_prints.dart';

// SEGIL AL MAKHDOMEN
class MyMakhdomsScreen extends StatefulWidget {
  const MyMakhdomsScreen({super.key});

  @override
  State<MyMakhdomsScreen> createState() => _MyMakhdomsScreenState();
}

class _MyMakhdomsScreenState extends State<MyMakhdomsScreen> {
  @override
  void deactivate() {
    Provider.of<MyMakhdomsProvider>(context, listen: false).clearFilterDate();
    super.deactivate();
  }

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
        builder: (context, MyMakhdomsProvider mymakhdomsprovider, child) {
      return Scaffold(
          bottomNavigationBar: Card(
            elevation: 10,
            shadowColor: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          ),
          appBar: AppBar(
            title: Text(
              "سجل المخدومين",
              style: AppStylesUtil.textRegularStyle(
                  20.0, Colors.black, FontWeight.w500),
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
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      SearchSectionWidget(
                        provider: mymakhdomsprovider,
                        filtervisibility: true,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            itemCount: mymakhdomsprovider.items.length,
                            itemBuilder: (ctx, index) {
                              return MakdomList(
                                mymakhdomsprovider.items[index],
                                Icons.phone,
                                () => launchUrl(Uri.parse(
                                    'tel://${mymakhdomsprovider.items[index].phone}')), //provider.allMakhdoms![index].phone
                                false,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
    });
  }
}
