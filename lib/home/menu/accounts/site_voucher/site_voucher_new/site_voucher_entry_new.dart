import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prahkurticore/home/menu/accounts/site_voucher/site_voucher_new/site_voucher_sitewise.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../commonpopup/accountnameadd_alert.dart';
import '../../../../../commonpopup/vouchertype_alert.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../../controller/bottomsheet_Controllers.dart';
import '../../../../../controller/commonvoucher_controller.dart';
import '../../../../../controller/dailyentries_controller.dart';
import '../../../../../controller/logincontroller.dart';
import '../../../../../controller/nmrweeklybill_controller.dart';
import '../../../../../controller/projectcontroller.dart';
import '../../../../../controller/sitecontroller.dart';
import '../../../../../controller/sitevoucher_controller.dart';
import '../../../../../controller/subcontcontroller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/image_view.dart';
import '../../../../../utilities/requestconstant.dart';
import '../../../../punch_in_out/camera_screen.dart';

class SiteVoucher_EntryScreen extends StatefulWidget {
  const SiteVoucher_EntryScreen({Key? key}) : super(key: key);

  @override
  State<SiteVoucher_EntryScreen> createState() =>
      _SiteVoucher_EntryScreenState();
}

class _SiteVoucher_EntryScreenState extends State<SiteVoucher_EntryScreen> {
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());
  SiteVoucher_Controller siteVoucher_Controller =
      Get.put(SiteVoucher_Controller());
  CommonVoucherController commonVoucherController =
      Get.put(CommonVoucherController());
  LoginController loginController = Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());

  @override
  void initState() {
    // TODO: implement initState
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (siteVoucher_Controller.SaveButton.value == RequestConstant.SUBMIT) {
        siteVoucher_Controller.gettingNetworkImages.value = [];
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteVoucher_Controller.sitevocDate.text =
            BaseUtitiles.initiateCurrentDateFormat();
        siteVoucher_Controller.type.value = "Direct Payment/Office";
        siteVoucher_Controller.Amount.text = "0.0";
        commonVoucherController.AccountTypename.text = "--SELECT--";
        commonVoucherController.selectedAccnameId = 0.obs;
        commonVoucherController.AccPayforname.text = "--SELECT--";
        commonVoucherController.Accountname.text = "--SELECT--";
        commonVoucherController.namethrough.text = "";
        commonVoucherController.VoucherTypeController.text = "Payment";
        commonVoucherController.voucherPaidForm.text = "PETTY CASH";
        commonVoucherController.vocPaidformId = 1;
        commonVoucherController.VocType.value = "P";
        commonVoucherController.Paymodename.text = "BY CASH";
        commonVoucherController.selectedPaymodeId.value = 1;
        siteVoucher_Controller.Remarks.text = "";
        await autoYearWiseNoController.AutoYearWiseNo("SITE VOUCHER");
        siteVoucher_Controller.AutoYearwiseSiteVoc.text =
            autoYearWiseNoController.SiteVoucher_autoYrsWise.value;
      } else if (siteVoucher_Controller.SaveButton.value ==
          RequestConstant.RESUBMIT) {
        await siteVoucher_Controller.gettingImage();
        siteVoucher_Controller.Sitevoucher_EditListApiValue.forEach((element) {
          siteVoucher_Controller.VocID = element.id;
          siteVoucher_Controller.AutoYearwiseSiteVoc.text =
              element.siteVoucherNo;
          siteVoucher_Controller.sitevocDate.text = element.siteVoucherDate;
          commonVoucherController.VocType.value = element.siteVoucherType;
          commonVoucherController.VoucherTypeController.text =
              element.siteVoucherType == "P" ? "Payment" : "Receipt";
          projectController.projectname.text = element.projectName;
          projectController.selectedProjectId.value = element.projectId;
          commonVoucherController.voucherPaidForm.text =
              element.paidFrom == 1 ? "PETTY CASH" : "PREPAID CARD";
          commonVoucherController.vocPaidformId = element.paidFrom;
          commonVoucherController.AccountTypename.text =
              element.accountTypeName;
          commonVoucherController.selectedAccTypeId.value =
              element.accountTypeId;
          commonVoucherController.Accountname.text = element.accountName;
          commonVoucherController.selectedAccnameId.value =
              element.accountNameId;
          commonVoucherController.selectedAccPayId.value = element.payForType;
          commonVoucherController.namethrough.text = element.nameThrough;
          commonVoucherController.selectedPaymodeId.value = element.payModeId;
          siteVoucher_Controller.Amount.text =
              element.siteVoucherAmount.toString();
          siteVoucher_Controller.Remarks.text = element.remarks;
          siteVoucher_Controller.type.value = element.paymentType == "SP"
              ? "SiteWise Payment"
              : "Direct Payment/Office";
          commonVoucherController.AccPayforname.text =
              element.accountPayForName;
          commonVoucherController.Paymodename.text = element.payModeName;
        });
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
                          Text(
                            "Site Voucher",
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
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
                                siteVoucher_Controller.AutoYearwiseSiteVoc,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
                            controller: siteVoucher_Controller.sitevocDate,
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
                              if (value!.isEmpty || value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
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
                            controller: projectController.projectname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
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
                                  child: ConstIcons.siteName),
                            ),
                            onTap: () async {
                              await projectController.getProjectList();
                              bottomsheetControllers.ProjectName(context,
                                  projectController.getdropDownvalue.value);
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--SELECT--") {
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
                              if (value!.isEmpty || value == "--SELECT--") {
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
                              if (value!.isEmpty || value == "--SELECT--") {
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

                                  print("wwwwwww...${commonVoucherController.AddAccountname.text.toUpperCase()}");
                                  print("rrrrrrrr...${commonVoucherController
                                      .Accountname.text}");

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
                                      if (commonVoucherController.Accountname.text.isNotEmpty) {
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
                              if (value!.isEmpty || value == "--SELECT--") {
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
                              if (value!.isEmpty || value == "--SELECT--") {
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
                            controller: commonVoucherController.voucherPaidForm,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Paid From",
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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const VoucherPaidForm();
                                  });
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--SELECT--") {
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
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
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
                                  readOnly: true,
                                  controller:
                                      commonVoucherController.Paymodename,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
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
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: siteVoucher_Controller.type.value ==
                                          "SiteWise Payment"
                                      ? true
                                      : false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  controller: siteVoucher_Controller.Amount,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
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
                                    if (value!.isEmpty &&
                                        siteVoucher_Controller.type.value !=
                                            "SiteWise Payment") {
                                      return '\u26A0 ${RequestConstant.VALIDATE}';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {});
                                    if (siteVoucher_Controller.type.value ==
                                        "Direct Payment/Office") {
                                      if (siteVoucher_Controller.Amount.text ==
                                              "0.0" ||
                                          siteVoucher_Controller.Amount.text ==
                                              "0") {
                                        siteVoucher_Controller.Amount.text = "";
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
                            controller: siteVoucher_Controller.Remarks,
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
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio<String>(
                            value: 'Direct Payment/Office',
                            groupValue: siteVoucher_Controller.type.value,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            onChanged: (value) {
                              setState(() {
                                siteVoucher_Controller.type.value = value!;
                              });
                            },
                          ),
                          Container(child: const Text('Direct Payment/Office')),
                          Radio<String>(
                            value: 'SiteWise Payment',
                            groupValue: siteVoucher_Controller.type.value,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            onChanged: (value) {
                              setState(() {
                                siteVoucher_Controller.type.value = value!;
                                siteVoucher_Controller.Amount.text = "0.0";
                              });
                            },
                          ),
                          Container(child: const Text('SiteWise Payment')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Visibility(
                            visible: siteVoucher_Controller.type.value ==
                                    "Direct Payment/Office"
                                ? false
                                : true,
                            child: ElevatedButton(
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
                                              const Site_Voucher_Sitewise()));
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.add,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Add List",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Setmybackground),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // await getImage(ImageSource.camera);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CameraCapturePage(
                                            fromScreen: "Site Voucher",
                                          )),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Add image",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      final allImages = [
                        ...siteVoucher_Controller.gettingNetworkImages,
                        ...siteVoucher_Controller.imageFiles,
                      ];

                      if (allImages.isEmpty) return SizedBox();
                      return Container(
                        height: BaseUtitiles.getheightofPercentage(context, 37),
                        width: BaseUtitiles.getWidthtofPercentage(context, 95),
                        child: Builder(
                          builder: (context) {
                            return GridView.builder(
                              padding: const EdgeInsets.all(8),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1,
                              ),
                              itemCount: allImages.length,
                              itemBuilder: (context, index) {
                                final image = allImages[index];
                                final isNetwork = image
                                    is String; // URL → network, File → local

                                return Stack(
                                  children: [
                                    GestureDetector(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: isNetwork
                                              ? Image.network(
                                                  "$image?time=${DateTime.now().millisecondsSinceEpoch}",
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                )
                                              : Image.file(
                                                  image
                                                      as File, // 👈 cast to File
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (image is String) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageViewPage(
                                                        imageUrl:
                                                            "$image?time=${DateTime.now().millisecondsSinceEpoch}",
                                                        netUrl: true,
                                                      )));
                                        } else if (image is File) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageViewPage(
                                                        imagePath: image,
                                                        netUrl: false,
                                                      )));
                                        }
                                      },
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (image is String) {
                                            DeleteAlert(
                                                context, index, "String");
                                          } else if (image is File) {
                                            DeleteAlert(context, index, "File");
                                          }
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 12,
                                          child: Icon(Icons.close,
                                              color: Colors.white, size: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: height),
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: siteVoucher_Controller
                            .Sitevoucher_itemview_GetDbList.value.isEmpty
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
                            decoration: const BoxDecoration(
                              color: Setmybackground,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
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
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
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
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                      ResetAlert(context);
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
                        siteVoucher_Controller.SaveButton.value,
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
              itemCount: siteVoucher_Controller
                  .Sitevoucher_itemview_GetDbList.value.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, String> paymentTypeMap = {};

                if (siteVoucher_Controller.SaveButton.value == RequestConstant.SUBMIT) {
                  paymentTypeMap = {
                    for (var item in commonVoucherController.paymentTypeList)
                      item.paymentTypeValue: item.paymentTypeName
                  };

                } else {
                  if (siteVoucher_Controller.Sitevoucher_EditListApiValue.isNotEmpty) {
                    paymentTypeMap.addAll({
                      for (var item in siteVoucher_Controller
                          .Sitevoucher_EditListApiValue[0]
                          .accountSiteVoucherSwPayments)
                        item.payType: item.paytypeDesc
                    });
                  }
                  if (siteVoucher_Controller.SaveButton.value == RequestConstant.RESUBMIT) {
                    paymentTypeMap.addAll({
                      for (var item in commonVoucherController.paymentTypeList)
                        item.paymentTypeValue: item.paymentTypeName
                    });
                  }
                }

                final payType = siteVoucher_Controller
                    .Sitevoucher_itemview_GetDbList[index]
                    .paytype;

                final payTypeName = paymentTypeMap[payType]??"";

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
                                siteVoucher_Controller
                                    .Sitevoucher_itemview_GetDbList
                                    .value[index]
                                    .sitename
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
                                                          await siteVoucher_Controller
                                                              .deleteParticularList(
                                                                  siteVoucher_Controller
                                                                          .Sitevoucher_itemview_GetDbList[
                                                                      index]);
                                                          siteVoucher_Controller
                                                                  .Sitevoucher_itemview_GetDbList
                                                              .remove(siteVoucher_Controller
                                                                      .Sitevoucher_itemview_GetDbList[
                                                                  index]);
                                                          await siteVoucher_Controller
                                                              .getsitevoucherTablesDatas();
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
                                child: Text(payTypeName,
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
                                  siteVoucher_Controller
                                      .Sitevoucher_itemview_GetDbList
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
                                  siteVoucher_Controller
                                      .Sitevoucher_itemview_GetDbList
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
        content:
            Text('Are you sure to ${siteVoucher_Controller.SaveButton.value}?'),
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
                          if (projectController.selectedProjectId.value == 0 ||
                              commonVoucherController.AccountTypename.text ==
                                  "--SELECT--" ||
                              commonVoucherController.Accountname.text ==
                                  "--SELECT--" ||
                              commonVoucherController.Paymodename.text ==
                                  "--SELECT--" ||
                              commonVoucherController.AccPayforname.text ==
                                  "--SELECT--" ||
                              double.parse(
                                      siteVoucher_Controller.Amount.text) ==
                                  0.0) {
                            BaseUtitiles.showToast("Some field is missing");
                          } else {
                            if (siteVoucher_Controller.type.value ==
                                "SiteWise Payment") {
                              await siteVoucher_Controller
                                  .getsitevoucherTablesDatas();
                            }
                            if (await BaseUtitiles.checkNetworkAndShowLoader(
                                context)) {
                              await siteVoucher_Controller
                                  .SaveButtonSitevoucher_ItemlistScreen(
                                      context,
                                      siteVoucher_Controller.VocID != 0
                                          ? siteVoucher_Controller.VocID
                                          : 0);
                            }
                          }
                        },
                        child: Text(
                          siteVoucher_Controller.SaveButton.value,
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryColor, // Change color when disabled
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
                            setState(() {
                              siteController.getSiteDropdownvalue.value.clear();
                              siteController.siteDropdownName.clear();
                              siteVoucher_Controller
                                  .delete_Sitevoucher_itemlist_Table();
                              siteVoucher_Controller
                                  .Sitevoucher_itemview_GetDbList.clear();
                              siteVoucher_Controller.SaveButton.value =
                                  RequestConstant.SUBMIT;
                              // siteController.selectedsitedropdownName = "--Select--".obs;
                              // siteController.selectedsiteId = 0.obs;
                              // projectController.projectname.text = "--Select--";
                              // projectController.selectedProjectId.value = 0;
                              siteVoucher_Controller.type.value =
                                  "Direct Payment/Office";
                              siteVoucher_Controller.Amount.text = "0.0";
                              commonVoucherController.Accountname.text =
                                  "--SELECT--";
                              commonVoucherController.AccountTypename.text =
                                  "--SELECT--";
                              commonVoucherController.selectedAccnameId = 0.obs;
                              commonVoucherController.setSelectedaccountName(0);
                              commonVoucherController.AccPayforname.text =
                                  "--SELECT--";
                              commonVoucherController.Accountname.text =
                                  "--SELECT--";
                              commonVoucherController.namethrough.text = "";
                              siteController.Sitename.text = "--SELECT--";
                              commonVoucherController
                                  .VoucherTypeController.text = "Payment";
                              commonVoucherController.voucherPaidForm.text =
                                  "PETTY CASH";
                              commonVoucherController.vocPaidformId = 1;
                              commonVoucherController.VocType.value = "P";
                              commonVoucherController
                                  .setSelectedAccPayForListName("A");
                              siteVoucher_Controller.AutoYearwiseSiteVoc.text =
                                  autoYearWiseNoController
                                      .SiteVoucher_autoYrsWise.value;
                              siteVoucher_Controller.sitevocDate.text =
                                  BaseUtitiles.initiateCurrentDateFormat();
                              commonVoucherController.Paymodename.text =
                                  "BY CASH";
                              commonVoucherController.selectedPaymodeId.value =
                                  1;
                              siteVoucher_Controller.Remarks.text = "";
                              dailyEntriesController.imageFiles.value = [];
                            });
                            Navigator.pop(context);
                          });
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

  Future DeleteAlert(BuildContext context, int index, itemType) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
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
                          if (itemType == "String") {
                            final imageId =
                                siteVoucher_Controller.imageId[index];

                            final isDeleted = await siteVoucher_Controller
                                .deletingImage(imageId);

                            if (isDeleted) {
                              siteVoucher_Controller.gettingNetworkImages
                                  .removeAt(index);
                            }
                          } else if (itemType == "File") {
                            int localIndex = index -
                                siteVoucher_Controller
                                    .gettingNetworkImages.length;
                            if (localIndex >= 0 &&
                                localIndex <
                                    siteVoucher_Controller.imageFiles.length) {
                              setState(() {
                                siteVoucher_Controller.imageFiles
                                    .removeAt(localIndex);
                              });
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
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
