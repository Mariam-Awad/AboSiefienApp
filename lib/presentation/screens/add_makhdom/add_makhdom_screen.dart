import 'package:abosiefienapp/model/default_model.dart';
import 'package:abosiefienapp/presentation/screens/add_makhdom/add_makhdom_provider.dart';
import 'package:abosiefienapp/presentation/widgets/app_date_picker_widget.dart';
import 'package:abosiefienapp/presentation/widgets/custom_dropdown_widget.dart';
import 'package:abosiefienapp/presentation/widgets/gender.dart';
import 'package:abosiefienapp/presentation/widgets/input_form_fields.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:abosiefienapp/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class AddMakhdomScreen extends StatefulWidget {
  const AddMakhdomScreen({super.key});

  @override
  _AddMakhdomScreenState createState() => _AddMakhdomScreenState();
}

class _AddMakhdomScreenState extends State<AddMakhdomScreen> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    callGetKhademApi();
    super.initState();
  }

  callGetKhademApi() async {
    Future.delayed(Duration.zero, () {  
      Provider.of<AddMakhdomProvider>(context, listen: false)
          .getkhadem(context)
          .then((value) {
        printDone('Done $value');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMakhdomProvider>(
        builder: (context, addMakhdomProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "بيانات المخدوم",
            style: AppStylesUtil.textRegularStyle(
                20.0, Colors.white, FontWeight.w500),
          ),
        ),
        body: Form(
          key: addMakhdomProvider.formKey,
          child: SingleChildScrollView(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: CustomDropdownWidget(
                      labelText: 'اختر الخادم',
                      items: addMakhdomProvider.dropdownList,
                      value: addMakhdomProvider.selectedKhadem,
                      onChanged: (val) {
                        addMakhdomProvider.setSelectedKhadem(val ?? 2);
                        printDone(
                            'Selected Khadem updated ${addMakhdomProvider.selectedKhadem}');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InputFieldWidget(
                    labeltext: 'الإسم',
                    width: MediaQuery.of(context).size.width - 40,
                    controller: addMakhdomProvider.nameController,
                    keyboardType: TextInputType.text,
                    validation: addMakhdomProvider.nameController.isValidName(),
                    validationText: 'يجب إدخال الإسم',
                    lines: 1,
                    obscure: false,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      // makhdomdetailsprovider.recievedMakhdom!.name =
                      //     value ?? '';
                    },
                  ),
                  InputFieldWidget(
                      labeltext: 'التليفون',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.phoneController,
                      keyboardType: TextInputType.number,
                      validation:
                          addMakhdomProvider.phoneController.isValidPhone(),
                      validationText: 'يجب إدخال رقم تليفون صحيح',
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.phone =
                        //     value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'رقم تليفون اّخر',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.phone2Controller,
                      keyboardType: TextInputType.number,
                      // validation:
                      //     addMakhdomProvider.phone2Controller.isValidPhone(),
                      // validationText: 'يجب إدخال رقم تليفون صحيح',
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.phone2 =
                        //     value ?? '';
                      }),
                  GenderSelect(
                      checkedIncome: true,
                      radioValue: addMakhdomProvider.genderValue,
                      title1: 'النوع',
                      title2: 'ذكر',
                      title3: 'انثى',
                      color: Colors.black,
                      onChanged: (value) {
                        printDone('in screen value $value');
                        // makhdomdetailsprovider.recievedMakhdom!.genderId =
                        //     value;
                      }),
                  InputFieldWidget(
                      labeltext: 'العنوان/رقم',
                      width: MediaQuery.of(context).size.width - 40,
                      keyboardType: TextInputType.number,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      controller: addMakhdomProvider.addressNumberController,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.addNo =
                        //     int.parse(value) ?? 0;
                        // _makhdomData['addNo'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'العنوان/شارع',
                      width: MediaQuery.of(context).size.width - 40,
                      keyboardType: TextInputType.text,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      controller: addMakhdomProvider.addressStreetController,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.addStreet =
                        //     value ?? '';
                        //  _makhdomData['addStreet'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'بجانب',
                      width: MediaQuery.of(context).size.width - 40,
                      keyboardType: TextInputType.text,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      controller: addMakhdomProvider.addressBesideController,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.addBeside =
                        //     value ?? '';
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
                    child: InkWell(
                      onTap: () async {
                        DateTime? selected =
                            await customShowDatePicker(context);
                        addMakhdomProvider.changeBirthdate(selected);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            addMakhdomProvider.birthdate ?? '',
                            style: AppStylesUtil.textBoldStyle(
                              16.sp,
                              Colors.black,
                              FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.date_range,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  InputFieldWidget(
                      labeltext: 'أب الإعتراف',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.fatherController,
                      validation: addMakhdomProvider.fatherController.isEmpty(),
                      keyboardType: TextInputType.text,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.father =
                        //     value ?? '';
                        // _makhdomData['father'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'الجامعة',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.universityController,
                      // validation:
                      //     addMakhdomProvider.universityController.isEmpty(),
                      keyboardType: TextInputType.text,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.university =
                        //     value ?? '';
                        //  _makhdomData['university'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'الكلية',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.facultyController,
                      // validation:
                      //     addMakhdomProvider.facultyController.isEmpty(),
                      keyboardType: TextInputType.text,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.faculty =
                        //     value ?? '';
                        // _makhdomData['faculty'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'السنة الدراسية',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.levelController,
                      //validation: addMakhdomProvider.levelController.isEmpty(),
                      keyboardType: TextInputType.number,
                      lines: 1,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.levelId =
                        //     int.parse(value) ?? 0;
                        // _makhdomData['studentYear'] = value ?? '';
                      }),
                  InputFieldWidget(
                      labeltext: 'الملاحظات',
                      width: MediaQuery.of(context).size.width - 40,
                      controller: addMakhdomProvider.notesController,
                      //validation: addMakhdomProvider.notesController.isEmpty(),
                      keyboardType: TextInputType.text,
                      lines: 4,
                      obscure: false,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        // makhdomdetailsprovider.recievedMakhdom!.notes =
                        //     value ?? '';
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
                    child: Text('إضافة',
                        style: AppStylesUtil.textBoldStyle(
                            18, Colors.white, FontWeight.bold)),
                    onPressed: () {
                      printDone(addMakhdomProvider.nameController.text);
                      printDone(addMakhdomProvider.phoneController.text);
                      printDone(addMakhdomProvider.phone2Controller.text);
                      printDone(addMakhdomProvider.genderValue.value);
                      printDone(
                          addMakhdomProvider.addressNumberController.text);
                      printDone(
                          addMakhdomProvider.addressStreetController.text);
                      printDone(
                          addMakhdomProvider.addressBesideController.text);
                      printDone(addMakhdomProvider.facultyController.text);
                      printDone(addMakhdomProvider.universityController.text);
                      printDone(addMakhdomProvider.facultyController.text);
                      printDone(addMakhdomProvider.levelController.text);
                      printDone(addMakhdomProvider.notesController.text);
                      addMakhdomProvider.validate(context);
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
