import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'inward_itemlist.dart';

class Inward_entry extends StatefulWidget {
  const Inward_entry({Key? key}) : super(key: key);

  @override
  State<Inward_entry> createState() => _InwardState();
}

class _InwardState extends State<Inward_entry> {
  InwardPending_Controller inward_controller =
      Get.put(InwardPending_Controller());
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    super.initState();
    Future.delayed(duration, () async {

      if (inward_controller.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("INWARD");
        inward_controller.InwardAutoyearText.text = autoYearWiseNoController.InwardPendingautoYrsWise.value.toString();
        inward_controller.InwardNetAmtText.text = "0";
        inward_controller.InwardInvoiceNoText.text = "";
        inward_controller.InwardDCNoText.text = "";
        inward_controller.InwardRemarksText.text = "";
        inward_controller.InwardVechileNoText.text = "";
        inward_controller.InwardDriverNameText.text ="";
        inward_controller.InwardEntryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        inward_controller.InwardInvoiceDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        inward_controller.InwardDCDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        inward_controller.checkImgList.value = false;
        inward_controller.count.value = 0;
        inward_controller.pickedImageCount.value = 0;
        inward_controller.imageFiles.value=[];
        if (inward_controller.inwardAllDatasList.isNotEmpty) {
          for (var element in inward_controller.inwardAllDatasList) {
            inward_controller.InwardSupplierNameText.text = element.supplierName!;
            inward_controller.InwardProjectNameText.text = element.projectName!;
            inward_controller.InwardSiteNameText.text = element.siteName!;
            inward_controller.InwardTypeText.text = element.inwardType == "P" ? "Against PO" : "Against Request";
            inward_controller.InwardNoText.text = element.purchaseOrdNo!;
            inward_controller.siteId = element.siteid!;
            inward_controller.projectId = element.projectid!;
            inward_controller.supId = element.supplierid!;
          }
        }
      }

      if (inward_controller.saveButton.value == RequestConstant.RESUBMIT) {
        await inward_controller.gettingImage();
        inward_controller.checkImgList.value = true;
        inward_controller.editListApiDatas.value.forEach((element) {
          inward_controller.inwardID= element.inwardId;
          inward_controller.InwardAutoyearText.text =
              element.inwardNo.toString();
          inward_controller.InwardEntryDateText.text =
              element.entryDate.toString();
          inward_controller.InwardSupplierNameText.text =
              element.supplierName.toString();
          inward_controller.InwardProjectNameText.text =
              element.projectName.toString();
          inward_controller.InwardSiteNameText.text =
              element.siteName.toString();
          inward_controller.InwardInvoiceNoText.text = element.invoiceNo.toString();
          inward_controller.InwardInvoiceDateText.text =
              element.invoiceDate.toString();
          inward_controller.InwardDCNoText.text = element.dcNo.toString();
          inward_controller.InwardDCDateText.text = element.dcDate.toString();
          inward_controller.InwardManualNoText.text = "";
          inward_controller.InwardTypeText.text =
              element.inwType == "P" ? "Against PO" : "Against Request";
          inward_controller.InwardNoText.text = element.selectedNo.toString();
          inward_controller.InwardVechileNoText.text = element.vechileName.toString();
          inward_controller.InwardDriverNameText.text =
              element.driverName.toString();
          inward_controller.projectId = element.projectId;
          inward_controller.siteId = element.siteId;
          inward_controller.supId = element.supplierId;
          inward_controller.InwardRemarksText.text = element.remarks.toString();
        });
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Form(
        key: _formKey,
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Inward",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: inward_controller.InwardAutoyearText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "GRN No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.requestNo,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: inward_controller.InwardEntryDateText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Date",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                  if (loginController.user.value.userType != "S") {
                    var Entrydate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme
                                    .of(context)
                                    .primaryColor, // header background color
                                onPrimary:
                                Colors.white, // header text color
                                onSurface:
                                Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary:
                      Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            });
                inward_controller.InwardEntryDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
              }
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: inward_controller.InwardProjectNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Project Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.projectName),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: inward_controller.InwardSiteNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Site Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.siteName),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: inward_controller.InwardSupplierNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Supplier Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.supplierName),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardInvoiceNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Invoice No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.dcNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          // validator: (value) {
                          //   if ((value!.isEmpty || value == "--Select--" || value == "--SELECT--") && (inward_controller.InwardDCNoText.text.isEmpty || value == "--Select--" || value == "--SELECT--")) {
                          //     return '\u26A0 ${RequestConstant.VALIDATE}';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: inward_controller.InwardInvoiceDateText,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Invoice Date",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor, // header background color
                                      onPrimary: Colors.white, // header text color
                                      onSurface: Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                    child: child!,
                                  );
                                });
                            inward_controller.InwardInvoiceDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // keyboardType: TextInputType.number,
                          controller: inward_controller.InwardDCNoText,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "DC No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.dcNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: inward_controller.InwardDCDateText,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Dc Date ",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor, // header background color
                                      onPrimary: Colors.white, // header text color
                                      onSurface: Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                    child: child!,
                                  );
                                });
                            inward_controller.InwardDCDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: inward_controller.InwardTypeText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: inward_controller.InwardNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.requestNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardVechileNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Vehicle No.",
                            labelStyle: TextStyle(
                                color:  Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.vehicleNo),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardDriverNameText,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Driver Name",
                            labelStyle: TextStyle(
                                color:  Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.driverName),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(color: Colors.white70, width: 1),
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     elevation: 3,
                  //     child: Padding(
                  //       padding:
                  //       const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                  //       child: TextFormField(
                  //         readOnly: true,
                  //         keyboardType: TextInputType.number,
                  //         controller: inward_controller.InwardNetAmtText,
                  //         cursorColor: Colors.black,
                  //         style: TextStyle(color: Colors.black),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.zero,
                  //           border: InputBorder.none,
                  //           labelText: "Net Amount",
                  //           labelStyle: TextStyle(
                  //               color: Colors.grey,
                  //               fontSize: RequestConstant.Lable_Font_SIZE),
                  //           prefixIconConstraints:
                  //           BoxConstraints(minWidth: 0, minHeight: 0),
                  //           prefixIcon: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: 8, horizontal: 8),
                  //               child: ConstIcons.rate),
                  //         ),
                  //         onChanged: (value) {
                  //           //nmrWklyController.deduction_paymentCalculation();
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardRemarksText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Remarks",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.remarks),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                    color:  Theme.of(context).primaryColor
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: RequestConstant.Lable_Font_SIZE,
                        color:  Colors.white
                            ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if ((inward_controller.InwardDCNoText.text!.trim().isEmpty || inward_controller.InwardDCNoText.text.trim()=="null" || inward_controller.InwardDCNoText.text.trim()=="0") &&
                          (inward_controller.InwardInvoiceNoText.text!.trim().isEmpty || inward_controller.InwardInvoiceNoText.text.trim()=="null" || inward_controller.InwardInvoiceNoText.text.trim()=="0")) {
                        BaseUtitiles.showToast("Please enter Invoice No or DC No");
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Inward_Itemlist()));
                      }
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
