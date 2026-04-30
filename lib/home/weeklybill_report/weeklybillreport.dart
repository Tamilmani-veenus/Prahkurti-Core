// import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../../../controller/projectcontroller.dart';
import '../../../../controller/wklybillreport_controller.dart';


import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WklyBillReport extends StatefulWidget {
  const WklyBillReport({Key? key}) : super(key: key);

  @override
  State<WklyBillReport> createState() => _WklyBillReportState();
}

class _WklyBillReportState extends State<WklyBillReport> {
  final ProjectController projectController = Get.put(ProjectController());
  // HDTRefreshController _hdtRefreshController = HDTRefreshController();

  WklyBillReport_controller wklyBillReport_Controller=Get.put(WklyBillReport_controller());

  @override
  void initState() {
    wklyBillReport_Controller.fromdate.clear();
    wklyBillReport_Controller.todate.clear();
    wklyBillReport_Controller.wklyreportDatas.clear();

    DateTime currentDate = DateTime.now();

    wklyBillReport_Controller.fromdate.text =
        currentDate.toString().substring(0, 10);
    wklyBillReport_Controller.todate.text =
        currentDate.toString().substring(0, 10);

    projectController.projectname.text = "--SELECT--";
    projectController.selectedProjectId.value = 0;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Text("Weekly Bill Report"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 7, left: 4),
                  width: BaseUtitiles.getWidthtofPercentage(context, 40),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    readOnly: true,
                    controller: wklyBillReport_Controller.fromdate,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme
                            .of(context)
                            .primaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme
                            .of(context)
                            .primaryColor, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range_sharp,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    onTap: () async {
                      var Frdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme.of(context).primaryColor, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.black, // button text color
                                ),
                              ),
                            ),
                              child: child!,
                            );
                          });
                      wklyBillReport_Controller.fromdate.text =
                          Frdate.toString().substring(0, 10);
                    },
                  ),
                ),
        
                Container(
                  margin: EdgeInsets.only(top: 7, right: 4),
                  width: BaseUtitiles.getWidthtofPercentage(context, 40),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    readOnly: true,
                    controller: wklyBillReport_Controller.todate,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme
                            .of(context)
                            .primaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme
                            .of(context)
                            .primaryColor, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range_sharp,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    onTap: () async {
                      var Frdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme.of(context).primaryColor, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.black, // button text color
                                ),
                              ),
                            ),
                              child: child!,
                            );
                          });
                      wklyBillReport_Controller.todate.text =
                          Frdate.toString().substring(0, 10);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin:
            EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            height: BaseUtitiles.getheightofPercentage(context, 5),
            width: BaseUtitiles.getWidthtofPercentage(context, 90),
            child: TextField(
              style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
              readOnly: true,
              controller: projectController.projectname,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                labelText: "ProjectName",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme
                      .of(context)
                      .primaryColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme
                      .of(context)
                      .primaryColor, width: 1.0),
                ),
        
              ),
        
              onTap: () {
                setState(() {
                  projectController.getProjectList();
                  FocusScope.of(context).unfocus();
                });
                FocusScope.of(context).unfocus();
              },
            ),
        
          ),
        
        
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme
                    .of(context)
                    .primaryColor,
                side: BorderSide(width: 3, color: Colors.black),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                setState(() {
                  wklyBillReport_Controller.wklybill_rptList();
                });
              },
              child: Text("Show"),
            ),
          ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
        
                Obx(()=>Visibility(
                  visible: wklyBillReport_Controller.wklyreportDatas.value.length>0?true:false,
                  child:
                  Container(
                    child: Container(),
        
                    // HorizontalDataTable(
                    //   leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 25),
                    //   rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 162),
                    //   isFixedHeader: true,
                    //   headerWidgets: _getTitleWidget(),
                    //   leftSideItemBuilder: _generateFirstColumnRow,
                    //   rightSideItemBuilder: _generateRightHandSideColumnRow,
                    //   itemCount: wklyBillReport_Controller.wklyreportDatas.value.length,
                    //   rowSeparatorWidget: const Divider(
                    //     color: Colors.black54,
                    //     height: 1.0,
                    //     thickness: 0.0,
                    //   ),
                    //   leftHandSideColBackgroundColor: Colors.white24,
                    //   rightHandSideColBackgroundColor: Colors.white24,
                    //   verticalScrollbarStyle: const ScrollbarStyle(
                    //     thumbColor: Colors.yellow,
                    //     isAlwaysShown: true,
                    //     thickness: 4.0,
                    //     radius: Radius.circular(5.0),
                    //   ),
                    //   horizontalScrollbarStyle: const ScrollbarStyle(
                    //     thumbColor: Colors.white24,
                    //     isAlwaysShown: true,
                    //     thickness: 4.0,
                    //     radius: Radius.circular(5.0),
                    //   ),
                    //   enablePullToRefresh: false,
                    //   refreshIndicator: const WaterDropHeader(),
                    //   refreshIndicatorHeight: 60,
                    //   onRefresh: () async {
                    //     //Do sth
                    //     await Future.delayed(const Duration(milliseconds: 500));
                    //     _hdtRefreshController.refreshCompleted();
                    //   },
                    //   enablePullToLoadNewData: false,
                    //   loadIndicator: const ClassicFooter(),
                    //   onLoad: () async {
                    //     //Do sth
                    //     await Future.delayed(const Duration(milliseconds: 500));
                    //     _hdtRefreshController.loadComplete();
                    //   },
                    //   htdRefreshController: _hdtRefreshController,
                    // ),
                    height: BaseUtitiles.getheightofPercentage(context, 55),
                    width:2000,
                  ),
                )
                ),
        
        
        
            ],
          ),
        ),),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Bill No', BaseUtitiles.getWidthtofPercentage(context, 25) ),
      _getTitleItemWidget('Date', BaseUtitiles.getWidthtofPercentage(context, 30) ),
      _getTitleItemWidget('Type', BaseUtitiles.getWidthtofPercentage(context, 15), ),
      _getTitleItemWidget('Cont Name', BaseUtitiles.getWidthtofPercentage(context, 37), ),
      _getTitleItemWidget('Bill Amt',BaseUtitiles.getWidthtofPercentage(context, 20)  ),
      _getTitleItemWidget('Verify Amt', BaseUtitiles.getWidthtofPercentage(context, 20), ),
      _getTitleItemWidget('Pre/App-Amt', BaseUtitiles.getWidthtofPercentage(context, 20), ),
      _getTitleItemWidget('Approve Amt', BaseUtitiles.getWidthtofPercentage(context, 20), ),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Colors.black,  // red as border color
        ),
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: BaseUtitiles.getheightofPercentage(context, 6),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,  // red as border color
        ),
      ),
      child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].workNo.toString()),
      height: BaseUtitiles.getheightofPercentage(context,9),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].nmrDate.toString()),
          width: BaseUtitiles.getWidthtofPercentage(context,30),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].type.toString()),
          width: BaseUtitiles.getWidthtofPercentage(context,15),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].subconName.toString()),
          width:  BaseUtitiles.getWidthtofPercentage(context,37),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].billamt.toString()),
          width:  BaseUtitiles.getWidthtofPercentage(context,20),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].verifyAmt.toString()),
          width:  BaseUtitiles.getWidthtofPercentage(context,20),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].preApprovalAmt.toString()),
          width:  BaseUtitiles.getWidthtofPercentage(context,20),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,  // red as border color
            ),
          ),
          child: Text(wklyBillReport_Controller.wklyreportDatas.value[index].approvalAmt.toString()),
          width:  BaseUtitiles.getWidthtofPercentage(context,20),
          height: BaseUtitiles.getheightofPercentage(context,9),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),

      ],
    );
  }

}
