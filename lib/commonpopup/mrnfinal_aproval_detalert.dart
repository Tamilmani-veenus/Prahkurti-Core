// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../app_theme/app_colors.dart';
// import '../controller/mrn_finalapproval_controller.dart';
// import '../controller/mrn_preapproval_controller.dart';
// import '../controller/mrn_request_indent_controller.dart';
// import '../controller/pendinglistcontroller.dart';
// import '../utilities/baseutitiles.dart';
// import '../utilities/requestconstant.dart';
//
// class MrnfinalApprovalDetAlert extends StatefulWidget {
//     MrnfinalApprovalDetAlert({Key? key,required this.data}) : super(key: key);
//
//   var data;
//   @override
//   State<MrnfinalApprovalDetAlert> createState() => _MrnfinalApprovalDetAlertState();
// }
//
// class _MrnfinalApprovalDetAlertState extends State<MrnfinalApprovalDetAlert> {
//
//   MrnFinalApprovalController mrnFinalApprovalController=Get.put(MrnFinalApprovalController());
//   PendingListController pendingListController=Get.put(PendingListController());
//   MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
//   final list=["PO","Rental WorkOrder","Transfer","Cancel","Pending"];
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 color: Theme.of(context).primaryColor,
//                 child: Center(child: Text("Approval Type",style: TextStyle(color: Colors.white),)),
//               ),
//
//
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                 height: BaseUtitiles.getheightofPercentage(context,30),
//                 child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: ()  async {
//                           int i=0;
//                           mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
//                             mrnFinalApprovalController.itemlist_textControllersInitiate();
//                             if(element.reqMasDetId==widget.data){
//                               if(index==0){
//                                 mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//
//                               }
//                               else  if(index==1){
//                                 mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//
//
//                               }
//                               else  if(index==2){
//                                 mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//
//
//                               }else  if(index==3){
//                                 mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//
//                               }
//                               else  if(index==4){
//                                 mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//
//
//                               }
//                               // else  if(index==5){
//                               //   mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//                               //
//                               //
//                               // }
//                               // else  if(index==6){
//                               //   mrnFinalApprovalController.Approval_ListController[i].text=list[index];
//                               //
//                               // }
//                             }
//                             i++;
//                           });
//                           await mrnFinalApprovalController.finalApproval_updateConsumTables();
//                           Navigator.pop(context);
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                     width: BaseUtitiles.getWidthtofPercentage(context, 60),
//                                     child: Text(list[index].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
//                                 Divider(
//                                   color: Theme.of(context).primaryColorLight,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// class MrnPreapprovalDetAlert extends StatefulWidget {
//   MrnPreapprovalDetAlert({Key? key,required this.data}) : super(key: key);
//   var data;
//   @override
//   State<MrnPreapprovalDetAlert> createState() => _MrnPreapprovalDetAlertState();
// }
//
// class _MrnPreapprovalDetAlertState extends State<MrnPreapprovalDetAlert> {
//   PendingListController pendingListController=Get.put(PendingListController());
//   MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
//   final searchcontroller = TextEditingController();
//
//   final list=["PO","Rental WorkOrder","Transfer","Cancel","Pending"];
//   // final list=["PO","Cash PO","Rental WorkOrder","Petty Cash","Transfer","Cancel","Pending"];
//   MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 color: Theme.of(context).primaryColor,
//                 child: Center(child: Text("Approval Type",style: TextStyle(color: Colors.white),)),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                 height: BaseUtitiles.getheightofPercentage(context,30),
//                 child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: ()  async {
//                           int i=0;
//                           mrnPreApprovalController.mrnPreAppDetList.forEach((element) async {
//                             mrnPreApprovalController.itemlist_textControllersInitiate();
//                             if(element.reqMasDetId==widget.data){
//                               if(index==0){
//                                 mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//
//                               }
//                               // else  if(index==1){
//                               //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//                               //
//                               //
//                               // }
//                               else  if(index==1){
//                                 mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//
//
//                               }
//                               // else  if(index==3){
//                               //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//                               //
//                               // }
//                               else  if(index==2){
//                                 mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//
//
//                               }
//                               else  if(index==3){
//                                 mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//
//
//                               }
//                               else  if(index==4){
//                                 mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//
//                               }
//                             }
//                             i++;
//                           });
//                           await mrnPreApprovalController.Approval_updateConsumTables();
//                           Navigator.pop(context);
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                     width: BaseUtitiles.getWidthtofPercentage(context, 60),
//                                     child: Text(list[index].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
//                                 Divider(
//                                   color: Theme.of(context).primaryColorLight,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//   // MRNPreAppDet_bottomSheet(){
//   //   showModalBottomSheet(context: context,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
//   //     builder: (BuildContext context) {
//   //       return Column(
//   //         children: [
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Container(
//   //                 width: BaseUtitiles.getWidthtofPercentage(context, 50),
//   //                 margin: EdgeInsets.only(top: 10, left: 15),
//   //                 child: TextField(
//   //                   controller: searchcontroller,
//   //                   decoration: InputDecoration(
//   //                     filled: true,
//   //                     border: OutlineInputBorder(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       borderSide: BorderSide.none,
//   //                     ),
//   //                     prefixIcon: const Icon(Icons.search,
//   //                       color: Colors.black,
//   //                     ),
//   //                     hintText: "search..",
//   //                     hintStyle: TextStyle(color: Colors.black),
//   //                     isDense: true,
//   //                     fillColor: Setmybackground,
//   //                   ),
//   //                   onEditingComplete: () {
//   //                     FocusScope.of(context).unfocus();
//   //                     // if (onSearch != null) onSearch!(searchcontroller.text);
//   //                   },
//   //                   textInputAction: TextInputAction.search,
//   //                   onChanged: (value)  {
//   //                     // list=list;
//   //                   },
//   //                 ),
//   //               ),
//   //               SizedBox(width: 20),
//   //               Container(
//   //                 width: BaseUtitiles.getWidthtofPercentage(context, 25),
//   //                 alignment: Alignment.center,
//   //                 decoration: BoxDecoration(
//   //                   border: Border.all(width: 2, color: Theme.of(context).primaryColor),
//   //                   borderRadius: BorderRadius.circular(12),
//   //                 ),
//   //                 child: Padding(
//   //                   padding: EdgeInsets.all(3),
//   //                   child: Text("Transfer From Projects", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
//   //                 ),
//   //               ),
//   //               InkWell(
//   //                   onTap: (){
//   //                     Navigator.pop(context);
//   //                     searchcontroller.text = "";
//   //                   },
//   //                   child: Container(
//   //                       margin: EdgeInsets.only(right: 10),
//   //                       child: Icon(Icons.expand_circle_down, color: Theme.of(context).primaryColor))),
//   //             ],
//   //           ),
//   //           Divider(),
//   //           Expanded(
//   //             child:  ListView.builder(
//   //                 itemCount: list.length,
//   //                 itemBuilder: (BuildContext context, int index) {
//   //                   return InkWell(
//   //                     onTap: ()  {
//   //                       int i=0;
//   //                       pendingListController.mrnPreAppDetList.forEach((element) {
//   //                         mrnPreApprovalController.itemlist_textControllersInitiate();
//   //                         if(element.reqMasDetId==widget.data){
//   //                           if(index==0){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //                           }
//   //                           else  if(index==1){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //
//   //                           }
//   //                           else  if(index==2){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //
//   //                           }else  if(index==3){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //                           }
//   //                           else  if(index==4){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //
//   //                           }
//   //                           else  if(index==5){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //
//   //                           }
//   //                           else  if(index==6){
//   //                             mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[index];
//   //
//   //                           }
//   //                         }
//   //                         i++;
//   //                       });
//   //
//   //                       Navigator.pop(context);
//   //                     },
//   //                     child: Column(
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       children: <Widget>[
//   //                         Column(
//   //                           mainAxisAlignment:
//   //                           MainAxisAlignment.center,
//   //                           children: <Widget>[
//   //                             Container(
//   //                                 width: BaseUtitiles.getWidthtofPercentage(context, 60),
//   //                                 child: Text(list[index].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
//   //                             Divider(
//   //                               color: Theme.of(context).primaryColorLight,
//   //                             )
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }),
//   //
//   //             // ListView.builder(
//   //             //   padding: EdgeInsets.zero,
//   //             //   physics: BouncingScrollPhysics(),
//   //             //   itemCount: list.length,
//   //             //   itemBuilder: (BuildContext context, int index) {
//   //             //     return Column(
//   //             //       children: [
//   //             //         InkWell(
//   //             //           child: Container(
//   //             //             margin: EdgeInsets.only(left: 10),
//   //             //             alignment: Alignment.center,
//   //             //             child: Text(list[index].project.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE,fontWeight: FontWeight.bold),),
//   //             //           ),
//   //             //           onTap: () async {
//   //             //             projectcontroller.projectname.text = list[index].project.toString();
//   //             //             projectcontroller.selectedProjectId.value = list[index].projectId;
//   //             //             await siteController.subcontEntry_siteDropdowntList(context, 0);
//   //             //             await fromsiteController.getsiteDropdowntList(context,0);
//   //             //             await subcontractorController.getSubcontList(context, projectcontroller.selectedProjectId.value);
//   //             //             await transferBt_Site_Controller.from_siteDropdowntList(context);
//   //             //             searchcontroller.text = "";
//   //             //             siteController.Sitename.text = "--Select--";
//   //             //             Navigator.pop(context);
//   //             //           },
//   //             //         ),
//   //             //         Divider(),
//   //             //       ],
//   //             //     );
//   //             //   }, ),
//   //           )
//   //         ],
//   //       );
//   //     },);
//   // }
//
// }
//
