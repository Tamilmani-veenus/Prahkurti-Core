// import '../../../../home/requistionslip/requisitionslipentry.dart';
// import '../../../../home/requistionslip/requisitionslipentrylist.dart';
// import 'package:flutter/material.dart';
//
//
//
// class requistion_Activity extends StatefulWidget {
//   int selectedPage;
//
//   requistion_Activity(this.selectedPage);
//
//   @override
//   State<requistion_Activity> createState() =>
//       _requistion_ActivityState();
// }
//
// class _requistion_ActivityState
//     extends State<requistion_Activity>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: widget.selectedPage,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: const Text('Requisition Slip'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Entry'),
//               Tab(text: 'Entry List')
//             ],
//           ),
//         ),
//         body: TabBarView(
//
//           children: [
//             RequisitionSlip_EntryScreen(),
//             RequisitionSlipEntryListScreen(),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
