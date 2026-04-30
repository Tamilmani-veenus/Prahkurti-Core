//
// import 'package:flutter/material.dart';
// import '../../../../home/menu/daily_entries/pre_approval/preapproval_entrylist.dart';
// import '../../../../home/menu/daily_entries/pre_approval/preapproval_entryscreen.dart';
//
// class PreapprovalMain extends StatefulWidget {
//   int selectedPage;
//
//   PreapprovalMain(this.selectedPage);
//
//   @override
//   State<PreapprovalMain> createState() => _PreapprovalMainState();
// }
//
// class _PreapprovalMainState extends State<PreapprovalMain> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: widget.selectedPage,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: const Text('Pre Approval'),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//               Tab(text: 'Entry'),
//               Tab(text: 'Entry List'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Preapproval_EntryScreen(),
//             Preapproval_EntryList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
