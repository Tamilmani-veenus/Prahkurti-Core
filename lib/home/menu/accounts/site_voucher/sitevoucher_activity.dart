//
// import 'package:get/get.dart';
//
// import '../../../../controller/comman_controller.dart';
// import '../../../../home/menu/accounts/site_voucher/site_voucher_entry.dart';
// import '../../../../home/menu/accounts/site_voucher/site_voucher_entrylist.dart';
// import '../../../../home/menu/accounts/site_voucher/site_voucher_itemlist.dart';
// import 'package:flutter/material.dart';
//
//
//
// class Site_Voucher_Activity extends StatefulWidget {
//   int selectedPage;
//
//   Site_Voucher_Activity(this.selectedPage);
//
//   @override
//   State<Site_Voucher_Activity> createState() =>
//       _Site_Voucher_ActivityState();
// }
//
// class _Site_Voucher_ActivityState
//     extends State<Site_Voucher_Activity>
//     with SingleTickerProviderStateMixin {
//   CommanController commanController=Get.put(CommanController());
//
//   @override
//   void initState() {
//     var duration = Duration(seconds: 0);
//     Future.delayed(duration,() async {
//      // await commanController.getControllEntryListRights();
//     });
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: widget.selectedPage,
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: const Text('Site Voucher'),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(text: 'Entry'),
//               Tab(text: 'Item List'),
//               Tab(text: 'Entry List')
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Site_Voucher_EntryScreen(),
//             Site_Voucher_Itemlist(),
//             Site_Voucher_EntryListScreen(),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
