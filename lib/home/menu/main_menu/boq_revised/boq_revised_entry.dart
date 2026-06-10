import 'package:fluttertoast/fluttertoast.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/boqrevised_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Boq_Revised_EntryScreen extends StatefulWidget {
  const Boq_Revised_EntryScreen({Key? key}) : super(key: key);

  @override
  State<Boq_Revised_EntryScreen> createState() =>
      _Boq_Revised_EntryScreenState();
}

class _Boq_Revised_EntryScreenState extends State<Boq_Revised_EntryScreen> {
  CommanController commanController = Get.put(CommanController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  Boq_Revised_Controller boq_revised_controller = Get.put(Boq_Revised_Controller());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (boq_revised_controller.saveButton.value == RequestConstant.SUBMIT) {
        boq_revised_controller.reviseId = 0;
        boq_revised_controller.boq_dateController.text = BaseUtitiles.initiateCurrentDateFormat();
        projectController.projectname.text = RequestConstant.SELECT;
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.selectedsiteId.value = 0;
        siteController.headNameController.text = RequestConstant.SELECT;
        siteController.selectedHeadId.value=0;
        boq_revised_controller.boq_preparedbyController.text = loginController.EmpName();
        boq_revised_controller.boq_remarksController.text = "";
        await autoYearWiseNoController.AutoYearWiseNo("BOQ REVISED");
        boq_revised_controller.boq_autoYearWiseNoController.text = autoYearWiseNoController.BOQRevised_autoYrsWise.value;
      }

      if (boq_revised_controller.saveButton.value == RequestConstant.RESUBMIT) {
          boq_revised_controller.BoqRevised_EditListApiValue.value.forEach((element) {
          boq_revised_controller.reviseId = element.id;
          boq_revised_controller.boq_autoYearWiseNoController.text = element.reviseNo;
          boq_revised_controller.boq_dateController.text = element.reviseDate;
          projectController.selectedProjectId.value = element.projectId;
          projectController.projectname.text = element.projectName;
          siteController.selectedsiteId.value = element.siteId;
          siteController.Sitename.text = element.siteName;
          siteController.selectedHeadId.value = element.measureHeadItemId;
          siteController.headNameController.text = element.measureHeadItemName;
          boq_revised_controller.boq_preparedbyController.text = element.createdByName;
          boq_revised_controller.boq_remarksController.text = element.remarks;
        });
      }
    });
  }


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
          body: Stack(children: [
            SingleChildScrollView(
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
                          "BOQ - Revised",
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
                          controller:
                          boq_revised_controller.boq_autoYearWiseNoController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
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
                                boq_revised_controller.boq_dateController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                child: ConstIcons.projectName),
                          ),
                          onTap: () async {
                            await projectController.getProjectList();
                            bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: siteController.Sitename,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
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
                            bottomsheetControllers.SiteName(context,
                                siteController.getSiteDropdownvalue.value);
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
                          controller: siteController.headNameController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Head Name",
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
                          onTap: () async {
                            await siteController.headNameList("BOQ");
                            bottomsheetControllers.dprNewHeadName(context, siteController.getHeadNameDropdownvalue.value,"BOQ" );
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
                          controller: boq_revised_controller.boq_preparedbyController,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
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
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: false,
                          controller: boq_revised_controller.boq_remarksController,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
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
                  SizedBox(
                      height: BaseUtitiles.getheightofPercentage(context, 1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Setmybackground,
                          ),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              boq_revised_controller.getItemList(context);
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
                                "Add Items",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: height),
                ],
              ),
            ),
                Obx(() => Visibility(
                      visible: boq_revised_controller
                              .Boqitem_itemview_GetDbList.value.isEmpty
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
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height * 0.9,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: ListDetails(
                                                    context, scrollController)),
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
                                              color: Colors.grey,
                                            ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color:  Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color:  Theme.of(context).primaryColor
                        ),
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
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color:  Theme.of(context).primaryColor
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        boq_revised_controller.saveButton.value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color:  Colors.white
                        ),
                      ),
                    ),
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        if(boq_revised_controller.Boqitem_itemview_GetDbList.isEmpty){
                          Fluttertoast.showToast(msg: "Please add items");
                        }
                        else{
                          bool hasInvalid = false;
                          for (int i = 0; i < boq_revised_controller.Boqitem_itemview_GetDbList.length; i++) {
                            final controller = boq_revised_controller.Addwork_qtyControllers[i];
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
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          )
      )
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: BaseUtitiles.getheightofPercentage(context, 3)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Obx(()=>
                 ListView.builder(
                   shrinkWrap: true,
                   physics: BouncingScrollPhysics(),
                   itemCount: boq_revised_controller.Boqitem_itemview_GetDbList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    boq_revised_controller
                        .Item_itemlist_textControllersInitiate();
                    return Card(
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      color: Colors.white,
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin:
                            const EdgeInsets.only(left: 5, top: 5, right: 5,bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 80),
                                  child: Text(
                                    "${boq_revised_controller.Boqitem_itemview_GetDbList.value[index].level3ItemName} (${boq_revised_controller.Boqitem_itemview_GetDbList.value[index].scaleName})",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: RequestConstant.ALERT_Font_SIZE,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 2),
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 10),
                                  child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                              RequestConstant.DO_YOU_WANT_DELETE,
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                            actions: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
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
                                                            child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE))),
                                                      ),
                                                      VerticalDivider(
                                                        color:
                                                            Colors.grey.shade400,
                                                        //color of divider
                                                        width: 5,
                                                        //width space of divider
                                                        thickness: 2,
                                                        //thickness of divier line
                                                        indent: 15,
                                                        //Spacing at the top of divider.
                                                        endIndent:
                                                            15, //Spacing at the bottom of divider.
                                                      ),
                                                      Expanded(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              boq_revised_controller
                                                                  .deleteParticularList(
                                                                      boq_revised_controller
                                                                              .Boqitem_itemview_GetDbList[
                                                                          index]);
                                                              boq_revised_controller
                                                                      .Boqitem_itemview_GetDbList
                                                                  .remove(boq_revised_controller
                                                                          .Boqitem_itemview_GetDbList[
                                                                      index]);
                                                              boq_revised_controller
                                                                  .getItemTablesDatas();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
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
                                      child: const Icon(Icons.remove_circle,
                                          color: Colors.red
                                          // color: Theme.of(context).primaryColor

                                          )
                                      // Image.asset('assets/cancle.png'),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Rate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: RequestConstant.ALERT_Font_SIZE,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Curr Qty",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: RequestConstant.ALERT_Font_SIZE,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Amount",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: RequestConstant.ALERT_Font_SIZE,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    boq_revised_controller
                                        .Boqitem_itemview_GetDbList
                                        .value[index]
                                        .rate
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: RequestConstant.ALERT_Font_SIZE,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: BaseUtitiles.getheightofPercentage(context, 5),
                                    child: TextFormField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: boq_revised_controller.Addwork_qtyControllers[index],
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context).primaryColor),
                                                  borderRadius: const BorderRadius.all(Radius.circular(10),
                                                  ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context).primaryColor),
                                                  borderRadius: const BorderRadius.all(Radius.circular(10),
                                              ),
                                          ),
                                        ),
                                        style: const TextStyle(color: Colors.black),
                                        onChanged: (value) async {
                                            await boq_revised_controller.calculatelist();
                                            setState(() {});
                                        }),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child:
                                     Text(
                                      boq_revised_controller
                                          .Addwork_AmountControllers[index].text
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: RequestConstant.ALERT_Font_SIZE,
                                          color: Colors.black),
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
        ));
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
            'Are you sure to ${boq_revised_controller.saveButton.value}?'),
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
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed:  () async {
                          if (projectController.selectedProjectId.value == 0 ||
                              siteController.selectedsiteId.value == 0) {
                            BaseUtitiles.showToast("Some field missing");
                          } else {
                           if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                             await boq_revised_controller.getItemTablesDatas();
                             await boq_revised_controller.SaveButton_BoqRevisedScreen(context,
                                 boq_revised_controller.reviseId);
                           }
                          }
                        },
                        child: Text(
                          boq_revised_controller.saveButton.value,
                          style: TextStyle(
                            color:  Theme.of(context).primaryColor,
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
                        onPressed: () {
                          setState(() {
                            boq_revised_controller.reviseId = 0;
                            boq_revised_controller.saveButton.value = RequestConstant.SUBMIT;
                            boq_revised_controller.delete_BoqRevised_itemlist_Table();
                            boq_revised_controller.Boqitem_itemview_GetDbList.clear();
                            projectController.projectname.text = RequestConstant.SELECT;
                            projectController.selectedProjectId.value = 0;
                            siteController.selectedsiteId.value = 0;
                            siteController.Sitename.text = RequestConstant.SELECT;
                            siteController.headNameController.text = RequestConstant.SELECT;
                            siteController.selectedHeadId.value=0;
                            boq_revised_controller.boq_preparedbyController.text =
                                loginController.EmpName();
                            boq_revised_controller.boq_autoYearWiseNoController.text =
                                autoYearWiseNoController.BOQRevised_autoYrsWise.value;
                            boq_revised_controller.boq_dateController.text =
                                BaseUtitiles.initiateCurrentDateFormat();
                            boq_revised_controller.boq_remarksController.text = "";
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
}
