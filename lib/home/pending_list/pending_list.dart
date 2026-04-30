// import '../../../../controller/logincontroller.dart';
// import '../../../../controller/pendinglistcontroller.dart';
// import '../../../../models/pendinglist_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../utilities/baseutitiles.dart';
//
// class PendingList extends StatefulWidget {
//   const PendingList({Key? key}) : super(key: key);
//
//   @override
//   State<PendingList> createState() => _PendingListState();
// }
//
// class _PendingListState extends State<PendingList> {
//   LoginController loginController = Get.find();
//   PendingListController pendingListController = Get.put(PendingListController());
//   List<GetPendingListResponse> list = [];
//
//   @override
//   void initState() {
//     pendingListController.getPendingList();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PendingList"),
//         actions: <Widget>[
//           IconButton(
//               icon: new Icon(Icons.arrow_drop_down_circle_outlined),
//               onPressed: () {}),
//         ],
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Obx(() => Column(
//         children: <Widget>[
//           Container(
//               height:BaseUtitiles.getheightofPercentage(context,50),
//               child: ListDetails()),
//         ],
//       )),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       margin: EdgeInsets.only(top: 13),
//       child: RefreshIndicator(
//         onRefresh: () async {
//           pendingListController.getPendingList();
//         },
//         child: Container(
//           height: BaseUtitiles.getheightofPercentage(context, 100),
//           child: Obx(()=> ListView.builder(
//               itemCount: pendingListController.pendingList_datas.value.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () async {
//                     // if(loginController.openCheckPendinglist==1){
//                     if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
//                     pendingListController.getSubcontractor_ExpensesList(
//                         pendingListController.pendingList_datas.value[index].entrytype!,
//                         context);
//                     }
//                   },
//                   child: Card(
//                     shadowColor: Colors.red,
//                     child: ListTile(
//                       title: Text(pendingListController.pendingList_datas.value[index].entrytype!),
//                       trailing: Text("(" + pendingListController.pendingList_datas.value[index].count.toString() + ")",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ),
//                 );
//               }),),
//         ),
//       ),
//     );
//   }
// }
