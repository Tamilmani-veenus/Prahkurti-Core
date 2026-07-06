import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/billtype_alert.dart';
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


class Bill_Generation_EntryScreen extends StatefulWidget {
  final String heading;
  const Bill_Generation_EntryScreen({Key? key,required this.heading}) : super(key: key);

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

      if (billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL) {
        billGenerationDirectController.bill_editListApiDatas.forEach((element) {
          billGenerationDirectController.workid = element.id!;
          billGenerationDirectController.autoYearWiseNoController.text =
              element.workNo.toString();
          billGenerationDirectController.billentryDateController.text =
              element.workDate.toString();
          projectController.projectname.text = element.projectName.toString();
          projectController.selectedProjectId.value = element.projectId;
          siteController.Sitename.text = element.siteName.toString();
          siteController.selectedsiteId.value = element.siteId;
          subcontractorController.Subcontractorname.text =
              element.subContName.toString();
          subcontractorController.selectedSubcontId.value = element.subContId;
          billGenerationDirectController.DirectBillTypeText.text = element.billTypeDesc;
          billGenerationDirectController.directBillTypeID.value = element.billType;
          subcontractorController.InvoiceNo.text = element.billNo.toString();
          billGenerationDirectController.billInvoiceDateController.text =
              element.workDate.toString();
          billGenerationDirectController.billPaymentWkDateController.text = element.paymentDate;

          subcontractorController.selectedWorkOrderId.value =element.workOrderId;
          subcontractorController.WorkOrderNo.text =element.workOrderNo == null ? "--SELECT--":element.workOrderNo;
          billGenerationDirectController.FromdateController.text =
              element.fromWorkDate.toString();
          billGenerationDirectController.TodateController.text =
              element.toWorkDate.toString();

          billGenerationDirectController.RemarksController.text =
              element.remarks.toString();
        });
      }
      if (billGenerationDirectController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("DIRECT BILL");
        billGenerationDirectController.autoYearWiseNoController.text =
            autoYearWiseNoController.DirectBillautoYrsWise.value;
        billGenerationDirectController.billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationDirectController.workid = 0;
        subcontractorController.selectedWorkOrderId.value = 0;
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.selectedSubcontId.value=0;
        billGenerationDirectController.DirectBillTypeText.text = "--SELECT--";
        billGenerationDirectController.directBillTypeID.value = "0";
        subcontractorController.WorkOrderNo.text = "--SELECT--";
        billGenerationDirectController.billInvoiceDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        subcontractorController.InvoiceNo.text="";
        billGenerationDirectController.billPaymentWkDateController
            .text = BaseUtitiles.initiateCurrentDateFormat();
        billGenerationDirectController.RemarksController.text = "";
        billGenerationDirectController.to_be_dection_advance = "0";
        billGenerationDirectController.saveButton.value = RequestConstant.SUBMIT;
        billGenerationDirectController.billgen_itemlistTable_Delete();
        billGenerationDirectController.ItemGetTableListdata.value.clear();
        billGenerationDirectController.billamount.text = "0.0";
        billGenerationDirectController.Creditamt.text = "0.0";
        billGenerationDirectController.Debitamt.text = "0.0";
        billGenerationDirectController.materialDebitamt.text = "0.0";
        billGenerationDirectController.materialDebitRemarks.text = "";
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
                        Expanded(
                          child: Text(
                            widget.heading,
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
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
                            if (billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT) {
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
                          autovalidateMode: AutovalidateMode.always,
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
                            if(billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL)
                            {}
                            else{
                              await projectController.getProjectList();
                            if(mounted) {
                              bottomsheetControllers.ProjectName(context,
                                  projectController.getdropDownvalue.value);
                            }}
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
                          autovalidateMode: AutovalidateMode.always,
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
                            if(billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL)
                            {}
                            else{
                            setState(() {
                              bottomsheetControllers.SiteName(context,
                                  siteController.getSiteDropdownvalue.value);
                            });}
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
                          autovalidateMode: AutovalidateMode.always,
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
                            if(billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL)
                            {}
                            else{
                              await subcontractorController.getSubcontList(context,
                              projectController.selectedProjectId.value,
                              siteController.selectedsiteId.value,"billdirect");
                              bottomsheetControllers.SubcontractorName(context,
                              subcontractorController.getdropDownvalue.value);
                          } },
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
                          autovalidateMode: AutovalidateMode.always,
                          readOnly: true,
                          controller: billGenerationDirectController.DirectBillTypeText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Bill Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.billType),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
                          },
                          onTap: () async {
                            if(billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL)
                            {}
                            else{
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BillType_Alert();
                                });}

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
                          autovalidateMode: AutovalidateMode.always,
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
                            if(billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL)
                            {}
                            else{
                            await subcontractorController.getWorkOrderNoList("BILL DIRECT",
                                projectController.selectedProjectId.value,
                                siteController.selectedsiteId.value,
                                subcontractorController.selectedSubcontId.value);
                            bottomsheetControllers.WorkOrderName(context,
                                subcontractorController.getdpDnWrkOrderValue.value,type: "BILL DIRECT");
                          }},

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
                          controller: billGenerationDirectController.billInvoiceDateController,
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
                            if (billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT) {
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
                              billGenerationDirectController.billInvoiceDateController
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
                          controller: billGenerationDirectController.billPaymentWkDateController,
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
                            if (billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT) {
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
                              billGenerationDirectController.billPaymentWkDateController
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
                          autovalidateMode: AutovalidateMode.always,
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
                          autovalidateMode: AutovalidateMode.always,
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
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return '\u26A0 ${RequestConstant.VALIDATE}';
                          //   }
                          //   return null;
                          // },
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
                          billGenerationDirectController.tobededadv.addListener(() {
                            billGenerationDirectController.updateAdvanceReadOnly();
                          });
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
