import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/fromproject_ccontroller.dart';
import '../../../../controller/fromsite_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class TrasferBetweenProjects_Entry extends StatefulWidget {
  const TrasferBetweenProjects_Entry({Key? key}) : super(key: key);

  @override
  State<TrasferBetweenProjects_Entry> createState() =>
      _TrasferBetweenProjects_EntryState();
}

class _TrasferBetweenProjects_EntryState
    extends State<TrasferBetweenProjects_Entry> {
  LoginController loginController = Get.put(LoginController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  TransferBW_project_Controller transferBW_project_Controller =
      Get.put(TransferBW_project_Controller());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  FromProjectController fromprojectController =
      Get.put(FromProjectController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  SiteController siteController = Get.put(SiteController());

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      transferBW_project_Controller.AgMRNAppreqMasid.value=0;
      transferBW_project_Controller.AgTransReqMasid.value=0;

      if (transferBW_project_Controller.type.value == "Against Mrn Approval" && transferBW_project_Controller.saveButton.value == RequestConstant.SUBMIT) {
       await autoYearWiseNoController.AutoYearWiseNo("TRANSFER BETWEEN PROJECTS");
       transferBW_project_Controller.autoyrwiseText.text = autoYearWiseNoController.TransferBetProjectautoYrsWise.toString();
       transferBW_project_Controller.vechicleNoText.text = "";
        transferBW_project_Controller.dcNoText.text = "";
        transferBW_project_Controller.transportCostText.text = "0.0";
        transferBW_project_Controller.transportAmtText.text = "0.0";
        transferBW_project_Controller.remarksText.text = "";
        transferBW_project_Controller.ItemGetTableListdata.value = [];
        fromsiteController.FromSitename.text = "--SELECT--";
        fromsiteController.selectedsiteId.value = 0;
       fromprojectController.fromprojectname.text = "--SELECT--";
       fromprojectController.selectedProjectId.value = 0;
       transferBW_project_Controller.transferTypeText.text = transferBW_project_Controller.type.value;
       transferBW_project_Controller.entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
       transferBW_project_Controller.appNoText.text = transferBW_project_Controller.transferAllDatasList[0].requestNo;
       projectController.projectnameAll.text = transferBW_project_Controller.transferAllDatasList[0].toprojectName.toString();
        projectController.selectedProjectIdAll.value = transferBW_project_Controller.transferAllDatasList[0].toProjectId;
       transferBW_project_Controller.prearedbyText.text = loginController.EmpName();
       transferBW_project_Controller.AgMRNAppreqMasid.value=transferBW_project_Controller.transferAllDatasList[0].reqMasid;
      }

      else if (transferBW_project_Controller.type.value == "Against Transfer Request" && transferBW_project_Controller.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("TRANSFER BETWEEN PROJECTS");
        transferBW_project_Controller.autoyrwiseText.text = autoYearWiseNoController.TransferBetProjectautoYrsWise.toString();
        transferBW_project_Controller.vechicleNoText.text = "";
          transferBW_project_Controller.dcNoText.text = "";
          transferBW_project_Controller.remarksText.text = "";
          transferBW_project_Controller.transportCostText.text = "0.0";
          transferBW_project_Controller.transportAmtText.text = "0.0";
        transferBW_project_Controller.transferTypeText.text = transferBW_project_Controller.type.value;
          projectController.projectnameAll.text =
              transferBW_project_Controller.transferAllDatasList[0]
                  .toProjectName.toString();
          projectController.selectedProjectIdAll.value =
              transferBW_project_Controller.transferAllDatasList[0].toProjectId;
          fromprojectController.fromprojectname.text =
              transferBW_project_Controller.transferAllDatasList[0]
                  .fromProjectName.toString();
          fromprojectController.selectedProjectId.value =
              transferBW_project_Controller.transferAllDatasList[0]
                  .fromProjectId;
          fromsiteController.FromSitename.text =
              transferBW_project_Controller.transferAllDatasList[0].siteName
                  .toString();
        transferBW_project_Controller.appNoText.text = transferBW_project_Controller.transferAllDatasList[0].transferNo;
        transferBW_project_Controller.entryDateText.text =
              BaseUtitiles.initiateCurrentDateFormat();
          fromsiteController.selectedsiteId.value =
              transferBW_project_Controller.transferAllDatasList[0].fromSiteId;
          transferBW_project_Controller.prearedbyText.text = loginController.EmpName();
          transferBW_project_Controller.AgTransReqMasid.value =
              transferBW_project_Controller.transferAllDatasList[0].id;
      }

      else if (transferBW_project_Controller.saveButton.value == RequestConstant.SUBMIT) {
        await transferBW_project_Controller.itemlistTable_Delete();
        await autoYearWiseNoController.AutoYearWiseNo("TRANSFER BETWEEN PROJECTS");
        transferBW_project_Controller.autoyrwiseText.text = autoYearWiseNoController.TransferBetProjectautoYrsWise.toString();
        transferBW_project_Controller.transferId = 0;
        transferBW_project_Controller.transferTypeText.text =
            transferBW_project_Controller.type.value;
        transferBW_project_Controller.entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        transferBW_project_Controller.prearedbyText.text = loginController.EmpName();
        fromprojectController.fromprojectname.text = "--SELECT--";
        fromprojectController.selectedProjectId.value = 0;
        projectController.projectnameAll.text = "--SELECT--";
        projectController.selectedProjectIdAll.value = 0;
        fromsiteController.FromSitename.text = "--SELECT--";
        fromsiteController.selectedsiteId.value = 0;
        transferBW_project_Controller.vechicleNoText.text = "";
        transferBW_project_Controller.dcNoText.text = "";
        transferBW_project_Controller.transportCostText.text = "0.0";
        transferBW_project_Controller.transportAmtText.text = "0.0";
        transferBW_project_Controller.remarksText.text = "";
        transferBW_project_Controller.appNoText.text="";
        transferBW_project_Controller.ItemGetTableListdata.value = [];
      }

      else if (transferBW_project_Controller.saveButton.value == RequestConstant.RESUBMIT) {
        transferBW_project_Controller.editListApiDatas.forEach((element) {
          transferBW_project_Controller.transferId = element.id!;
          transferBW_project_Controller.autoyrwiseText.text =
              element.transferNo.toString();
          transferBW_project_Controller.entryDateText.text =
              element.entryDate.toString();
          fromprojectController.fromprojectname.text =
              element.frProjectName.toString();
          fromprojectController.selectedProjectId.value =
              element.fromProjectId!;
          fromsiteController.FromSitename.text = element.frSiteName.toString();
          fromsiteController.selectedsiteId.value = element.fromSiteid!;
          projectController.projectnameAll.text =
              element.toProjectName.toString();
          if(transferBW_project_Controller.type.value != "Direct")transferBW_project_Controller.appNoText.text = (element.entryType == "R" ? element.matTransferReqNo : element.reqOrdNo)!;
          projectController.selectedProjectIdAll.value = element.toProjectId!;
          transferBW_project_Controller.transferTypeText.text =
              element.entryType == "A"
                  ? "Against Mrn Approval"
                  : element.entryType == "R"
                      ? "Against Transfer Request"
                      : "Direct";
          transferBW_project_Controller.vechicleNoText.text =
              element.vehicleName.toString();
          transferBW_project_Controller.dcNoText.text = element.dcNo.toString();
          transferBW_project_Controller.remarksText.text =
              element.remarks.toString();
          transferBW_project_Controller.prearedbyText.text =
              element.createdName.toString();
          transferBW_project_Controller.transportAmtText.text =
              element.totalAmount.toString();
          transferBW_project_Controller.transportCostText.text =
              element.transportAmount.toString();
          transferBW_project_Controller.AgTransReqMasid.value=element.matTransReqMasId!;
          transferBW_project_Controller.AgMRNAppreqMasid.value=element.matReqMasId!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return GestureDetector(
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
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Transfer Between Projects",
                              style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white70,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 3,
                                    left: 10,
                                    bottom: 5,
                                  ),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: transferBW_project_Controller
                                        .autoyrwiseText,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Transfer No",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE,
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 0,
                                        minHeight: 0,
                                      ),
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
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, right: 10),
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
                                    readOnly: true,
                                    controller: transferBW_project_Controller
                                        .entryDateText,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Date",
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
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              controller: fromprojectController.fromprojectname,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.FROM_PROJECT_NAME,
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
                                  String? type = transferBW_project_Controller.type.value;

                                  if (type == "Direct") {
                                    await fromprojectController.getFromProjectList();
                                  }
                                  else if (type == "Against Mrn Approval") {
                                    await fromprojectController.getFromProjectList(
                                      type: "Against Mrn Approval",
                                      id: transferBW_project_Controller.AgMRNAppreqMasid.value,
                                    );
                                  }
                                  else {
                                    return;
                                  }
                                  if (mounted) {
                                    bottomsheetControllers.FromProjectName(
                                      context,
                                      fromprojectController.getdropDownvalue.value,
                                    );
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
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              controller: fromsiteController.FromSitename,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.FROM_SITE_NAME,
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
                                if (transferBW_project_Controller.type.value ==
                                        "Against Transfer Request" ||
                                    (transferBW_project_Controller.type.value ==
                                            "Against Mrn Approval" &&
                                        transferBW_project_Controller
                                                .saveButton.value ==
                                            RequestConstant.RESUBMIT)) {
                                } else {
                                  await siteController.subcontEntry_siteDropdowntList(context, 0, type: "transb/wproj&site");
                                  if (mounted) {
                                    bottomsheetControllers.FromSiteName(context, "Transfer Between Projects", siteController.getSiteDropdownvalue);
                                  }
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
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              controller: projectController.projectnameAll,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.TO_PROJECT_NAME,
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
                                if (transferBW_project_Controller.type.value ==
                                    "Direct") {
                                  transferBW_project_Controller
                                      .itemlistTable_Delete();
                                  transferBW_project_Controller
                                      .ItemGetTableListdata.value
                                      .clear();
                                  await projectController.getToProjectName(
                                      fromprojectController
                                          .selectedProjectId.value);
                                  await bottomsheetControllers.projectnameAll(
                                      context,
                                      projectController
                                          .ToProjectDropdownName.value);
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
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              readOnly: true,
                              controller: transferBW_project_Controller
                                  .transferTypeText,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Transfer Type",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types,
                                ),
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
                      Obx(
                        () => Visibility(
                          visible: transferBW_project_Controller.type.value ==
                                  "Direct"
                              ? false
                              : true,
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
                                  readOnly: true,
                                  controller:
                                      transferBW_project_Controller.appNoText,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "No",
                                    labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Icon(Icons.account_circle,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              readOnly: true,
                              controller:
                                  transferBW_project_Controller.prearedbyText,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.PREPARED_BY,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
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
                                    controller: transferBW_project_Controller
                                        .vechicleNoText,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Vehicle No",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.vehicleNo),
                                    ),
                                    onChanged: (value) {},
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
                                    // keyboardType: TextInputType.number,
                                    controller:
                                        transferBW_project_Controller.dcNoText,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "DC No",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.dcNo),
                                    ),
                                    onChanged: (value) {},
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                    controller: transferBW_project_Controller
                                        .transportCostText,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Transport Cost",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.transportCost),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        transferBW_project_Controller
                                            .transportAmtCalculation();
                                      });
                                    },
                                    onTap: () {
                                      if (transferBW_project_Controller
                                                  .transportCostText.text ==
                                              "0.0" ||
                                          transferBW_project_Controller
                                                  .transportCostText.text ==
                                              "0") {
                                        transferBW_project_Controller
                                            .transportCostText.text = "";
                                      }
                                    },
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
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                    controller: transferBW_project_Controller
                                        .transportAmtText,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Transport Amt",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.netAmt),
                                    ),
                                    onChanged: (value) {},
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
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              controller:
                                  transferBW_project_Controller.remarksText,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: RequestConstant.REMARKS,
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
                        () => Visibility(
                            visible: transferBW_project_Controller.type.value ==
                                    "Direct"
                                ? true
                                : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Setmybackground),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                      if (fromprojectController
                                                  .selectedProjectId.value !=
                                              0 &&
                                          fromsiteController
                                                  .selectedsiteId.value !=
                                              0) {
                                        await transferBW_project_Controller
                                            .getTransproject_ItemList(
                                                fromprojectController
                                                    .selectedProjectId.value,
                                                fromsiteController
                                                    .selectedsiteId.value,
                                                0,
                                                context);
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.add,
                                          color:
                                              Theme.of(context).primaryColor),
                                      const SizedBox(width: 5),
                                      Text("Add Items",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible:
                      transferBW_project_Controller.ItemGetTableListdata.isEmpty
                          ? false
                          : true,
                  child: SizedBox(
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
                              SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: ListDetails(
                                            context, scrollController)),
                                  ],
                                ),
                              ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
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
                ),
              ),
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
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Text(
                        transferBW_project_Controller.saveButton.value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        if (transferBW_project_Controller.ItemGetTableListdata.isEmpty) {
                          Fluttertoast.showToast(msg: "Please add items");
                        } else {
                          bool hasInvalid = false;
                          for (int i = 0;
                          i < transferBW_project_Controller.ItemGetTableListdata.length; i++) {
                            final controller = transferBW_project_Controller.Itemlist_TransQty_ListController[i];
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
                            BaseUtitiles.showToast(
                                "Transfer Qty Should Not be Zero or Empty");
                          } else {
                            SubmitAlert(context);
                          }
                        }
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
      child: transferBW_project_Controller.type.value ==
              "Against Transfer Request"
          ? Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 4,
                    right: 4,
                  ),
                  height: MediaQuery.of(context).size.height * 80 / 100,
                  child: Obx(
                    () => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: transferBW_project_Controller
                          .ItemGetTableListdata.length,
                      itemBuilder: (BuildContext context, int index) {
                        transferBW_project_Controller
                            .itemlist_textControllersInitiate();
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${transferBW_project_Controller.ItemGetTableListdata[index].materialName} ( ${transferBW_project_Controller.ItemGetTableListdata[index].scale} ) ",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                        Text(
                                          "Bal Qty ( ${transferBW_project_Controller.ItemGetTableListdata[index].balQty} ) ",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                    ],
                                  )),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 4, bottom: 5, top: 5),
                                child: const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      "Stock Quantity",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Transfer Qty",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 7, right: 4, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 38),
                                      child: TextField(
                                        readOnly: true,
                                        cursorColor:
                                        Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: transferBW_project_Controller
                                            .Itemlist_stockQty_ListController[
                                        index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 11, left: 8, bottom: 0),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 38),
                                      child: TextFormField(
                                        onTap: () {
                                          if (transferBW_project_Controller
                                              .Itemlist_TransQty_ListController[
                                          index]
                                              .text !=
                                              "" &&
                                              transferBW_project_Controller
                                                  .Itemlist_TransQty_ListController[
                                              index]
                                                  .text !=
                                                  "0" &&
                                              transferBW_project_Controller
                                                  .Itemlist_TransQty_ListController[
                                              index]
                                                  .text !=
                                                  "0.0") {
                                            return;
                                          } else {
                                            transferBW_project_Controller
                                                .Itemlist_TransQty_ListController[
                                            index]
                                                .text = "";
                                          }
                                        },
                                        cursorColor:
                                        Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: transferBW_project_Controller
                                            .Itemlist_TransQty_ListController[
                                        index],
                                        keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        onChanged: (value) async {
                                          transferBW_project_Controller
                                              .ItemListclickEdit();
                                          transferBW_project_Controller
                                              .transportAmtCalculation();

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 4, bottom: 5, top: 5),
                                child: const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      "Rate",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Amount",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 7, right: 4, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 38),
                                      child: TextField(
                                        cursorColor:
                                        Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: transferBW_project_Controller
                                            .Itemlist_Rate_ListController[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        onChanged: (value) {
                                          transferBW_project_Controller
                                              .ItemListclickEdit();
                                          transferBW_project_Controller
                                              .transportAmtCalculation();
                                          setState(() {});
                                        },
                                        onTap: () {
                                          if (transferBW_project_Controller
                                              .Itemlist_Rate_ListController[
                                          index]
                                              .text !=
                                              "" &&
                                              transferBW_project_Controller
                                                  .Itemlist_Rate_ListController[
                                              index]
                                                  .text !=
                                                  "0" &&
                                              transferBW_project_Controller
                                                  .Itemlist_Rate_ListController[
                                              index]
                                                  .text !=
                                                  "0.0") {
                                            return;
                                          } else {
                                            transferBW_project_Controller
                                                .Itemlist_Rate_ListController[
                                            index]
                                                .text = "";
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 11,
                                      ),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 38),
                                      child: TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          if (transferBW_project_Controller
                                              .Itemlist_Amt_ListController[
                                          index]
                                              .text !=
                                              "" &&
                                              transferBW_project_Controller
                                                  .Itemlist_Amt_ListController[
                                              index]
                                                  .text !=
                                                  "0" &&
                                              transferBW_project_Controller
                                                  .Itemlist_Amt_ListController[
                                              index]
                                                  .text !=
                                                  "0.0") {
                                            return;
                                          } else {
                                            transferBW_project_Controller
                                                .Itemlist_Amt_ListController[
                                            index]
                                                .text = "";
                                          }
                                        },
                                        cursorColor:
                                        Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: transferBW_project_Controller
                                            .Itemlist_Amt_ListController[index],
                                        keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 4,
                    right: 4,
                  ),
                  height: MediaQuery.of(context).size.height * 80 / 100,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: transferBW_project_Controller
                        .ItemGetTableListdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      transferBW_project_Controller
                          .itemlist_textControllersInitiate();
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${transferBW_project_Controller.ItemGetTableListdata[index].materialName} ( ${transferBW_project_Controller.ItemGetTableListdata[index].scale} ) ",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    if (transferBW_project_Controller
                                            .type.value !=
                                        "Direct")
                                      Text(
                                        "Bal Qty ( ${transferBW_project_Controller.ItemGetTableListdata[index].balQty} ) ",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    if (transferBW_project_Controller
                                            .type.value ==
                                        "Direct")
                                      SizedBox(
                                        width: 50,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context:
                                              context,
                                              builder:
                                                  (context) =>
                                                  AlertDialog(
                                                    title:
                                                    const Text(
                                                      RequestConstant.DO_YOU_WANT_DELETE,
                                                      style:
                                                      TextStyle(color: Colors.black),
                                                    ),
                                                    actions: <Widget>[
                                                      Container(
                                                        // margin: const EdgeInsets.only(left: 20, right: 20),
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: RequestConstant.Lable_Font_SIZE,
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                      setState(() {
                                                                        transferBW_project_Controller.deleteParticularList(transferBW_project_Controller.ItemGetTableListdata[index]);
                                                                        transferBW_project_Controller.ItemGetTableListdata.remove(transferBW_project_Controller.ItemGetTableListdata[index]);
                                                                        transferBW_project_Controller.getItemlistTablesDatas();
                                                                        Navigator.pop(context);
                                                                      });
                                                                    },
                                                                    child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 4, bottom: 5, top: 5),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Stock Quantity",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Transfer Qty",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 7, right: 4, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 11),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 38),
                                    child: TextField(
                                      readOnly: true,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textAlign: TextAlign.center,
                                      controller: transferBW_project_Controller
                                              .Itemlist_stockQty_ListController[
                                          index],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 11, left: 8, bottom: 0),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 38),
                                    child: TextFormField(
                                      onTap: () {
                                        if (transferBW_project_Controller
                                                    .Itemlist_TransQty_ListController[
                                                        index]
                                                    .text !=
                                                "" &&
                                            transferBW_project_Controller
                                                    .Itemlist_TransQty_ListController[
                                                        index]
                                                    .text !=
                                                "0" &&
                                            transferBW_project_Controller
                                                    .Itemlist_TransQty_ListController[
                                                        index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          transferBW_project_Controller
                                              .Itemlist_TransQty_ListController[
                                                  index]
                                              .text = "";
                                        }
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textAlign: TextAlign.center,
                                      controller: transferBW_project_Controller
                                              .Itemlist_TransQty_ListController[
                                          index],
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (value) async {
                                        transferBW_project_Controller
                                            .ItemListclickEdit();
                                        transferBW_project_Controller
                                            .transportAmtCalculation();

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 4, bottom: 5, top: 5),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Rate",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Amount",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 7, right: 4, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 11),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 38),
                                    child: TextField(
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textAlign: TextAlign.center,
                                      controller: transferBW_project_Controller
                                          .Itemlist_Rate_ListController[index],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (value) {
                                        transferBW_project_Controller
                                            .ItemListclickEdit();
                                        transferBW_project_Controller
                                            .transportAmtCalculation();
                                        setState(() {});
                                      },
                                      onTap: () {
                                        if (transferBW_project_Controller
                                                    .Itemlist_Rate_ListController[
                                                        index]
                                                    .text !=
                                                "" &&
                                            transferBW_project_Controller
                                                    .Itemlist_Rate_ListController[
                                                        index]
                                                    .text !=
                                                "0" &&
                                            transferBW_project_Controller
                                                    .Itemlist_Rate_ListController[
                                                        index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          transferBW_project_Controller
                                              .Itemlist_Rate_ListController[
                                                  index]
                                              .text = "";
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 11,
                                    ),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 38),
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () {
                                        if (transferBW_project_Controller
                                                    .Itemlist_Amt_ListController[
                                                        index]
                                                    .text !=
                                                "" &&
                                            transferBW_project_Controller
                                                    .Itemlist_Amt_ListController[
                                                        index]
                                                    .text !=
                                                "0" &&
                                            transferBW_project_Controller
                                                    .Itemlist_Amt_ListController[
                                                        index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          transferBW_project_Controller
                                              .Itemlist_Amt_ListController[
                                                  index]
                                              .text = "";
                                        }
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      textAlign: TextAlign.center,
                                      controller: transferBW_project_Controller
                                          .Itemlist_Amt_ListController[index],
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Reset?'),
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
                        transferBW_project_Controller.transferId = 0;
                        transferBW_project_Controller.autoyrwiseText.text =
                            autoYearWiseNoController
                                .TransferBetProjectautoYrsWise.toString();
                        transferBW_project_Controller.entryDateText.text =
                            BaseUtitiles.initiateCurrentDateFormat();
                        transferBW_project_Controller.prearedbyText.text =
                            loginController.EmpName();
                        projectController.projectnameAll.text = "--SELECT--";
                        projectController.selectedProjectIdAll.value = 0;
                        // fromprojectController.fromprojectname.text = "--SELECT--";
                        // fromprojectController.selectedProjectId = 0.obs;
                        // fromsiteController.selectedsiteId = 0.obs;
                        // fromsiteController.FromSitename.text = "";
                        transferBW_project_Controller.vechicleNoText.text = "";
                        transferBW_project_Controller.dcNoText.text = "";
                        transferBW_project_Controller.transportCostText.text =
                            "0.0";
                        transferBW_project_Controller.transportAmtText.text =
                            "0.0";
                        transferBW_project_Controller.remarksText.text = "";
                        transferBW_project_Controller.ItemGetTableListdata.value
                            .clear();
                        setState(() {
                          transferBW_project_Controller.itemlistTable_Delete();
                          transferBW_project_Controller
                              .ItemGetTableListdata.value
                              .clear();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
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

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(
            'Are you sure to ${transferBW_project_Controller.saveButton.value}?'),
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
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
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
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                          onPressed: () async {
                            if (fromsiteController.selectedsiteId.value != 0 &&
                                fromprojectController.selectedProjectId.value !=
                                    0 &&
                                projectController.selectedProjectIdAll.value !=
                                    0 &&
                                transferBW_project_Controller
                                        .vechicleNoText.text !=
                                    "") {
                              if (fromprojectController
                                      .selectedProjectId.value ==
                                  projectController
                                      .selectedProjectIdAll.value) {
                                BaseUtitiles.showToast(
                                    "Saving the same project is not allowed");
                              } else if (transferBW_project_Controller
                                  .ItemGetTableListdata.isEmpty) {
                                BaseUtitiles.showToast(
                                    "Need Material Items to Save");
                              } else {
                                if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                  await transferBW_project_Controller
                                      .getItemlistTablesDatas();
                                  await transferBW_project_Controller
                                      .Save_EntryScreen(
                                          context,
                                          transferBW_project_Controller.saveButton.value == RequestConstant.RESUBMIT ? transferBW_project_Controller.transferId : 0,
                                      transferBW_project_Controller.AgMRNAppreqMasid.value,
                                      transferBW_project_Controller.AgTransReqMasid.value);
                                }
                              }
                            } else {
                              BaseUtitiles.showToast("Some field is missing");
                            }
                          },
                          child: Text(
                              transferBW_project_Controller.saveButton.value,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE))),
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
}
