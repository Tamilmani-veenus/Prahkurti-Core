import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/stocksite_controller.dart';
import '../../utilities/requestconstant.dart';


class ProjectDetailsPopup extends StatefulWidget {
  const ProjectDetailsPopup({Key? key,required this.list, required this.ProjectName}) : super(key: key);
  final List list;
  final String ProjectName;
  @override
  State<ProjectDetailsPopup> createState() => _ProjectDetailsPopupState();
}

class _ProjectDetailsPopupState extends State<ProjectDetailsPopup> {
  final StockSiteController stockSiteController=Get.put(StockSiteController());

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
                      "Stock At Site Material Details",
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
                        margin: EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(widget.ProjectName.toString(),
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
  Widget ListDetails(BuildContext context) {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 100),
      width: BaseUtitiles.getWidthtofPercentage(context, 100),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: stockSiteController.projectDetailsList.value.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Materials:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Theme
                                .of(context)
                                .primaryColor),
                          ),
                        ),
                        Expanded(
                            flex: 8,
                            child: Text(stockSiteController.projectDetailsList.value[index].material.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("Scale:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].scale.toString())),
                        Expanded(
                            flex: 3,
                            child: Text("Op Qty" + ":  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].opQty.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("Pur Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].purQty.toString())),
                        Expanded(
                          flex: 3,
                          child: Text("Trans In Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].transInQty.toString())),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("Trans Out Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].transOutQty.toString())),
                        Expanded(
                          flex: 3,
                          child: Text("Usage Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].usageQty.toString())),
                      ],
                    ),


                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("Cl Qty:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(stockSiteController.projectDetailsList.value[index].clQty.toString())),
                        Expanded(
                            flex: 6,
                            child: Container())
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



// class ProjectDetailsPopup extends StatefulWidget {
//   ProjectDetailsPopup({Key? key, required this.list, required this.ProjectName}) : super(key: key);
//   final List list;
//   final String ProjectName;
//
//   // HDTRefreshController _hdtRefreshController = HDTRefreshController();
//
//   // static const int sortName = 0;
//   // static const int sortStatus = 1;
//   // bool isAscending = true;
//   // int sortType = sortName;
//
//
//   @override
//   State<StatefulWidget> createState() {
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Setmybackground,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               Container(
//                 margin: EdgeInsets.only(left: 15, right: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Stock At Site Material Details",
//                       style: TextStyle(
//                           fontSize: RequestConstant.Heading_Font_SIZE,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           "Back",
//                           style: TextStyle(color: Colors.grey, fontSize: 18),
//                         ))
//                   ],
//                 ),
//               ),
//
//               Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: Container(
//                         margin: EdgeInsets.only(left: 15, bottom: 10),
//                         child: Text(widget.ProjectName.toString(),
//                           style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
//                           ),)),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                         margin: EdgeInsets.only( bottom: 10),
//                         child: Text("",
//                           // widget.ReqNo.toString(),
//                           style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
//                           ),)),
//                   ),
//                 ],
//               ),
//               Divider(),
//               ListDetails(context),
//
//             ],
//           ),
//         ));
//   }
//
//
//
//
// }



//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Container(
//         child: Container(),
//         HorizontalDataTable(
//           leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 35),
//           rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,170),
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
//         height: list.length <=5? BaseUtitiles.getheightofPercentage(context,55):BaseUtitiles.getheightofPercentage(context,68),
//         width: 2000,
//       ),
//     );
//   }
//   List<Widget> _getTitleWidget(BuildContext context) {
//     return [
//       _getTitleItemWidget('Materials', BaseUtitiles.getWidthtofPercentage(context, 35),context),
//       _getTitleItemWidget('Scale', BaseUtitiles.getWidthtofPercentage(context,20),context),
//       _getTitleItemWidget('Op Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Pur Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Trans In Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Trans Out Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Usage Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
//       _getTitleItemWidget('Cl Qty', BaseUtitiles.getWidthtofPercentage(context, 25),context),
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
//       child: Text(list[index].material.toString()),
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
//           child: Text(list[index].opQty.toString()),
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
//           child: Text(list[index].purQty.toString()),
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
//           child: Text(list[index].transInQty.toString()),
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
//           child: Text(list[index].transOutQty.toString()),
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
//           child: Text(list[index].usageQty.toString()),
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
//           child: Text(list[index].clQty.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,25),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//       ],
//     );
//   }
// }

