// import '../../../../controller/dailywrk_done_dpr_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../controller/sitecontroller.dart';
// import '../../../../controller/subcontcontroller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'addwrk_click_popup.dart';
//
// class DailyWork_done_DPR_ItemList extends StatefulWidget {
//   DailyWork_done_DPR_ItemList({Key? key}) : super(key: key);
//
//   @override
//   State<DailyWork_done_DPR_ItemList> createState() => _DailyWork_done_DPR_ItemListState();
// }
//
// class _DailyWork_done_DPR_ItemListState extends State<DailyWork_done_DPR_ItemList> {
//   DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
//   ProjectController projectController=Get.put(ProjectController());
//   SiteController siteController=Get.put(SiteController());
//   SubcontractorController subcontractorController=Get.put(SubcontractorController());
//
//   @override
//   void initState() {
//     dailyWrkDone_DPR_Controller.entrycheck=1;
//     // dailyWrkDone_DPR_Controller.dpr_getItemList(projectController.selectedProjectId.value,siteController.selectedsiteId.value,dailyWrkDone_DPR_Controller.TypeSubcontId.value,dailyWrkDone_DPR_Controller.entryType);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 15),
//               height: BaseUtitiles.getheightofPercentage(context, 4),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).primaryColor,
//                   //background color of button
//                   side: BorderSide(width: 3, color: Colors.black),
//                   //border width and color
//                   elevation: 3,
//                   //elevation of button
//                   shape: RoundedRectangleBorder(
//                     //to set border radius to button
//                       borderRadius: BorderRadius.circular(30)),),
//                 child: Text("Add Work"),
//                 onPressed: () {
//                   if(projectController.selectedProjectId.value == 0 || siteController.selectedsiteId.value == 0 || dailyWrkDone_DPR_Controller.TypeSubcontId.value == 0){
//                     BaseUtitiles.showToast("No Record Found!");
//                   }
//                   else{
//                     dailyWrkDone_DPR_Controller.dpr_getItemList(projectController.selectedProjectId.value,siteController.selectedsiteId.value,dailyWrkDone_DPR_Controller.TypeSubcontId.value,dailyWrkDone_DPR_Controller.entryType,context);
//                   }
//                 },
//               ),
//             ),
//             Obx(()=>Container(
//               child: Visibility(
//                   visible:
//                   true,
//                   child: ListDetails()),
//             )),
//
//             Obx(() => Container(
//               child: Visibility(
//                 visible:dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.isEmpty?false:true,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10),
//                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       side: BorderSide(width: 3, color: Colors.black),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     onPressed: () async {
//                       //save & Update & Aproval
//                       if(projectController.selectedProjectId.value == 0 || siteController.selectedsiteId.value == 0 ||dailyWrkDone_DPR_Controller.TypeSubcontId.value == 0){
//                         BaseUtitiles.showToast("Some field is missing for entry screen");
//                       }
//                       else{
//                         BaseUtitiles.showLoadingDialog(context,Colors.cyan);
//                         await dailyWrkDone_DPR_Controller.getDprTablesDatas();
//                         dailyWrkDone_DPR_Controller.SaveButton_EntryScreen_Save(context,dailyWrkDone_DPR_Controller.workId);
//                       }
//
//                     },
//                     child: Text( dailyWrkDone_DPR_Controller.saveButton.value),
//                   ),
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       height: BaseUtitiles.getheightofPercentage(context, 65),
//       child: ListView.builder(
//         itemCount: dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.length,
//         itemBuilder: (BuildContext context, int index) {
//           dailyWrkDone_DPR_Controller.dpr_itemlist_textControllersInitiate();
//           return Container(
//            // height: BaseUtitiles.getheightofPercentage(context,12),
//             margin: EdgeInsets.only(bottom:3),
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 9,
//                       child: Container(
//                           child: Text(
//                             dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index].itemDesc.toString()+" ("+dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index].unit.toString()+")",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.yellow),
//                           )),
//                     ),
//
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context,2),
//
//                         child: InkWell(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) =>
//                                   AlertDialog(
//                                     title: Text(RequestConstant.DO_YOU_WANT_DELETE),
//                                     actions: <Widget>[
//                                       ElevatedButton(
//                                           child: Text(RequestConstant.NO),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           }
//                                       ),
//                                       ElevatedButton(
//                                           child: Text(RequestConstant.YES),
//                                           onPressed: () async{
//                                            await dailyWrkDone_DPR_Controller.deleteParticularList(dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value[index]);
//                                             dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.removeAt(index);
//                                            await dailyWrkDone_DPR_Controller. getDprTablesDatas();
//                                             Navigator.pop(context);
//                                           }
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           },
//                           child: Image.asset('assets/cancle.png'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Container(
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Container(
//                           child: Text(
//                             "Rate",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           child: Text(
//                             "Cur.Qty",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           child: Text(
//                             "Amount",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(bottom: 3),
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         width: BaseUtitiles.getWidthtofPercentage(context,25),
//                         child: TextField(
//                           readOnly: true,
//                           textAlign: TextAlign.center,
//                           controller: dailyWrkDone_DPR_Controller.Itemlist_RateControllers[index],
//                           style: TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: BaseUtitiles.getheightofPercentage(context,4),
//                         width: BaseUtitiles.getWidthtofPercentage(context,25),
//                         child: TextField(
//                           cursorColor:Theme.of(context).primaryColor,
//                           textAlign: TextAlign.center,
//                           controller: dailyWrkDone_DPR_Controller.Itemlist_CurrentQtyControllers[index],
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                           ),
//                           style: TextStyle(color: Colors.white),
//                           onChanged: (value) {
//                             setState(() {
//                               dailyWrkDone_DPR_Controller.dprItemlist_clickEdit();
//                             });
//
//                           },
//                         ),
//                       ),
//                       Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         width: BaseUtitiles.getWidthtofPercentage(context,25),
//                         child: TextField(
//                          readOnly: true,
//                           textAlign: TextAlign.center,
//                           controller: dailyWrkDone_DPR_Controller.Itemlist_AmntControllers[index],
//                           style: TextStyle(color: Colors.white),
//
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                           ),
//                         ),),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
