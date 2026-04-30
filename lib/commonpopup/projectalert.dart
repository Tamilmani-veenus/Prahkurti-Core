//
// import '../controller/boqrevised_controller.dart';
// import '../controller/cashbook_site_controller.dart';
// import '../controller/consumption_controller.dart';
// import '../controller/dailyentries_controller.dart';
// import '../controller/dailywrk_done_dpr_controller.dart';
// import '../controller/projectcontroller.dart';
// import '../controller/sitecontroller.dart';
// import '../controller/sitevoucher_controller.dart';
// import '../controller/stocksite_controller.dart';
// import '../controller/subcontcontroller.dart';
// import '../controller/transferbw_site_controller.dart';
// import '../utilities/baseutitiles.dart';
// import '../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProjectShowPopup extends StatefulWidget {
//   const ProjectShowPopup({Key? key, required this.list}) : super(key: key);
//   final List list;
//
//   @override
//   State<ProjectShowPopup> createState() => _ProjectShowPopupState();
// }
//
// class _ProjectShowPopupState extends State<ProjectShowPopup> {
//   TextEditingController editingController = TextEditingController();
//   final ProjectController projectController=Get.put(ProjectController());
//   final SiteController siteController=Get.put(SiteController());
//   final SubcontractorController subcontractorController=Get.put(SubcontractorController());
//   DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
//   final TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());
//   Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
//   DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
//   Consumption_Controller consumption_controller=Get.put(Consumption_Controller());
//   SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
//   CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());
//   StockSiteController stockSiteController=Get.put(StockSiteController());
//
//   var id=0;
//   @override
//   void initState() {
//     projectController.mainlist.value.clear();
//     projectController.mainlist.value=widget.list;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: SingleChildScrollView(
//         child: Container(
//           //height: BaseUtitiles.getheightofPercentage(context, 60),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       projectController.mainlist.value=BaseUtitiles.projectPopupAlert(value,widget.list);
//                     });
//                   },
//                   controller: editingController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText: "Search",
//                       labelStyle: TextStyle(
//                           fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
//                       prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                 height: BaseUtitiles.getheightofPercentage(context, 55),
//                 child: ListView.builder(
//                   itemCount: projectController.mainlist.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: ()async{
//                         if(projectController.selectedProjectId!=0){
//                           await showDialog(
//                             context: context,
//                             builder: (BuildContext context)  {
//                               return AlertDialog(
//                                 title: Text('Alert'),
//                                 content: Text('Do you want change the Project?'),
//                                 actions: [
//                                   ElevatedButton(
//                                     // textColor: Colors.black,
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text('No'),
//                                   ),
//                                   ElevatedButton(
//                                     // textColor: Colors.black,
//                                     onPressed: () async {
//                                       id=1;
//                                       boq_revised_controller.Boqitem_itemview_GetDbList.value.clear();
//                                       boq_revised_controller.delete_BoqRevised_itemlist_Table();
//                                       consumption_controller.Consum_itemview_GetDbList.value.clear();
//                                       consumption_controller.delete_Consum_itemlist_Table();
//                                       siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value.clear();
//                                       siteVoucher_Controller.delete_Sitevoucher_itemlist_Table();
//                                       stockSiteController.projectShowList.clear();
//                                       siteController.setSelectedMRNListName(0);
//                                       siteController.Sitename.text="--Select--";
//                                       siteController.selectedsiteId.value=0;
//                                       transferBt_Site_Controller.setSelectedMRNListName(0);
//                                       subcontractorController.setSelectedsubcontListName(0);
//                                       dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
//                                       projectController.setSelectedProjectID(projectController.mainlist.value[index].project!);
//                                       siteController.mrnListValue.value.clear();
//                                       Navigator.pop(context);
//                                       FocusScope.of(context).unfocus();
//                                     },
//                                     child: Text('Yes'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//
//                           if(id==1){
//                             dailyEntriesController.deleteSubcontDetTableDatas();
//                             dailyEntriesController.readListdata.clear();
//                             Navigator.pop(context);
//                           }
//                           else{
//                             Navigator.pop(context);
//                           }
//
//                         }
//                         else{
//                           projectController.setSelectedProjectID(projectController.mainlist.value[index].project!);
//                           projectController.setSelectedProjectIDAll(projectController.mainlist.value[index].project!);
//                           siteController.mrnListValue.value.clear();
//                           Navigator.pop(context);
//
//                         }
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   width:
//                                   BaseUtitiles.getWidthtofPercentage(
//                                       context, 60),
//                                   child: Text(projectController.mainlist.value[index].project
//                                       .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
//                               Divider(
//                                 color: Theme.of(context).primaryColorLight,
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
