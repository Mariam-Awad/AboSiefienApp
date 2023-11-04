import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/presentation/screens/makhdom_details/makhdom_details_provider.dart';
import 'package:abosiefienapp/presentation/widgets/custom_lable_textfield_widget.dart';
import 'package:abosiefienapp/presentation/widgets/input_form_fields.dart';
import 'package:abosiefienapp/presentation/widgets/makhdom_details_widget.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:abosiefienapp/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MakhdomDetailsScreen extends StatefulWidget {
  final Data? makhdom;

  const MakhdomDetailsScreen({super.key, this.makhdom});

  @override
  _MakhdomDetailsScreenState createState() => _MakhdomDetailsScreenState();
}

class _MakhdomDetailsScreenState extends State<MakhdomDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String dateTitle = "";
  DateTime? selectedDate;
  FocusNode focusNode = FocusNode();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    setMakhdomData();
    super.initState();
  }

  setMakhdomData() {
    Provider.of<MakhdomDetailsProvider>(context, listen: false)
        .setRecievedMakhdom(widget.makhdom);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _makhdomData = {};

    // void _submit() async {
    //   if (!_formKey.currentState!.validate()) {
    //     // Invalid!
    //     return;
    //   }
    //   _formKey.currentState!.save();
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   // subimt data
    //   try {
    //     // if (_makhdoms.addnew) //add new
    //     // {
    //     //   Map<String, dynamic> response =
    //     //       await _makhdoms.add(_makhdomData['id'], _makhdomData);
    //     //   if (response['saved']) {
    //     //     // await AppToast.show(response['message']);
    //     //   }

    //     //   setState(() {
    //     //     _isLoading = false;
    //     //   });
    //     //   Navigator.pop(context);
    //     // } else //update
    //     // {
    //     //   Map<String, dynamic> response =
    //     //       await _makhdoms.update(_makhdomData['id'], _makhdomData);

    //     //   if (response['saved']) {
    //     //     // await AppToast.show(response['message']);
    //     //   }
    //     //   setState(() {
    //     //     _isLoading = false;
    //     //   });

    //     //   Navigator.pop(context);
    //     // }
    //   } catch (e) {
    //     print(e.toString());
    //     // await AppToast.show(e.toString());
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   } finally {}
    // }

    // print(_makhdomData['birthdate']);
    // dateTitle = _makhdomData['birthdate'] != null
    //     ? _makhdomData['birthdate'].toString().substring(0, 10)
    //     : "";
    return Consumer<MakhdomDetailsProvider>(
        builder: (context, makhdomdetailsprovider, child) {
      printError(
          'makhdomdetailsprovider ${makhdomdetailsprovider.recievedMakhdom!.name!}');
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "بيانات المخدوم",
            style: AppStylesUtil.textRegularStyle(
                20.0, Colors.white, FontWeight.w500),
          ),
          // actions: [
          //   IconButton(
          //       icon: const Icon(
          //         Icons.save,
          //         size: 25,
          //       ),
          //       onPressed: () {
          //         // todo submit function
          //         makhdomdetailsprovider.updateMyMakhdom(context,
          //             makhdomdetailsprovider.recievedMakhdom ?? Data());
          //       })
          // ],
        ),
        body: makhdomdetailsprovider == null
            ? Container()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InputFieldWidget(
                        labeltext: 'الإسم',
                        initialvalue:
                            makhdomdetailsprovider.recievedMakhdom!.name ?? '',
                        width: MediaQuery.of(context).size.width - 40,
                        //  controller: nameController,
                        keyboardType: TextInputType.text,
                        validation: nameController.isValidName(),
                        lines: 1,
                        obscure: false,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          makhdomdetailsprovider.recievedMakhdom!.name =
                              value ?? '';
                          //  _makhdomData['name'] = value ?? '';
                        },
                      ),
                      InputFieldWidget(
                          labeltext: 'التليفون',
                          initialvalue:
                              makhdomdetailsprovider.recievedMakhdom!.phone ??
                                  '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.number,
                          validation: nameController.isEmpty(),
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.phone =
                                value ?? '';
                            // _makhdomData['phone'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'العنوان/رقم',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.addNo
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.number,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.addNo =
                                int.parse(value) ?? 0;
                            // _makhdomData['addNo'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'العنوان/شارع',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.addStreet
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.addStreet =
                                value ?? '';
                            //  _makhdomData['addStreet'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'تاريخ الميلاد',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.birthdate
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.birthdate =
                                value ?? '';
                            //  _makhdomData['birthdate'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'أب الإعتراف',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.father
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.father =
                                value ?? '';
                            // _makhdomData['father'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'الجامعة',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.university
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.university =
                                value ?? '';
                            //  _makhdomData['university'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'الكلية',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.faculty
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.faculty =
                                value ?? '';
                            // _makhdomData['faculty'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'السنة الدراسية',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.levelId
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.number,
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.levelId =
                                int.parse(value) ?? 0;
                            // _makhdomData['studentYear'] = value ?? '';
                          }),
                      InputFieldWidget(
                          labeltext: 'الملاحظات',
                          initialvalue: makhdomdetailsprovider
                                  .recievedMakhdom!.notes
                                  .toString() ??
                              '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.number,
                          lines: 4,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.notes =
                                value ?? '';
                            // _makhdomData['notes'] = value ?? '';
                          }),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 40, 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Text('تعديل',
                            style: AppStylesUtil.textBoldStyle(
                                18, Colors.white, FontWeight.bold)),
                        onPressed: () {
                          makhdomdetailsprovider.updateMyMakhdom(context,
                              makhdomdetailsprovider.recievedMakhdom ?? Data());
                        },
                      ),
                    ],
                  ),
                )),
              ),
      );
    });
  }
}
