import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/requesttype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/mrnrequest_preIndent_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class MRNRequest_PreIndent_EntryScreen extends StatefulWidget {
  const MRNRequest_PreIndent_EntryScreen({Key? key}) : super(key: key);

  @override
  State<MRNRequest_PreIndent_EntryScreen> createState() => _MRNRequest_PreIndent_EntryScreenState();
}

class _MRNRequest_PreIndent_EntryScreenState extends State<MRNRequest_PreIndent_EntryScreen> {

  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  LoginController loginController = Get.put(LoginController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.VERIFY || mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.APPROVAL) {
        mrnRequest_PreIndent_Controller.pendingAllDatasList.forEach((element) {
          mrnRequest_PreIndent_Controller.reqId = element.reqId;
          mrnRequest_PreIndent_Controller.autoYearWiseNoController.text = element.reqNo;
          mrnRequest_PreIndent_Controller.RequestDateController.text = element.reqDate;
          mrnRequest_PreIndent_Controller.DuedateController.text = element.reqDueDate;
          projectController.selectedProjectId.value = element.projectId;
          siteController.selectedsiteId.value = element.siteId;
          projectController.projectname.text = element.projectName;
          siteController.Sitename.text = element.siteName;
          mrnRequest_PreIndent_Controller.preparedbyController.text = element.preparedbyName;
          mrnRequest_PreIndent_Controller.ReqTypeController.text = element.purchaseType == "PO" ? "General Items" : "Asset Materials";
          mrnRequest_PreIndent_Controller.ReqType.value = element.purchaseVal.toString();
          mrnRequest_PreIndent_Controller.RemarksController.text = element.reqRemarks;
        });
      }
      if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.RESUBMIT) {
        mrnRequest_PreIndent_Controller.saveButton.value = RequestConstant.RESUBMIT;
        mrnRequest_PreIndent_Controller.Material_EditListApiValue.forEach((element) {
          mrnRequest_PreIndent_Controller.reqId = element.reqId;
          mrnRequest_PreIndent_Controller.autoYearWiseNoController.text = element.reqNo;
          mrnRequest_PreIndent_Controller.RequestDateController.text = element.reqDate;
          mrnRequest_PreIndent_Controller.DuedateController.text = element.reqDueDate;
          projectController.selectedProjectId.value = element.projectId;
          siteController.selectedsiteId.value = element.siteId;
          projectController.projectname.text = element.projectName;
          siteController.Sitename.text = element.siteName;
          mrnRequest_PreIndent_Controller.preparedbyController.text = element.preparedbyName;
          mrnRequest_PreIndent_Controller.ReqTypeController.text = element.purchaseType == "PO" ? "General Items" : "Asset Materials";
          mrnRequest_PreIndent_Controller.ReqType.value = element.purchaseVal.toString();
          mrnRequest_PreIndent_Controller.RemarksController.text = element.reqRemarks;
        });
      }
      if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("MRN PRE INDENT");
        mrnRequest_PreIndent_Controller.autoYearWiseNoController.text = autoYearWiseNoController.MRNIndentPreIndent_autoYrsWise.value;
        await projectController.getProjectList();
        mrnRequest_PreIndent_Controller.saveButton.value = RequestConstant.SUBMIT;
        mrnRequest_PreIndent_Controller.reqId = 0;
        mrnRequest_PreIndent_Controller.delete_MaterialIntent_itemlist_Table();
        mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.clear();
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        subcontractorController.Subcontractorname.text = "--Select--";
        subcontractorController.selectedSubcontId.value = 0;
        mrnRequest_PreIndent_Controller.RemarksController.clear();
        mrnRequest_PreIndent_Controller.RequestDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        mrnRequest_PreIndent_Controller.DuedateController.text = BaseUtitiles.initiateCurrentDateFormat();
        mrnRequest_PreIndent_Controller.preparedbyController.text = loginController.EmpName();
        mrnRequest_PreIndent_Controller.ReqTypeController.text = "--SELECT--";
        mrnRequest_PreIndent_Controller.ReqType.value = "0";
        siteController.selectedsiteId = 0.obs;
        siteController.selectedsitedropdownName = "--Select--".obs;
        siteController.getSiteDropdownvalue.value.clear();
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.siteDropdownName.clear();
        bottomsheetControllers.searchcontroller.text = "";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
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
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Site Request (Issue Slip)",
                              style: TextStyle(
                                  fontSize: RequestConstant.Heading_Font_SIZE,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Back", style: TextStyle(color: Colors.grey, fontSize: 18)))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          color: Colors.white,
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
                              controller: mrnRequest_PreIndent_Controller.autoYearWiseNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request No",
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                              EdgeInsets.only(top: 2, left: 10, right: 10),
                              child: Card(
                                color: Colors.white,
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
                                    readOnly: true,
                                    controller: mrnRequest_PreIndent_Controller.RequestDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Request Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: mrnRequest_PreIndent_Controller.DuedateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Due Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                    onTap: () async {
                                      var Entrydate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  // header background color
                                                  onPrimary: Colors.white,
                                                  // header text color
                                                  onSurface: Colors
                                                      .black, // body text color
                                                ),
                                                textButtonTheme:
                                                TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors
                                                        .black, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          });
                                      mrnRequest_PreIndent_Controller.DuedateController.text = BaseUtitiles.selectDateFormat(Entrydate!);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                        const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                              mrnRequest_PreIndent_Controller.ReqTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request Type",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                ),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types,
                                ),
                              ),
                              onTap: () async {
                                if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.VERIFY || mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.VERIFY || mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.APPROVAL) {
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const RequestType_Alert();
                                      });
                                }
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
                        margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          color: Colors.white,
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
                              controller: projectController.projectname,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                // await projectController.getProjectList(context, 0);
                                setState(() {
                                  if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.VERIFY ||
                                      mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.APPROVAL ||
                                      mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.RESUBMIT ) {
                                  } else {
                                    bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          color: Colors.white,
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
                              controller: siteController.Sitename,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              onTap: () {
                                setState(() {
                                  if (mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.VERIFY ||
                                      mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.APPROVAL ||
                                      mrnRequest_PreIndent_Controller.saveButton.value == RequestConstant.RESUBMIT) {
                                  } else {
                                    bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                  return '\u26A0 Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      // Container(
                      //   margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //       side: BorderSide(color: Colors.white70, width: 1),
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     elevation: 3,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //           top: 3, left: 10, bottom: 5),
                      //       child: TextFormField(
                      //         readOnly: true,
                      //         controller: mrn_request_controller.ReqTypeController,
                      //         cursorColor: Colors.black,
                      //         style: TextStyle(color: Colors.black),
                      //         decoration: InputDecoration(
                      //           contentPadding: EdgeInsets.zero,
                      //           border: InputBorder.none,
                      //           labelText: "Request Type",
                      //           labelStyle: TextStyle(
                      //               color: Colors.grey,
                      //               fontSize: RequestConstant.Lable_Font_SIZE),
                      //           prefixIconConstraints:
                      //           BoxConstraints(minWidth: 0, minHeight: 0),
                      //           prefixIcon: Padding(
                      //               padding: EdgeInsets.symmetric(
                      //                   vertical: 8, horizontal: 8),
                      //               child: ConstIcons.types),
                      //         ),
                      //         onTap: () async {
                      //           if(mrn_request_controller.screenCheck == "PendingScreen" || mrn_request_controller.Material_itemview_GetDbList.value.length>0){
                      //
                      //           }else{
                      //             showDialog(
                      //                 context: context,
                      //                 builder: (BuildContext context) {
                      //                   return  RequestType_Alert();
                      //                 });
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Container(
                        margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          color: Colors.white,
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
                              controller: mrnRequest_PreIndent_Controller.preparedbyController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Prepared By",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.preparedBy),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: false,
                              controller: mrnRequest_PreIndent_Controller.RemarksController,
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),

                      Visibility(
                        visible: mrnRequest_PreIndent_Controller.saveButton.value != RequestConstant.VERIFY && mrnRequest_PreIndent_Controller.saveButton.value != RequestConstant.APPROVAL,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () {
                                  if(  mrnRequest_PreIndent_Controller.screenCheck=="PendingScreen"){

                                  }else{
                                    if (_formKey.currentState!.validate()) {
                                      mrnRequest_PreIndent_Controller.getMaterialList(
                                          context,
                                          mrnRequest_PreIndent_Controller.ReqType.value
                                              .toString(),
                                          projectController.selectedProjectId.value,
                                          siteController.selectedsiteId.value);
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.add, color: Theme.of(context).primaryColor),
                                    SizedBox(width: 5),
                                    Text("Add Materials", style: TextStyle(color: Theme.of(context).primaryColor)),
                                  ],)),
                          ],
                        ),
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                ),

                Obx(() => Visibility(
                  visible: mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value.isEmpty
                      ? false : true,
                  child:  Container(
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
                                        // ...List.generate(50,
                                        //         (index) => Container(
                                        //         height: 50, child: Text('Container $index')))
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20, bottom: 20),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: mrnRequest_PreIndent_Controller.screenCheck != "PendingScreen"
                        ? true
                        : false,
                    child: Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: mrnRequest_PreIndent_Controller.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: mrnRequest_PreIndent_Controller.checkColor == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mrnRequest_PreIndent_Controller.checkColor = 1;
                            ResetAlert(context);
                          });
                        },
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: mrnRequest_PreIndent_Controller.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child:
                          Obx(()=> Text(
                            mrnRequest_PreIndent_Controller.saveButton.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: mrnRequest_PreIndent_Controller.checkColor == 0
                                    ? Colors.white
                                    : Theme.of(context).primaryColor),
                          ))),
                      onTap: () async {
                        mrnRequest_PreIndent_Controller.checkColor = 0;

                        if (mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value.length < 1) {
                          BaseUtitiles.showToast("Plese select item list");
                        } else if (_formKey.currentState!.validate()) {
                          bool hasInvalid = false;
                          for (int i = 0; i < mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.length; i++) {
                            final controller = mrnRequest_PreIndent_Controller.Addwork_qtyControllers[i];
                            final text = controller.text.trim();

                            if (text.isEmpty) {
                              hasInvalid = true;
                              break;
                            }

                            final value = double.tryParse(text);
                            if (value == null || value <= 0) {
                              hasInvalid = true;
                              break;
                            }
                          }
                          if (hasInvalid) {
                            BaseUtitiles.showToast("Qty Should Not be Zero or Empty");
                          } else {
                            SubmitAlert(context);
                          }
                        } else {}
                      },
                    ),
                  ),

                ],
              ),
            ),

          ),
        ),
      ),
    );
  }


  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return
      Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 5/100),
          Container(
              height: MediaQuery.of(context).size.height * 75/100,
              // height: BaseUtitiles.getheightofPercentage(context,65),
              // margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 5),
              child: Obx(()=> ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                itemCount: mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  mrnRequest_PreIndent_Controller.Material_itemlist_textControllersInitiate();
                  return Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value[index].material.toString() +
                                    " (" + mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value[index].scale.toString() + ")",
                                //textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.ALERT_Font_SIZE,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Visibility(
                                visible : mrnRequest_PreIndent_Controller.saveButton.value != RequestConstant.VERIFY && mrnRequest_PreIndent_Controller.saveButton.value != RequestConstant.APPROVAL,
                                child: Container(
                                  height: BaseUtitiles.getheightofPercentage(context, 2),
                                  width: BaseUtitiles.getWidthtofPercentage(context, 10),
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
                                                        endIndent: 15,
                                                      ),
                                                      Expanded(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              mrnRequest_PreIndent_Controller.deleteParticularList(mrnRequest_PreIndent_Controller.Material_itemview_GetDbList[index]);
                                                              mrnRequest_PreIndent_Controller
                                                                  .Material_itemview_GetDbList
                                                                  .remove(mrnRequest_PreIndent_Controller
                                                                  .Material_itemview_GetDbList[
                                                              index]);
                                                              mrnRequest_PreIndent_Controller.getMaterialTablesDatas();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("Delete",
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
                                      },
                                      child: Icon(Icons.remove_circle,
                                          color: Colors.red
                                        // color: Theme.of(context).primaryColor
                                      )
                                    // Image.asset('assets/cancle.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 15, bottom: 10,right: 5),
                                        child: Text( "BalQty:  ",
                                            style: TextStyle(
                                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).primaryColor))
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text( mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value[index].balqty.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                                color: Colors.black))),
                                  ),

                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                                        child: Text(
                                          "Quantity",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: RequestConstant.ALERT_Font_SIZE,
                                              color: Colors.black),
                                        )),
                                  ),

                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, right: 10, bottom: 10),
                                      height: BaseUtitiles.getheightofPercentage(context, 3),
                                      width: BaseUtitiles.getWidthtofPercentage(context, 20),
                                      child: TextField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnRequest_PreIndent_Controller.Addwork_qtyControllers[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (value) {
                                          setState(() {
                                          });
                                          mrnRequest_PreIndent_Controller.MaterialItemlist_clickEdit();
                                        },
                                        onTap: (){
                                          if(mrnRequest_PreIndent_Controller.Addwork_qtyControllers[index].text=="0" || mrnRequest_PreIndent_Controller.Addwork_qtyControllers[index].text=="0.0" ){
                                            mrnRequest_PreIndent_Controller.Addwork_qtyControllers[index].text="";
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(top: 5, right: 10, left: 10),
                                height: BaseUtitiles.getheightofPercentage(
                                    context, 3),
                                child: TextFormField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  textAlign: TextAlign.center,
                                  controller: mrnRequest_PreIndent_Controller.Addwork_descControllers[index],
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: const TextStyle(color: Colors.black,fontSize: 12.0),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                  ),
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    mrnRequest_PreIndent_Controller.MaterialItemlist_clickEdit();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left: 10, bottom: 5),
                                height: BaseUtitiles.getheightofPercentage(
                                    context, 3),
                                child: TextField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  textAlign: TextAlign.center,
                                  controller: mrnRequest_PreIndent_Controller.Addwork_remarksControllers[index],
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    labelText: 'Remarks',
                                    labelStyle: const TextStyle(color: Colors.black,fontSize: 12.0),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                  ),
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    mrnRequest_PreIndent_Controller.MaterialItemlist_clickEdit();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),)
          ),
        ],
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
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          mrnRequest_PreIndent_Controller.entrycheck == 0;
                          mrnRequest_PreIndent_Controller.reqId = 0;
                          mrnRequest_PreIndent_Controller.saveButton.value = RequestConstant.SUBMIT;
                          mrnRequest_PreIndent_Controller.delete_MaterialIntent_itemlist_Table();
                          mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.clear();
                          projectController.projectname.text = "--Select--";
                          projectController.selectedProjectId.value = 0;
                          subcontractorController.Subcontractorname.text = "--Select--";
                          subcontractorController.selectedSubcontId.value = 0;
                          mrnRequest_PreIndent_Controller.RemarksController.clear();
                          mrnRequest_PreIndent_Controller.RequestDateController.text = BaseUtitiles.initiateCurrentDateFormat();
                          mrnRequest_PreIndent_Controller.DuedateController.text = BaseUtitiles.initiateCurrentDateFormat();
                          mrnRequest_PreIndent_Controller.preparedbyController.text = loginController.EmpName();
                          mrnRequest_PreIndent_Controller.autoYearWiseNoController.text = autoYearWiseNoController.MRNIndent_autoYrsWise.value;
                          // mrn_request_controller.ReqTypeController.text = "General items";
                          // mrn_request_controller.ReqType.value = "PO";
                          siteController.selectedsiteId = 0.obs;
                          siteController.selectedsitedropdownName = "--Select--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();
                          bottomsheetControllers.searchcontroller.text = "";
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

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.white,
        title: Text('Alert!'),
        content: Text('Are you sure to ${mrnRequest_PreIndent_Controller.saveButton.value}?'),
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
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),

                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (await BaseUtitiles.checkNetworkAndShowLoader(
                          context)) {
                            await mrnRequest_PreIndent_Controller.getMaterialTablesDatas();
                            mrnRequest_PreIndent_Controller.SaveButton_MaterialIntentScreen(
                                context,
                                mrnRequest_PreIndent_Controller.reqId != 0 ?
                                mrnRequest_PreIndent_Controller.reqId : 0);
                          }
                          },
                        child:
                        Text(
                            mrnRequest_PreIndent_Controller.saveButton.value,
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
