import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/entry_type_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../home/menu/daily_entries/daily_wrk_done_dpr/type_subcont_alert.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/image_view.dart';
import '../../../../utilities/print_logger.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../punch_in_out/camera_screen.dart';


class DailyWork_done_DPR_Entry extends StatefulWidget {
  const DailyWork_done_DPR_Entry({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_Entry> createState() => _DailyWork_done_DPR_EntryState();
}

class _DailyWork_done_DPR_EntryState extends State<DailyWork_done_DPR_Entry> {

  CommanController commanController=Get.put(CommanController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  LoginController loginController = Get.put(LoginController());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller = Get.put(DailyWrkDone_DPRNEW_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());


  @override
  void initState() {
    var duration = Duration(seconds:0);
    dailyWrkDone_DPR_Controller.imageFiles.value=[];
    Future.delayed(duration,() async {
      await autoYearWiseNoController.AutoYearWiseNo("DPR");
      await  dailyWrkDone_DPR_Controller.dpr_getSubcotType();
      await projectController.getProjectList();
      dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController.text=autoYearWiseNoController.DPR_autoYrsWise.value;
      if(dailyWrkDone_DPR_Controller.editCheck==1){
        dailyWrkDone_DPR_Controller.ButtonChanges(1,dailyWrkDone_DPR_Controller.aprovedButton);
        dailyWrkDone_DPR_Controller.dpr_EditListApiValue.value.forEach((element) {
          dailyWrkDone_DPR_Controller.workId=element.workId!;
          projectController.projectname.text=element.projectName;
          dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=element.subContName;
          dailyWrkDone_DPR_Controller.entryTypeController.text=element.entryTypeName;
          siteController.Sitename.text=element.siteName;
          dailyWrkDone_DPR_Controller.dpr_preparedbyController.text=element.preparedbyName;
          dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController.text=element.workNo;
          dailyWrkDone_DPR_Controller.dpr_dateController.text=element.workDate;
          dailyWrkDone_DPR_Controller.dpr_referenceController.text=element.refNo;
          dailyWrkDone_DPR_Controller.dpr_remarksController.text=element.remarks;
          projectController.selectedProjectId.value=element.projectId;
          siteController.selectedsiteId.value=element.siteId;
          subcontractorController.selectedSubcontId.value=element.subContId;
          dailyWrkDone_DPR_Controller.TypeSubcontId.value=element.subContId;
          dailyWrkDone_DPR_Controller.entryType=element.entryType.toString();
        });
      }
      if(dailyWrkDone_DPR_Controller.entrycheck==0){
        dailyWrkDone_DPR_Controller.saveButton.value=RequestConstant.SUBMIT;
        dailyWrkDone_DPR_Controller.workId=0;
        // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
        // subcontractorController.selectedSubcontId.value=0;
        // projectController.projectname.text=RequestConstant.SELECT;
        // projectController.selectedProjectId.value=0;
        // dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";



        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        // siteController.setSelectedMRNListName(0);

        subcontractorController.setSelectedsubcontListName(0);
        dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

        dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
        dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();

        dailyWrkDone_DPR_Controller.dpr_preparedbyController.text = loginController.EmpName();
        dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController.text=autoYearWiseNoController.DPR_autoYrsWise.value;
        dailyWrkDone_DPR_Controller.dpr_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
        dailyWrkDone_DPR_Controller.dpr_referenceController.clear();
        dailyWrkDone_DPR_Controller.dpr_remarksController.text="";
        dailyWrkDone_DPR_Controller.entryTypeController.text="BOQ";
        dailyWrkDone_DPR_Controller.entryType="B";
        dailyWrkDone_DPR_Controller.gettingNetworkImages.value = [];
      }
     });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> takePicture() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedFile.path);
        await pickedFile.saveTo('${appDir.path}/$fileName');
        setState(() {
          dailyWrkDone_DPR_Controller.imageFiles.add(File(pickedFile.path));
        });
      } else {
        setState(() {
          printToLog('Something went wrong');
        });
        if (kDebugMode) {
          printToLog('No image selected.');
        }
      }
    }
    else if (status.isPermanentlyDenied) {
      BaseUtitiles.showToast(
          'Camera permissions are permanently denied, we cannot request permissions.');
    }
  }


  Future<void> takeNetPicture() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      await pickedFile.saveTo('${appDir.path}/$fileName');
      setState(() {
        dailyWrkDone_DPR_Controller.imageFiles.add(File(pickedFile.path));
      });
    } else {
      setState(() {
        printToLog('Something went wrong');
      });
      if (kDebugMode) {
        printToLog('No image selected.');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
    return Form(
      key: _formKey,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
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
                            "Daily Work Done - DPR",
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
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            controller: dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
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
                                  controller: dailyWrkDone_DPR_Controller.dpr_dateController,
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
                                            vertical: 8,
                                            horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
                                  onTap: () async {
                                    if(dailyWrkDone_DPR_Controller.screenchek.value==1){

                                    }
                                    else{
                                      var Entrydate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(const Duration(days: 1)),
                                          lastDate: DateTime.now(),
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
                                      dailyWrkDone_DPR_Controller.dpr_dateController.text = BaseUtitiles.selectDateFormat(Entrydate!);
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
                            onTap: () {
                              if(dailyWrkDone_DPR_Controller.screenchek.value==1){

                              }else{
                                setState(() {
                                  bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
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
                              if(dailyWrkDone_DPR_Controller.screenchek.value==1){

                              }else{
                                setState(() {
                                  bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
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
                          padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: dailyWrkDone_DPR_Controller.entryTypeController,
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
                              // if(dailyWrkDone_DPR_Controller.screenchek.value==1
                              //
                              // ){
                              //
                              // }
                              // else{
                              //   showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return  EntryTypeAlert();
                              //       });
                              // }

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
                            controller: dailyWrkDone_DPR_Controller.TypeSubcontractorname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "SubContractor Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                              ),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.subcontractorName),
                            ),
                            onTap: ()  async {
                              if(dailyWrkDone_DPR_Controller.screenchek.value==1){

                              }else{
                                await dailyWrkDone_DPR_Controller.dpr_getSubcotType();
                                dailyWrkDone_DPR_Controller.SubcontractorName(context, dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);
                              }

                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return  TypeSubcontAlert(list: dailyWrkDone_DPR_Controller.dpr_subcontractorList,);
                              //     });

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
                            readOnly: true,
                            controller: dailyWrkDone_DPR_Controller.dpr_preparedbyController,
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
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            readOnly: false,
                            controller: dailyWrkDone_DPR_Controller.dpr_remarksController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Remarks",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                    _formKey.currentState!.save();
                                    if(dailyWrkDone_DPR_Controller.screenchek.value==1){

                                    }
                                    else{
                                      dailyWrkDone_DPR_Controller.dpr_getItemList(projectController.selectedProjectId.value,siteController.selectedsiteId.value,dailyWrkDone_DPR_Controller.TypeSubcontId.value,dailyWrkDone_DPR_Controller.entryType,context);
                                    }
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
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CameraCapturePage(
                                          fromScreen:
                                          "DPR",
                                        )),
                                  );
                                  // if (dailyWrkDone_DPR_Controller.screenchek ==
                                  //     "PendingScreen") {
                                  //   Fluttertoast.showToast(msg:
                                  //   "Image can't add in approve stage");
                                  // }  else {
                                  //   if (dailyWrkDone_DPR_Controller.gettingNetworkImages.length==0) {
                                  //     takeNetPicture();
                                  //   } else {
                                  //     takePicture();
                                    // }
                                  // }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      "Add Image",
                                      style: TextStyle(
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),

                    Obx(() {
                      final allImages = [
                        ...dailyWrkDone_DPR_Controller.gettingNetworkImages,
                        ...dailyWrkDone_DPR_Controller.imageFiles,
                      ];

                      if (allImages.isEmpty) return SizedBox();
                      return Container(
                        height:
                        BaseUtitiles.getheightofPercentage(context, 37),
                        width:
                        BaseUtitiles.getWidthtofPercentage(context, 95),
                        child: Builder(
                          builder: (context){
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
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: isNetwork
                                              ? Image.network(
                                            image,
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
                                                        imageUrl: image,
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
                                            DeleteAlert(
                                                context, index, "File");
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

              Obx(()=>Container(
                child: Visibility(
                  visible: dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.isEmpty?false:true,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context, ScrollController scrollController) {
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
                                  height: MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        // SizedBox(height: 30),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: ListDetails(context, scrollController)
                                        ),
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
                                        margin: EdgeInsets.only(top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
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
              )),
            ],
          ),

          bottomNavigationBar:
           Obx(()=> Container(
             height: BaseUtitiles.getheightofPercentage(context, 4),
             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Visibility(
                   visible: dailyWrkDone_DPR_Controller.editCheck==1 ? false : true,
                   child: Expanded(
                     child: InkWell(
                       child: Container(
                         margin: EdgeInsets.only(left: 20,right: 20),
                         height: BaseUtitiles.getheightofPercentage(context, 4),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                           color:  dailyWrkDone_DPR_Controller.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                         ),
                         alignment: Alignment.center,
                         child: Text("Reset",
                           style: TextStyle(
                               fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                               color:  dailyWrkDone_DPR_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                         ),
                       ),
                       onTap: (){
                         setState(() {
                           dailyWrkDone_DPR_Controller.checkColor = 1;
                           ResetAlert(context);
                         });
                       },
                     ),
                   ),
                 ),
                 Expanded(
                   child: InkWell(
                     child: Container(
                       margin: EdgeInsets.only(left: 20 , right: 20),
                       height: BaseUtitiles.getheightofPercentage(context, 4),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                         color: dailyWrkDone_DPR_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                       ),
                       alignment: Alignment.center,
                       child: Text(
                         // dailyWrkDone_DPR_Controller.appEnb==1 ? RequestConstant.APPROVAL :
                         // editCheck==1? RequestConstant.RESUBMIT:RequestConstant.SUBMIT
                         dailyWrkDone_DPR_Controller.saveButton.value,  style: TextStyle(
                           fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                           color:  dailyWrkDone_DPR_Controller.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                     ),
                     onTap: () {
                       dailyWrkDone_DPR_Controller.checkColor = 0;
                       if(_formKey.currentState!.validate()){
                         _formKey.currentState!.save();
                         if(dailyWrkDone_DPR_Controller.dpr_itemview_DbList.isEmpty){
                           Fluttertoast.showToast(msg: "Please add items");
                         }else{
                           SubmitAlert(context);
                         }
                       }
                     },
                   ),
                 ),
               ],
             ),
           ), ),
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
          margin: EdgeInsets.only(top: 10, left: 4, right: 4, ),
          height: BaseUtitiles.getheightofPercentage(context, 80),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.length,
            itemBuilder: (BuildContext context, int index) {
              dailyWrkDone_DPR_Controller.dpr_itemlist_textControllersInitiate();
              return Card(
                color:  Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Container(
                            width: BaseUtitiles.getWidthtofPercentage(context,80),
                            child: Text(
                              dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index].itemDesc.toString()+" ("+dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index].unit.toString()+")",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.App_Font_SIZE,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Container(
                            height: BaseUtitiles.getheightofPercentage(context,2),
                            width: BaseUtitiles.getWidthtofPercentage(context, 10),
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: Text(RequestConstant.DO_YOU_WANT_DELETE,style: TextStyle(color: Colors.black),),
                                          actions: <Widget>[
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
                                                      child: TextButton(onPressed: () async {
                                                        await dailyWrkDone_DPR_Controller.deleteParticularList(dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index]);
                                                        dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.removeAt(index);
                                                        await dailyWrkDone_DPR_Controller. getDprTablesDatas();
                                                        Navigator.pop(context);
                                                      }, child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                child: ConstIcons.cancle
                              // Image.asset('assets/cancle.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Rate",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              // Text(
                              //   "Rate",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: RequestConstant.App_Font_SIZE,),
                              // ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,right: 5),
                            height: BaseUtitiles.getheightofPercentage(context,3),
                            width: BaseUtitiles.getWidthtofPercentage(context,40),
                            child: TextField(
                              readOnly: true,
                              cursorColor:Theme.of(context).primaryColor,
                              textAlign: TextAlign.center,
                              controller: dailyWrkDone_DPR_Controller.Itemlist_RateControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                              ),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                setState(() {
                                  dailyWrkDone_DPR_Controller.dprItemlist_clickEdit();
                                });

                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(text: "Net.Qty"),
                                    TextSpan(
                                      text: dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0.0" ? "" : " *",
                                      style: TextStyle(
                                        color: dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0.0" ? Colors.white : Colors.red,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                            ),

                            // Text(
                            //   "Cur.Qty",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: RequestConstant.App_Font_SIZE,
                            //       color: Colors.black),
                            // ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5,right: 5),
                          height: BaseUtitiles.getheightofPercentage(context,3),
                          width: BaseUtitiles.getWidthtofPercentage(context,40),
                          child: TextFormField(
                            onTap: (){
                              if(dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0" && dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text != "0.0"){
                                return;
                              } else {
                                setState(() {
                                  dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index].text = "";
                                  dailyWrkDone_DPR_Controller.dprItemlist_clickEdit();
                                });
                              }
                            },
                            cursorColor:Theme.of(context).primaryColor,
                            textAlign: TextAlign.center,
                            controller: dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index],
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                            ),
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) {
                              setState(() {
                                dailyWrkDone_DPR_Controller.dprItemlist_clickEdit();
                              });
                            },
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Amount",
                                    ),
                                    TextSpan(
                                      text: "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                            ),
                            // const Text(
                            //   "Amount",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: RequestConstant.App_Font_SIZE,
                            //       color: Colors.black),
                            // ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5,right: 5,bottom: 5),
                          height: BaseUtitiles.getheightofPercentage(context,3),
                          width: BaseUtitiles.getWidthtofPercentage(context,40),
                          child: TextField(
                            cursorColor:Theme.of(context).primaryColor,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: dailyWrkDone_DPR_Controller.Itemlist_AmntControllers[index],
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                            ),
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) {

                            },
                          ),
                        ),
                      ],
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
                        onPressed: () async {
                          Future.delayed(Duration(seconds: 0),(){
                            dailyWrkDone_DPR_Controller.saveButton.value=RequestConstant.SUBMIT;
                            dailyWrkDone_DPR_Controller.workId=0;

                            // projectController.projectname.text=RequestConstant.SELECT;
                            // projectController.selectedProjectId.value=0;
                            // siteController.Sitename.text=RequestConstant.SELECT;
                            // siteController.selectedsiteId.value=0;
                            // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
                            // subcontractorController.selectedSubcontId.value=0;
                            subcontractorController.setSelectedsubcontListName(0);
                            dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
                            dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

                            dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
                            dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();


                            // dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";
                            dailyWrkDone_DPR_Controller.dpr_preparedbyController.text=loginController.EmpName();
                            dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController.text=autoYearWiseNoController.DPR_autoYrsWise.value;
                            dailyWrkDone_DPR_Controller.dpr_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                            dailyWrkDone_DPR_Controller.dpr_referenceController.clear();
                            dailyWrkDone_DPR_Controller.dpr_remarksController.text="";
                            dailyWrkDone_DPR_Controller.entryTypeController.text="BOQ";
                            dailyWrkDone_DPR_Controller.entryType="B";
                            dailyWrkDone_DPR_Controller.imageFiles.value=[];
                          });
                          // dailyWrkDone_DPR_Controller.saveButton.value=RequestConstant.SUBMIT;
                          // dailyWrkDone_DPR_Controller.workId=0;
                          // projectController.selectedProjectId.value=0;
                          // siteController.selectedsiteId.value=0;
                          // subcontractorController.selectedSubcontId.value=0;
                          // dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
                          // dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
                          // projectController.projectname.text=RequestConstant.SELECT;
                          // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
                          // siteController.Sitename.text=RequestConstant.SELECT;
                          // // dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";
                          // dailyWrkDone_DPR_Controller.dpr_preparedbyController.text=loginController.EmpName();
                          // dailyWrkDone_DPR_Controller.dpr_autoYearWiseNoController.text=autoYearWiseNoController.DPR_autoYrsWise.value;
                          // dailyWrkDone_DPR_Controller.dpr_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                          // dailyWrkDone_DPR_Controller.dpr_referenceController.clear();
                          // dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
                          // dailyWrkDone_DPR_Controller.dpr_remarksController.text="-";
                          //
                          // dailyWrkDone_DPR_Controller.entryTypeController.text="BOQ";
                          // dailyWrkDone_DPR_Controller.entryType="B";
                          Navigator.pop(context);
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

  Future SubmitAlert(BuildContext context) async {
    dailyWrkDone_DPR_Controller.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
            dailyWrkDone_DPR_Controller.screenchek.value==1 ? 'Are you sure to Approval?' :
        dailyWrkDone_DPR_Controller.editCheck == 1 ? 'Are you sure to Re-Submit?' : 'Are you sure to Submit?' ),
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

                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //
                  //         if(dailyWrkDone_DPR_Controller.buttonControl == 0){
                  //           if(dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.isEmpty){
                  //             BaseUtitiles.showToast("Please add items");
                  //           }
                  //           else{
                  //             BaseUtitiles.showLoadingDialog(context,Theme.of(context).primaryColor);
                  //             await dailyWrkDone_DPR_Controller.getDprTablesDatas();
                  //             if(mounted){
                  //               dailyWrkDone_DPR_Controller.SaveButton_EntryScreen_Save(context,dailyWrkDone_DPR_Controller.workId);
                  //             }
                  //             // Navigator.pop(context);
                  //           }
                  //         }
                  //         else if(dailyWrkDone_DPR_Controller.buttonControl == 1){
                  //           dailyWrkDone_DPR_Controller.buttonControl = 0;
                  //           BaseUtitiles.showToast("Please wait... processing.");
                  //         }
                  //
                  //       },
                  //       child:
                  //       Obx(() => Text(
                  //       dailyWrkDone_DPR_Controller.screenchek.value==1 ? RequestConstant.APPROVAL :
                  //       dailyWrkDone_DPR_Controller.screenchek.value ==2? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
                  //       style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE)))
                  //       ),
                  // ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed:
                        // dailyWrkDone_DPR_Controller.buttonControl == 0 ?
                            () async {
                          // setState(() {
                          //   dailyWrkDone_DPR_Controller.buttonControl = 1; // Disable the button
                          // });

                          if (dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.isEmpty) {
                            BaseUtitiles.showToast("Please add items");
                          } else {
                         if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                           await dailyWrkDone_DPR_Controller.getDprTablesDatas();
                           if (mounted) {
                             dailyWrkDone_DPR_Controller.SaveButton_EntryScreen_Save(
                                 context, dailyWrkDone_DPR_Controller.workId);
                           }
                         }
                            // setState(() {
                            //   dailyWrkDone_DPR_Controller.buttonControl = 0; // Re-enable the button
                            // });
                            // Navigator.pop(context); Uncomment if you want to close the dialog
                          }
                        },
                        //     : () {
                        //   BaseUtitiles.showToast("Please wait... processing.");
                        // },
                        child: Obx(() => Text(
                          dailyWrkDone_DPR_Controller.screenchek.value == 1
                              ? RequestConstant.APPROVAL
                              : dailyWrkDone_DPR_Controller.screenchek.value == 2
                              ? RequestConstant.RESUBMIT
                              : RequestConstant.SUBMIT,
                          style: TextStyle(
                            color: dailyWrkDone_DPR_Controller.buttonControl == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey, // Change color when disabled
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        )),
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

  Future DeleteAlert(BuildContext context,int index,itemType) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                        onPressed: () async {
                          if(itemType=="String"){
                            // await dailyEntriesController.deletingImage(
                            //   dailyWrkDone_DPR_Controller.imageIds[index],"DPR"
                            // );
                            setState(() {
                              dailyWrkDone_DPR_Controller.gettingNetworkImages.removeAt(index);
                            });
                          }
                          else if (itemType == "File") {
                            int localIndex = index - dailyWrkDone_DPR_Controller.gettingNetworkImages.length;
                            if (localIndex >= 0 && localIndex < dailyWrkDone_DPR_Controller.imageFiles.length) {
                              setState(() {
                                dailyWrkDone_DPR_Controller.imageFiles.removeAt(localIndex);
                              });
                            }
                          }
                          Navigator.pop(context);
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
  }


}