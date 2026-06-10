import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/billtype_alert.dart';
import '../../../../commonpopup/entry_type_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/billgeneration_boq_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bill_generation_boq_itemlist.dart';


class Bill_Generation_Boq_EntryScreen extends StatefulWidget {
  const Bill_Generation_Boq_EntryScreen({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_Boq_EntryScreen> createState() =>
      _Bill_Generation_Boq_EntryScreenState_Site();
}

class _Bill_Generation_Boq_EntryScreenState_Site
    extends State<Bill_Generation_Boq_EntryScreen> {
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
  Get.put(AutoYearWiseNoController());
  BillGenerationBoqController billGenerationBoqController=Get.put(BillGenerationBoqController());

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

      if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT || billGenerationBoqController.saveButton.value == RequestConstant.VERIFY || billGenerationBoqController.saveButton.value == RequestConstant.APPROVAL) {
        billGenerationBoqController.bill_editListApiDatas.forEach((element) {

          billGenerationBoqController.workid = element.id!;
          billGenerationBoqController.autoYearWiseNoController.text = element.workNo.toString();
          billGenerationBoqController.billentryDateController.text = element.workDate.toString();
          projectController.projectname.text = element.projectName.toString();
          projectController.selectedProjectId.value = element.projectId;
          siteController.Sitename.text = element.siteName.toString();
          siteController.selectedsiteId.value = element.siteId;
          dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = element.subContName.toString();
          dailyWrkDone_DPR_Controller.TypeSubcontId.value = element.subContId;
          billGenerationBoqController.DirectBillTypeText.text = element.billTypeDesc;
          billGenerationBoqController.directBillTypeID.value = element.billType;
          billGenerationBoqController.entryTypeController.text = element.entryType == "D" ? "DIRECT" : "BOQ";
          billGenerationBoqController.entryType.value = element.entryType;
          subcontractorController.InvoiceNo.text = element.billNo.toString();
          billGenerationBoqController.billInvoiceDateController.text = element.workDate.toString();
          billGenerationBoqController.billPaymentWkDateController.text = element.paymentDate;
          subcontractorController.selectedWorkOrderId.value =element.workOrderId;
          subcontractorController.WorkOrderNo.text =element.workOrderNo == null ? "--SELECT--":element.workOrderNo;
          billGenerationBoqController.FromdateController.text = element.fromWorkDate.toString();
          billGenerationBoqController.TodateController.text = element.toWorkDate.toString();
          billGenerationBoqController.RemarksController.text = element.remarks.toString();
        });
      }
      if (billGenerationBoqController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("BILL BOQ");
        billGenerationBoqController.autoYearWiseNoController.text =
            autoYearWiseNoController.BillBoqautoYrsWise.value;
        billGenerationBoqController.billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationBoqController.workid = 0;
        subcontractorController.selectedWorkOrderId.value = 0;
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
        billGenerationBoqController.DirectBillTypeText.text = "Company";
        billGenerationBoqController.directBillTypeID.value = "C";
        billGenerationBoqController.entryTypeController.text = "BOQ";
        billGenerationBoqController.entryType.value = "B";
        subcontractorController.WorkOrderNo.text = "--SELECT--";
        billGenerationBoqController.FromdateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationBoqController.TodateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationBoqController.billInvoiceDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        subcontractorController.InvoiceNo.text="";
        billGenerationBoqController.billPaymentWkDateController
            .text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationBoqController.RemarksController.text = "";
        billGenerationBoqController.to_be_dection_advance = "0";
        billGenerationBoqController.saveButton.value = RequestConstant.SUBMIT;
        billGenerationBoqController.billgen_itemlistTable_Delete();
        billGenerationBoqController.ItemGetTableListdata.value=[];
        billGenerationBoqController.billamount.text = "0.0";
        billGenerationBoqController.Creditamt.text = "0.0";
        billGenerationBoqController.Debitamt.text = "0.0";
        billGenerationBoqController.materialDebitamt.text = "0.0";
        billGenerationBoqController.materialDebitRemarks.text = "";
        billGenerationBoqController.CreditRemarksController.text = "";
        billGenerationBoqController.DebitRemarksController.text = "";
        billGenerationBoqController.Advded.text = billGenerationBoqController.tobededadv.text;
        billGenerationBoqController.Roundoff.text = "0";
        billGenerationBoqController.netpayamt.text = "0.0";
        billGenerationBoqController.tobededadv.text = billGenerationBoqController.to_be_dection_advance;
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
                          "Bill Generation - BOQ",
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
                          controller: billGenerationBoqController.autoYearWiseNoController,
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
                          controller: billGenerationBoqController.billentryDateController,
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
                            if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT) {
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
                              billGenerationBoqController.billentryDateController
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
                          onTap: () async {
                            await projectController.getProjectList();
                            if(mounted) {
                              bottomsheetControllers.ProjectName(context,
                                  projectController.getdropDownvalue.value);
                            }},
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
                          controller: dailyWrkDone_DPR_Controller.TypeSubcontractorname,
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
                            await dailyWrkDone_DPR_Controller.dpr_getSubcotType();
                            dailyWrkDone_DPR_Controller.SubcontractorName(context, dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);
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
                          readOnly: true,
                          controller: billGenerationBoqController.entryTypeController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Entry Type",
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
                            if(dailyWrkDone_DPR_Controller.saveButton.value==RequestConstant.APPROVAL){

                            }
                            else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return  EntryTypeAlert(from: 'BILL BOQ',);
                                  });
                            }

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
                          readOnly: true,
                          controller: billGenerationBoqController.billInvoiceDateController,
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
                            if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT) {
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
                              billGenerationBoqController.billInvoiceDateController
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
                          readOnly: true,
                          controller: billGenerationBoqController.billPaymentWkDateController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Payment Wk Date",
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
                            if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT) {
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
                              billGenerationBoqController.billPaymentWkDateController
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
                                controller: billGenerationBoqController.FromdateController,
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
                                  if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT) {
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
                                    billGenerationBoqController
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
                                controller: billGenerationBoqController.TodateController,
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
                                  if (billGenerationBoqController.saveButton.value == RequestConstant.RESUBMIT) {
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
                                    billGenerationBoqController
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
                            await subcontractorController.getWorkOrderNoList("BILL BOQ",
                                projectController.selectedProjectId.value,
                                siteController.selectedsiteId.value,
                                dailyWrkDone_DPR_Controller.TypeSubcontId.value,
                                fromDate: billGenerationBoqController.FromdateController.text,
                                toDate: billGenerationBoqController.TodateController.text);
                            bottomsheetControllers.WorkOrderName(context,
                                subcontractorController.getdpDnWrkOrderValue.value,type: "BILL BOQ",todate:  billGenerationBoqController.TodateController.text);
                          },
                          validator: (value)
                          {
                            if(value == "--SELECT--" || value == "--Select--")
                              {
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
                          controller: billGenerationBoqController.RemarksController,
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
                          color: Theme.of(context).primaryColor

                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bill_Generation_Boq_Itemlist()));
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
