import 'package:flutter/material.dart';

import 'company_nmr_entrylist.dart';
import 'company_nmr_entryscreen.dart';

class CompanyNmrMain extends StatefulWidget {
  int selectedPage;

  CompanyNmrMain(this.selectedPage);

  @override
  State<CompanyNmrMain> createState() => _CompanyNmrMainState();
}

class _CompanyNmrMainState extends State<CompanyNmrMain> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Company NMR Attendance'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Entry'),
              Tab(text: 'Entry List')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Company_nmr_entryscreen(),
            Company_nmr_entrylist(),
          ],
        ),
      ),
    );

  }
}
