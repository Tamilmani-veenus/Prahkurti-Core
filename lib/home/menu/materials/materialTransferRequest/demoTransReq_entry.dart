// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import '../../../../app_theme/app_colors.dart';
// import '../../../../constants/ui_constant/icons_const.dart';
// import '../../../../controller/auto_yrwise_no_controller.dart';
// import '../../../../controller/bottomsheet_Controllers.dart';
// import '../../../../controller/fromproject_ccontroller.dart';
// import '../../../../controller/fromsite_controller.dart';
// import '../../../../controller/logincontroller.dart';
// import '../../../../controller/material_transreq_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
//
// class MatTransReqEntry extends StatefulWidget {
//   const MatTransReqEntry({super.key});
//
//   @override
//   State<MatTransReqEntry> createState() => _MatTransReqEntryState();
// }
//
// class _MatTransReqEntryState extends State<MatTransReqEntry> {
//   MaterialTransferReqController materialTransferReqController = Get.put(MaterialTransferReqController());
//   FromProjectController fromprojectController = Get.put(FromProjectController());
//   FromSiteController fromsiteController = Get.put(FromSiteController());
//   BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
//   ProjectController projectController = Get.put(ProjectController());
//   LoginController loginController = Get.put(LoginController());
//   AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
//   final _formkey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     var duration = const Duration(seconds: 0);
//     Future.delayed(duration, () async {
//       await autoYearWiseNoController.matTransReq_AutoYearWise();
//       if (mounted) {
//         await projectController.getProjectListAll(context, 0);
//         await fromsiteController.getsiteDropdowntList(context, 0);
//       }
//       materialTransferReqController.autoyrwiseText.text = autoYearWiseNoController.matTransReqautoYrsWise.toString();
//       if (materialTransferReqController.editcheck == 1) {
//         if (materialTransferReqController.screenCheck.value == "TRANSFER REQUEST VERIFICATION PENDING") {
//           materialTransferReqController.saveButton.value = RequestConstant.VERIFY;
//         } else if (materialTransferReqController.screenCheck.value == "TRANSFER REQUEST APPROVAL PENDING") {
//           materialTransferReqController.saveButton.value = RequestConstant.APPROVAL;
//         } else {
//           materialTransferReqController.saveButton.value = RequestConstant.RESUBMIT;
//         }
//         print("ScreenCheck1 :: ${materialTransferReqController.screenCheck.value}");
//         print("ButtonEvent1 :: ${materialTransferReqController.saveButton.value}");
//         materialTransferReqController.mattranReqEditListValue.forEach((element) {
//           // materialTransferReqController.ButtonChanges(materialTransferReqController.mattranReqEditListValue[0].trId);
//           materialTransferReqController.matTansReqId = materialTransferReqController.mattranReqEditListValue[0].trId;
//           materialTransferReqController.autoyrwiseText.text = element.trNo.toString();
//           materialTransferReqController.entryDateText.text = element.transferDate.toString();
//           fromprojectController.fromprojectname.text = element.frProjectName.toString();
//           fromprojectController.selectedProjectId.value = element.frProjectId;
//           fromsiteController.FromSitename.text = element.frSiteName.toString();
//           fromsiteController.selectedsiteId.value = element.frSiteId;
//           projectController.projectnameAll.text = element.toProjectName.toString();
//           projectController.selectedProjectIdAll.value = element.toProjectId;
//           materialTransferReqController.remarksText.text = element.remarks.toString();
//           materialTransferReqController.prearedbyText.text = element.preparedbyName.toString();
//           materialTransferReqController.preparedbyId = element.preparedby;
//         });
//       }
//       if (materialTransferReqController.entrycheck == 0) {
//         materialTransferReqController.screenCheck.value = "";
//         materialTransferReqController.saveButton.value = RequestConstant.SUBMIT;
//         materialTransferReqController.matTansReqId = 0;
//         materialTransferReqController.autoyrwiseText.text = autoYearWiseNoController.matTransReqautoYrsWise.toString();
//         materialTransferReqController.entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
//         fromprojectController.fromprojectname.text = "--SELECT--";
//         fromprojectController.selectedProjectId = 0.obs;
//         fromsiteController.selectedsiteId = 0.obs;
//         fromsiteController.FromSitename.text = "--SELECT--";
//         projectController.projectnameAll.text = "--SELECT--";
//         projectController.selectedProjectIdAll.value = 0;
//         materialTransferReqController.prearedbyText.text = loginController.EmpName();
//         materialTransferReqController.preparedbyId = loginController.user.value.empId!;
//
//         // projectController.setSelectedProjectListNameAll(0);
//         //
//         // fromprojectController.setSelectedProjectListName(0);
//         //
//         // fromsiteController.setSelectedMRNListName(0);
//
//         materialTransferReqController.remarksText.text = "";
//         materialTransferReqController.entrycheck = 1;
//         materialTransferReqController.itemlistTable_Delete();
//         materialTransferReqController.ItemGetTableListdata.clear();
//       }
//       print("ButtonEventValue:: ${ materialTransferReqController.saveButton.value}");
//
//       // if (materialTransferReqController.type.value == "Against Approval") {
//       //   materialTransferReqController.appNoText.text = materialTransferReqController.transferAllDatasList[0].appOrdNo.toString();
//       //   projectController.projectnameAll.text = materialTransferReqController.transferAllDatasList[0].toProjectName.toString();
//       //   projectController.selectedProjectIdAll.value = materialTransferReqController.transferAllDatasList[0].toProjectid;
//       // }
//       // if(materialTransferReqController.type.value == "Against Approval" && materialTransferReqController.selectedProjectId.value != 0 && fromsiteController.selectedsiteId.value != 0) {
//       //   materialTransferReqController.itemlistTable_Delete();
//       //   materialTransferReqController.ItemGetTableListdata.value.clear();
//       // } else {}
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width * 100 / 100;
//     final double height = MediaQuery.of(context).size.height * 50 / 100;
//     return Form(
//       key: _formkey,
//       child: GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//             FocusManager.instance.primaryFocus?.unfocus();
//           }
//         },
//
//
//         child: SafeArea(
//           top: false,
//           child: Scaffold(
//             backgroundColor: Setmybackground,
//             bottomNavigationBar: Container(
//               height: BaseUtitiles.getheightofPercentage(context, 4),
//               margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Expanded(
//                     child: InkWell(
//                       child: Container(
//                         margin: const EdgeInsets.only(left: 20, right: 20),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           color: materialTransferReqController.checkColor == 0
//                               ? Colors.white
//                               : Theme.of(context).primaryColor,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Reset",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: RequestConstant.Lable_Font_SIZE,
//                               color: materialTransferReqController.checkColor == 0
//                                   ? Theme.of(context).primaryColor
//                                   : Colors.white),
//                         ),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           materialTransferReqController.checkColor = 1;
//                           ResetAlert(context);
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                       child: Container(
//                         margin: const EdgeInsets.only(left: 20, right: 20),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           color: materialTransferReqController.checkColor == 0
//                               ? Theme.of(context).primaryColor
//                               : Colors.white,
//                         ),
//                         alignment: Alignment.center,
//                         child: Obx(() => Text(
//                           materialTransferReqController.saveButton.value,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: RequestConstant.Lable_Font_SIZE,
//                               color: materialTransferReqController.checkColor == 0
//                                   ? Colors.white
//                                   : Theme.of(context).primaryColor),
//                         ),
//                         ),
//                       ),
//                       onTap: () {
//                         print("ButtonEvent 2 :: ${materialTransferReqController.saveButton.value}");
//                         materialTransferReqController.checkColor = 0;
//                         if (_formkey.currentState!.validate()) {
//                           _formkey.currentState!.save();
//                           if (materialTransferReqController.ItemGetTableListdata.isEmpty) {
//                             Fluttertoast.showToast(msg: "Please add items");
//                           } else {
//                             SubmitAlert(context);
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         Container(
//                           margin: const EdgeInsets.only(left: 15, right: 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Material Transfer Request",
//                                 style: TextStyle(
//                                   fontSize: RequestConstant.Heading_Font_SIZE,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text(
//                                   "Back",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 4,
//                               child: Container(
//                                 margin: const EdgeInsets.only(top: 5, left: 10),
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                       color: Colors.white70,
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 3,
//                                       left: 10,
//                                       bottom: 5,
//                                     ),
//                                     child: TextFormField(
//                                       readOnly: true,
//                                       controller: materialTransferReqController.autoyrwiseText,
//                                       cursorColor: Colors.black,
//                                       style: const TextStyle(color: Colors.black),
//                                       decoration: const InputDecoration(
//                                         contentPadding: EdgeInsets.zero,
//                                         border: InputBorder.none,
//                                         labelText: "Transfer No",
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: RequestConstant.Lable_Font_SIZE,
//                                         ),
//                                         prefixIconConstraints: BoxConstraints(
//                                           minWidth: 0,
//                                           minHeight: 0,
//                                         ),
//                                         prefixIcon: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 8, horizontal: 8),
//                                           child: ConstIcons.requestNo,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 margin: const EdgeInsets.only(top: 5, right: 10),
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(color: Colors.white70, width: 1),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 3, left: 10, bottom: 5),
//                                     child: TextFormField(
//                                       readOnly: true,
//                                       controller: materialTransferReqController.entryDateText,
//                                       cursorColor: Colors.black,
//                                       style: const TextStyle(color: Colors.black),
//                                       decoration: const InputDecoration(
//                                         contentPadding: EdgeInsets.zero,
//                                         border: InputBorder.none,
//                                         labelText: "Date",
//                                         labelStyle: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize:
//                                             RequestConstant.Lable_Font_SIZE),
//                                         prefixIconConstraints: BoxConstraints(
//                                             minWidth: 0, minHeight: 0),
//                                         prefixIcon: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 8, horizontal: 8),
//                                             child: ConstIcons.date),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 readOnly: true,
//                                 controller: fromprojectController.fromprojectname,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: RequestConstant.FROM_PROJECT_NAME,
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.projectName),
//                                 ),
//                                 onTap: () async {
//                                   if(materialTransferReqController.saveButton.value == RequestConstant.SUBMIT || materialTransferReqController.saveButton.value == RequestConstant.RESUBMIT){
//                                     await fromprojectController.getFromProjectList();
//                                     if (mounted) {
//                                       await bottomsheetControllers.FromProjectName(context, fromprojectController.getdropDownvalue.value);
//                                     }
//                                   }else{
//
//                                   }
//                                 },
//                                 validator: (value) {
//                                   if (value!.isEmpty ||
//                                       value == "--Select--" ||
//                                       value == "--SELECT--") {
//                                     return '\u26A0 ${RequestConstant.VALIDATE}';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin:
//                           const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side:
//                               const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 readOnly: true,
//                                 controller: fromsiteController.FromSitename,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: RequestConstant.FROM_SITE_NAME,
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.siteName),
//                                 ),
//                                 onTap: () async {
//                                   if(materialTransferReqController.saveButton.value == RequestConstant.SUBMIT || materialTransferReqController.saveButton.value == RequestConstant.RESUBMIT){
//                                     await fromsiteController.getsiteDropdowntList(context, 0);
//                                     await bottomsheetControllers.FromSiteName(context, "Material Transfer Request", fromsiteController.getSiteDropdownvalue.value);
//                                   }else{
//
//                                   }
//                                 },
//                                 validator: (value) {
//                                   if (value!.isEmpty ||
//                                       value == "--Select--" ||
//                                       value == "--SELECT--") {
//                                     return '\u26A0 ${RequestConstant.VALIDATE}';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 readOnly: true,
//                                 controller: projectController.projectnameAll,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: RequestConstant.TO_PROJECT_NAME,
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                                       child: ConstIcons.projectName),
//                                 ),
//                                 onTap: () {
//                                   if(materialTransferReqController.saveButton.value == RequestConstant.SUBMIT || materialTransferReqController.saveButton.value == RequestConstant.RESUBMIT){
//                                     setState(() {
//                                       materialTransferReqController.itemlistTable_Delete();
//                                       materialTransferReqController.ItemGetTableListdata.value.clear();
//                                       bottomsheetControllers.projectnameAll(context, projectController.getdropDownvalueAll.value);
//                                     });
//                                   }else{
//
//                                   }
//                                 },
//                                 validator: (value) {
//                                   if (value!.isEmpty ||
//                                       value == "--Select--" ||
//                                       value == "--SELECT--") {
//                                     return '\u26A0 ${RequestConstant.VALIDATE}';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin:
//                           const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side:
//                               const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller:
//                                 materialTransferReqController.prearedbyText,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: RequestConstant.PREPARED_BY,
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.preparedBy),
//                                 ),
//                                 onChanged: (value) {},
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin:
//                           const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side:
//                               const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 3, left: 10, bottom: 5),
//                               child: TextFormField(
//                                 controller: materialTransferReqController.remarksText,
//                                 cursorColor: Colors.black,
//                                 style: const TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: RequestConstant.REMARKS,
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: ConstIcons.remarks),
//                                 ),
//                                 onChanged: (value) {},
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Setmybackground,
//                                 ),
//                                 onPressed: () async {
//                                   if (fromprojectController.selectedProjectId.value != 0 && fromsiteController.selectedsiteId.value != 0) {
//                                     await materialTransferReqController.getItemList(fromprojectController.selectedProjectId.value, fromsiteController.selectedsiteId.value, context);
//                                   }
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Icon(
//                                       Icons.add,
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                       "Add Items",
//                                       style: TextStyle(
//                                           color: Theme.of(context).primaryColor),
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         ),
//
//                         Obx(() => Visibility(
//                           visible: materialTransferReqController.ItemGetTableListdata.value.isEmpty ? false : true,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics: const ScrollPhysics(),
//                             itemCount: materialTransferReqController
//                                 .ItemGetTableListdata.value.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               materialTransferReqController
//                                   .itemlist_textControllersInitiate();
//                               return Card(
//                                 color: Colors.white,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: <Widget>[
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 4),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                   top: 5, left: 5),
//                                               child: Text(
//                                                 "${materialTransferReqController.ItemGetTableListdata[index].materialName} ( ${materialTransferReqController.ItemGetTableListdata[index].scale} ) ",
//                                                 style: TextStyle(
//                                                   color: Theme.of(context).primaryColor,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             child: InkWell(
//                                               onTap: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) => AlertDialog(
//                                                     title: const Text(
//                                                       RequestConstant
//                                                           .DO_YOU_WANT_DELETE,
//                                                       style: TextStyle(
//                                                           color: Colors.black),
//                                                     ),
//                                                     actions: <Widget>[
//                                                       Container(
//                                                         margin: const EdgeInsets.only(
//                                                             left: 20, right: 20),
//                                                         child: IntrinsicHeight(
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                             children: [
//                                                               Expanded(
//                                                                 child: TextButton(
//                                                                   onPressed: () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   },
//                                                                   child: const Text(
//                                                                     "Cancel",
//                                                                     style: TextStyle(
//                                                                       color:
//                                                                       Colors.grey,
//                                                                       fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                       fontSize:
//                                                                       RequestConstant
//                                                                           .Lable_Font_SIZE,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               VerticalDivider(
//                                                                 color: Colors
//                                                                     .grey.shade400,
//                                                                 width: 5,
//                                                                 thickness: 2,
//                                                                 indent: 15,
//                                                                 endIndent: 15,
//                                                               ),
//                                                               Expanded(
//                                                                 child: TextButton(
//                                                                     onPressed: () {
//                                                                       setState(() {
//                                                                         materialTransferReqController
//                                                                             .deleteParticularList(
//                                                                             materialTransferReqController
//                                                                                 .ItemGetTableListdata[index]);
//                                                                         materialTransferReqController
//                                                                             .ItemGetTableListdata
//                                                                             .remove(materialTransferReqController
//                                                                             .ItemGetTableListdata[
//                                                                         index]);
//                                                                         materialTransferReqController
//                                                                             .getItemlistTablesDatas();
//                                                                         Navigator.pop(
//                                                                             context);
//                                                                       });
//                                                                     },
//                                                                     child: const Text(
//                                                                         "Delete",
//                                                                         style: TextStyle(
//                                                                             color: Colors
//                                                                                 .red,
//                                                                             fontWeight:
//                                                                             FontWeight
//                                                                                 .bold,
//                                                                             fontSize:
//                                                                             RequestConstant
//                                                                                 .Lable_Font_SIZE))),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                               child: const Icon(Icons.remove_circle,
//                                                   color: Colors.red),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 5, right: 4, bottom: 5, top: 5),
//                                       child: const Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                         children: <Widget>[
//                                           Text(
//                                             "Stock Quantity",
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                           Text(
//                                             "Transfer Qty",
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                           //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 7, right: 4, bottom: 8),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                         children: <Widget>[
//                                           Container(
//                                             margin: const EdgeInsets.only(right: 11),
//                                             height: BaseUtitiles.getheightofPercentage(
//                                                 context, 4),
//                                             width: BaseUtitiles.getWidthtofPercentage(
//                                                 context, 38),
//                                             child: TextField(
//                                               readOnly: true,
//                                               cursorColor:
//                                               Theme.of(context).primaryColor,
//                                               textAlign: TextAlign.center,
//                                               controller: materialTransferReqController
//                                                   .Show_Itemlist_stockQtyControllers[
//                                               index],
//                                               keyboardType: TextInputType.number,
//                                               decoration: InputDecoration(
//                                                 contentPadding:
//                                                 const EdgeInsets.fromLTRB(
//                                                     8.0, 0.0, 8.0, 0.0),
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                     borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(10))),
//                                                 enabledBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                     borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(10))),
//                                               ),
//                                               style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold),
//                                               onChanged: (value) {},
//                                             ),
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.only(
//                                                 right: 11, left: 8, bottom: 8),
//                                             height: BaseUtitiles.getheightofPercentage(
//                                                 context, 4),
//                                             width: BaseUtitiles.getWidthtofPercentage(
//                                                 context, 38),
//                                             child: TextFormField(
//                                               cursorColor:
//                                               Theme.of(context).primaryColor,
//                                               textAlign: TextAlign.center,
//                                               controller: materialTransferReqController
//                                                   .Show_Itemlist_TransQtyController[
//                                               index],
//                                               keyboardType: TextInputType.number,
//                                               decoration: InputDecoration(
//                                                 contentPadding:
//                                                 const EdgeInsets.fromLTRB(
//                                                     8.0, 0.0, 8.0, 0.0),
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                     borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(10))),
//                                                 enabledBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                     borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(10))),
//                                               ),
//                                               style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold),
//                                               onTap: () {
//                                                 if (materialTransferReqController
//                                                     .Show_Itemlist_TransQtyController[
//                                                 index]
//                                                     .text !=
//                                                     "" &&
//                                                     materialTransferReqController
//                                                         .Show_Itemlist_TransQtyController[
//                                                     index]
//                                                         .text !=
//                                                         "0" &&
//                                                     materialTransferReqController
//                                                         .Show_Itemlist_TransQtyController[
//                                                     index]
//                                                         .text !=
//                                                         "0.0") {
//                                                 } else {
//                                                   materialTransferReqController
//                                                       .Show_Itemlist_TransQtyController[
//                                                   index]
//                                                       .text = "";
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   materialTransferReqController
//                                                       .ItemListclickEdit();
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         )),
//
//                         SizedBox(height: height),
//
//                       ],
//                     ),
//                   ),
//
//
//
//
//                   // Obx(() => Visibility(
//                   //     visible: materialTransferReqController.ItemGetTableListdata.value.isEmpty ? false : true,
//                   //     child: SizedBox(
//                   //       height: BaseUtitiles.getheightofPercentage(context, 100),
//                   //       child: DraggableScrollableSheet(
//                   //         minChildSize: 0.1,
//                   //         maxChildSize: 0.9,
//                   //         initialChildSize: 0.3,
//                   //         builder: (BuildContext context, ScrollController scrollController) {
//                   //           return Container(
//                   //             decoration: const BoxDecoration(
//                   //               color: Setmybackground,
//                   //               borderRadius: BorderRadius.only(
//                   //                 topLeft: Radius.circular(40.0),
//                   //                 topRight: Radius.circular(40.0),
//                   //               ),
//                   //             ),
//                   //             child: Stack(
//                   //               children: [
//                   //                 SingleChildScrollView(
//                   //                   controller: scrollController,
//                   //                   child: Column(
//                   //                     children: [
//                   //                       const SizedBox(height: 10),
//                   //                       Column(
//                   //                         children: <Widget>[
//                   //                           Padding(
//                   //                             padding: const EdgeInsets.only(top: 40.0,left: 8.0,right: 8.0),
//                   //                             child: Obx(() => ListView.builder(
//                   //                               shrinkWrap: true,
//                   //                               padding: EdgeInsets.zero,
//                   //                               physics: const ScrollPhysics(),
//                   //                                   itemCount: materialTransferReqController.ItemGetTableListdata.value.length,
//                   //                                   itemBuilder: (BuildContext context, int index) {
//                   //                                     materialTransferReqController.itemlist_textControllersInitiate();
//                   //                                     return Card(
//                   //                                       color: Colors.white,
//                   //                                       child: Column(
//                   //                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //                                         children: <Widget>[
//                   //                                           Container(
//                   //                                             margin: const EdgeInsets.only(left: 4),
//                   //                                             child: Row(
//                   //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //                                               children: <Widget>[
//                   //                                                 Expanded(
//                   //                                                   child: Container(
//                   //                                                     margin: const EdgeInsets.only(top: 5, left: 5),
//                   //                                                     child: Text(
//                   //                                                       "${materialTransferReqController.ItemGetTableListdata[index].materialName} ( ${materialTransferReqController.ItemGetTableListdata[index].scale} ) ",
//                   //                                                       style: TextStyle(
//                   //                                                         color: Theme.of(context).primaryColor,
//                   //                                                         fontWeight: FontWeight.bold,
//                   //                                                         fontSize: 15,
//                   //                                                       ),
//                   //                                                     ),
//                   //                                                   ),
//                   //                                                 ),
//                   //                                                 SizedBox(
//                   //                                                   child: InkWell(
//                   //                                                     onTap: () {
//                   //                                                       showDialog(
//                   //                                                         context: context,
//                   //                                                         builder: (context) => AlertDialog(
//                   //                                                           title: const Text(
//                   //                                                             RequestConstant.DO_YOU_WANT_DELETE,
//                   //                                                             style: TextStyle(color: Colors.black),
//                   //                                                           ),
//                   //                                                           actions: <Widget>[
//                   //                                                             Container(
//                   //                                                               margin: const EdgeInsets.only(
//                   //                                                                   left: 20, right: 20),
//                   //                                                               child: IntrinsicHeight(
//                   //                                                                 child: Row(
//                   //                                                                   mainAxisAlignment:
//                   //                                                                   MainAxisAlignment
//                   //                                                                       .spaceBetween,
//                   //                                                                   children: [
//                   //                                                                     Expanded(
//                   //                                                                       child: TextButton(
//                   //                                                                         onPressed: () {
//                   //                                                                           Navigator.pop(context);
//                   //                                                                         },
//                   //                                                                         child: const Text(
//                   //                                                                           "Cancel",
//                   //                                                                           style: TextStyle(
//                   //                                                                             color: Colors.grey,
//                   //                                                                             fontWeight:
//                   //                                                                             FontWeight.bold,
//                   //                                                                             fontSize: RequestConstant
//                   //                                                                                 .Lable_Font_SIZE,
//                   //                                                                           ),
//                   //                                                                         ),
//                   //                                                                       ),
//                   //                                                                     ),
//                   //                                                                     VerticalDivider(
//                   //                                                                       color: Colors.grey.shade400,
//                   //                                                                       width: 5,
//                   //                                                                       thickness: 2,
//                   //                                                                       indent: 15,
//                   //                                                                       endIndent: 15,
//                   //                                                                     ),
//                   //                                                                     Expanded(
//                   //                                                                       child: TextButton(
//                   //                                                                           onPressed: () {
//                   //                                                                             setState(() {
//                   //                                                                               materialTransferReqController.deleteParticularList(materialTransferReqController.ItemGetTableListdata[index]);
//                   //                                                                               materialTransferReqController.ItemGetTableListdata.remove(materialTransferReqController.ItemGetTableListdata[index]);
//                   //                                                                               materialTransferReqController.getItemlistTablesDatas();
//                   //                                                                               Navigator.pop(context);
//                   //                                                                             });
//                   //                                                                           },
//                   //                                                                           child: const Text(
//                   //                                                                               "Delete",
//                   //                                                                               style: TextStyle(
//                   //                                                                                   color: Colors.red,
//                   //                                                                                   fontWeight:
//                   //                                                                                   FontWeight
//                   //                                                                                       .bold,
//                   //                                                                                   fontSize:
//                   //                                                                                   RequestConstant
//                   //                                                                                       .Lable_Font_SIZE))),
//                   //                                                                     )
//                   //                                                                   ],
//                   //                                                                 ),
//                   //                                                               ),
//                   //                                                             ),
//                   //                                                           ],
//                   //                                                         ),
//                   //                                                       );
//                   //                                                     },
//                   //                                                     child: const Icon(Icons.remove_circle,
//                   //                                                         color: Colors.red),
//                   //                                                   ),
//                   //                                                 ),
//                   //                                               ],
//                   //                                             ),
//                   //                                           ),
//                   //                                           Container(
//                   //                                             margin: const EdgeInsets.only(
//                   //                                                 left: 5, right: 4, bottom: 5, top: 5),
//                   //                                             child: const Row(
//                   //                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //                                               children: <Widget>[
//                   //                                                 Text(
//                   //                                                   "Stock Quantity",
//                   //                                                   style: TextStyle(color: Colors.black),
//                   //                                                 ),
//                   //                                                 Text(
//                   //                                                   "Transfer Qty",
//                   //                                                   style: TextStyle(color: Colors.black),
//                   //                                                 ),
//                   //                                                 //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
//                   //                                               ],
//                   //                                             ),
//                   //                                           ),
//                   //                                           Container(
//                   //                                             margin:
//                   //                                             const EdgeInsets.only(left: 7, right: 4, bottom: 8),
//                   //                                             child: Row(
//                   //                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //                                               children: <Widget>[
//                   //                                                 Container(
//                   //                                                   margin: const EdgeInsets.only(right: 11),
//                   //                                                   height: BaseUtitiles.getheightofPercentage(
//                   //                                                       context, 4),
//                   //                                                   width: BaseUtitiles.getWidthtofPercentage(
//                   //                                                       context, 38),
//                   //                                                   child: TextField(
//                   //                                                     readOnly: true,
//                   //                                                     cursorColor: Theme.of(context).primaryColor,
//                   //                                                     textAlign: TextAlign.center,
//                   //                                                     controller: materialTransferReqController.Show_Itemlist_stockQtyControllers[index],
//                   //                                                     keyboardType: TextInputType.number,
//                   //                                                     decoration: InputDecoration(
//                   //                                                       contentPadding: const EdgeInsets.fromLTRB(
//                   //                                                           8.0, 0.0, 8.0, 0.0),
//                   //                                                       focusedBorder: OutlineInputBorder(
//                   //                                                           borderSide: BorderSide(
//                   //                                                               color:
//                   //                                                               Theme.of(context).primaryColor),
//                   //                                                           borderRadius: const BorderRadius.all(
//                   //                                                               Radius.circular(10))),
//                   //                                                       enabledBorder: OutlineInputBorder(
//                   //                                                           borderSide: BorderSide(
//                   //                                                               color:
//                   //                                                               Theme.of(context).primaryColor),
//                   //                                                           borderRadius: const BorderRadius.all(
//                   //                                                               Radius.circular(10))),
//                   //                                                     ),
//                   //                                                     style: const TextStyle(
//                   //                                                         color: Colors.black,
//                   //                                                         fontWeight: FontWeight.bold),
//                   //                                                     onChanged: (value) {},
//                   //                                                   ),
//                   //                                                 ),
//                   //                                                 Container(
//                   //                                                   margin: const EdgeInsets.only(
//                   //                                                       right: 11, left: 8, bottom: 8),
//                   //                                                   height: BaseUtitiles.getheightofPercentage(
//                   //                                                       context, 4),
//                   //                                                   width: BaseUtitiles.getWidthtofPercentage(
//                   //                                                       context, 38),
//                   //                                                   child: TextFormField(
//                   //                                                     cursorColor: Theme.of(context).primaryColor,
//                   //                                                     textAlign: TextAlign.center,
//                   //                                                     controller: materialTransferReqController.Show_Itemlist_TransQtyController[index],
//                   //                                                     keyboardType: TextInputType.number,
//                   //                                                     decoration: InputDecoration(
//                   //                                                       contentPadding: const EdgeInsets.fromLTRB(
//                   //                                                           8.0, 0.0, 8.0, 0.0),
//                   //                                                       focusedBorder: OutlineInputBorder(
//                   //                                                           borderSide: BorderSide(
//                   //                                                               color:
//                   //                                                               Theme.of(context).primaryColor),
//                   //                                                           borderRadius: const BorderRadius.all(
//                   //                                                               Radius.circular(10))),
//                   //                                                       enabledBorder: OutlineInputBorder(
//                   //                                                           borderSide: BorderSide(
//                   //                                                               color:
//                   //                                                               Theme.of(context).primaryColor),
//                   //                                                           borderRadius: const BorderRadius.all(
//                   //                                                               Radius.circular(10))),
//                   //                                                     ),
//                   //                                                     style: const TextStyle(
//                   //                                                         color: Colors.black,
//                   //                                                         fontWeight: FontWeight.bold),
//                   //                                                     onTap: () {
//                   //                                                       if (materialTransferReqController.Show_Itemlist_TransQtyController[index].text != "" &&
//                   //                                                           materialTransferReqController.Show_Itemlist_TransQtyController[index].text != "0" &&
//                   //                                                           materialTransferReqController
//                   //                                                               .Show_Itemlist_TransQtyController[
//                   //                                                           index]
//                   //                                                               .text !=
//                   //                                                               "0.0") {
//                   //                                                       } else {
//                   //                                                         materialTransferReqController
//                   //                                                             .Show_Itemlist_TransQtyController[index]
//                   //                                                             .text = "";
//                   //                                                       }
//                   //                                                     },
//                   //                                                     onChanged: (value) {
//                   //                                                       setState(() {
//                   //                                                         materialTransferReqController.ItemListclickEdit();
//                   //                                                       });
//                   //                                                     },
//                   //                                                   ),
//                   //                                                 ),
//                   //                                               ],
//                   //                                             ),
//                   //                                           ),
//                   //                                         ],
//                   //                                       ),
//                   //                                     );
//                   //                                   },
//                   //                                 ),
//                   //                             ),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //
//                   //
//                   //                 IgnorePointer(
//                   //                   child: Container(
//                   //                     decoration: const BoxDecoration(
//                   //                       color: Colors.white,
//                   //                       borderRadius: BorderRadius.only(
//                   //                         topLeft: Radius.circular(40.0),
//                   //                         topRight: Radius.circular(40.0),
//                   //                       ),
//                   //                     ),
//                   //                     child: Row(
//                   //                       mainAxisAlignment: MainAxisAlignment.center,
//                   //                       children: [
//                   //                         Container(
//                   //                           margin: const EdgeInsets.only(
//                   //                               top: 20, bottom: 20),
//                   //                           height: 5,
//                   //                           width: 60,
//                   //                           decoration: BoxDecoration(
//                   //                               borderRadius:
//                   //                                   BorderRadius.circular(10),
//                   //                               color: Colors.grey),
//                   //                         ),
//                   //                       ],
//                   //                     ),
//                   //                   ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           );
//                   //         },
//                   //       ),
//                   //     ),
//                   //   ),
//
//                 ]),
//           ),
//         ),
//
//       ),
//     );
//   }
//
//   Future ResetAlert(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Alert!'),
//         content: const Text('Are you sure to Reset?'),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20),
//             child: IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Cancel",
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: RequestConstant.Lable_Font_SIZE))),
//                   ),
//                   VerticalDivider(
//                     color: Colors.grey.shade400,
//                     //color of divider
//                     width: 5,
//                     //width space of divider
//                     thickness: 2,
//                     //thickness of divier line
//                     indent: 15,
//                     //Spacing at the top of divider.
//                     endIndent: 15, //Spacing at the bottom of divider.
//                   ),
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () async {
//                         materialTransferReqController.screenCheck.value = "";
//                         materialTransferReqController.saveButton.value =
//                             RequestConstant.SUBMIT;
//                         materialTransferReqController.matTansReqId = 0;
//                         materialTransferReqController.autoyrwiseText.text =
//                             autoYearWiseNoController.matTransReqautoYrsWise
//                                 .toString();
//                         materialTransferReqController.entryDateText.text =
//                             BaseUtitiles.initiateCurrentDateFormat();
//                         fromprojectController.fromprojectname.text =
//                         "--SELECT--";
//                         fromprojectController.selectedProjectId = 0.obs;
//                         fromsiteController.selectedsiteId = 0.obs;
//                         fromsiteController.FromSitename.text = "--SELECT--";
//                         projectController.projectnameAll.text = "--SELECT--";
//                         projectController.selectedProjectIdAll.value = 0;
//
//                         materialTransferReqController.prearedbyText.text =
//                             loginController.EmpName();
//                         materialTransferReqController.preparedbyId =
//                         loginController.user.value.empId!;
//
//                         // projectController.setSelectedProjectListNameAll(0);
//                         //
//                         // fromprojectController.setSelectedProjectListName(0);
//                         //
//                         // fromsiteController.setSelectedMRNListName(0);
//
//                         materialTransferReqController.remarksText.text = "";
//                         materialTransferReqController.ItemGetTableListdata.value
//                             .clear();
//                         materialTransferReqController.entrycheck = 1;
//                         setState(() {
//                           materialTransferReqController.itemlistTable_Delete();
//                           materialTransferReqController
//                               .ItemGetTableListdata.value
//                               .clear();
//                         });
//
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         "Reset",
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: RequestConstant.Lable_Font_SIZE,
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
//   Future SubmitAlert(BuildContext context) async {
//     materialTransferReqController.buttonControl = 0;
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Alert!'),
//         content: Text(
//           materialTransferReqController.saveButton.value ==
//               RequestConstant.VERIFY
//               ? 'Are you sure to Verify?'
//               : materialTransferReqController.saveButton.value ==
//               RequestConstant.APPROVAL
//               ? 'Are you sure to Approve?'
//               : materialTransferReqController.editcheck == 1
//               ? 'Are you sure to Re-Submit?'
//               : 'Are you sure to Submit?',
//         ),
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
//                     //color of divider
//                     width: 5,
//                     //width space of divider
//                     thickness: 2,
//                     //thickness of divier line
//                     indent: 15,
//                     //Spacing at the top of divider.
//                     endIndent: 15, //Spacing at the bottom of divider.
//                   ),
//                   // Expanded(
//                   //   child: TextButton(
//                   //       onPressed: () async {
//                   //         if (transferBW_project_Controller.buttonControl == 0) {
//                   //           if (fromsiteController.selectedsiteId.value != 0 && fromprojectController.selectedProjectId.value != 0 && projectController.selectedProjectIdAll.value != 0 && transferBW_project_Controller.vechicleNoText.text != "") {
//                   //             if (fromprojectController.selectedProjectId.value == projectController.selectedProjectIdAll.value) {
//                   //               BaseUtitiles.showToast("Same project save can't accept");
//                   //             } else if (transferBW_project_Controller.ItemGetTableListdata.isEmpty) {
//                   //               BaseUtitiles.showToast("Need Det Items to Save");
//                   //             } else {
//                   //               // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
//                   //                 await transferBW_project_Controller.getItemlistTablesDatas();
//                   //                 await transferBW_project_Controller.Save_EntryScreen(context, transferBW_project_Controller.transferId);
//                   //             }
//                   //           } else {
//                   //             BaseUtitiles.showToast("Some field is missing");
//                   //           }
//                   //         } else if(transferBW_project_Controller.buttonControl == 1) {
//                   //           transferBW_project_Controller.buttonControl = 0;
//                   //           BaseUtitiles.showToast("Please wait... processing.");
//                   //         }
//                   //       },
//                   //       child: Text(
//                   //           transferBW_project_Controller.editcheck == 1
//                   //               ? RequestConstant.RESUBMIT
//                   //               : RequestConstant.SUBMIT,
//                   //           style: TextStyle(
//                   //               color: Theme.of(context).primaryColor,
//                   //               fontWeight: FontWeight.bold,
//                   //               fontSize: RequestConstant.Lable_Font_SIZE))),
//                   // ),
//
//                   Expanded(
//                     child: StatefulBuilder(
//                       builder: (context, setState) => TextButton(
//                           onPressed:
//                           materialTransferReqController.buttonControl == 0
//                               ? () async {
//                             setState(() {
//                               materialTransferReqController
//                                   .buttonControl =
//                               1; // Disable the button
//                             });
//                             if (fromsiteController
//                                 .selectedsiteId.value !=
//                                 0 &&
//                                 fromprojectController
//                                     .selectedProjectId.value !=
//                                     0 &&
//                                 projectController
//                                     .selectedProjectIdAll.value !=
//                                     0) {
//                               if (fromprojectController
//                                   .selectedProjectId.value ==
//                                   projectController
//                                       .selectedProjectIdAll.value) {
//                                 BaseUtitiles.showToast("Saving the same project is not allowed");
//                               } else if (materialTransferReqController.ItemGetTableListdata.isEmpty) {
//                                 BaseUtitiles.showToast("Need Det Items to Save");
//                               } else {
//                                 // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
//                                 await materialTransferReqController.getItemlistTablesDatas();
//                                 await materialTransferReqController.SaveEntryScreen(context, materialTransferReqController.matTansReqId);
//                               }
//                             } else {
//                               BaseUtitiles.showToast(
//                                   "Some field is missing");
//                             }
//                             setState(() {
//                               materialTransferReqController
//                                   .buttonControl =
//                               0; // Re-enable the button
//                             });
//                           }
//                               : () {
//                             BaseUtitiles.showToast(
//                                 "Please wait... processing.");
//                           },
//                           child: Text(
//                               materialTransferReqController.saveButton.value,
//                               style: TextStyle(
//                                   color: materialTransferReqController
//                                       .buttonControl ==
//                                       0
//                                       ? Theme.of(context).primaryColor
//                                       : Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: RequestConstant.Lable_Font_SIZE))),
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
// }
