// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:newcorefile/utilities/baseutitiles.dart';
// import 'package:newcorefile/utilities/requestconstant.dart';
// import 'apimanager/apimanager.dart';
// import 'app_theme/app_colors.dart';
// import 'commonpopup/projectalert.dart';
// import 'commonpopup/requesttype_alert.dart';
// import 'constants/ui_constant/icons_const.dart';
// import 'controller/auto_yrwise_no_controller.dart';
// import 'controller/bottomsheet_Controllers.dart';
// import 'controller/consumption_controller.dart';
// import 'controller/dailyentries_controller.dart';
// import 'controller/dailywrk_done_dprnew_controller.dart';
// import 'controller/logincontroller.dart';
// import 'controller/mrn_request_indent_controller.dart';
// import 'controller/pendinglistcontroller.dart';
// import 'controller/projectcontroller.dart';
// import 'controller/sitecontroller.dart';
// import 'controller/subcontcontroller.dart';
// import 'home/menu/materials/mrn_request(indent)/materials_add.dart';
// import 'models/sampleAPIModel.dart';
//
// class sampeAPICheck extends StatefulWidget {
//   const sampeAPICheck({super.key});
//
//   @override
//   State<sampeAPICheck> createState() => _sampeAPICheckState();
// }
//
// class _sampeAPICheckState extends State<sampeAPICheck> {
//   RxList listValues = [].obs;
//
//   Future<List> getEntry_List() async {
//     try {
//       final value = await ApiManager.getAPICall(
//           "http://49.204.233.151/cms_dev_api/api/GenericMaster/GetEmployee"
//       );
//
//       final model = sampleApiResmodelFromJson(value);
//
//       if (model.success == true) {
//         listValues.value= model.result ?? [];
//         return listValues;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print("Error: $e");
//       return [];
//     }
//   }
//
//   Future<bool> deleteEntry_List(int id) async {
//     try {
//       final value = await ApiManager.deleteAPICall(
//         "http://192.168.0.200/cms_dev_api/api/Employee/DeleteEmployee?id=$id",
//       );
//
//       final res = json.decode(value);
//
//       if (res != null && res["success"] == true) {
//         BaseUtitiles.showToast("Deleted Successfully");
//         return true;   // ✔ success
//       } else {
//         print("Delete failed");
//         return false;
//       }
//     } catch (e) {
//       print("Error: $e");
//       return false;
//     }
//   }
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getEntry_List();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 50,),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "API Test",
//                   style: TextStyle(
//                       fontSize: RequestConstant.Heading_Font_SIZE,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "Back",
//                       style: TextStyle(color: Colors.grey, fontSize: 18),
//                     ))
//               ],
//             ),
//           ),
//       SingleChildScrollView(
//         child: Container(
//           // height: BaseUtitiles.getheightofPercentage(context, 69),
//           child: Column(
//             children: [
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 80),
//                 child: Obx(() => ListView.builder(
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     itemCount: listValues.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: EdgeInsets.only(left: 3, right: 3),
//                         child: Card(
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: Container(
//                             margin: EdgeInsets.all(3),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 SizedBox(height: 10),
//                                 Row(
//                                   children: <Widget>[
//                                     Container(
//                                       margin: EdgeInsets.only(top: 5, left: 10),
//                                       child: Text(""),
//                                     ),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           "Employee Name",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,),
//                                         )),
//                                     Expanded(
//                                         flex: 6,
//                                         child: Text(
//                                           listValues[index].employeeName
//                                               .toString(),
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         )),
//                                     Expanded(
//                                         flex: 1,
//                                         child: IconButton(
//                                           icon: Icon(Icons.close,color: Colors.red,), onPressed: () async {
//                                             setState(() {});
//                                              await deleteEntry_List(listValues[index].id);
//                                              await getEntry_List();
//
//                                         },
//                                         )),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//         ],
//       ),
//     );
//   }
// }
//
//
// class sampleMRNIndent extends StatefulWidget {
//   const sampleMRNIndent({super.key});
//
//   @override
//   State<sampleMRNIndent> createState() => _sampleMRNIndentState();
// }
//
// class _sampleMRNIndentState extends State<sampleMRNIndent> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   LoginController loginController = Get.put(LoginController());
//   ProjectController projectController = Get.put(ProjectController());
//   DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
//   Get.put(DailyWrkDone_DPRNEW_Controller());
//   SubcontractorController subcontractorController =
//   Get.put(SubcontractorController());
//   SiteController siteController = Get.put(SiteController());
//   MRN_Request_Controller mrn_request_controller =
//   Get.put(MRN_Request_Controller());
//   PendingListController pendingListController =
//   Get.put(PendingListController());
//   Consumption_Controller consumption_controller =
//   Get.put(Consumption_Controller());
//   ProjectShowPopup projectShowPopup = Get.put(const ProjectShowPopup(list: []));
//   DailyEntriesController dailyEntriesController =
//   Get.put(DailyEntriesController());
//   BottomsheetControllers bottomsheetControllers =
//   Get.put(BottomsheetControllers());
//   final searchcontroller = TextEditingController();
//   var list;
//   final ScrollController scrollController = ScrollController();
//   final autoYearWiseNoController=TextEditingController();
//
//
//   RxList projectList = [].obs;
//   RxList siteList = [].obs;
//
//   Future getAPI(from) async {
//     try {
//       String? response;
//       if(from=="autoNo") {
//         response = await ApiManager.getAPICall(
//             "http://192.168.0.250:8080/cms_dev_api/api/GenericMaster/GetAutoNumber?fieldName=ReqOrdNo&tableName=MaterialReqOrdMas&formName=MaterialReqOrdMas"
//         );
//       }
//       else if(from=="project") {
//          response = await ApiManager.getAPICall(
//             "http://192.168.0.250:8080/cms_dev_api/api/GenericMaster/GetProjects"
//         );
//       }
//       else if(from=="site"){
//         response = await ApiManager.getAPICall(
//             "http://192.168.0.250:8080/cms_dev_api/api/GenericMaster/GetProjectWiseSiteList?ProjectId=${projectController.selectedProjectId.value}"
//         );
//       }
//
//       final  value = jsonDecode(response!);
//
//       if (value["success"] == true) {
//
//         if(from=="autoNo") {
//           autoYearWiseNoController.text= value["entryAutoNo"] ??"";
//         }
//         else if(from=="project") {
//           projectList.value = value["result"] ?? [];
//         }
//         else if(from=="site") {
//           siteList.value = value["result"] ?? [];
//         }
//         else if(from=="material") {
//           mrn_request_controller.getmaterialvalue.value = value["result"] ?? [];
//         }
//
//       } else {
//         return  BaseUtitiles.showToast(value["message"].toString());
//       }
//     } catch (e) {
//       print("Error: $e");
//       BaseUtitiles.showToast(e.toString());
//
//       return [];
//     }
//   }
//
//
//   @override
//   void initState() {
//     var duration = const Duration(seconds: 0);
//     Future.delayed(duration, () async {
//       if (mrn_request_controller.entrycheck == 0) {
//         await getAPI("autoNo");
//         mrn_request_controller.reqId = 0;
//         mrn_request_controller.saveButton.value = RequestConstant.SUBMIT;
//         mrn_request_controller.delete_MaterialIntent_itemlist_Table();
//         mrn_request_controller.Material_itemview_GetDbList.clear();
//         mrn_request_controller.RemarksController.text = "";
//         projectController.projectname.text = "--SELECT--";
//         projectController.selectedProjectId.value = 0;
//         subcontractorController.Subcontractorname.text = "--SELECT--";
//         subcontractorController.selectedSubcontId.value = 0;
//         mrn_request_controller.RequestDateController.text =
//             BaseUtitiles.initiateCurrentDateFormat();
//         mrn_request_controller.DuedateController.text =
//             BaseUtitiles.initiateCurrentDateFormat();
//         mrn_request_controller.preparedbyController.text =
//             loginController.EmpName();
//         mrn_request_controller.ReqTypeController.text = "--SELECT--";
//         mrn_request_controller.ReqType.value = "0";
//         siteController.selectedsiteId = 0.obs;
//         siteController.selectedsitedropdownName = "--SELECT--".obs;
//         siteController.getSiteDropdownvalue.value.clear();
//         siteController.Sitename.text = RequestConstant.SELECT;
//         siteController.siteDropdownName.clear();
//         bottomsheetControllers.searchcontroller.text = "";
//       // }
//       projectController.mainlist.value.clear();
//       projectController.mainlist.value =
//           projectController.getdropDownvalue.value;
//       projectController.mainlist;
//     }
//       if (mrn_request_controller.editCheck == 1) {
//         mrn_request_controller.saveButton.value = RequestConstant.RESUBMIT;
//         mrn_request_controller.Material_EditListApiValue.forEach((element) {
//           mrn_request_controller.reqId = element.reqId;
//           autoYearWiseNoController.text = element.reqNo.trim();
//           mrn_request_controller.RequestDateController.text = element.reqDate;
//           mrn_request_controller.DuedateController.text = element.reqDueDate;
//           projectController.selectedProjectId.value = element.projectId;
//           siteController.selectedsiteId.value = element.siteId;
//           projectController.projectname.text = element.projectName;
//           siteController.Sitename.text = element.siteName;
//           mrn_request_controller.preparedbyController.text = element.preparedbyName;
//           mrn_request_controller.ReqTypeController.text = element.purchaseType=="PO "?"General Items":"Asset Materials";
//           mrn_request_controller.ReqType.value = element.purchaseVal.toString();
//           mrn_request_controller.RemarksController.text = element.reqRemarks;
//         });
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height * 50 / 100;
//
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//           backgroundColor: Setmybackground,
//           bottomNavigationBar: Container(
//             height: BaseUtitiles.getheightofPercentage(context, 4),
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   child: InkWell(
//                     child: Container(
//                         margin: const EdgeInsets.only(left: 20, right: 20),
//                         height:
//                         BaseUtitiles.getheightofPercentage(context, 4),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10)),
//                           color:  Theme.of(context).primaryColor,
//                         ),
//                         alignment: Alignment.center,
//                         child:Text(
//                           mrn_request_controller.saveButton.value,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: RequestConstant.Lable_Font_SIZE,
//                               color:
//                                Colors.white
//                                   ),
//                         )),
//                     onTap: () async {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         _formKey.currentState?.save();
//                         await SubmitAlert(context);
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           body: Stack(children: [
//             SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   SizedBox(
//                       height:
//                       BaseUtitiles.getheightofPercentage(context, 5)),
//                   Container(
//                     margin: const EdgeInsets.only(left: 15, right: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "MRN Request (Indent)",
//                           style: TextStyle(
//                               fontSize: RequestConstant.Heading_Font_SIZE,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             "Back",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: autoYearWiseNoController,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Request No",
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: RequestConstant.Lable_Font_SIZE),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: ConstIcons.requestNo),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               top: 2, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(
//                                   color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller: mrn_request_controller
//                                     .RequestDateController,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: "Request Date",
//                                   labelStyle: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize:
//                                     RequestConstant.Lable_Font_SIZE,
//                                   ),
//                                   prefixIconConstraints: BoxConstraints(
//                                       minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.date),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               top: 2, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(
//                                   color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller: mrn_request_controller
//                                     .DuedateController,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: "Due Date",
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize:
//                                       RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints: BoxConstraints(
//                                       minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.date),
//                                 ),
//                                 onTap: () async {
//                                   // if (mrn_request_controller.screenCheck ==
//                                   //     "PendingScreen") {
//                                   // }
//                                   // else {
//                                   var Entrydate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime.now(),
//                                       lastDate: DateTime(2100),
//                                       builder: (context, child) {
//                                         return Theme(
//                                           data:
//                                           Theme.of(context).copyWith(
//                                             colorScheme:
//                                             ColorScheme.light(
//                                               primary: Theme.of(context)
//                                                   .primaryColor,
//                                               // header background color
//                                               onPrimary: Colors.white,
//                                               // header text color
//                                               onSurface: Colors
//                                                   .black, // body text color
//                                             ),
//                                             textButtonTheme:
//                                             TextButtonThemeData(
//                                               style: TextButton.styleFrom(
//                                                 primary: Colors
//                                                     .black, // button text color
//                                               ),
//                                             ),
//                                           ),
//                                           child: child!,
//                                         );
//                                       });
//                                   mrn_request_controller
//                                       .DuedateController.text =
//                                       BaseUtitiles.selectDateFormat(
//                                           Entrydate!);
//                                   // }
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           autovalidateMode:
//                           AutovalidateMode.onUserInteraction,
//                           readOnly: true,
//                           controller:
//                           mrn_request_controller.ReqTypeController,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Request Type",
//                             labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontSize: RequestConstant.Lable_Font_SIZE,
//                             ),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 8),
//                               child: ConstIcons.types,
//                             ),
//                           ),
//                           onTap: () async {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return const RequestType_Alert();
//                                   });
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty ||
//                                 value == "--Select--" ||
//                                 value == "--SELECT--") {
//                               return '\u26A0 ${RequestConstant.VALIDATE}';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           autovalidateMode:
//                           AutovalidateMode.onUserInteraction,
//                           readOnly: true,
//                           controller: projectController.projectname,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Project Name",
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: RequestConstant.Lable_Font_SIZE),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: ConstIcons.projectName),
//                           ),
//                           onTap: () async {
//                             await getAPI("project");
//                                 ProjectName(
//                                     context,
//                                     projectList.value,
//                                 "project");
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty ||
//                                 value == "--Select--" ||
//                                 value == "--SELECT--") {
//                               return '\u26A0 ${RequestConstant.VALIDATE}';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           autovalidateMode:
//                           AutovalidateMode.onUserInteraction,
//                           readOnly: true,
//                           controller: siteController.Sitename,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Site Name",
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: RequestConstant.Lable_Font_SIZE),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: ConstIcons.siteName),
//                           ),
//                           onTap: () async {
//                               await getAPI("site");
//                               ProjectName(
//                                   context,
//                                   siteList.value,
//                                   "site");
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty ||
//                                 value == "--Select--" ||
//                                 value == "--SELECT--") {
//                               return '\u26A0 ${RequestConstant.VALIDATE}';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller:
//                           mrn_request_controller.preparedbyController,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Prepared By",
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: RequestConstant.Lable_Font_SIZE),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: ConstIcons.preparedBy),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                     const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.white70, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 3, left: 10, bottom: 5),
//                         child: TextFormField(
//                           autovalidateMode:
//                           AutovalidateMode.onUserInteraction,
//                           readOnly: false,
//                           controller:
//                           mrn_request_controller.RemarksController,
//                           cursorColor: Colors.black,
//                           style: const TextStyle(color: Colors.black),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.zero,
//                             border: InputBorder.none,
//                             labelText: "Remarks",
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: RequestConstant.Lable_Font_SIZE),
//                             prefixIconConstraints:
//                             BoxConstraints(minWidth: 0, minHeight: 0),
//                             prefixIcon: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: ConstIcons.remarks),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return '\u26A0 ${RequestConstant.VALIDATE}';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                       height:
//                       BaseUtitiles.getheightofPercentage(context, 1)),
//                   // mrn_request_controller.screenCheck == "PendingScreen"?SizedBox(height: 14,):
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: Setmybackground,
//                           ),
//                           onPressed: () async {
//                               mrn_request_controller.getMaterialList(
//                                   context,
//                                   mrn_request_controller.ReqType.value.toString()=="PO"?"0":"1",
//                                   projectController.selectedProjectId.value,
//                                   siteController.selectedsiteId.value);
//
//                           },
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Icon(
//                                 Icons.add,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               const SizedBox(width: 5),
//                               Text("Add Materials",
//                                   style: TextStyle(
//                                       color:
//                                       Theme.of(context).primaryColor)),
//                             ],
//                           )
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height),
//                 ],
//               ),
//             ),
//             Obx(() => Visibility(
//                 visible: mrn_request_controller
//                     .Material_itemview_GetDbList.value.isEmpty
//                     ? false
//                     : true,
//                 child: Container(
//                   height: BaseUtitiles.getheightofPercentage(context, 95),
//                   child: DraggableScrollableSheet(
//                     minChildSize: 0.1,
//                     maxChildSize: 0.9,
//                     initialChildSize: 0.3,
//                     builder: (BuildContext context, ScrollController scrollController) {
//                       return Container(
//                         decoration: const BoxDecoration(
//                           color: Setmybackground,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(40.0),
//                             topRight: Radius.circular(40.0),
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Container(
//                                 height: MediaQuery.of(context).size.height * 1,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: SingleChildScrollView(
//                                   controller: scrollController,
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                           margin: EdgeInsets.only(top: 10),
//                                           child: ListDetails(context, scrollController)),
//                                     ],
//                                   ),
//                                 )),
//                             IgnorePointer(
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(40.0),
//                                     topRight: Radius.circular(40.0),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(top: 20, bottom: 20),
//                                       height: 5,
//                                       width: 60,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 )
//             )),
//           ])),
//     );
//   }
//
//   Future SubmitAlert(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Alert!'),
//         content: Text( 'Are you sure to ${mrn_request_controller.saveButton.value}?'),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20),
//             child: IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                           fontSize: RequestConstant.Lable_Font_SIZE,
//                         ),
//                       ),
//                     ),
//                   ),
//                   VerticalDivider(
//                     color: Colors.grey.shade400,
//                     width: 5,
//                     thickness: 2,
//                     indent: 15,
//                     endIndent: 15,
//                   ),
//                   Expanded(
//                     child: StatefulBuilder(
//                       builder: (context, setState) => TextButton(
//                         onPressed: () async {
//                           if (await BaseUtitiles.checkNetworkAndShowLoader(
//                               context)) {
//                             await mrn_request_controller
//                                 .getMaterialTablesDatas();
//                             // await mrn_request_controller
//                             //     .SaveButton_MaterialIntentScreen(
//                             //   context,
//                             //   mrn_request_controller.reqId != 0
//                             //       ? mrn_request_controller.reqId
//                             //       : 0,
//                             //     autoYearWiseNoController
//                             // );
//                           }
//                         },
//                         child: Text(
//                           mrn_request_controller.saveButton.value,
//                           style: TextStyle(
//                             color:  Theme.of(context).primaryColor,
//                             // Change color when disabled
//                             fontWeight: FontWeight.bold,
//                             fontSize: RequestConstant.Lable_Font_SIZE,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   ProjectName(context, list, from){
//     showModalBottomSheet(context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
//       builder: (BuildContext context) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: BaseUtitiles.getWidthtofPercentage(context, 50),
//                   margin: const EdgeInsets.only(top: 10, left: 15),
//                   child: TextField(
//                     controller: searchcontroller,
//                     decoration: InputDecoration(
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: const Icon(Icons.search,
//                         color: Colors.black,
//                       ),
//                       hintText: "search..",
//                       hintStyle: const TextStyle(color: Colors.black),
//                       isDense: true,
//                       fillColor: Setmybackground,
//                     ),
//                     onEditingComplete: () {
//                       FocusScope.of(context).unfocus();
//                       // if (onSearch != null) onSearch!(searchcontroller.text);
//                     },
//                     textInputAction: TextInputAction.search,
//                     // onChanged: (value)  {
//                     //   list=BaseUtitiles.projectPopupAlert(value, projectcontroller.getdropDownvalue.value);
//                     // },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Container(
//                   width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Theme.of(context).primaryColor),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(3),
//                     child: Text(from=="project"?"Projects":"Sites", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
//                   ),
//                 ),
//                 InkWell(
//                     onTap: (){
//                       Navigator.pop(context);
//                       searchcontroller.text = "";
//                     },
//                     child: Container(
//                         margin: const EdgeInsets.only(right: 10),
//                         child: Icon(Icons.expand_circle_down, color: Theme.of(context).primaryColor))),
//               ],
//             ),
//             const Divider(),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: list.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     children: [
//                       InkWell(
//                         child: Container(
//                           margin: const EdgeInsets.only(left: 10),
//                           alignment: Alignment.center,
//                           child: Text(from=="project"?list[index]["projectName"].toString():list[index]["siteName"].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE,fontWeight: FontWeight.bold),),
//                         ),
//                         onTap: () async {
//                           if(from=="project"){
//                             projectController.projectname.text = list[index]["projectName"].toString();
//                             projectController.selectedProjectId.value = list[index]["id"];
//                             searchcontroller.text = "";
//                             siteController.Sitename.text = "--SELECT--";
//                             siteController.selectedsiteId.value=0;
//                           }
//                           else{
//                             searchcontroller.text = "";
//                             siteController.Sitename.text = list[index]["siteName"].toString();
//                             siteController.selectedsiteId.value = list[index]["id"];
//                           }
//                           Navigator.pop(context);
//                         },
//                       ),
//                       Divider(),
//                     ],
//                   );
//                 }, ),
//             )
//           ],
//         );
//       },);
//   }
//
//   Widget ListDetails(BuildContext context, ScrollController scrollController) {
//     return SingleChildScrollView(
//         controller: scrollController,
//         child: Column(
//           children: [
//             SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.79,
//               child: Obx(() => ListView.builder(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.only(bottom: 50   ),
//                 physics: BouncingScrollPhysics(),
//                 itemCount:mrn_request_controller
//                     .Material_itemview_GetDbList
//                     .value
//                     .length,
//                 itemBuilder: (BuildContext context, int index) {
//                   mrn_request_controller
//                       .Material_itemlist_textControllersInitiate();
//                   return Container(
//                     margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Card(
//                           color: Colors.white,
//                           elevation: 5,
//                           margin: EdgeInsets.only(left: 5, right: 5,top: 15),
//                           child: Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment
//                                 .spaceAround,
//                             children: <Widget>[
//                               Container(
//                                 margin:
//                                 const EdgeInsets
//                                     .only(
//                                     left: 10,
//                                     top: 10,
//                                     right: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .spaceBetween,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: Text(
//                                         "${mrn_request_controller.Material_itemview_GetDbList.value[index].material} (${mrn_request_controller.Material_itemview_GetDbList.value[index].scale})",
//                                         style: TextStyle(
//                                             fontWeight:
//                                             FontWeight
//                                                 .bold,
//                                             fontSize:
//                                             RequestConstant
//                                                 .ALERT_Font_SIZE,
//                                             color: Theme.of(context)
//                                                 .primaryColor),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       child:
//                                       InkWell(
//                                         onTap: () {
//                                           showDialog(
//                                             context:
//                                             context,
//                                             builder:
//                                                 (context) =>
//                                                 AlertDialog(
//                                                   title:
//                                                   const Text(
//                                                     RequestConstant.DO_YOU_WANT_DELETE,
//                                                     style:
//                                                     TextStyle(color: Colors.black),
//                                                   ),
//                                                   actions: <Widget>[
//                                                     Container(
//                                                       margin: const EdgeInsets.only(left: 20, right: 20),
//                                                       child: IntrinsicHeight(
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Expanded(
//                                                               child: TextButton(
//                                                                 onPressed: () {
//                                                                   Navigator.pop(context);
//                                                                 },
//                                                                 child: const Text(
//                                                                   "Cancel",
//                                                                   style: TextStyle(
//                                                                     color: Colors.grey,
//                                                                     fontWeight: FontWeight.bold,
//                                                                     fontSize: RequestConstant.Lable_Font_SIZE,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             VerticalDivider(
//                                                               color: Colors.grey.shade400,
//                                                               width: 5,
//                                                               thickness: 2,
//                                                               indent: 15,
//                                                               endIndent: 15,
//                                                             ),
//                                                             Expanded(
//                                                               child: TextButton(
//                                                                   onPressed: () {
//                                                                     mrn_request_controller.deleteParticularList(mrn_request_controller.Material_itemview_GetDbList[index]);
//                                                                     mrn_request_controller.Material_itemview_GetDbList.remove(mrn_request_controller.Material_itemview_GetDbList[index]);
//                                                                     mrn_request_controller.getMaterialTablesDatas();
//                                                                     Navigator.pop(context);
//                                                                   },
//                                                                   child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                           );
//                                         },
//                                         child: const Icon(
//                                             Icons
//                                                 .remove_circle,
//                                             color: Colors
//                                                 .red),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ////------
//
//                               Container(
//                                 margin:
//                                 const EdgeInsets
//                                     .only(
//                                     top: 10),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           flex: 4,
//                                           child: Container(
//                                               margin: EdgeInsets.only(
//                                                   left:
//                                                   15,
//                                                   bottom:
//                                                   10),
//                                               child: Text(
//                                                   "Stock Qty:  ",
//                                                   style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE, color: Theme.of(context).primaryColor))),
//                                         ),
//                                         Expanded(
//                                           flex: 5,
//                                           child: Container(
//                                               margin: const EdgeInsets
//                                                   .only(
//                                                   bottom:
//                                                   10),
//                                               child: Text(
//                                                   mrn_request_controller.Material_itemview_GetDbList.value[index].stockqty.toString(),
//                                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: RequestConstant.ALERT_Font_SIZE, color: Colors.black))),
//                                         ),
//                                         Expanded(
//                                           flex: 3,
//                                           child:
//                                           Container(
//                                             margin: const EdgeInsets
//                                                 .only(
//                                                 left:
//                                                 10,
//                                                 bottom:
//                                                 10),
//                                             child:
//                                             RichText(
//                                               text: TextSpan(
//                                                   style: const TextStyle(
//                                                     fontSize: 12.0,
//                                                     fontWeight: FontWeight.normal,
//                                                     color: Colors.black,
//                                                   ),
//                                                   children: <TextSpan>[
//                                                     const TextSpan(
//                                                       text: "Quantity",
//                                                     ),
//                                                     TextSpan(
//                                                       text: mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0" ? "" : " *",
//                                                       style: TextStyle(
//                                                         color: mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0" ? Colors.white : Colors.red,
//                                                         fontSize: 12.0,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ]),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 5,
//                                           child:
//                                           Container(
//                                             margin: const EdgeInsets
//                                                 .only(
//                                                 top:
//                                                 5,
//                                                 right:
//                                                 10,
//                                                 bottom:
//                                                 10),
//                                             height: BaseUtitiles.getheightofPercentage(
//                                                 context,
//                                                 3),
//                                             width: BaseUtitiles.getWidthtofPercentage(
//                                                 context,
//                                                 20),
//                                             child:
//                                             TextFormField(
//                                               autovalidateMode:
//                                               AutovalidateMode.onUserInteraction,
//                                               onTap:
//                                                   () {
//                                                 setState(() {
//                                                   if (mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0") {
//                                                     return;
//                                                   } else {
//                                                     mrn_request_controller.Addwork_qtyControllers[index].text = "";
//                                                     mrn_request_controller.MaterialItemlist_clickEdit();
//                                                   }
//                                                 });
//                                               },
//                                               cursorColor:
//                                               Theme.of(context).primaryColor,
//                                               textAlign:
//                                               TextAlign.center,
//                                               controller:
//                                               mrn_request_controller.Addwork_qtyControllers[index],
//                                               keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                               decoration:
//                                               InputDecoration(
//                                                 contentPadding: const EdgeInsets.fromLTRB(
//                                                     5.0,
//                                                     0.0,
//                                                     5.0,
//                                                     0.0),
//                                                 focusedBorder:
//                                                 OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: const BorderRadius.all(Radius.circular(5))),
//                                                 enabledBorder:
//                                                 const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
//                                                 errorStyle:
//                                                 const TextStyle(
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: 10.0,
//                                                 ),
//                                                 errorBorder:
//                                                 OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(2.0),
//                                                   borderSide: const BorderSide(
//                                                     color: Colors.red,
//                                                   ),
//                                                 ),
//                                                 focusedErrorBorder:
//                                                 OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(2.0),
//                                                   borderSide: const BorderSide(
//                                                     color: Colors.red,
//                                                   ),
//                                                 ),
//                                               ),
//                                               style:
//                                               const TextStyle(color: Colors.black),
//                                               onChanged:
//                                                   (value) {
//                                                 setState(() {
//                                                   mrn_request_controller.updateConsumTables();
//                                                   // mrn_request_controller.MaterialItemlist_clickEdit();
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       margin:
//                                       const EdgeInsets
//                                           .only(
//                                           top:
//                                           5,
//                                           right:
//                                           10,
//                                           left:
//                                           10),
//                                       height: BaseUtitiles
//                                           .getheightofPercentage(
//                                           context,
//                                           3),
//                                       child:
//                                       TextFormField(
//                                         cursorColor:
//                                         Theme.of(context)
//                                             .primaryColor,
//                                         textAlign:
//                                         TextAlign
//                                             .center,
//                                         controller:
//                                         mrn_request_controller
//                                             .Addwork_descControllers[index],
//                                         keyboardType:
//                                         TextInputType
//                                             .multiline,
//                                         decoration:
//                                         InputDecoration(
//                                           labelText:
//                                           'Brand/Description',
//                                           labelStyle: const TextStyle(
//                                               color: Colors
//                                                   .black,
//                                               fontSize:
//                                               12.0),
//                                           contentPadding: const EdgeInsets
//                                               .fromLTRB(
//                                               5.0,
//                                               0.0,
//                                               5.0,
//                                               0.0),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Theme.of(context)
//                                                       .primaryColor),
//                                               borderRadius: const BorderRadius
//                                                   .all(
//                                                   Radius.circular(5))),
//                                           enabledBorder: const OutlineInputBorder(
//                                               borderSide:
//                                               BorderSide(color: Colors.grey),
//                                               borderRadius: BorderRadius.all(Radius.circular(5))),
//                                         ),
//                                         style: const TextStyle(
//                                             color: Colors
//                                                 .black),
//                                         onChanged:
//                                             (value) {
//                                           mrn_request_controller
//                                               .MaterialItemlist_clickEdit();
//                                         },
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets
//                                           .only(
//                                           top: 10,
//                                           right: 10,
//                                           left: 10,
//                                           bottom:
//                                           5),
//                                       height: BaseUtitiles
//                                           .getheightofPercentage(
//                                           context,
//                                           3),
//                                       child:
//                                       TextField(
//                                         cursorColor:
//                                         Theme.of(context)
//                                             .primaryColor,
//                                         textAlign:
//                                         TextAlign
//                                             .center,
//                                         controller:
//                                         mrn_request_controller
//                                             .Addwork_remarksControllers[index],
//                                         keyboardType:
//                                         TextInputType
//                                             .multiline,
//                                         decoration:
//                                         InputDecoration(
//                                           labelText:
//                                           'Remarks',
//                                           labelStyle: const TextStyle(
//                                               color: Colors
//                                                   .black,
//                                               fontSize:
//                                               12.0),
//                                           contentPadding: const EdgeInsets
//                                               .fromLTRB(
//                                               5.0,
//                                               0.0,
//                                               5.0,
//                                               0.0),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Theme.of(context)
//                                                       .primaryColor),
//                                               borderRadius: const BorderRadius
//                                                   .all(
//                                                   Radius.circular(5))),
//                                           enabledBorder: const OutlineInputBorder(
//                                               borderSide:
//                                               BorderSide(color: Colors.grey),
//                                               borderRadius: BorderRadius.all(Radius.circular(5))),
//                                         ),
//                                         style: const TextStyle(
//                                             color: Colors
//                                                 .black),
//                                         onChanged:
//                                             (value) {
//                                           mrn_request_controller
//                                               .MaterialItemlist_clickEdit();
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               )),
//             ),
//           ],
//         ));
//   }
//
// }
//



import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

class VoiceToTextExample extends StatefulWidget {
  @override
  _VoiceToTextExampleState createState() => _VoiceToTextExampleState();
}

class _VoiceToTextExampleState extends State<VoiceToTextExample> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Tap mic and start speaking";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();

      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
            localeId: "ta_IN" // Tamil
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Voice to Text")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text(_text),
            SizedBox(height: 20,),
            Text(
              isRecording ? "Listening..." : "Hold to speak",
              style: TextStyle(
                color: isRecording ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),


            GestureDetector(
              onLongPressStart: (_) async {
                setState(() {
                  isRecording = true; // 🔴 UI ON
                });

                bool available = await _speech.initialize();

                if (available) {
                  _speech.listen(
                    onResult: (result) {
                      setState(() {
                        _text = result.recognizedWords;
                      });
                    },
                    listenFor: Duration(minutes: 1),
                    pauseFor: Duration(seconds: 5),
                    partialResults: true,
                  );
                }
              },

              onLongPressEnd: (_) {
                setState(() {
                  isRecording = false; // ⚪ UI OFF
                });

                _speech.stop();
              },

              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(isRecording ? 20 : 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRecording ? Colors.red : Colors.blue,
                  boxShadow: [
                    if (isRecording)
                      BoxShadow(
                        color: Colors.red.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                  ],
                ),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: isRecording ? 30 : 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
