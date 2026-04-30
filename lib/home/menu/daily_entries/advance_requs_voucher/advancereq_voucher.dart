
import 'package:flutter/material.dart';

import 'advance_req_entry.dart';
import 'advance_req_entrylist.dart';
import 'advance_req_itemlist.dart';

class Advance_Req_Voucher extends StatefulWidget {
  int selectedPage;

  Advance_Req_Voucher(this.selectedPage);

  @override
  State<Advance_Req_Voucher> createState() =>
      _Advance_Req_VoucherState();
}

class _Advance_Req_VoucherState
    extends State<Advance_Req_Voucher>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Advance Requisition Voucher'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Entry'),
              Tab(text: 'Item List'),
              Tab(text: 'Entry List')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Advance_Req_Voucher_EntryScreen(),
            Advance_Req_Voucher_Itemlist(),
            Advance_req_EntryListScreen(),

          ],
        ),
      ),
    );
  }
}
