// import '../../../../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_deduction_site.dart';
// import '../../../../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entry_site.dart';
// import '../../../../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
// import 'package:flutter/material.dart';
//
// class SubCont_NMR_WeeklyBillGeneration_Site extends StatefulWidget {
//   int selectedPage;
//
//   SubCont_NMR_WeeklyBillGeneration_Site(this.selectedPage);
//
//   @override
//   State<SubCont_NMR_WeeklyBillGeneration_Site> createState() =>
//       _SubCont_NMR_WeeklyBillGenerationState_Site();
// }
//
// class _SubCont_NMR_WeeklyBillGenerationState_Site
//     extends State<SubCont_NMR_WeeklyBillGeneration_Site>
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
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: const Text('NMR Wkly Bill - Generation'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Entry'),
//               Tab(text: 'Deduction'),
//               Tab(text: 'Entry List'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Subcont_Nmr_EntryScreen_Site(),
//             Subcont_NMR_Deduction_Site(),
//             Subcont_NMR_EntryListScreen_Site(),
//           ],
//         ),
//       ),
//     );
//   }
// }
