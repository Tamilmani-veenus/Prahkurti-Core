import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/comman_controller.dart';
import 'daily_wrkdone_dpr_entrylistnew.dart';
import 'daily_wrkdone_dpr_entrynew.dart';
import 'daily_wrkdone_dpr_labour.dart';
import 'daily_wrkdone_dpr_material.dart';
import 'dailywrkdone_dpr_measurement.dart';


class DailyWrk_Done_DPR_New extends StatefulWidget {
  int selectedPage;

  DailyWrk_Done_DPR_New(this.selectedPage);

  @override
  State<DailyWrk_Done_DPR_New> createState() =>
      _DailyWrk_Done_New_DPRState();
}

class _DailyWrk_Done_New_DPRState
    extends State<DailyWrk_Done_DPR_New>
    with SingleTickerProviderStateMixin {

  CommanController commanController=Get.put(CommanController());
  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration,() async {
     // await commanController.getControllEntryListRights();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Daily Work Done DPR(New)'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Entry'),
              Tab(text: 'Labour'),
              Tab(text: 'Material'),
              Tab(text: 'Measurement'),
              Tab(text: 'List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DailyWork_done_DPR_Entry_New(),
            DailyWork_done_DPR_Labour(),
            DailyWork_done_DPR_Material(),
            DailyWork_done_DPR_Measurement(),
            DailyWork_done_DPR_EntryListNew(),
          ],
        ),
      ),
    );
  }
}
