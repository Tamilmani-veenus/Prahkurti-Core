import '../../../../home/stock_site/projectwise.dart';
import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import 'materialwise.dart';

class StockSite extends StatefulWidget {
  const StockSite({Key? key}) : super(key: key);

  @override
  State<StockSite> createState() => _StockSiteState();
}


class _StockSiteState extends State<StockSite> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black,),
            backgroundColor: Setmybackground,
            title: const Text('Stock at Site', style: TextStyle(color: Colors.black),),
            bottom: const TabBar(
              labelColor: Colors.black,
                indicatorColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.account_tree_sharp, color: Colors.indigo), text: 'ProjectWise'),
                Tab(icon: Icon(Icons.api_sharp, color: Colors.indigo), text: 'MaterialWise')
              ],
            ),
          ),
          body: const TabBarView(
            children: [PrjectWise(), MaterialWise()],
          ),
        ),
      ),
    );
  }
}
