

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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


///-------------PO Supplier Trader Agencies------------
class PendingList_PoSupTradAgenPopup extends StatefulWidget {
  const PendingList_PoSupTradAgenPopup({Key? key, required this.list,required this.ReqNo, required this.ProjectName,required this.heading }) : super(key: key);
  final List list;
  final String ReqNo;
  final String ProjectName;
  final String heading;

  @override
  State<PendingList_PoSupTradAgenPopup> createState() => _PendingList_PoSupTradAgenPopupState();
}

class _PendingList_PoSupTradAgenPopupState extends State<PendingList_PoSupTradAgenPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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

class PendingPo_Approval_Popup extends StatefulWidget {
  const PendingPo_Approval_Popup({Key? key, required this.id, required this.heading, required this.list,required this.ReqNo,required this.projectName, required this.siteName, required this.supplierName, required this.preparedBy, required this.Date,required this.dueDate, required this.netAmount}) : super(key: key);
  final int id;
  final String heading;
  final List list;
  final String ReqNo;
  final String projectName;
  final String siteName;
  final String supplierName;
  final String preparedBy;
  final String Date;
  final String dueDate;
  final String netAmount;


  @override
  State<PendingPo_Approval_Popup> createState() => _PendingPo_Approval_PopupState();
}

class _PendingPo_Approval_PopupState extends State<PendingPo_Approval_Popup> {

  PendingListController pendingListController = Get.put(PendingListController());

  final ScrollController leftController = ScrollController();
  final ScrollController rightController = ScrollController();

  @override
  void initState() {
    super.initState();

    leftController.addListener(() {
      if (rightController.hasClients &&
          rightController.offset != leftController.offset) {
        rightController.jumpTo(leftController.offset);
      }
    });

    rightController.addListener(() {
      if (leftController.hasClients &&
          leftController.offset != rightController.offset) {
        leftController.jumpTo(rightController.offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,

        bottomNavigationBar: widget.list.isNotEmpty?Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 10,
          ),

          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              /// NET AMOUNT
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 5),

                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        Expanded(
                          flex: 3,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Net Amount ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                ":",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 5,

                          child: Text(
                              "${RequestConstant.CURRENCY_SYMBOL} "
                            "${pendingListController
                                .onclickPendingListDet[0].netPayAmount.toString()}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,



                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        Expanded(
                          flex: 3,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Net Pay Amount ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                ":",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 5,

                          child: Text(
                            "${RequestConstant.CURRENCY_SYMBOL} "
                                "${widget.netAmount}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,



                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /// BUTTONS
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20 , right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),

                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color:  Theme.of(context).primaryColor   ,
                          ),

                          alignment: Alignment.center,

                          child: Text(
                            widget.heading == "PO VERIFICATION" ? RequestConstant.VERIFY : RequestConstant.APPROVAL,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: Colors.white  ),),
                        ),
                        onTap: () {
                          setState(() {
                            verifyAlert(context, widget.id);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ):SizedBox(),

        body: SafeArea(
          child: Column(
            children: [

              /// TOP HEADER
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      widget.heading,

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// SUPPLIER + PURCHASE INFO
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    /// SUPPLIER INFO CARD
                    Expanded(
                      child: Card(
                        elevation: 2,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(10),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                "Supplier Info",

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              SizedBox(height: 10),

                              buildInfoRow(
                                "Project",
                                widget.projectName,
                              ),

                              SizedBox(height: 10),

                              buildInfoRow(
                                "Site",
                                widget.siteName,
                              ),

                              SizedBox(height: 10),

                              buildInfoRow(
                                "Supplier",
                                widget.supplierName,
                              ),

                              SizedBox(height: 10),

                              buildInfoRow(
                                "Prepared By",
                                widget.preparedBy,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 3),

                    /// PURCHASE INFO CARD
                    Expanded(
                      child: Card(
                        elevation: 3,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(12),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                "Purchase Info",

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              SizedBox(height: 15),

                              buildInfoRow(
                                "PO No",
                                widget.ReqNo,
                              ),

                              SizedBox(height: 10),

                              buildInfoRow(
                                "Date",
                                widget.Date,
                              ),

                              SizedBox(height: 10),
                              buildInfoRow(
                                "Delivery Date",
                                widget.dueDate,
                              ),
                            ],
                          ),


                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Obx(() {
                final reqNos = pendingListController.reqNoList
                    .map((e) => e["ReqOrdNo"].toString().trim())
                    .toList();

                List<String> rows = [];
                for (int i = 0; i < reqNos.length; i += 2) {
                  if (i + 1 < reqNos.length) {
                    rows.add("${reqNos[i]}, ${reqNos[i + 1]}");
                  } else {
                    rows.add(reqNos[i]);
                  }
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "  Req No :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rows.map((row) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              row ?? "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 15),
              /// HORIZONTAL SCROLL AREA

              Expanded(
                child: Row(
                  children: [

                    /// FIXED SECTION
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [

                          /// HEADER
                          Container(
                            height: 50,
                            color: Theme.of(context).primaryColor,

                            child: Row(
                              children: [

                                // fixedHeaderCell("S.No", 30),

                                fixedHeaderCell("", 40),

                                fixedHeaderCell("Material Name", 160),
                              ],
                            ),
                          ),

                          /// DATA
                          Expanded(
                            child: ListView.builder(
                              controller: leftController,
                              itemCount: pendingListController
                                  .onclickPendingListDet.length,
                              itemBuilder: (context, index) {

                                var item = pendingListController
                                    .onclickPendingListDet[index];

                                return Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    //   right: BorderSide(
                                    //   color: Colors.grey.shade400,
                                    //   width: 1,
                                    // ),
                                    ),
                                  ),

                                  child: Row(
                                    children: [

                                      /// S.NO
                                      // fixedDataCell(
                                      //   "${index + 1}",
                                      //   30,
                                      // ),

                                      /// Action

                                      Container(
                                        width: 40,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              pendingListController.poapprovalSupplierlist(
                                                context,
                                                item.materialId,
                                                item.materialName.toString(),
                                                item.scaleName.toString(),
                                              );
                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 25,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),

                                      ),

                                      /// MATERIAL
                                      fixedDataCell(
                                        "${item.materialName}\n(${item.scaleName})",
                                        160,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// SCROLLABLE SECTION
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: 600,
                          child: Column(
                            children: [

                              /// HEADER
                              Container(
                                height: 50,
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                  children: [

                                    headerCell("Qty"),
                                    headerCell("Data\nRate"),
                                    headerCell("PO\nRate"),
                                    headerCell("PO\nAmt"),
                                    headerCell("GST%"),
                                    headerCell("GST\nAmt"),
                                    headerCell("Net\nAmt"),

                                  ],
                                ),
                              ),

                              /// DATA
                              Expanded(
                                child: ListView.builder(
                                  controller: rightController,
                                  itemCount: pendingListController
                                      .onclickPendingListDet.length,
                                  itemBuilder: (context, index) {

                                    var item = pendingListController
                                        .onclickPendingListDet[index];

                                    return Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [

                                          dataCell(
                                            item.Poqty.toString(),
                                          ),
                                          dataCell("0.0"),
                                          dataCell(
                                            item.rate.toString(),
                                          ),

                                          dataCell(
                                            item.amount.toString(),
                                          ),

                                          dataCell(
                                            item.GSTPer.toString(),
                                          ),

                                          dataCell(
                                            item.GSTAmt.toString(),
                                          ),

                                          dataCell(

                                            item.netAmount.toString(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Expanded(
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //
              //     child: SizedBox(
              //       width: 750,
              //
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //
              //           /// HEADER
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //
              //             child: Table(
              //               border: TableBorder(
              //                 verticalInside: BorderSide(
              //                   color: Colors.white24,
              //                 ),
              //               ),
              //
              //               columnWidths: {
              //
              //                 /// MATERIAL NAME BIGGER
              //                 0: FixedColumnWidth(150),
              //
              //                 /// ALL SAME WIDTH
              //                 1: FixedColumnWidth(75),
              //                 2: FixedColumnWidth(75),
              //                 3: FixedColumnWidth(75),
              //                 4: FixedColumnWidth(75),
              //                 5: FixedColumnWidth(75),
              //                 6: FixedColumnWidth(75),
              //                 7: FixedColumnWidth(75),
              //                 8: FixedColumnWidth(75),
              //               },
              //
              //               children: [
              //
              //                 TableRow(
              //                   children: [
              //
              //                     tableHeader("Material Name"),
              //
              //                     tableHeader("Qty"),
              //
              //                     tableHeader("PO\nRate"),
              //
              //                     tableHeader("PO\nAmt"),
              //
              //                     tableHeader("GST %"),
              //
              //                     tableHeader("GST\nAmt"),
              //
              //                     tableHeader("Net\nAmt"),
              //
              //                     tableHeader("Data\nRate"),
              //
              //                     tableHeader(""),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //
              //           /// LIST
              //           Expanded(
              //             child: ListView.builder(
              //               itemCount: pendingListController
              //                   .onclickPendingListDet.length,
              //
              //               itemBuilder: (context, index) {
              //
              //                 var item =
              //                 pendingListController
              //                     .onclickPendingListDet[index];
              //
              //                 return Container(
              //
              //                   decoration: BoxDecoration(
              //                     border: Border(
              //                       bottom: BorderSide(
              //                         color: Colors.grey.shade300,
              //                       ),
              //                     ),
              //                   ),
              //
              //                   child: Table(
              //                     border: TableBorder(
              //                       verticalInside: BorderSide(
              //                         color: Colors.grey.shade300,
              //                       ),
              //                     ),
              //
              //                     columnWidths: {
              //
              //                       /// MATERIAL NAME BIGGER
              //                       0: FixedColumnWidth(150),
              //
              //                       /// ALL SAME WIDTH
              //                       1: FixedColumnWidth(75),
              //                       2: FixedColumnWidth(75),
              //                       3: FixedColumnWidth(75),
              //                       4: FixedColumnWidth(75),
              //                       5: FixedColumnWidth(75),
              //                       6: FixedColumnWidth(75),
              //                       7: FixedColumnWidth(75),
              //                       8: FixedColumnWidth(75),
              //                     },
              //
              //                     children: [
              //
              //                       TableRow(
              //                         children: [
              //
              //                           tableCell(
              //                             "${item.materialName} "
              //                                 "(${item.scaleName})"
              //                           ),
              //
              //                           tableCell(
              //                             item.Poqty.toString()
              //                           ),
              //
              //                           tableCell(
              //                             item.rate.toString()
              //                           ),
              //
              //                           tableCell(
              //                             item.amount.toString()
              //                           ),
              //
              //                           tableCell(
              //                             item.GSTPer.toString()
              //                           ),
              //
              //                           tableCell(
              //                             item.GSTAmt.toString()
              //                           ),
              //
              //                           tableCell(
              //                             item.netAmount.toString()
              //                           ),
              //
              //                           tableCell("0.0"),
              //
              //                           Padding(
              //                             padding: EdgeInsets.all(8),
              //
              //                             child: InkWell(
              //                               onTap: () {
              //
              //                                 pendingListController
              //                                     .poapprovalSupplierlist(
              //                                   context,
              //                                   item.materialId,
              //                                   item.materialName
              //                                       .toString(),
              //                                   item.scaleName
              //                                       .toString(),
              //                                 );
              //                               },
              //
              //                               child: Icon(
              //                                 Icons
              //                                     .arrow_circle_right_outlined,
              //
              //                                 color:
              //                                 Theme.of(context)
              //                                     .primaryColor,
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),










              // Expanded(
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //
              //     child: SizedBox(
              //       width: 620,
              //
              //       child: Column(
              //         children: [
              //
              //           /// TABLE HEADER
              //           Container(
              //             color: Theme.of(context).primaryColor,
              //             padding: EdgeInsets.symmetric(
              //                 vertical: 12),
              //
              //             child: Row(
              //               children: [
              //
              //                 headerCell("Material Name", 120),
              //
              //                 // headerCell("Unit\nPrice", 60),
              //
              //                 headerCell("Qty", 60),
              //
              //                 headerCell("PO\nRate", 60),
              //
              //                 headerCell("PO\nAmt", 60),
              //
              //                 headerCell("GST %", 60),
              //
              //                 headerCell("GST\nAmt", 60),
              //
              //                 headerCell("Net\nAmt", 60),
              //
              //                 headerCell("Data\nRate", 60),
              //
              //                 // headerCell("Action", 80),
              //               ],
              //             ),
              //           ),
              //
              //           /// LIST
              //           Expanded(
              //             child: ListView.builder(
              //               itemCount: pendingListController
              //                   .onclickPendingListDet.length,
              //
              //               itemBuilder: (context, index) {
              //
              //                 var item =
              //                 pendingListController
              //                     .onclickPendingListDet[index];
              //
              //                 return Container(
              //                   padding: EdgeInsets.symmetric(
              //                     vertical: 12,
              //                   ),
              //
              //                   decoration: BoxDecoration(
              //                     border: Border(
              //                       bottom: BorderSide(
              //                         color: Colors.grey.shade300,
              //                       ),
              //                     ),
              //                   ),
              //
              //                   child: Row(
              //                     children: [
              //
              //                       /// MATERIAL
              //                       dataCell(
              //                         "${item.materialName.toString()} ( ${item.scaleName} )",
              //                         120,
              //                       ),
              //
              //                       /// UNIT PRICE
              //                       // dataCell(
              //                       //   "₹ ${item.rate}",
              //                       //   60,
              //                       // ),
              //
              //                       /// QTY
              //                       dataCell(
              //                         item.Poqty.toString(),
              //                         60,
              //                       ),
              //
              //                       /// PO RATE
              //                       dataCell(
              //                         item.rate.toString(),
              //                         60,
              //                       ),
              //
              //                       /// PO AMT
              //                       dataCell(
              //                         item.amount.toString(),
              //                         60,
              //                       ),
              //
              //                       /// GST %
              //                       dataCell(
              //                         item.GSTPer.toString(),
              //                         60,
              //                       ),
              //
              //                       /// GST AMT
              //                       dataCell(
              //                         item.GSTAmt.toString(),
              //                         60,
              //                       ),
              //
              //                       /// NET AMT
              //                       dataCell(
              //                         item.netAmount.toString(),
              //                         60,
              //                       ),
              //
              //                       /// DATA RATE
              //                       dataCell(
              //                         "0.0",
              //                         // item.rate.toString() ==
              //                         //     "null"
              //                         //     ? "-"
              //                         //     : item.rate.toString(),
              //                         60,
              //                       ),
              //
              //                       /// ACTION
              //                       SizedBox(
              //                         width: 80,
              //
              //                         child: InkWell(
              //                           onTap: () {
              //
              //                             pendingListController
              //                                 .poapprovalSupplierlist(
              //                               context,
              //                               item.materialId,
              //                               item.materialName
              //                                   .toString(),
              //                               item.scaleName.toString(),
              //                             );
              //                             },
              //
              //                           child: Icon(
              //                             Icons
              //                                 .arrow_circle_right_outlined,
              //                             color: Theme.of(context).primaryColor,
              //                             size: 28,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fixedHeaderCell(
      String text,
      double width,
      ) {
    return Container(
      width: width,
      height: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.white24,
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget fixedDataCell(
      String text,
      double width, {
        Alignment alignment = Alignment.center,
      }) {
    return Container(
      width: width,
      height: 70,
      padding: const EdgeInsets.all(6),
      alignment: alignment,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget headerCell(String text) {
    return Container(
      width: 85,
      height: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.white24,
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget dataCell(String text) {
    return Container(
      width: 85,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableHeader(String text) {

    return SizedBox(
      height: 50,

      child: Center(
        child: Padding(
          padding: EdgeInsets.all(6),

          child: Text(
            text,

            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCell(String text) {

    return SizedBox(
      height: 50,

      child: Center(
        child: Padding(
          padding: EdgeInsets.all(6),

          child: Text(
            text,

            textAlign: TextAlign.center,

            maxLines: 2,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }


  Widget buildInfoRow(
      String title,
      String value,
      ) {

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Expanded(
          flex: 3,

          child: Text(
            title,

            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

        Text(
          ": ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 11
          ),
        ),

        Expanded(
          flex: 5,

          child: Text(
            value,

            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                widget.ReqNo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await pendingListController.PO_Approval_DeleteApi(widget.id);
                          if (result) {
                            // pendingListController.mainlist.removeAt(index);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            await pendingListController.getPendingList();

                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },

                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future verifyAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
          ],
        ),
        content: Text(widget.heading == "PO VERIFICATION" ? 'Are you sure to Verify?' : 'Are you sure to Approve?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          pendingListController.getPoAprovalDetList.value = [];
                          await pendingListController.poAproval_buttonApi(context, widget.heading.toString(),id: widget.id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          await pendingListController.getPendingList();
                        },
                        child: Text(widget.heading == "PO VERIFICATION" ? RequestConstant.VERIFY : RequestConstant.APPROVAL,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget ListDetails(BuildContext context){
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 90),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 15)),
        itemCount: pendingListController.onclickPendingListDet.length,
        itemBuilder: (BuildContext context, int index) {

          var item = pendingListController.onclickPendingListDet[index];

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        item.materialName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        "(${item.scaleName})",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        "PO Amt : ${item.amount}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                /// UNIT PRICE
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "₹ ${item.rate}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                /// QTY
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "${item.Poqty} ${item.scaleName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                /// VIEW BUTTON
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {

                      pendingListController.poapprovalSupplierlist(
                        context,
                        item.materialID,
                        item.materialName.toString(),
                        item.scale.toString(),
                      );

                    },
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        // itemBuilder: (BuildContext context, int index) {
        //   return Container(
        //     margin: EdgeInsets.only(left: 3, right: 3),
        //     child: Card(
        //       elevation: 5,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0),
        //       ),
        //       child: Container(
        //         margin: EdgeInsets.only(left: 10, right: 5, bottom: 10, top:5 ),
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Text("Material" + ":   ",
        //                   style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
        //                 ),
        //                 Expanded(
        //                     flex: 5,
        //                     child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )),
        //                 Expanded(
        //                     flex: 3,
        //                     child: InkWell(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Icon(Icons.arrow_circle_right_outlined, color: Theme.of(context).primaryColor,),
        //                           Container(child: Text("    "),)
        //                         ],
        //                       ),
        //                       onTap: (){
        //                         pendingListController.poapprovalSupplierlist(context,
        //                           pendingListController.onclickPendingListDet[index].materialId,
        //                           pendingListController.onclickPendingListDet[index].materialName.toString(),
        //                           pendingListController.onclickPendingListDet[index].scaleName.toString(),
        //                         );
        //                       },
        //                     ))
        //               ],
        //             ),
        //             Divider(),
        //             Row(
        //               children: [
        //                 Expanded(
        //                   flex: 2,
        //                   child: Text("Po Qty:",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( pendingListController.onclickPendingListDet[index].Poqty.toString())),
        //                 Expanded(
        //                     flex: 2,
        //                     child: Text("Scale" + ":  ",
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( pendingListController.onclickPendingListDet[index].scaleName.toString())),
        //               ],
        //             ),
        //             Divider(),
        //             Row(
        //               children: [
        //                 Expanded(
        //                   flex: 2,
        //                   child: Text("Po Rate" + ":  ",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( pendingListController.onclickPendingListDet[index].rate.toString())),
        //                 Expanded(
        //                     flex: 2,
        //                     child: Text("Data Rate" + ":  ",
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( "")),
        //               ],
        //             ),
        //             Divider(),
        //             Row(
        //               children: [
        //
        //                 Expanded(
        //                   flex: 2,
        //                   child: Text("Po Amt" + ":  ",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( pendingListController.onclickPendingListDet[index].amount.toString())),
        //                 Expanded(
        //                   flex: 2,
        //                   child: Text("GST Per:" ,
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Text( " "+pendingListController.onclickPendingListDet[index].GSTPer.toString())),
        //               ],
        //             ),
        //             Divider(),
        //             Row(
        //               children: [
        //                 Expanded(
        //                   flex: 3,
        //                   child: Text("GST Amt:" + "   ",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 6,
        //                     child: Text(" " + pendingListController.onclickPendingListDet[index].GSTAmt.toString())),
        //
        //                 Expanded(
        //                   flex: 3,
        //                   child: Text("Net Amt" + ":",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 Expanded(
        //                     flex: 6,
        //                     child: Text( pendingListController.onclickPendingListDet[index].netAmount.toString()))
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }

}


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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
                              flex: 8,
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
  const PendingList_InwardPopup({Key? key, required this.list,required this.ReqNo,required this.heading}) : super(key: key);
  final List list;
  final String ReqNo;
  final String heading;

  @override
  State<PendingList_InwardPopup> createState() => _PendingList_InwardPopupState();
}

class _PendingList_InwardPopupState extends State<PendingList_InwardPopup> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
                              child: Text( widget.heading=="INWARD PENDING - WO"?pendingListController.onclickPendingListDet[index].ScaleName.toString():pendingListController.onclickPendingListDet[index].unitName.toString())),

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
                            child: Text(widget.heading=="INWARD PENDING - WO"?"WO Qty:  ":"Po Qty:  ",
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
          )),
    );
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

