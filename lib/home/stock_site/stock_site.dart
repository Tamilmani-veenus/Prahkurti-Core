import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../home/stock_site/projectwise.dart';
import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/reports_controller.dart';
import '../../controller/stocksite_controller.dart';
import 'materialwise.dart';

// class StockSite extends StatefulWidget {
//   const StockSite({Key? key}) : super(key: key);
//
//   @override
//   State<StockSite> createState() => _StockSiteState();
// }
//
//
// class _StockSiteState extends State<StockSite> {
//   late TabController _tabController;
//   StockSiteController stockSiteController = Get.put(StockSiteController());
//
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging) {
//         stockSiteController.getStockList.value=[];
//       }
//     });
//     super.initState();
//   }

// class _StockSiteState extends State<StockSite>
//     with SingleTickerProviderStateMixin {
//
//   late TabController _tabController;
//   StockSiteController stockSiteController = Get.put(StockSiteController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(length: 2, vsync: this);
//
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging) {
//         stockSiteController.getStockList.value = [];
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           appBar: AppBar(
//             iconTheme: const IconThemeData(color: Colors.black,),
//             backgroundColor: Setmybackground,
//             title: const Text('Stock at Site', style: TextStyle(color: Colors.black),),
//             bottom: const TabBar(
//               labelColor: Colors.black,
//                 indicatorColor: Colors.black,
//               tabs: [
//                 Tab(icon: Icon(Icons.account_tree_sharp, color: Colors.indigo), text: 'ProjectWise'),
//                 Tab(icon: Icon(Icons.api_sharp, color: Colors.indigo), text: 'MaterialWise')
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [PrjectWise(), MaterialWise()],
//           ),
//         ),
//       ),
//     );
//   }
// }

class StockSite extends StatefulWidget {
  final String heading;
  const StockSite({Key? key,required this.heading}) : super(key: key);

  @override
  State<StockSite> createState() => _StockSiteState();
}

class _StockSiteState extends State<StockSite>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final StockSiteController stockSiteController =
  Get.put(StockSiteController());
  ReportsController reportsController = Get.put(ReportsController());


  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        stockSiteController.getStockList.value = [];
        reportsController.Subheadername.text="--ALL--";
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Setmybackground,
          title:  Row(
            children: [
              Expanded(
                child: Text(
                  widget.heading,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.account_tree_sharp,
                  color: Colors.indigo,
                ),
                text: 'ProjectWise',
              ),
              Tab(
                icon: Icon(
                  Icons.api_sharp,
                  color: Colors.indigo,
                ),
                text: 'MaterialWise',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            PrjectWise(),
            MaterialWise(),
          ],
        ),
      ),
    );
  }
}
