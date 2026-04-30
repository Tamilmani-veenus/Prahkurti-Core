// import 'package:get/get.dart';
//
// import '../../../../controller/comman_controller.dart';
// import '../../../../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entrylist.dart';
// import '../../../../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_itemlist.dart';
// import 'package:flutter/material.dart';
//
// import 'daily_wrkdone_dpr_entry.dart';
//
//
// class DailyWrk_Done_DPR extends StatefulWidget {
//   int selectedPage;
//
//   DailyWrk_Done_DPR(this.selectedPage);
//
//   @override
//   State<DailyWrk_Done_DPR> createState() =>
//       _DailyWrk_Done_DPRState();
// }
//
// class _DailyWrk_Done_DPRState
//     extends State<DailyWrk_Done_DPR>
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
//           title: const Text('Daily Work Done DPR'),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(text: 'Entry'),
//               Tab(text: 'Item List'),
//               Tab(text: 'Entry List'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             DailyWork_done_DPR_Entry(),
//             DailyWork_done_DPR_ItemList(),
//             DailyWork_done_DPR_EntryList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
