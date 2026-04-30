//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/pendinglistcontroller.dart';
// import '../../controller/projectcontroller.dart';
//
// import '../home/menu/daily_entries/pre_approval/preapproval_main.dart';
// import '../home/menu/daily_entries/pre_approval/typealert.dart';
// import '../models/preapproval_saveapi_reqmodel.dart';
// import '../provider/preapproval_provider.dart';
// import '../utilities/baseutitiles.dart';
// import '../utilities/requestconstant.dart';
// import 'logincontroller.dart';
//
// class PreApprovalController extends GetxController{
//
//   LoginController loginController=Get.put(LoginController());
//   ProjectController projectController=Get.put(ProjectController());
//   PendingListController pendingListController=Get.put(PendingListController());
//   final preApprovalNoText = TextEditingController();
//   final preApprovalTypeText = TextEditingController();
//   final preApprovalDateText = TextEditingController();
//
//   final preApprovalLocationText = TextEditingController();
//   final preApprovalDescriptionText = TextEditingController();
//   final preApproval_AppHrsText = TextEditingController();
//   final preApproval_AppQtyText = TextEditingController();
//   final preApproval_EquipmentText = TextEditingController();
//   final preApproval_ChemicalsText = TextEditingController();
//   final preApproval_PlannedDateText = TextEditingController();
//   final preApproval_PreparedbyText = TextEditingController();
//
//
//   final preApproval_FromdateText = TextEditingController();
//   final preApproval_TodateText = TextEditingController();
//
//
//   RxList AttenEtyList = [].obs;
//   RxList Entrylist=[].obs;
//   RxList Typelist=[].obs;
//   RxList searchTypelist=[].obs;
//   RxList EditApiList=[].obs;
//   RxList pendingAllDatasList=[].obs;
//
//   RxInt typeId=0.obs;
//   RxString typeName="".obs;
//
//   int entrycheck=0;
//   int editcheck=0;
//   int pendingcheck=0;
//   int appId=0;
//
//   Future TypeAlert(BuildContext context) async {
//     Typelist.value.clear();
//     await PreApprovalProvider.getType_List()
//         .then((value) async {
//       if (value != null && value.length > 0) {
//         Typelist.value = value;
//         return showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return  PreApprovalTypeAlert(list: Typelist.value,);
//             });
//       }
//     });
//   }
//
//   setSelectedStaffID(String value) {
//     if (Typelist.value.length>0) {
//       Typelist.forEach((element) {
//         if(value == element.typeName){
//           typeId(element.typeId);
//         }
//       });
//     }
//     setSelectedName(typeId.value);
//   }
//
//   setSelectedName(int? id) {
//     if (Typelist.value != null) {
//       Typelist.value.forEach((element) {
//         if (id == element.typeId) {
//           typeName(element.typeName.toString());
//         }
//       });
//     }
//     preApprovalTypeText.text=typeName.value;
//   }
//
//
//   Future getAttenEntryList() async {
//     AttenEtyList.value.clear();
//     Entrylist.value.clear();
//     await PreApprovalProvider.getSubcontAttenEntry_List(
//         loginController.user.value.userId,
//         loginController.UserType(),
//         preApproval_FromdateText.text,
//         preApproval_TodateText.text)
//         .then((value) async {
//       if (value != null && value.length > 0) {
//         AttenEtyList.value = value;
//         Entrylist.value=AttenEtyList.value;
//         return AttenEtyList.value;
//       }
//     });
//   }
//
//   Future Save_EntryScreen(BuildContext context, int id, int aprovebutton) async {
//     await Future.delayed(const Duration(seconds: 0));
//     String body = preapprovalSaveReqModelToJson(PreapprovalSaveReqModel(
//         preApprovalId:id != 0 ? id.toString() : "0",
//         preApprovalNo:preApprovalNoText.text,
//         preApprovalDate:preApprovalDateText.text,
//         preApprovalType:typeId.value.toString(),
//         projectId:projectController.selectedProjectId.value.toString(),
//         location:preApprovalLocationText.text,
//         description:preApprovalDescriptionText.text,
//         approxHrs:preApproval_AppHrsText.text,
//         approxQty:preApproval_AppQtyText.text,
//         equipment:preApproval_EquipmentText.text,
//         chemicalUsed:preApproval_ChemicalsText.text,
//         plannedDate:preApproval_PlannedDateText.text,
//         preparedby:loginController.EmpId(),
//         approvedby:aprovebutton != 0 ? loginController.EmpId() : "0",
//         userId:loginController.EmpId(),
//         entryMode:id==0?"ADD":id!=0 && aprovebutton==0?"Update":"APPROVAL",
//         deviceName: BaseUtitiles.deviceName,
//     ));
//     final list = await PreApprovalProvider.SaveScreenEntryAPI(body, id, aprovebutton);
//     if (list != null && id != 0) {
//       if(aprovebutton==1){
//         await pendingListController.getPendingList();
//         BaseUtitiles.showToast(list);
//         Navigator.pop(context);
//         return Navigator.pop(context);
//       }
//       else{
//         BaseUtitiles.showToast(list);
//         Navigator.pop(context);
//         return Navigator.pushReplacement(
//             context,
//             new MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                 new PreapprovalMain(1)));
//       }
//
//     } else {
//       if (list == RequestConstant.DUPLICATE_OCCURED) {
//         Navigator.pop(context);
//         Navigator.pop(context);
//         return BaseUtitiles.showToast(list);
//       } else {
//
//         BaseUtitiles.showToast(list);
//         Navigator.pop(context);
//         return Navigator.pushReplacement(
//             context,
//             new MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                 new PreapprovalMain(1)));
//       }
//     }
//   }
//
//   Future EntryList_EditApi(int preAppID, BuildContext context) async {
//     await PreApprovalProvider.entryList_editAPI(preAppID)
//         .then((value) async {
//       if (value != null && value.length > 0) {
//         EditApiList.value = value;
//         return Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => PreapprovalMain(0)),
//         );
//       }
//     });
//   }
//
//   Future getPendingList_Alldatas(int reqId,BuildContext context) async {
//     pendingAllDatasList.clear();
//     await PreApprovalProvider.entryList_editAPI(reqId).then((value) async {
//       if (value != null && value.length > 0) {
//         pendingAllDatasList.value = value;
//         entrycheck=1;
//         editcheck=0;
//         pendingcheck=1;
//         FocusScope.of(context).unfocus();
//         Navigator.push(context, MaterialPageRoute(builder: (context) => PreapprovalMain(0)));
//       }
//       else {
//         BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
//       }
//     });
//   }
//   Future EntryList_DeleteApi(int PreAppId, String PreAppNo) async {
//     await PreApprovalProvider.entryList_deleteAPI(PreAppId, PreAppNo,
//         loginController.user.value.userId!,
//         BaseUtitiles.deviceName)
//         .then((value) async {
//       if (value != null && value.length > 0) {
//         return value;
//       }
//     });
//   }
//
//   Future DeleteAlert(BuildContext context, int index) async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Alert!'),
//         content: Text('Do you want to delete?'),
//         actions: [
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               entrycheck = 0;
//               editcheck = 0;
//               EntryList_DeleteApi(Entrylist.value[index].preApprovalId, Entrylist.value[index].preApprovalNo);
//               Entrylist.removeAt(index);
//               Navigator.of(context).pop();
//             },
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String button(String value){
//     if(editcheck==1){
//       value="Update";
//       return value;
//     }
//     else if(entrycheck==0){
//       value="Save";
//       return value;
//     }
//     else if(pendingcheck==0){
//       value="Save";
//       return value;
//     }
//     return value;
//   }
// }