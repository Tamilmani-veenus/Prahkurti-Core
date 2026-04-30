//
// import '../../../../controller/commonvoucher_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../controller/sitevoucher_controller.dart';
// import '../../../../utilities/baseutitiles.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../../../commonpopup/sitewisepaymet_alert.dart';
// import '../../../../utilities/requestconstant.dart';
//
//
//
//
// class Site_Voucher_Itemlist extends StatefulWidget {
//   const Site_Voucher_Itemlist({Key? key}) : super(key: key);
//
//   @override
//   State<Site_Voucher_Itemlist> createState() => _Subcont_Nmr_EntryScreenState_Site();
// }
//
// class _Subcont_Nmr_EntryScreenState_Site extends State<Site_Voucher_Itemlist> {
//
// SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
// ProjectController projectController=Get.put(ProjectController());
// CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());
//
//
//
//   @override
//   void initState(){
//
//     siteVoucher_Controller.itemcheck=1;
//
//
//
//     super.initState();
//   }
//
//
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
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10,bottom: 10),
//                 child:ElevatedButton(
//
//                   child: Text('ADD ITEM'),
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return SitewisePaymentAlert();
//                         });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     side: BorderSide(width: 3, color: Colors.black),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//
//                 ),
//               ),
//
//               Obx(()=>Container(
//                 child: Visibility(
//                     visible: siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value.isEmpty?false:true,
//                     child: ListDetails()),
//               )),
//               Obx(() => Container(
//                 child: Visibility(
//                   visible: siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value.isEmpty?false:true,
//                   child: Container(
//                     margin: EdgeInsets.only(top: 10,bottom: 10),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     width: BaseUtitiles.getWidthtofPercentage(context, 24),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: Theme.of(context).primaryColor,
//                         side: BorderSide(width: 3, color: Colors.black),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                       ),
//                       onPressed: () async {
//                         if(projectController.selectedProjectId.value==0 ||commonVoucherController.AccountTypename.text == "--Select--"||commonVoucherController.Accountname.text=="--Select--"||commonVoucherController.Paymodename.text=="--Select--"||commonVoucherController.AccPayforname.text=="--Select--"||double.parse(siteVoucher_Controller.Amount.text)==0.0){
//                           BaseUtitiles.showToast("Some field is missing");
//                         }
//                         else{
//                           siteVoucher_Controller.SaveButtonSitevoucher_ItemlistScreen(context,siteVoucher_Controller.VocID!=0?siteVoucher_Controller.VocID:0);
//                         }
//
//                       },
//                       child: Text( siteVoucher_Controller.SaveButton.value),
//                     ),
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
// Widget ListDetails() {
//   return Container(
//     margin: EdgeInsets.all(10),
//     height: BaseUtitiles.getheightofPercentage(context, 60),
//     child: Container(
//       height: BaseUtitiles.getheightofPercentage(context, 55),
//       child: ListView.builder(
//         itemCount: siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
//             height: BaseUtitiles.getheightofPercentage(context,18),
//             color: Colors.blueGrey.shade800,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(left: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children:<Widget> [
//                       Text(
//                         siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].sitename.toString(),
//                         //textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize:
//                             RequestConstant.App_Font_SIZE,
//                             color: Colors.yellow),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 5),
//                         height: BaseUtitiles.getheightofPercentage(context,2),
//                        // width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                         child: InkWell(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) =>
//                                   AlertDialog(
//                                     backgroundColor: Theme.of(context).primaryColorLight,
//                                     title: Text(RequestConstant.DO_YOU_WANT_DELETE,style: TextStyle(color: Colors.black),),
//                                     actions: <Widget>[
//                                       ElevatedButton(
//                                           child: Text(RequestConstant.NO,style: TextStyle(color: Colors.black)),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           }
//                                       ),
//                                       ElevatedButton(
//                                           child: Text(RequestConstant.YES,style: TextStyle(color: Colors.black)),
//                                           onPressed : () {
//                                             setState(() {
//                                               siteVoucher_Controller.deleteParticularList(siteVoucher_Controller.Sitevoucher_itemview_GetDbList[index]);
//                                               siteVoucher_Controller.Sitevoucher_itemview_GetDbList.remove(siteVoucher_Controller.Sitevoucher_itemview_GetDbList[index]);
//                                               siteVoucher_Controller.getsitevoucherTablesDatas();
//                                               Navigator.pop(context);
//                                             });
//
//                                           }
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           },
//                           child: Image.asset('assets/cancle.png'),
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top:20),
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.only(left: 5),
//                           child: Text(
//                             "Site Name",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           margin: EdgeInsets.only(right: 5),
//                           child: Text(
//                             siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].sitename.toString(),
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.red),
//                           )),
//
//
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top:10),
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.only(left: 5),
//                           child: Text(
//                             "Payment Type",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           margin: EdgeInsets.only(right: 5),
//                           child: Text(
//                             siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].paytype=="A"?"Advance":"Payment",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.red),
//                           )),
//
//
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top:10),
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.only(left: 5),
//                           child: Text(
//                             "Amount",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           margin: EdgeInsets.only(right: 5),
//                           child: Text(
//                             siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].amt.toString(),
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.red),
//                           )),
//
//
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top:10),
//                   child: Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.only(left: 5),
//                           child: Text(
//                             "Net Amount",
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.white),
//                           )),
//                       Container(
//                           margin: EdgeInsets.only(right: 5),
//                           child: Text(
//                             siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].NetAmt.toString(),
//                             style: TextStyle(
//                                 fontSize:
//                                 RequestConstant.App_Font_SIZE,
//                                 color: Colors.red),
//                           )),
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
//
//
//
//
//
//
// }
