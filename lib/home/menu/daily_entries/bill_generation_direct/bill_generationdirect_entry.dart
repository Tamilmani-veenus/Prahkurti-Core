import 'package:flutter/foundation.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bill_generation_itemlist.dart';
import 'package:path/path.dart' as path;


class Bill_Generation_EntryScreen extends StatefulWidget {
  const Bill_Generation_EntryScreen({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_EntryScreen> createState() =>
      _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site
    extends State<Bill_Generation_EntryScreen> {
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  BillGenerationDirectController billGenerationDirectController =
      Get.put(BillGenerationDirectController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await autoYearWiseNoController.AutoYearWiseNo("DIRECT BILL");
     billGenerationDirectController.autoYearWiseNoController.text =
          autoYearWiseNoController.DirectBillautoYrsWise.value;
      if (billGenerationDirectController.editCheck == 1) {
        billGenerationDirectController.ButtonChanges(
            billGenerationDirectController.bill_editListApiDatas[0].workId);
        billGenerationDirectController.bill_editListApiDatas.forEach((element) {
          billGenerationDirectController.workid = element.workId!;
          projectController.projectname.text = element.projectName.toString();
          subcontractorController.InvoiceNo.text = element.billNo.toString();
          projectController.selectedProjectId.value = element.projectId;
          subcontractorController.Subcontractorname.text =
              element.subContName.toString();
          subcontractorController.selectedSubcontId.value = element.subContId;
          billGenerationDirectController.RemarksController.text =
              element.remarks.toString();
          billGenerationDirectController.billentryDateController.text =
              element.workDate.toString();
          subcontractorController.selectedWorkOrderId.value =element.workOrderId;
          subcontractorController.WorkOrderNo.text = element.workOrderNo;
          billGenerationDirectController.FromdateController.text =
              element.fromDate.toString();
          billGenerationDirectController.TodateController.text =
              element.toDate.toString();
          billGenerationDirectController.autoYearWiseNoController.text =
              element.workNo.toString();
          siteController.selectedsiteId.value = element.siteId;
          siteController.Sitename.text = element.siteName.toString();
          billGenerationDirectController.billamount.text =
              element.billAmt.toString();
          billGenerationDirectController.tobededadv.text =
              element.actAdvAmt.toString();
          billGenerationDirectController.Creditamt.text =
              element.creditAmt.toString();
          billGenerationDirectController.Debitamt.text =
              element.debitAmt.toString();
          billGenerationDirectController.CreditRemarksController.text =
              element.creditRemarks.toString();
          billGenerationDirectController.DebitRemarksController.text =
              element.debitRemarks.toString();
          billGenerationDirectController.to_be_dection_advance =
              element.advAmt.toString();
          billGenerationDirectController.Advded.text =
              element.advAmt.toString();
          billGenerationDirectController.Roundoff.text =
              element.rndOff.toString();
          billGenerationDirectController.netpayamt.text =
              element.netPayAmt.toString();
        });
      }
      if (billGenerationDirectController.entrycheck == 0) {
        billGenerationDirectController.workid = 0;
        projectController.selectedProjectId.value = 0;
        subcontractorController.selectedWorkOrderId.value = 0;
        siteController.selectedsiteId.value = 0;
        subcontractorController.selectedSubcontId.value=0;
        await projectController.getProjectList();
        await subcontractorController.getSubcontList(context, projectController.selectedProjectId.value,siteController.selectedsiteId.value,"billdirect");
        await subcontractorController.getWorkOrderNoList( projectController.selectedProjectId.value,siteController.selectedsiteId.value,subcontractorController.selectedSubcontId.value);
        subcontractorController.InvoiceNo.text="";
        billGenerationDirectController.to_be_dection_advance = "0";
        billGenerationDirectController.saveButton.value = RequestConstant.SUBMIT;
        projectController.projectname.text = "--SELECT--";
        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.WorkOrderNo.text = "--SELECT--";
        billGenerationDirectController.RemarksController.clear();
        billGenerationDirectController.billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationDirectController.FromdateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationDirectController.TodateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationDirectController.autoYearWiseNoController.text = autoYearWiseNoController.DirectBillautoYrsWise.value;
        siteController.selectedsitedropdownName = "--SELECT--".obs;
        siteController.getSiteDropdownvalue.value.clear();
        siteController.Sitename.text = "--SELECT--";
        siteController.siteDropdownName.clear();
        billGenerationDirectController.billgen_itemlistTable_Delete();
        billGenerationDirectController.ItemGetTableListdata.value.clear();
        billGenerationDirectController.billamount.text = "0.0";
        billGenerationDirectController.Creditamt.text = "0.0";
        billGenerationDirectController.Debitamt.text = "0.0";
        billGenerationDirectController.CreditRemarksController.text = "";
        billGenerationDirectController.DebitRemarksController.text = "";
        billGenerationDirectController.Advded.text = billGenerationDirectController.tobededadv.text;
        billGenerationDirectController.Roundoff.text = "0";
        billGenerationDirectController.netpayamt.text = "0.0";
        billGenerationDirectController.tobededadv.text = billGenerationDirectController.to_be_dection_advance;
      }
    });
    super.initState();
  }



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
            backgroundColor: Setmybackground,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Direct - Bill",
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
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: billGenerationDirectController.autoYearWiseNoController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Entry No",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.requestNo)),
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: billGenerationDirectController.billentryDateController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                            if (billGenerationDirectController.editCheck == 1) {
                            } else {
                              var Entrydate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          // header background color
                                          onPrimary: Colors.white,
                                          // header text color
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
                              billGenerationDirectController.billentryDateController
                                  .text = BaseUtitiles.selectDateFormat(Entrydate!);
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: projectController.projectname,
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
                          onTap: () {
                            setState(() {
                              bottomsheetControllers.ProjectName(context,
                                  projectController.getdropDownvalue.value);
                            });
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
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: siteController.Sitename,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: RequestConstant.SITE_NAME,
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
                          onTap: () {
                            setState(() {
                              bottomsheetControllers.SiteName(context,
                                  siteController.getSiteDropdownvalue.value);
                            });
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: subcontractorController.Subcontractorname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: RequestConstant.SUBCONTRACTOR_NAME,
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.subcontractorName),
                          ),
                          onTap: () async {
                            await subcontractorController.getSubcontList(context, projectController.selectedProjectId.value,siteController.selectedsiteId.value,"billdirect");
                            bottomsheetControllers.SubcontractorName(context,
                                subcontractorController.getdropDownvalue.value);
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: subcontractorController.WorkOrderNo,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: 'Work Order No',
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
                          onTap: ()  async {
                            await subcontractorController.getWorkOrderNoList( projectController.selectedProjectId.value,siteController.selectedsiteId.value,subcontractorController.selectedSubcontId.value);
                            bottomsheetControllers.WorkOrderName(context,
                                subcontractorController.getdpDnWrkOrderValue.value);
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: subcontractorController.InvoiceNo,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: 'Invoice No',
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
                          onTap: ()  async {
                          },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 65),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          // color: Colors.pink.shade50,
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: Text(
                          "Sub Contractor Work Done",
                          style: TextStyle(
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
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
                                controller: billGenerationDirectController.FromdateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: RequestConstant.FROMDATE,
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
                                  if (billGenerationDirectController.editCheck ==
                                      1) {
                                  } else {
                                    var Frdate = await showDatePicker(
                                        fieldHintText: "From",
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    Theme.of(context).primaryColor,
                                                // header background color
                                                onPrimary: Colors.white,
                                                // header text color
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
                                    billGenerationDirectController
                                            .FromdateController.text =
                                        BaseUtitiles.selectDateFormat(Frdate!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
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
                                controller: billGenerationDirectController.TodateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: RequestConstant.TODATE,
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
                                  if (billGenerationDirectController.editCheck == 1) {
                                  } else {
                                    var Todate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    Theme.of(context).primaryColor,
                                                // header background color
                                                onPrimary: Colors.white,
                                                // header text color
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
                                    billGenerationDirectController
                                            .TodateController.text =
                                        BaseUtitiles.selectDateFormat(Todate!);
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
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: billGenerationDirectController.RemarksController,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: RequestConstant.REMARKS,
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), child: ConstIcons.remarks),
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
                  // SizedBox(
                  //     width: BaseUtitiles.getWidthtofPercentage(context, 42),
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: Setmybackground,
                  //       ),
                  //       onPressed: () async {
                  //       },
                  //       child: Row(
                  //         mainAxisAlignment:
                  //         MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(right: 10),
                  //             child: Icon(
                  //               Icons.add,
                  //               color: Theme.of(context).primaryColor,
                  //             ),
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //               "Attach Image",
                  //               style: TextStyle(
                  //                   color:
                  //                   Theme.of(context).primaryColor),
                  //             ),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: billGenerationDirectController.checkColor == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: billGenerationDirectController.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        billGenerationDirectController.checkColor = 0;
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bill_Generation_Itemlist()));
                        }


                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
