import 'package:flutter/material.dart';

import 'daily_wrkdone_dprlabour_entrylistscreen.dart';
import 'daily_wrkdone_dprlabour_entryscreen.dart';
import 'daily_wrkdone_dprlabour_itemlistscreen.dart';

class DailyWrk_Done_DPR_Labour extends StatefulWidget {
  int selectedPage;

  DailyWrk_Done_DPR_Labour(this.selectedPage);

  @override
  State<DailyWrk_Done_DPR_Labour> createState() => _DailyWrk_Done_DPR_LabourState();
}

class _DailyWrk_Done_DPR_LabourState extends State<DailyWrk_Done_DPR_Labour> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Daily Work Done DPR(Labour)'),
          bottom: TabBar(
           // labelStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Entry'),
              Tab(text: 'ItemList'),
              Tab(text: 'Entry List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DailyWork_done_DPRLabour_EntryScreen(),
            DailyWork_done_DPRLabour_ItemListScreen(),
            DailyWork_done_DPRLabour_EntryListScreen(),
          ],
        ),
      ),
    );
  }
}
