// import '../controller/commonvoucher_controller.dart';
//
// import '../controller/sitecontroller.dart';
// import '../utilities/baseutitiles.dart';
// import '../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
//
// class SitewisepaymentTypeAlert extends StatefulWidget {
//   final String from;
//   const SitewisepaymentTypeAlert({Key? key,required this.from}) : super(key: key);
//
//   @override
//   State<SitewisepaymentTypeAlert> createState() => _SitewisepaymentTypeAlertState();
// }
//
// class _SitewisepaymentTypeAlertState extends State<SitewisepaymentTypeAlert> {
//
//   SiteController siteController=Get.put(SiteController());
//   CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
//
//   List<String> list = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     list = widget.from == "Advance req voucher"
//         ? ["Advance"]
//         : ["Advance", "Payment"];
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
//           child: Column(
//             children: <Widget>[
//
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 color: Theme.of(context).primaryColor,
//                 child: Center(child: Text("Payment Type",style: TextStyle(color: Colors.white),)),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                 height: BaseUtitiles.getheightofPercentage(context,10),
//                 child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: ()  {
//                           if(index==0){
//                             commonVoucherController.detVoucherTypeController.text="Advance";
//                             commonVoucherController.detVocType="A";
//                           }
//                           else{
//                             commonVoucherController.detVoucherTypeController.text="Payment";
//                             commonVoucherController.detVocType="P";
//                           }
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
//                                     width:
//                                     BaseUtitiles.getWidthtofPercentage(
//                                         context, 60),
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
