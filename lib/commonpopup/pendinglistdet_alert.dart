

// import 'package:horizontal_data_table/horizontal_data_table.dart';
//
// import '../utilities/baseutitiles.dart';
// import 'package:flutter/material.dart';
//
//
//
// class PendingListDetPopup extends StatelessWidget {
//    PendingListDetPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content:
//
//       Container(
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,80),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Qty', BaseUtitiles.getWidthtofPercentage(context,20),context),
//       _getTitleItemWidget('Scale', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].qty.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].scale.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
//
// class PendingListMRnFinalPopup extends StatelessWidget {
//   PendingListMRnFinalPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,115),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Qty', BaseUtitiles.getWidthtofPercentage(context,20),context),
//       _getTitleItemWidget('Scale', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('PreAppType', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].qty.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].scale.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].preAppType.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
//
// class PendingListPOPopup extends StatelessWidget {
//   PendingListPOPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,120),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Qty', BaseUtitiles.getWidthtofPercentage(context,20),context),
//       _getTitleItemWidget('Scale', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Po Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Bal Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].qty.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].scale.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].poQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].balQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
//
// class PendingPOAprovalPopup extends StatelessWidget {
//   PendingPOAprovalPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,180),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Sacle', BaseUtitiles.getWidthtofPercentage(context,25),context),
//       _getTitleItemWidget('Po Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Po Rate', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Po Amt', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('GST Per', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('GST Amt', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('NetAmt', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].scale.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].poQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].PORate.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].PoAmt.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].GSTPer.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].GSTAmt.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].NetAmt.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
// class PendingInwardPopup extends StatelessWidget {
//   PendingInwardPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,120),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Sacle', BaseUtitiles.getWidthtofPercentage(context,25),context),
//       _getTitleItemWidget('Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('GRN Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Bal Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].scale.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].poQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].grnQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].balQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
// class TransferPendingPopup extends StatelessWidget {
//   TransferPendingPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,157),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Sacle', BaseUtitiles.getWidthtofPercentage(context,25),context),
//       _getTitleItemWidget('Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('TrnsQty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Bal Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('FrProjectName', BaseUtitiles.getWidthtofPercentage(context, 37),context),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context,35),context),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].scale.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].qty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].transQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].balQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].frProjectName.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,37),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].remarks.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,35),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }
//
// class TransferAckPopup extends StatelessWidget {
//   TransferAckPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
//   final List list;
//   final String ReqNo;
//
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,65),
//           isFixedHeader: true,
//           headerWidgets: _getTitleWidget(context),
//           leftSideItemBuilder: _generateFirstColumnRow,
//           rightSideItemBuilder: _generateRightHandSideColumnRow,
//           itemCount: list.length,
//           rowSeparatorWidget: const Divider(
//             color: Colors.black54,
//             height: 1.0,
//             thickness: 0.0,
//           ),
//           leftHandSideColBackgroundColor: Colors.white24,
//           rightHandSideColBackgroundColor: Colors.white24,
//           verticalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.yellow,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           horizontalScrollbarStyle: const ScrollbarStyle(
//             thumbColor: Colors.white24,
//             isAlwaysShown: true,
//             thickness: 4.0,
//             radius: Radius.circular(5.0),
//           ),
//           enablePullToRefresh: false,
//           refreshIndicator: const WaterDropHeader(),
//           refreshIndicatorHeight: 60,
//           onRefresh: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.refreshCompleted();
//           },
//           enablePullToLoadNewData: false,
//           loadIndicator: const ClassicFooter(),
//           onLoad: () async {
//             //Do sth
//             await Future.delayed(const Duration(milliseconds: 500));
//             _hdtRefreshController.loadComplete();
//           },
//           htdRefreshController: _hdtRefreshController,
//         ),
//         //    height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//
//         height:  BaseUtitiles.getheightofPercentage(context,15*list.length),
//         width:2000,
//       ),
//     );
//   }
//
//
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//
//       _getTitleItemWidget('Material', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Sacle', BaseUtitiles.getWidthtofPercentage(context,25),context),
//       _getTitleItemWidget('Trns Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//       _getTitleItemWidget('Ack Qty', BaseUtitiles.getWidthtofPercentage(context, 20),context),
//
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width,BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(list[index].materialName.toString()),
//
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(list[index].scale.toString())
//             ],
//           ),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].transQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(list[index].ackQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,20),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../controller/pendinglistcontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

//-------MRN Verification----------------
class PendingListDet_Popup extends StatefulWidget {
  const PendingListDet_Popup({Key? key, required this.list, required this.ReqNo, required this.ProjectName}) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<PendingListDet_Popup> createState() => _PendingListDet_PopupState();
}

class _PendingListDet_PopupState extends State<PendingListDet_Popup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "MRN Verification",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Material" + ":   ",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(pendingListController.onclickPendingListDet[index].materialName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            const Text("Req Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(pendingListController.onclickPendingListDet[index].qty.toString())),
                            const Expanded(
                                flex: 2,
                                child: Text("Scale:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(pendingListController.onclickPendingListDet[index].scaleName.toString())),
                          ],
                        ),

                        Divider(),
                        Row(
                          children: [
                            Text("Remarks" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(pendingListController.onclickPendingListDet[index].remarks.toString())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },),
    );
  }
}


//---------MRN Pre Approval-------------------
class PendingListDet_PreApproval extends StatefulWidget {
  const PendingListDet_PreApproval({Key? key, required this.heading, required this.list, required this.ReqNo, required this.ProjectName}) : super(key: key);
  final String heading;
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<PendingListDet_PreApproval> createState() => _PendingListDet_PreApprovalState();
}

class _PendingListDet_PreApprovalState extends State<PendingListDet_PreApproval> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading,
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),
            ],
          ),
        ));
  }
  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Material" + ":   ",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(pendingListController.onclickPendingListDet[index].qty.toString())),
                            Expanded(
                                flex: 2,
                                child: Text("Scale:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(pendingListController.onclickPendingListDet[index].ScaleName.toString())),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Req Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(pendingListController.onclickPendingListDet[index].ReqQty.toString())),
                            Expanded(child: Container())
                          ],
                        ),

                        Divider(),
                        Row(
                          children: [
                            Text("Remarks" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(pendingListController.onclickPendingListDet[index].remarks.toString())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },),
    );
  }
}




//---------MRN Final Approval----------------------

class PendingListDet_MRNFinalApproval_Popup extends StatefulWidget {
  const PendingListDet_MRNFinalApproval_Popup({Key? key, required this.list,required this.ReqNo,required this.ProjectName,  }) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<PendingListDet_MRNFinalApproval_Popup> createState() => _PendingListDet_MRNFinalApproval_PopupState();
}

class _PendingListDet_MRNFinalApproval_PopupState extends State<PendingListDet_MRNFinalApproval_Popup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "MRN Final Approval",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),

            ],
          ),
        ));
  }
  Widget ListDetails(BuildContext context){
    return
      Column(
        children: [
          Container(
            height: BaseUtitiles.getheightofPercentage(context, 90),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
              itemCount: pendingListController.onclickPendingListDet.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Material" + ":   ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(pendingListController.onclickPendingListDet[index].materialName.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text("Qty" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Text(pendingListController.onclickPendingListDet[index].qty.toString())),
                              Expanded(
                                  flex: 2,
                                  child: Text("Scale:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Text(pendingListController.onclickPendingListDet[index].scaleName.toString())),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Req Qty" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Text(pendingListController.onclickPendingListDet[index].reqQty.toString())),
                              Expanded(child: Container())
                            ],
                          ),

                          Divider(),
                          Row(
                            children: [
                              Text("Remarks" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(pendingListController.onclickPendingListDet[index].remarks.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },),
          ),
        ],
      );
  }
}

///-----------Direct Transfer Verify Approve-----------

class DirectTransVerifyApprovalDet extends StatefulWidget {
  const DirectTransVerifyApprovalDet({Key? key,required this.heading, required this.list,required this.ReqNo,required this.frProjectName,  }) : super(key: key);
  final String heading;
  final List list;
  final String ReqNo;
  final String frProjectName;

  @override
  State<DirectTransVerifyApprovalDet> createState() => _DirectTransVerifyApprovalDetState();
}

class _DirectTransVerifyApprovalDetState extends State<DirectTransVerifyApprovalDet> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.frProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),

            ],
          ),
        ));
  }
  Widget ListDetails(BuildContext context){
    return
      Column(
        children: [

          Container(
            height: BaseUtitiles.getheightofPercentage(context, 90),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
              itemCount: pendingListController.onclickPendingListDet.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Material" + ":   ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(pendingListController.onclickPendingListDet[index].materialName.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text("Scale:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Text(pendingListController.onclickPendingListDet[index].scaleName.toString())),
                              Expanded(
                                flex: 2,
                                child: Text("Qty" + ":  ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Text(pendingListController.onclickPendingListDet[index].qty.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },),
          ),
        ],
      );
  }
}




//-----------Pending po-------------
class PendingList_PoPopup extends StatefulWidget {
  const PendingList_PoPopup({Key? key, required this.list,required this.ReqNo, required this.ProjectName }) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<PendingList_PoPopup> createState() => _PendingList_PoPopupState();
}

class _PendingList_PoPopupState extends State<PendingList_PoPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pending Po",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 10, top:5 ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Material" + ":   ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text( pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].Qty.toString())),
                        Expanded(
                            flex: 2,
                            child: Text("Scale" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].ScaleName.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Po Qty" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].POQty.toString())),
                        Expanded(
                          flex: 2,
                          child: Text("Bal Qty" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].BalQty.toString())),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
}


///-------------PendingPo Approval------------

class PendingPo_Approvel_Popup extends StatefulWidget {
  const PendingPo_Approvel_Popup({Key? key, required this.heading, required this.list,required this.ReqNo}) : super(key: key);
  final String heading;
  final List list;
  final String ReqNo;

  @override
  State<PendingPo_Approvel_Popup> createState() => _PendingPo_Approvel_PopupState();
}

class _PendingPo_Approvel_PopupState extends State<PendingPo_Approvel_Popup> {

  PendingListController pendingListController = Get.put(PendingListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading.toString(),
                      // "Po Approval",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 10, top:5 ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Material" + ":   ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 3,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_circle_right_outlined, color: Theme.of(context).primaryColor,),
                                  Container(child: Text("    "),)
                                ],
                              ),
                              onTap: (){
                                pendingListController.poapprovalSupplierlist(context,
                                  pendingListController.onclickPendingListDet[index].materialId,
                                  pendingListController.onclickPendingListDet[index].materialName.toString(),
                                  pendingListController.onclickPendingListDet[index].scaleName.toString(),
                                );
                              },
                            ))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Po Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].Poqty.toString())),
                        Expanded(
                            flex: 2,
                            child: Text("Scale" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].scaleName.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Po Rate" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].rate.toString())),
                        Expanded(
                            flex: 2,
                            child: Text("Data Rate" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( "")),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [

                        Expanded(
                          flex: 2,
                          child: Text("Po Amt" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].amount.toString())),
                        Expanded(
                          flex: 2,
                          child: Text("GST Per:" ,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( " "+pendingListController.onclickPendingListDet[index].GSTPer.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("GST Amt:" + "   ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 6,
                            child: Text(" " + pendingListController.onclickPendingListDet[index].GSTAmt.toString())),

                        Expanded(
                          flex: 3,
                          child: Text("Net Amt" + ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 6,
                            child: Text( pendingListController.onclickPendingListDet[index].netAmount.toString()))
                      ],
                    ),

                    // Divider(),
                    // Row(
                    //   children: [
                    //     Text("Remarks" + ":  ",
                    //       style: TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //     Expanded(
                    //         flex: 2,
                    //         child: Text( pendingListController.onclickPendingListDet[index].remarks.toString())),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }

}


///------------WORK ORDER DET VERIFY AND APPROVAL--------------

class WorkOrderDet extends StatefulWidget {
  const WorkOrderDet({super.key, required this.heading, required this.list,required this.ReqNo, required this.WOType});
  final String heading;
  final List list;
  final String ReqNo;
  final String WOType;

  @override
  State<WorkOrderDet> createState() => _WorkOrderDetState();
}

class _WorkOrderDetState extends State<WorkOrderDet> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading.toString(),
                      // "Po Approval",
                      style: TextStyle(
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                child: Column(
                  children: [
                    if(widget.WOType == "D")
                      Row(
                        children: [
                          Text("Item Desc: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 5,
                              child: Text( pendingListController.onclickPendingListDet[index].itemDes.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    if(widget.WOType == "B")
                      Row(
                        children: [
                          Text("Item Desc: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                          Expanded(
                              flex: 5,
                              child: Text( pendingListController.onclickPendingListDet[index].fulldescription.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Unit:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 10,
                            child: Text( pendingListController.onclickPendingListDet[index].unit.toString())),

                        Expanded(
                          flex: 2,
                          child: Text("Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 10,
                            child: Text( pendingListController.onclickPendingListDet[index].qty.toString())),

                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Rate:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].rate.toString())),
                        Expanded(
                            flex: 2,
                            child: Text("Amount:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].amount.toString())),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
}





///----Direct TransferVerfication (MoreIcon)

class DirectTransVerifyDet extends StatefulWidget {
  const DirectTransVerifyDet({super.key, required this.heading, required this.list,required this.ReqNo });
  final String heading;
  final List list;
  final String ReqNo;

  @override
  State<DirectTransVerifyDet> createState() => _DirectTransVerifyDetState();
}

class _DirectTransVerifyDetState extends State<DirectTransVerifyDet> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.heading.toString(),
                        /// "Direct TransferVerification",
                        style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),

              ListDetails(context),

            ],
          ),
        ));
  }
  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Material" + ":   ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 10,
                            child: Text( pendingListController.onclickPendingListDet[index].qty.toString())),
                        Expanded(
                            flex: 2,
                            child: Text("Scale" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].scale.toString())),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
}

class PendingList_SiteVerifyPopup extends StatefulWidget {
  const PendingList_SiteVerifyPopup({Key? key, required this.list,required this.ReqNo,required this.ProjectName, required this.heading}) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;
  final String heading;

  @override
  State<PendingList_SiteVerifyPopup> createState() => _PendingList_SiteVerifyPopupState();
}

class _PendingList_SiteVerifyPopupState extends State<PendingList_SiteVerifyPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading,
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              ListDetails(context),
            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return
      Container(
        height: BaseUtitiles.getheightofPercentage(context, 90),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
          itemCount: pendingListController.onclickPendingListDet.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 3, bottom: 10,right: 3),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Material" + ":   ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Scale" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].scaleName.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("Stock Qty:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  " + pendingListController.onclickPendingListDet[index].stockQty.toString())),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("Req Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].reqQty.toString())),
                          // Expanded(
                          //   flex: 2,
                          //   child: Text("Bal Qty" + ":  ",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          // Expanded(
                          //     flex: 4,
                          //     child: Text("  "  + pendingListController.onclickPendingListDet[index].balQty.toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },),
      );
  }

}


class StoreTeansferPending extends StatefulWidget {
  StoreTeansferPending({Key? key,required this.URL,required this.list,required this.ReqNo, required this.ProjectName}) : super(key: key);
  final String URL;
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<StoreTeansferPending> createState() => _StoreTeansferPendingState();
}

class _StoreTeansferPendingState extends State<StoreTeansferPending> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(widget.URL,
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Material" + ":   ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text( pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("Scale" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].ScaleName.toString())),
                        Expanded(
                          flex: 2,
                          child: Text("StkQty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].stockqty.toString())),

                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Req Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].reqQty.toString())),
                        Expanded(
                          flex: 2,
                          child: Text("Tsf Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].tqty.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Bal Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text( pendingListController.onclickPendingListDet[index].balqty.toString())),
                        Expanded(
                            flex: 8,
                            child: Text(""))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
}


//-------Inward Pending---------------
class PendingList_InwardPopup extends StatefulWidget {
  const PendingList_InwardPopup({Key? key, required this.list,required this.ReqNo}) : super(key: key);
  final List list;
  final String ReqNo;

  @override
  State<PendingList_InwardPopup> createState() => _PendingList_InwardPopupState();
}

class _PendingList_InwardPopupState extends State<PendingList_InwardPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inward Pending",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              ListDetails(context),
            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return
      Container(
        height: BaseUtitiles.getheightofPercentage(context, 90),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
          itemCount: pendingListController.onclickPendingListDet.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 3, bottom: 10,right: 3),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Material" + ":   ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text( pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Scale" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].unitName.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("GRN Qty:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  " + pendingListController.onclickPendingListDet[index].grnQty.toString())),


                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("Po Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].poqty.toString())),
                          Expanded(
                            flex: 2,
                            child: Text("Bal Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Text("  "  + pendingListController.onclickPendingListDet[index].balqty.toString())),
                        ],
                      ),

                      // Divider(),
                      // Row(
                      //   children: [
                      //     Text("Remarks" + ":  ",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     Expanded(
                      //         flex: 2,
                      //         child: Text( pendingListController.onclickPendingListDet[index].remarks.toString())),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },),
      );
  }

}



//-------------Transfer Pending--------------

class PendingList_TransferPending_Popup extends StatefulWidget {
  const PendingList_TransferPending_Popup({Key? key, required this.list,required this.ReqNo, required this.ProjectName, required this.heading}) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;
  final String heading;

  @override
  State<PendingList_TransferPending_Popup> createState() => _PendingList_TransferPending_PopupState();
}

class _PendingList_TransferPending_PopupState extends State<PendingList_TransferPending_Popup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading.toString(),
                      style: TextStyle(
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.ProjectName.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.right,
                        widget.ReqNo.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),

              ListDetails(context),
            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return
            widget.heading.toString() == "TRANSFER REQUEST PENDING VIEW"
                ? Container(
              margin: EdgeInsets.only(left: 3, right: 3, bottom: 6),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, bottom: 8, top:5 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Material" + ":   ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text( pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Scale" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].ScaleName.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("Trans Qty:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  " + pendingListController.onclickPendingListDet[index].transQty.toString())),

                          // Expanded(
                          //     flex: 2,
                          //     child: Text("Req Qty:",
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     )),
                          // Expanded(
                          //     flex: 4,
                          //     child: Text("  " + pendingListController.onclickPendingListDet[index].Qty.toString())),

                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("App Qty",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 9,
                              child: Text( pendingListController.onclickPendingListDet[index].Qty.toString())),

                          // Expanded(
                          //     flex: 2,
                          //     child: Text("Trans Qty:",
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     )),
                          // Expanded(
                          //     flex: 4,
                          //     child: Text("  " + pendingListController.onclickPendingListDet[index].transQty.toString())),

                        ],
                      ),


                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Bal Qty",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 9,
                              child: Text( pendingListController.onclickPendingListDet[index].balQty.toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
                : Container(
              margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Material" + ":   ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text( pendingListController.onclickPendingListDet[index].MaterialName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Scale" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].ScaleName.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("Qty:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  " + pendingListController.onclickPendingListDet[index].Qty.toString())),

                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Trans Qty",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].transQty.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("Bal Qty:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  " + pendingListController.onclickPendingListDet[index].BalQty.toString())),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
        },),
    );
  }

}

class QuoteDetPopup extends StatefulWidget {
  const QuoteDetPopup({Key? key, required this.heading, required this.list,required this.ReqNo, required this.ProjectName}) : super(key: key);
  final String heading;
  final List list;
  final String ReqNo;
  final String ProjectName;

  @override
  State<QuoteDetPopup> createState() => _QuoteDetPopupState();
}

class _QuoteDetPopupState extends State<QuoteDetPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.heading.toString(),
                      style: TextStyle(
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(widget.ProjectName,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only( bottom: 10),
                        child: Text(widget.ReqNo.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),

              ListDetails(context),

            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 10, top:5 ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Material" + ":   ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("Scale" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].scaleName.toString())),
                        Expanded(
                          flex: 2,
                          child: Text("Req Qty" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text( pendingListController.onclickPendingListDet[index].qty.toString())
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
    );
  }
}

