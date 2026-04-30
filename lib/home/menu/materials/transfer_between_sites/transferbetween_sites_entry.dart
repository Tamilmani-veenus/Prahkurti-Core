import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'transferbetween_sites_additems.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/fromproject_ccontroller.dart';
import '../../../../controller/fromsite_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../controller/transferbw_site_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class TransferBetweenSites_Entry extends StatefulWidget {
  const TransferBetweenSites_Entry({Key? key}) : super(key: key);

  @override
  State<TransferBetweenSites_Entry> createState() => _TransferBetweenSites_EntryState();
}

class _TransferBetweenSites_EntryState extends State<TransferBetweenSites_Entry> {

  TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());
  LoginController loginController = Get.put(LoginController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  FromProjectController fromprojectController=Get.put(FromProjectController());
  FromSiteController fromsiteController=Get.put(FromSiteController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  CommanController commanController = Get.put(CommanController());
  TextEditingController editingController = TextEditingController();
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds:0);
    Future.delayed(duration,() async {
      if(transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST){
        await autoYearWiseNoController.AutoYearWiseNo("TRANSFER BETWEEN SITES");
        transferBt_Site_Controller.autoyrwiseText.text=autoYearWiseNoController.TransferBetSiteautoYrsWise.toString();
        transferBt_Site_Controller.transferAllDatasList.value.forEach((element)  {
          transferBt_Site_Controller.transId=0;
          transferBt_Site_Controller.prearedbyText.text=loginController.EmpName();
          transferBt_Site_Controller.entryDateText.text=BaseUtitiles.initiateCurrentDateFormat();
          projectController.projectname.text=element.projectName.toString();
          projectController.selectedProjectId.value=element.projectId;
          fromsiteController.FromSitename.text="--SELECT--";
          fromsiteController.selectedsiteId.value=0;
          siteController.Sitename.text=element.toSiteName.toString();
          siteController.selectedsiteId.value=element.toSiteId;
          transferBt_Site_Controller.ReqNoText.text = element.reqOrdNo;
          subcontractorController.Subcontractorname.text="--SELECT--";
          subcontractorController.selectedSubcontId.value=0;
          transferBt_Site_Controller.remarksText.text="";


        });
      }
     if(transferBt_Site_Controller.saveButton.value == RequestConstant.RESUBMIT){
       transferBt_Site_Controller.editListApiDatas.value.forEach((element) {
         transferBt_Site_Controller.transId=element.id;
         transferBt_Site_Controller.prearedbyText.text=element.employeeName;
         transferBt_Site_Controller.autoyrwiseText.text=element.transferNo.toString();
         transferBt_Site_Controller.entryDateText.text=element.entryDt.toString();
         projectController.projectname.text=element.projectName.toString();
         projectController.selectedProjectId.value=element.fromProjectId;
         fromsiteController.FromSitename.text=element.fromSiteName.toString();
         fromsiteController.selectedsiteId.value=element.fromSiteid;
         siteController.Sitename.text=element.toSiteName.toString();
         siteController.selectedsiteId.value=element.toSiteId;
         subcontractorController.Subcontractorname.text=element.subcontractName.toString();
         subcontractorController.selectedSubcontId.value=element.subContractId;
         transferBt_Site_Controller.remarksText.text=element.remarks.toString();
         transferBt_Site_Controller.radioValue.value=element.transferType==1?"transfer_usage":"transfer";
       });
     }
     if(transferBt_Site_Controller.saveButton.value == RequestConstant.SUBMIT){
       await autoYearWiseNoController.AutoYearWiseNo("TRANSFER BETWEEN SITES");
        transferBt_Site_Controller.radioValue.value="transfer_usage";
        transferBt_Site_Controller.transId=0;
        projectController.projectname.text="--SELECT--";
        projectController.selectedProjectId=0.obs;
        fromsiteController.FromSitename.text="--SELECT--";
        fromsiteController.selectedsiteId.value=0;
        siteController.Sitename.text="--SELECT--";
        siteController.selectedsiteId.value=0;
        subcontractorController.Subcontractorname.text="--SELECT--";
        subcontractorController.selectedSubcontId.value=0;
        transferBt_Site_Controller.itemlistTable_Delete();
        transferBt_Site_Controller.ItemGetTableListdata.value=[];
        transferBt_Site_Controller.remarksText.text="";
        transferBt_Site_Controller.autoyrwiseText.text=autoYearWiseNoController.TransferBetSiteautoYrsWise.toString();
        transferBt_Site_Controller.entryDateText.text=BaseUtitiles.initiateCurrentDateFormat();
        transferBt_Site_Controller.prearedbyText.text=loginController.EmpName();
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
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
              body:
              Stack(
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
                                  "Transfer Between Sites",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
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
                                        controller: transferBt_Site_Controller.autoyrwiseText,
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
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
                                          if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
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
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, right: 10),
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
                                        controller: transferBt_Site_Controller.entryDateText,
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
                                          transferBt_Site_Controller.entryDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
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
                                padding:
                                const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  controller: projectController.projectname,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: RequestConstant.PROJECT_NAME,
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
                                    if(transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST){}
                                    else {
                                      await projectController.getProjectList();
                                      bottomsheetControllers.ProjectName(
                                          context,
                                          projectController.getdropDownvalue
                                              .value);
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
                                  controller: fromsiteController.FromSitename,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
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
                                        child: ConstIcons.fromSiteName),
                                  ),
                                  onTap: () async {
                                    if(transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST){
                                      await siteController.subcontEntry_siteDropdowntList(context, 0, type: "StoreTransfer");
                                    }
                                      if (mounted) {
                                        bottomsheetControllers.FromSiteName(context,
                                            transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST ? "STORE TRANSFER" : "Transfer Between Sites",
                                            siteController.getSiteDropdownvalue.value);
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
                                  controller: siteController.Sitename,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "To Site Name",
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
                                    if(transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST){}
                                    else {
                                      await siteController
                                          .toSiteDropdowntList();
                                      await bottomsheetControllers.ToSiteName(
                                          context,
                                          siteController.getToSiteDropdownvalue
                                              .value);
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
                          Visibility(
                            visible: transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST,
                            child: Container(
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
                                    controller: transferBt_Site_Controller.ReqNoText,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
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
                                          child: ConstIcons.siteName),
                                    ),
                                    onTap: () async {
                                    },
                                    // validator: (value) {
                                    //   if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                                    //     return '\u26A0 ${RequestConstant.VALIDATE}';
                                    //   }
                                    //   return null;
                                    // },
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
                                    await subcontractorController.getSubcontList(context,projectController.selectedProjectId.value,0,context);
                                    bottomsheetControllers.SubcontractorName(context, subcontractorController.getdropDownvalue.value);
                                  },
                                  // validator: (value) {
                                  //   if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
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
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  controller: transferBt_Site_Controller.prearedbyText,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
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
                                  onChanged: (value){

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
                                  controller: transferBt_Site_Controller.remarksText,
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
                                    if (value=="") {
                                      return '\u26A0 ${RequestConstant.VALIDATE}';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                             Obx(()=>
                                Visibility(
                                  visible:transferBt_Site_Controller.saveButton.value != RequestConstant.PENDINGLIST,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: 15),
                                    Row(
                                        children: [
                                          Radio<String>(
                                            value: 'transfer_usage',
                                            groupValue: transferBt_Site_Controller.radioValue.value,
                                            fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                                            onChanged: (value) {
                                                transferBt_Site_Controller.radioValue.value = value!;
                                            },
                                          ),
                                          Container( child: const Text('Transfer and Usage')),
                                        ]),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'transfer',
                                          groupValue: transferBt_Site_Controller.radioValue.value,
                                          fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                                          onChanged: (value) {
                                              transferBt_Site_Controller.radioValue.value = value!;
                                          },
                                        ),
                                        Container( child: const Text('Transfer')),
                                      ],),
                                    Spacer(),
                                  ],),
                                ),
                             ),

                          SizedBox(height: MediaQuery.of(context).size.height * 1/100),

                          Visibility(
                            visible: transferBt_Site_Controller.saveButton.value != RequestConstant.PENDINGLIST,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Setmybackground,
                                      ),
                                      onPressed: () async {
                                        if(_formKey.currentState!.validate()){
                                          _formKey.currentState!.save();
                                          await transferBt_Site_Controller.getItemList(projectController.selectedProjectId.value,fromsiteController.selectedsiteId.value,context);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.add, color: Theme.of(context).primaryColor,),
                                          SizedBox(width: 5),
                                          Text("Add Items", style: TextStyle(color: Theme.of(context).primaryColor),),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: height),
                        ],
                      )),

                  Obx(() => Visibility(
                      visible: transferBt_Site_Controller.ItemGetTableListdata.value.isEmpty ? false : true,
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
                                            margin:
                                            EdgeInsets.only(top: 20, bottom: 20),
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
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color:  Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text("Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                                color:    Theme.of(context).primaryColor ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            ResetAlert(context);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20 , right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color:   Theme.of(context).primaryColor ,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST ? RequestConstant.SUBMIT : transferBt_Site_Controller.saveButton.value,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white ),),
                        ),
                        onTap: () async {

                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              if( transferBt_Site_Controller.ItemGetTableListdata.isEmpty){
                                Fluttertoast.showToast(msg: "Please add items");
                              }else{
                                bool hasInvalid = false;
                                for (int i = 0; i < transferBt_Site_Controller.ItemGetTableListdata.length; i++) {
                                  final controller = transferBt_Site_Controller.Itemlist_TransQty_ListController[i];
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
                                  BaseUtitiles.showToast("Transfer Qty Should Not be Zero or Empty");
                                }
                                else {
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
        ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return
          Column(
            children: <Widget>[
              SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5),),
              Container(
                height: BaseUtitiles.getheightofPercentage(context,65),
                child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ScrollPhysics(),
                  itemCount: transferBt_Site_Controller.ItemGetTableListdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    transferBt_Site_Controller.itemlist_textControllersInitiate();
                    return
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 4,right: 5,top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          transferBt_Site_Controller.ItemGetTableListdata[index].materialName.toString()+" ( "+ transferBt_Site_Controller.ItemGetTableListdata[index].scale.toString()+" )",
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 15),
                                        ),
                                      ),
                                      Visibility(
                                        visible: transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST,
                                        child: Text(
                                          "Bal Qty ( ${transferBt_Site_Controller.ItemGetTableListdata[index].balQty} ) ",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: transferBt_Site_Controller.saveButton.value != RequestConstant.PENDINGLIST,
                                        child: SizedBox(
                                          child:
                                          InkWell(
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
                                                                          transferBt_Site_Controller.deleteParticularList(transferBt_Site_Controller.ItemGetTableListdata[index]);
                                                                          transferBt_Site_Controller.ItemGetTableListdata.remove(transferBt_Site_Controller.ItemGetTableListdata[index]);
                                                                          transferBt_Site_Controller.getItemlistTablesDatas();
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
                                                Icons
                                                    .remove_circle,
                                                color: Colors
                                                    .red),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5,right: 4,bottom: 5,top: 5),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children:<Widget> [
                                      Text("Stock Quantity",style: TextStyle(color: Colors.black),),
                                      Text("Transfer Qty",style: TextStyle(color: Colors.black),), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7,right: 4,bottom: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children:<Widget> [
                                      Container(
                                        margin: EdgeInsets.only(right: 11),
                                        height: BaseUtitiles.getheightofPercentage(context, 4),
                                        width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                        child:
                                        TextField(
                                          readOnly: true,
                                          cursorColor:Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: transferBt_Site_Controller.Itemlist_stockQty_ListController[index],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                          onChanged: (value) {

                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 11,left: 8),
                                        height: BaseUtitiles.getheightofPercentage(context, 4),
                                        width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                        child: TextFormField(
                                          onTap: (){
                                            if(transferBt_Site_Controller.Itemlist_TransQty_ListController[index].text != "" && transferBt_Site_Controller.Itemlist_TransQty_ListController[index].text != "0" && transferBt_Site_Controller.Itemlist_TransQty_ListController[index].text != "0.0"){
                                              return;
                                            } else {
                                              // setState(() {
                                                transferBt_Site_Controller.Itemlist_TransQty_ListController[index].text = "";
                                                // transferBt_Site_Controller.updateItemlistTable();
                                              // });
                                            }
                                          },
                                          cursorColor:Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: transferBt_Site_Controller.Itemlist_TransQty_ListController[index],
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                          onChanged: (value) {
                                            setState(() {
                                              if(transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST)
                                                {
                                                  transferBt_Site_Controller.storeUpdateItemlistTable();
                                                }
                                              else {
                                                transferBt_Site_Controller
                                                    .updateItemlistTable();
                                              }});
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
                ),
                ),
              ),
            ],
          );
  }


  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to ${transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST ? RequestConstant.SUBMIT : transferBt_Site_Controller.saveButton.value}?' ),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {
                           if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                          transferBt_Site_Controller.getItemlistTablesDatas();
                          print("SSSSSS...${transferBt_Site_Controller.saveButton.value}");
                          transferBt_Site_Controller.Save_EntryScreen(context,transferBt_Site_Controller.transId);
                          }
                           },
                        child:  Text(
                            transferBt_Site_Controller.saveButton.value == RequestConstant.PENDINGLIST ? RequestConstant.SUBMIT : transferBt_Site_Controller.saveButton.value,
                                 style: TextStyle(color:  Theme.of(context).primaryColor,
                                     fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            transferBt_Site_Controller.saveButton.value=RequestConstant.SUBMIT;
                            transferBt_Site_Controller.entryDateText.text=BaseUtitiles.initiateCurrentDateFormat();
                            transferBt_Site_Controller.prearedbyText.text=loginController.EmpName();
                            transferBt_Site_Controller.radioValue.value="transfer_usage";
                            transferBt_Site_Controller.transId=1;
                            projectController.projectname.text="--SELECT--";
                            projectController.selectedProjectId=0.obs;
                            fromsiteController.FromSitename.text="--SELECT--";
                            fromsiteController.selectedsiteId.value=0;
                            siteController.Sitename.text="--SELECT--";
                            siteController.selectedsiteId.value=0;
                            subcontractorController.Subcontractorname.text="--SELECT--";
                            subcontractorController.selectedSubcontId.value=0;
                            transferBt_Site_Controller.itemlistTable_Delete();
                            transferBt_Site_Controller.ItemGetTableListdata.value.clear();
                            transferBt_Site_Controller.remarksText.text="";
                            Navigator.pop(context);
                          });

                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
