import '../../../../home/menu/accounts/staff_voucher/staff_voucher_sitewise.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/staffcontroller.dart';
import '../../../../controller/staffvoucher_controller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../commonpopup/accountnameadd_alert.dart';
import '../../../../commonpopup/vouchertype_alert.dart';

class Staff_Voucher_EntryScreen extends StatefulWidget {
  const Staff_Voucher_EntryScreen({Key? key}) : super(key: key);

  @override
  State<Staff_Voucher_EntryScreen> createState() =>
      _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site
    extends State<Staff_Voucher_EntryScreen> {
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
  Get.put(AutoYearWiseNoController());
  StaffController staffController = Get.put(StaffController());
  CommonVoucherController commonVoucherController =
  Get.put(CommonVoucherController());
  StaffVoucher_Controller staffVoucher_Controller =
  Get.put(StaffVoucher_Controller());
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  BottomsheetControllers bottomsheetControllers =
  Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (staffVoucher_Controller.SaveButton.value == RequestConstant.SUBMIT) {
        staffVoucher_Controller.type.value = "Direct Payment/Office";
        staffVoucher_Controller.staffvocDate.text =
            BaseUtitiles.initiateCurrentDateFormat();
        staffVoucher_Controller.ChequeDate.text =
            BaseUtitiles.initiateCurrentDateFormat();
        if (loginController.user.value.userType == "A") {
          staffController.Staffname.text = "--SELECT--";
          staffController.selectedstaffId.value = 0;
        } else {
          staffController.Staffname.text =
              loginController.user.value.empName
                  .toString();
          staffController.selectedstaffId.value =
          loginController.user.value.empId!;
        }
        commonVoucherController.VoucherTypeController.text = "Payment";
        commonVoucherController.VocType.value = "P";
        commonVoucherController.AccountTypename.text = "--SELECT--";
        commonVoucherController.Accountname.text = "--SELECT--";
        commonVoucherController.selectedAccnameId = 0.obs;
        commonVoucherController.Paymodename.text = "BY CASH";
        commonVoucherController.selectedPaymodeId.value = 1;
        commonVoucherController.AccPayforname.text = "--SELECT--";
        staffVoucher_Controller.Remarks.text = "";
        commonVoucherController.namethrough.text = "";
        siteController.selectedsiteId.value = 0;
        staffVoucher_Controller.ChequeNo.text = "";
        staffVoucher_Controller.BankName.text = "--SELECT--";
        staffVoucher_Controller.TotalAmount.text = "0.0";
        staffVoucher_Controller.payeeType.value = false;
        await autoYearWiseNoController.AutoYearWiseNo("STAFF VOUCHER");
        staffVoucher_Controller.AutoYearwisestaffVoc.text =
            autoYearWiseNoController.StaffVoucher_autoYrsWise.value;
      }

      if (staffVoucher_Controller.SaveButton.value == RequestConstant.RESUBMIT) {
        staffVoucher_Controller.Sitevoucher_EditListApiValue.forEach((element) {
          staffVoucher_Controller.AutoYearwisestaffVoc.text = element.staffVocNo;
          staffVoucher_Controller.staffvocDate.text = element.vocDate;
          commonVoucherController.VocType.value = element.vocType;
          commonVoucherController.VoucherTypeController.text =
          element.vocType == "P" ? "Payment" : "Receipt";
          staffController.Staffname.text = element.createdName;
          staffController.selectedstaffId.value = element.createdBy;
          commonVoucherController.AccountTypename.text = element.accTypeName;
          commonVoucherController.selectedAccTypeId.value = element.accTypeId;
          commonVoucherController.Accountname.text = element.accountName;
          commonVoucherController.selectedAccnameId.value = element.accountNameId;

          commonVoucherController.Paymodename.text = element.payModeName;
          commonVoucherController.selectedPaymodeId.value = element.payMode;

          commonVoucherController.AccPayforname.text = element.payForName;
          commonVoucherController.selectedAccPayId.value = element.payFor;

          commonVoucherController.namethrough.text = element.nameThrough;
          staffVoucher_Controller.TotalAmount.text = element.vocAmount.toString();
          staffVoucher_Controller.Remarks.text = element.remarks;
          staffVoucher_Controller.ChequeNo.text = element.chequeNo;
          staffVoucher_Controller.ChequeDate.text = element.chequeDate;
          staffVoucher_Controller.BankName.text = element.bankName == null ? "--SELECT--" : element.bankName;
          staffVoucher_Controller.payeeType.value = element.accountPayee==0?false:true;
          staffVoucher_Controller.type.value = element.payType == "SP"
              ? "SiteWise Payment"
              : "Direct Payment/Office";
        });
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return Form(
      key: _formKey,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Staff Voucher",
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
                                style:
                                TextStyle(color: Colors.grey, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                            staffVoucher_Controller.AutoYearwisestaffVoc,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Voucher No",
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: staffVoucher_Controller.staffvocDate,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Entry Date",
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
                              if (staffVoucher_Controller.SaveButton.value ==
                                  RequestConstant.RESUBMIT) {
                              } else {
                                var Entrydate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context)
                                                .primaryColor, // header background color
                                            onPrimary: Colors
                                                .white, // header text color
                                            onSurface:
                                            Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors
                                                  .black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                staffVoucher_Controller.staffvocDate.text =
                                    BaseUtitiles.selectDateFormat(Entrydate!);
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller:
                            commonVoucherController.VoucherTypeController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "VOC Type",
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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SiteAndStaffVoucherType();
                                  });
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: staffController.Staffname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Staff Name",
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
                            onTap: () async {
                              if (loginController.user.value.userType == "A") {
                                await staffController.get_staffDropdowntList(context, "staffVoucher");
                                bottomsheetControllers.StaffName(context, staffController.getStaffDropdownvalue.value, type: "staffVoucher");
                                  } },
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: commonVoucherController.AccountTypename,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Account Type",
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
                            onTap: () async {
                              await commonVoucherController
                                  .getAccountTypeList();
                              bottomsheetControllers.AccountType(
                                  context,
                                  commonVoucherController
                                      .getdropDownvalue.value);
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
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: commonVoucherController.Accountname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Account Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.accounttype),
                            ),
                            onTap: () async {
                              await commonVoucherController.getAccountName();
                              bottomsheetControllers.AccountName(
                                  context,
                                  commonVoucherController
                                      .getaccdropDownvalue.value);
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
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(right: 5, left: 5),
                                alignment: Alignment.center,
                                height: BaseUtitiles.getheightofPercentage(
                                    context, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 50,
                                        color: Color(0xffEEEEEE)),
                                  ],
                                ),
                                child: Icon(Icons.add_circle_outline_rounded,
                                    color: Colors.white),
                              ),
                              onTap: () {
                                if (commonVoucherController
                                    .AccountTypename.text ==
                                    "OTHERS" ||
                                    commonVoucherController
                                        .AccountTypename.text ==
                                        "SITE-OTHERS" ||
                                    commonVoucherController
                                        .AccountTypename.text ==
                                        "MATERIAL") {
                                  if (commonVoucherController
                                      .Accountname.text ==
                                      "--SELECT--") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AccountnameAddAlert();
                                        });
                                  } else {
                                    BaseUtitiles.showToast(
                                        "Please clear the account name");
                                  }
                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                alignment: Alignment.center,
                                height: BaseUtitiles.getheightofPercentage(
                                    context, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 50,
                                        color: Color(0xffEEEEEE)),
                                  ],
                                ),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                              onTap: () {
                                if (commonVoucherController
                                    .AccountTypename.text ==
                                    "OTHERS" ||
                                    commonVoucherController
                                        .AccountTypename.text ==
                                        "SITE-OTHERS" ||
                                    commonVoucherController
                                        .AccountTypename.text ==
                                        "MATERIAL") {
                                  if (commonVoucherController
                                      .Accountname.text !=
                                      "--SELECT--") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AccountnameAddAlert();
                                        });
                                  } else {
                                    BaseUtitiles.showToast(
                                        "Please select the account name");
                                  }
                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  alignment: Alignment.center,
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 50,
                                          color: Color(0xffEEEEEE)),
                                    ],
                                  ),
                                  child: Icon(Icons.delete_forever,
                                      color: Colors.white),
                                ),
                                onTap: () async {
                                  if (commonVoucherController
                                      .AccountTypename.text ==
                                      "OTHERS" ||
                                      commonVoucherController
                                          .AccountTypename.text ==
                                          "SITE-OTHERS" ||
                                      commonVoucherController
                                          .AccountTypename.text ==
                                          "MATERIAL") {
                                    if (commonVoucherController
                                        .Accountname.text !=
                                        "--SELECT--") {
                                      if (commonVoucherController
                                          .Accountname.text.isNotEmpty) {
                                        await commonVoucherController
                                            .DeleteAlert(context);
                                      } else {
                                        BaseUtitiles.showToast(
                                            "Something went wrong..");
                                      }
                                    } else {
                                      BaseUtitiles.showToast(
                                          "Please select the account name");
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height:
                          BaseUtitiles.getheightofPercentage(context, 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              "Payment Options",
                              style: TextStyle(
                                  fontSize: RequestConstant.ALERT_Font_SIZE,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: commonVoucherController.namethrough,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Name Through",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.namethrough),
                            ),
                            onTap: () {},
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: commonVoucherController.AccPayforname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Pay For",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.payfor),
                            ),
                            onTap: () async {
                              await commonVoucherController.getPayforList();
                              bottomsheetControllers.Payfor(
                                  context,
                                  commonVoucherController
                                      .getPayfordropDownvalue.value);
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin:
                            EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  controller:
                                  commonVoucherController.Paymodename,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Mode of Pay",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.modeofpay),
                                  ),
                                  onTap: () async {
                                    await commonVoucherController
                                        .getPaymodeList();
                                    bottomsheetControllers.ModeofPay(
                                        context,
                                        commonVoucherController
                                            .getpaymodedropDownvalue.value);
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
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin:
                            EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly:
                                  staffVoucher_Controller.type.value ==
                                      "SiteWise Payment"
                                      ? true
                                      : false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  controller:
                                  staffVoucher_Controller.TotalAmount,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Amount",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.amount),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value == "--Select--" ||
                                        value == "--SELECT--") {
                                      return '\u26A0 ${RequestConstant.VALIDATE}';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {});
                                    if (staffVoucher_Controller.type.value ==
                                        "Direct Payment/Office") {
                                      if (staffVoucher_Controller
                                          .TotalAmount.text ==
                                          "0.0" ||
                                          staffVoucher_Controller
                                              .TotalAmount.text ==
                                              "0") {
                                        staffVoucher_Controller
                                            .TotalAmount.text = "";
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                          () => commonVoucherController.selectedPaymodeId.value == 2
                          ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  controller:
                                  staffVoucher_Controller.ChequeNo,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Cheque No",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant
                                            .Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.requestNo),
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
                            margin: EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    controller: staffVoucher_Controller
                                        .ChequeDate,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Cheque Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant
                                              .Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                    onTap: () async {
                                      if (staffVoucher_Controller
                                          .SaveButton.value ==
                                          RequestConstant.RESUBMIT) {
                                      } else {
                                        var Entrydate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate:
                                            DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            builder:
                                                (context, child) {
                                              return Theme(
                                                data:
                                                Theme.of(context)
                                                    .copyWith(
                                                  colorScheme:
                                                  ColorScheme
                                                      .light(
                                                    primary: Theme.of(
                                                        context)
                                                        .primaryColor, // header background color
                                                    onPrimary: Colors
                                                        .white, // header text color
                                                    onSurface: Colors
                                                        .black, // body text color
                                                  ),
                                                  textButtonTheme:
                                                  TextButtonThemeData(
                                                    style: TextButton
                                                        .styleFrom(
                                                      primary: Colors
                                                          .black, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            });
                                        staffVoucher_Controller
                                            .ChequeDate.text =
                                            BaseUtitiles.selectDateFormat(
                                                Entrydate!);
                                      }
                                    }),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70,
                                          width: 1),
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 10, bottom: 5),
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode
                                            .onUserInteraction,
                                        readOnly: true,
                                        controller:
                                        staffVoucher_Controller
                                            .BankName,
                                        cursorColor: Colors.black,
                                        style: TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          labelText: "Bank Name",
                                          labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: RequestConstant
                                                  .Lable_Font_SIZE),
                                          prefixIconConstraints:
                                          BoxConstraints(
                                              minWidth: 0,
                                              minHeight: 0),
                                          prefixIcon: Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 8),
                                              child:
                                              ConstIcons.accountName),
                                        ),
                                        onTap: () async {
                                          await staffVoucher_Controller
                                              .getBankName_List();
                                          bottomsheetControllers.BankName(
                                              context,
                                              staffVoucher_Controller
                                                  .getbankNameList.value);
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
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  2.0),
                                            ),
                                            side: MaterialStateBorderSide
                                                .resolveWith(
                                                  (states) => BorderSide(
                                                width: 1.0,
                                                // color: Colors.white
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            checkColor: Colors.white,
                                            activeColor: Theme.of(context)
                                                .primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                staffVoucher_Controller
                                                    .payeeType
                                                    .value = value!;
                                              });
                                            },
                                            value: staffVoucher_Controller.payeeType.value),
                                        Text('A/C Payee')
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      )
                          : SizedBox(),
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: staffVoucher_Controller.Remarks,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
                    SizedBox(height: 5),
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio<String>(
                            value: 'Direct Payment/Office',
                            groupValue: staffVoucher_Controller.type.value,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                            onChanged: (value) {
                              setState(() {
                                staffVoucher_Controller.type.value = value!;
                                staffVoucher_Controller.Staffvoucher_itemview_GetDbList.value = [];
                                staffVoucher_Controller.TotalAmount.text = "0.0";
                              });
                            },
                          ),
                          Container(child: const Text('Direct Payment/Office')),
                          Radio<String>(
                            value: 'SiteWise Payment',
                            groupValue: staffVoucher_Controller.type.value,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                            onChanged: (value) {
                              setState(() {
                                staffVoucher_Controller.type.value = value!;
                                staffVoucher_Controller.TotalAmount.text = "0.0";
                              });
                            },
                          ),
                          Container(child: const Text('SiteWise Payment')),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Obx(() => Visibility(
                      visible: staffVoucher_Controller.type.value ==
                          "Direct Payment/Office"
                          ? false
                          : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Setmybackground,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              staff_voucher_sitewise()));
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Add List",
                                    style: TextStyle(
                                        color:
                                        Theme.of(context).primaryColor),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
                    SizedBox(
                        height:
                        BaseUtitiles.getheightofPercentage(context, 10)),
                    SizedBox(height: height),
                  ],
                ),
              ),
              Obx(() => Visibility(
                visible: staffVoucher_Controller
                    .Staffvoucher_itemview_GetDbList.value.isEmpty
                    ? false
                    : true,
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 100),
                  child: DraggableScrollableSheet(
                    minChildSize: 0.1,
                    maxChildSize: 0.9,
                    initialChildSize: 0.3,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Setmybackground,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      ListDetails(context, scrollController),
                                    ],
                                  ),
                                )),
                            IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      height: 5,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )),
            ],
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        ResetAlert(context);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Text(
                        staffVoucher_Controller.SaveButton.value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        SubmitAlert(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 4,
              right: 4,
            ),
            height: BaseUtitiles.getheightofPercentage(context, 80),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: staffVoucher_Controller.Staffvoucher_itemview_GetDbList.value.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> paymentTypeMap = {};

                if (staffVoucher_Controller.SaveButton.value ==
                    RequestConstant.SUBMIT) {
                  paymentTypeMap = {
                    for (var item in commonVoucherController.paymentTypeList)
                      item.paymentTypeValue: item.paymentTypeName
                  };
                } else {
                  if (staffVoucher_Controller
                      .Sitevoucher_EditListApiValue.isNotEmpty) {
                    paymentTypeMap.addAll({
                      for (var item in staffVoucher_Controller
                          .Sitevoucher_EditListApiValue[0]
                          .accStaffVocSWpaymentS)
                        item.payType: item.payTypeName
                    });
                  }
                  if (staffVoucher_Controller.SaveButton.value ==
                      RequestConstant.RESUBMIT) {
                    paymentTypeMap.addAll({
                      for (var item in commonVoucherController.paymentTypeList)
                        item.paymentTypeValue: item.paymentTypeName
                    });
                  }
                }

                final payType = staffVoucher_Controller
                    .Staffvoucher_itemview_GetDbList[index].paytype;

                final payTypeName = paymentTypeMap[payType] ?? "";

                return Card(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  elevation: 3,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 80),
                              child: Text(
                                staffVoucher_Controller
                                    .Staffvoucher_itemview_GetDbList
                                    .value[index]
                                    .projectname
                                    .toString(),
                                style: TextStyle(
                                    fontSize: RequestConstant.App_Font_SIZE,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 2),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 10),
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          RequestConstant.DO_YOU_WANT_DELETE,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        actions: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.grey.shade400,
                                                    width: 5,
                                                    thickness: 2,
                                                    indent: 15,
                                                    endIndent:
                                                    15, //Spacing at the bottom of divider.
                                                  ),
                                                  Expanded(
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          staffVoucher_Controller
                                                              .deleteParticularList(
                                                              staffVoucher_Controller
                                                                  .Staffvoucher_itemview_GetDbList[
                                                              index]);
                                                          staffVoucher_Controller
                                                              .Staffvoucher_itemview_GetDbList
                                                              .remove(staffVoucher_Controller
                                                              .Staffvoucher_itemview_GetDbList[
                                                          index]);
                                                          await staffVoucher_Controller
                                                              .getstaffvouchersiteTablesDatas();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Delete",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.red,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.remove_circle,
                                      color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Site Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  staffVoucher_Controller
                                      .Staffvoucher_itemview_GetDbList
                                      .value[index]
                                      .sitename
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: RequestConstant.App_Font_SIZE,
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Payment Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                margin: EdgeInsets.only(right: 5),
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                child: Text(
                                  payTypeName,
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  staffVoucher_Controller
                                      .Staffvoucher_itemview_GetDbList
                                      .value[index]
                                      .amt
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Net Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  staffVoucher_Controller
                                      .Staffvoucher_itemview_GetDbList
                                      .value[index]
                                      .NetAmt
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
            'Are you sure to ${staffVoucher_Controller.SaveButton.value}?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {
                          if (
                          commonVoucherController.AccountTypename.text ==
                              "--SELECT--" ||
                              commonVoucherController.Accountname.text ==
                                  "--SELECT--" ||
                              commonVoucherController.Paymodename.text ==
                                  "--SELECT--" ||
                              commonVoucherController.AccPayforname.text ==
                                  "--SELECT--" ||
                              double.parse(staffVoucher_Controller
                                  .TotalAmount.text) ==
                                  0.0) {
                            BaseUtitiles.showToast("Some field is missing");
                          } else {
                            if (staffVoucher_Controller.type.value ==
                                "SiteWise Payment") {
                              await staffVoucher_Controller
                                  .getstaffvouchersiteTablesDatas();
                            }
                            if (await BaseUtitiles.checkNetworkAndShowLoader(
                                context)) {
                              await staffVoucher_Controller
                                  .SaveButtonSitevoucher_ItemlistScreen(
                                  context,
                                  staffVoucher_Controller.SaveButton.value==RequestConstant.RESUBMIT?staffVoucher_Controller
                                      .Sitevoucher_EditListApiValue[0].id:0);
                            }
                          }
                        },
                        child: Text(
                          staffVoucher_Controller.SaveButton.value,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          Future.delayed(Duration(seconds: 0), () {
                            staffVoucher_Controller.SaveButton.value =
                                RequestConstant.SUBMIT;
                            staffVoucher_Controller.type.value =
                            "SiteWise Payment";
                            staffVoucher_Controller
                                .delete_Sitevoucher_itemlist_Table();
                            staffVoucher_Controller
                                .Staffvoucher_itemview_GetDbList.clear();
                            staffVoucher_Controller.TotalAmount.text = "0.00";
                            staffVoucher_Controller.staffvocDate.text =
                                BaseUtitiles.initiateCurrentDateFormat();
                            staffVoucher_Controller.AutoYearwisestaffVoc.text =
                                autoYearWiseNoController
                                    .StaffVoucher_autoYrsWise.value;
                            staffController.Staffname.text = "--SELECT--";
                            staffController.selectedstaffId.value = 0;
                            commonVoucherController.VoucherTypeController.text =
                            "Payment";
                            commonVoucherController.VocType.value = "P";
                            commonVoucherController.AccountTypename.text =
                            "--SELECT--";
                            commonVoucherController.Accountname.text =
                            "--SELECT--";
                            commonVoucherController.selectedAccnameId = 0.obs;
                            commonVoucherController.Paymodename.text =
                            "BY CASH";
                            commonVoucherController.selectedPaymodeId.value = 1;
                            commonVoucherController.AccPayforname.text =
                            "--SELECT--";
                            staffVoucher_Controller.Remarks.text = "";
                            commonVoucherController.namethrough.text = "";
                            siteController.selectedsiteId.value = 0;
                            staffVoucher_Controller.ChequeNo.text = "";
                            staffVoucher_Controller.ChequeDate.text = BaseUtitiles.initiateCurrentDateFormat();
                            staffVoucher_Controller.BankName.text = "--SELECT--";
                            staffVoucher_Controller.payeeType.value = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
