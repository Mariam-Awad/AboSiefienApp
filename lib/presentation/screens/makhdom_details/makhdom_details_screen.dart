import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/presentation/screens/makhdom_details/makhdom_details_provider.dart';
import 'package:abosiefienapp/presentation/widgets/app_date_picker_widget.dart';
import 'package:abosiefienapp/presentation/widgets/gender.dart';
import 'package:abosiefienapp/presentation/widgets/input_form_fields.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:abosiefienapp/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class MakhdomDetailsScreen extends StatefulWidget {
  final Data? makhdom;

  const MakhdomDetailsScreen({super.key, this.makhdom});

  @override
  _MakhdomDetailsScreenState createState() => _MakhdomDetailsScreenState();
}

class _MakhdomDetailsScreenState extends State<MakhdomDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String dateTitle = "";
  String? selectedDate;
  FocusNode focusNode = FocusNode();

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
        ),
        body: makhdomdetailsprovider == null
            ? Container()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InputFieldWidget(
                          labeltext: 'الإسم',
                          initialvalue:
                              makhdomdetailsprovider.recievedMakhdom!.name ??
                                  '',
                          width: MediaQuery.of(context).size.width - 40,
                          //  controller: nameController,
                          keyboardType: TextInputType.text,
                          validation: makhdomdetailsprovider.nameController
                              .isValidName(),
                          lines: 1,
                          obscure: false,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            makhdomdetailsprovider.recievedMakhdom!.name =
                                value ?? '';
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
                            // validation: makhdomdetailsprovider.phoneController
                            //     .isValidPhone(),
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              makhdomdetailsprovider.recievedMakhdom!.phone =
                                  value ?? '';
                            }),
                        InputFieldWidget(
                            labeltext: 'رقم تليفون اّخر',
                            initialvalue: makhdomdetailsprovider
                                    .recievedMakhdom!.phone2 ??
                                '',
                            width: MediaQuery.of(context).size.width - 40,
                            //  controller: nameController,
                            keyboardType: TextInputType.number,
                            // validation: makhdomdetailsprovider.phone2Controller
                            //     .isValidPhone(),
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              makhdomdetailsprovider.recievedMakhdom!.phone2 =
                                  value ?? '';
                            }),
                        GenderSelect(
                            checkedIncome: false,
                            radioValue: makhdomdetailsprovider.genderValue,
                            title1: 'النوع',
                            title2: 'ذكر',
                            title3: 'انثى',
                            color: Colors.black,
                            onChanged: (value) {
                              printDone('in screen value $value');
                              makhdomdetailsprovider.recievedMakhdom!.genderId =
                                  value;
                            }),
                        InputFieldWidget(
                            labeltext: 'العنوان/رقم',
                            initialvalue: makhdomdetailsprovider
                                    .recievedMakhdom!.addNo
                                    .toString() ??
                                '',
                            width: MediaQuery.of(context).size.width - 40,
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
                            keyboardType: TextInputType.text,
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              makhdomdetailsprovider
                                  .recievedMakhdom!.addStreet = value ?? '';
                              //  _makhdomData['addStreet'] = value ?? '';
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'تاريخ الميلاد',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              style: AppStylesUtil.textRegularStyle(
                                  14.sp, Colors.black, FontWeight.normal),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                makhdomdetailsprovider
                                            .recievedMakhdom!.birthdate !=
                                        null
                                    ? '${makhdomdetailsprovider.recievedMakhdom!.birthdate!}'
                                    : '2023/11/23',
                                style: AppStylesUtil.textBoldStyle(
                                  16.sp,
                                  Colors.black,
                                  FontWeight.w400,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  printWarning(
                                      'BIRTHDAY ${makhdomdetailsprovider.recievedMakhdom!.birthdate ?? ''}');
                                  DateTime? selected =
                                      await customShowDatePicker(context);
                                  makhdomdetailsprovider
                                          .recievedMakhdom!.birthdate =
                                      intl.DateFormat('yyyy-MM-dd')
                                          .format(selected!);

                                  printWarning(
                                      'BIRTHDAY ${makhdomdetailsprovider.recievedMakhdom!.birthdate ?? ''}');
                                },
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                  size: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        16.verticalSpace,
                        InputFieldWidget(
                            labeltext: 'أب الإعتراف',
                            initialvalue: makhdomdetailsprovider
                                    .recievedMakhdom!.father
                                    .toString() ??
                                '',
                            width: MediaQuery.of(context).size.width - 40,
                            //  controller: nameController,
                            validation: makhdomdetailsprovider.fatherController
                                .isEmpty(),
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
                            validation: makhdomdetailsprovider
                                .universityController
                                .isEmpty(),
                            keyboardType: TextInputType.text,
                            lines: 1,
                            obscure: false,
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              makhdomdetailsprovider
                                  .recievedMakhdom!.university = value ?? '';
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
                            validation: makhdomdetailsprovider.facultyController
                                .isEmpty(),
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
                            validation: makhdomdetailsprovider.levelController
                                .isEmpty(),
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
                            validation: makhdomdetailsprovider.notesController
                                .isEmpty(),
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
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 40, 40),
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
                            printDone(
                                makhdomdetailsprovider.recievedMakhdom!.name!);
                            printDone(
                                makhdomdetailsprovider.recievedMakhdom!.phone!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.phone2!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.genderId!);
                            printDone(
                                makhdomdetailsprovider.recievedMakhdom!.addNo!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.addStreet!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.birthdate!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.father!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.university!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.faculty!);
                            printDone(makhdomdetailsprovider
                                .recievedMakhdom!.levelId!);
                            printDone(
                                makhdomdetailsprovider.recievedMakhdom!.notes!);
                            makhdomdetailsprovider.updateMyMakhdom(
                                context,
                                makhdomdetailsprovider.recievedMakhdom ??
                                    Data());
                          },
                        ),
                      ],
                    ),
                  ),
                )),
              ),
      );
    });
  }
}
