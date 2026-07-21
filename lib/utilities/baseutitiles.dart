import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/boqrevised_itemlist_model.dart';

String? punchStatus;
bool punchIn = false;

class BaseUtitiles {
  static var deviceName;
  static var deviceVersion;
  static var identifier;
  static RxList dummyListData=[].obs;

  static double getheightofPercentage(BuildContext context, int percentage) {
    double _height = MediaQuery.of(context).size.height;
    return (_height / 100) * percentage;
  }

  static double getWidthtofPercentage(BuildContext context, int percentage) {
    double _width = MediaQuery.of(context).size.width;
    return (_width / 100) * percentage;
  }

  static showToast(String message) => Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG,);

  static Future<List<String>> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.id; //UUID for Android
        // identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [deviceName!, deviceVersion!, identifier!];
  }

  String convertToUtcIso(String date) {
    final parsedDate = DateTime.parse(date);
    final now = DateTime.now();

    final localDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
    );

    return localDateTime.toUtc().toIso8601String();
  }

  String convertDate(String date) {
    return DateFormat("yyyy-MM-dd").format(
      DateFormat("dd-MMM-yyyy").parse(date),
    );
  }

  static void popMultiple(BuildContext context, {int count = 1}) {
    for (int i = 0; i < count; i++) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  static String initiateCurrentDateFormat(){
    DateTime dateTime = DateTime.now();
    var month = dateTime.month.toString().padLeft(2, '0');
    var day = dateTime.day.toString().padLeft(2, '0');
    var dateformateTime = '${dateTime.year}-$month-$day ${dateTime.hour}:${dateTime.minute}';
    var dateformate = '${dateTime.year}-$month-$day';
    return dateformate;
  }

  static String selectDateFormat(DateTime selectDate){

    var month = selectDate.month.toString().padLeft(2, '0');
    var day = selectDate.day.toString().padLeft(2, '0');
    var dateformateTime = '${selectDate.year}-$month-$day ${selectDate.hour}:${selectDate.minute}';
    var dateformate = '${selectDate.year}-$month-$day';
    return dateformate;
  }

  static String NMR_After_OneWeekDate(DateTime selectDate){
    var newDate = new DateTime(selectDate.year, selectDate.month, selectDate.day+6);
    var dateformate='$newDate'.substring(0,10);
    return dateformate;
  }

  static  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> checkNetworkAndShowLoader(BuildContext context) async {
    if (await isConnectedToNetwork()) {
      showLoadingDialog(context);
      return true;
    } else {
      Fluttertoast.showToast(msg: "No Internet Connection. Please check your network.");
      return false;
    }
  }


  static MaterialheadNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialHead.toString().toLowerCase().contains(value) ||
            item.materialHead.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static filterSearchResults(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.reviseDate.toString().toLowerCase().contains(value) ||
            item.reviseDate.toString().toUpperCase().contains(value) ||
            item.reviseNo.toString().toLowerCase().contains(value) ||
            item.reviseNo.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.preparedby.toString().toLowerCase().contains(value) ||
            item.preparedby.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchNMRResults(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value) ||
            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||
            item.fromDate.toString().toLowerCase().contains(value) ||
            item.fromDate.toString().toUpperCase().contains(value) ||
            item.toDate.toString().toLowerCase().contains(value) ||
            item.toDate.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.subContractorName.toString().toLowerCase().contains(value) ||
            item.subContractorName.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value) ||
            item.status.toString().toLowerCase().contains(value) ||
            item.status.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return dummyListData.value;
    }
    else {
      return list.value;
    }
  }

  static List<Result> filterSearchResults_BOQRevised(
      String value,
      RxList<Result> originalList,
      ) {

    if (value.isEmpty) {
      return List<Result>.from(originalList);
    }

    String search = value.toLowerCase();

    List<Result> filteredMainList = [];

    for (var mainItem in originalList) {

      List<SubItem> filteredSubItems = [];

      for (var subItem in mainItem.subItems ?? []) {

        List<Level3Item> filteredLevel3 =
        subItem.level3Items!
            .where((level3) {

          return level3.name
              .toString()
              .toLowerCase()
              .contains(search)

              ||

              level3.scaleName
                  .toString()
                  .toLowerCase()
                  .contains(search)

              ||

              level3.seqno
                  .toString()
                  .toLowerCase()
                  .contains(search);

        }).toList();

        bool subItemMatch = subItem.subItem
            .toString()
            .toLowerCase()
            .contains(search);

        if (subItemMatch || filteredLevel3.isNotEmpty) {

          filteredSubItems.add(
            SubItem(
              measureSubItemId:
              subItem.measureSubItemId,
              subItem: subItem.subItem,
              seqno: subItem.seqno,
              level3Items: filteredLevel3,
            ),
          );
        }
      }

      bool mainMatch = mainItem.headItemName
          .toString()
          .toLowerCase()
          .contains(search);

      if (mainMatch || filteredSubItems.isNotEmpty) {

        filteredMainList.add(
          Result(
            measureHeadItemId:
            mainItem.measureHeadItemId,
            headItemName:
            mainItem.headItemName,
            subItems: filteredSubItems,
          ),
        );
      }
    }

    return filteredMainList;
  }


  static filterSearchResults_Consumptionitemlist(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value) ||
            item.scale.toString().toLowerCase().contains(value) ||
            item.scale.toString().toUpperCase().contains(value)  ||
            item.stockQty.toString().toLowerCase().contains(value) ||
            item.stockQty.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_dprlist(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.workDate.toString().toLowerCase().contains(value) ||
            item.workDate.toString().toUpperCase().contains(value) ||
            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.subcontractorName.toString().toLowerCase().contains(value) ||
            item.subcontractorName.toString().toUpperCase().contains(value) ||
            item.entryTypeDesc.toString().toLowerCase().contains(value) ||
            item.entryTypeDesc.toString().toUpperCase().contains(value) ||
            item.status.toString().toLowerCase().contains(value) ||
            item.status.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_AdvReqVoclist(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.advanceReqVoucherDate.toString().contains(value) ||
            item.advanceReqVoucherNo.toString().toLowerCase().contains(value) ||
            item.advanceReqVoucherNo.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.accountName.toString().toLowerCase().contains(value) ||
            item.accountName.toString().toUpperCase().contains(value) ||
            item.actualVoucherAmount.toString().contains(value) ||
            item.accountPayForName.toString().toLowerCase().contains(value) ||
            item.accountPayForName.toString().toUpperCase().contains(value) ||
            item.status.toString().toLowerCase().contains(value) ||
            item.status.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_billGenerationDirect(
      String value,
      List list,
      ) {
    dummyListData.clear();

    if (value.isNotEmpty) {
      for (var item in list) {
        if (item.workDate.toString().toLowerCase().contains(value) ||
            item.workDate.toString().toUpperCase().contains(value) ||
            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||
            item.subContractorName.toString().toLowerCase().contains(value) ||
            item.subContractorName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.fromWorkDate.toString().toLowerCase().contains(value) ||
            item.fromWorkDate.toString().toUpperCase().contains(value) ||
            item.toWorkDate.toString().toLowerCase().contains(value) ||
            item.toWorkDate.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value) ) {
          dummyListData.add(item);
        }
      }
      return dummyListData;
    } else {
      return list;
    }
  }

  static filterSearchResults_workOrderDirect(
      String value,
      List list,
      ) {
    dummyListData.clear();

    if (value.isNotEmpty) {
      for (var item in list) {
        if (item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value) ||
            item.workOrderNo.toString().toLowerCase().contains(value) ||
            item.workOrderNo.toString().toUpperCase().contains(value) ||
            item.subContractorName.toString().toLowerCase().contains(value) ||
            item.subContractorName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.netAmount.toString().toLowerCase().contains(value) ||
            item.netAmount.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value) ) {
          dummyListData.add(item);
        }
      }
      return dummyListData;
    } else {
      return list;
    }
  }


  static filterSearchResults_SubcontAttend(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.labourAttendanceDate.toString().toLowerCase().contains(value) ||
            item.labourAttendanceDate.toString().toUpperCase().contains(value) ||
            item.labourAttendanceNo.toString().toLowerCase().contains(value) ||
            item.labourAttendanceNo.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.totNos.toString().toLowerCase().contains(value) ||
            item.totNos.toString().toUpperCase().contains(value) ||
            item.totAmt.toString().toLowerCase().contains(value) ||
            item.totAmt.toString().toUpperCase().contains(value) ||
            item.workTypeName.toString().toLowerCase().contains(value) ||
            item.workTypeName.toString().toUpperCase().contains(value) ||
            item.subContractorName.toString().toLowerCase().contains(value) ||
            item.subContractorName.toString().toUpperCase().contains(value) ||
            item.employeeName.toString().toLowerCase().contains(value) ||
            item.employeeName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }


  static filterSearchResults_MRNRequestIndent(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value)  ||
            item.sitename.toString().toLowerCase().contains(value) ||
            item.sitename.toString().toUpperCase().contains(value)  ||
            item.reqOrdDate.toString().toLowerCase().contains(value) ||
            item.reqOrdDate.toString().toUpperCase().contains(value) ||
            item.reqOrdNo.toString().toLowerCase().contains(value) ||
            item.reqOrdNo.toString().toUpperCase().contains(value) ||
            item.reqDueDate.toString().toLowerCase().contains(value) ||
            item.reqDueDate.toString().toUpperCase().contains(value) ||
            item.Preparedby.toString().toLowerCase().contains(value) ||
            item.Preparedby.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_Inward(String value, list) {
    dummyListData.value.clear();

    if (value.isNotEmpty) {
      final search = value.toLowerCase();

      list.value.forEach((item) {

        String inwTypeText =
        item.inwType.toString().trim() == "O"
            ? "Against Rental WO"
            : "Against PO";

        if (item.entryDate.toString().toLowerCase().contains(search) ||
            item.selectedNo.toString().toLowerCase().contains(search) ||
            item.inwardNo.toString().toLowerCase().contains(search) ||
            item.supplierName.toString().toLowerCase().contains(search) ||
            item.invoiceNo.toString().toLowerCase().contains(search) ||
            item.siteName.toString().toLowerCase().contains(search) ||
            item.projectName.toString().toLowerCase().contains(search) ||
            inwTypeText.toLowerCase().contains(search)) {

          dummyListData.value.add(item);
        }
      });

      return dummyListData.value;
    } else {
      return list.value;
    }
  }

  static filterSearchResults_InwardPending(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.no.toString().toLowerCase().contains(value) ||
            item.no.toString().toUpperCase().contains(value)  ||
            item.date.toString().toLowerCase().contains(value) ||
            item.date.toString().toUpperCase().contains(value) ||
            item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.delaydays.toString().toLowerCase().contains(value) ||
            item.delaydays.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_MaterialTransferRequest(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.transferEntryDate.toString().toLowerCase().contains(value) ||
            item.transferEntryDate.toString().toUpperCase().contains(value)  ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.fromProjectName.toString().toLowerCase().contains(value) ||
            item.fromProjectName.toString().toUpperCase().contains(value) ||
            item.toProjectName.toString().toLowerCase().contains(value) ||
            item.toProjectName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_TransferBtwnProjects(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value)  ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.frProjectName.toString().toLowerCase().contains(value) ||
            item.frProjectName.toString().toUpperCase().contains(value) ||
            item.toProjectName.toString().toLowerCase().contains(value) ||
            item.toProjectName.toString().toUpperCase().contains(value) ||
            item.frSiteName.toString().toLowerCase().contains(value) ||
            item.frSiteName.toString().toUpperCase().contains(value) ||
            item.dcNo.toString().toLowerCase().contains(value) ||
            item.dcNo.toString().toUpperCase().contains(value) ||
            item.vehicleName.toString().toLowerCase().contains(value) ||
            item.vehicleName.toString().toUpperCase().contains(value) ||
            item.entryName.toString().toLowerCase().contains(value) ||
            item.entryName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }


  static filterSearchResults_TransferbetweenSites(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.entryDt.toString().toLowerCase().contains(value) ||
            item.entryDt.toString().toUpperCase().contains(value)  ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.frProjectName.toString().toLowerCase().contains(value) ||
            item.frProjectName.toString().toUpperCase().contains(value) ||
            item.frSiteName.toString().toLowerCase().contains(value) ||
            item.frSiteName.toString().toUpperCase().contains(value) ||
            item.toSiteName.toString().toLowerCase().contains(value) ||
            item.toSiteName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_Consumption(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.entryDt.toString().toLowerCase().contains(value) ||
            item.entryDt.toString().toUpperCase().contains(value)  ||
            item.expenseNo.toString().toLowerCase().contains(value) ||
            item.expenseNo.toString().toUpperCase().contains(value) ||
            item.expenseName.toString().toLowerCase().contains(value) ||
            item.expenseName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_PendingList(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.no.toString().toLowerCase().contains(value) ||
            item.no.toString().toUpperCase().contains(value) ||
            item.date.toString().toLowerCase().contains(value) ||
            item.date.toString().toUpperCase().contains(value) ||
            item.dueDate.toString().toLowerCase().contains(value) ||
            item.dueDate.toString().toUpperCase().contains(value) ||
            item.frProjectName.toString().toLowerCase().contains(value) ||
            item.frProjectName.toString().toUpperCase().contains(value) ||
            item.toProjectName.toString().toLowerCase().contains(value) ||
            item.toProjectName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.type.toString().toLowerCase().contains(value) ||
            item.type.toString().toUpperCase().contains(value) ||
            item.preparedBy.toString().toLowerCase().contains(value) ||
            item.preparedBy.toString().toUpperCase().contains(value) ||
            item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value) ||
            item.suppliername.toString().toLowerCase().contains(value) ||
            item.suppliername.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.netAmt.toString().toLowerCase().contains(value) ||
            item.netAmt.toString().toUpperCase().contains(value) ||
            item.potype.toString().toLowerCase().contains(value) ||
            item.potype.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||

            item.advanceReqVoucherNo.toString().contains(value) ||
            item.advanceReqVoucherDate.toString().contains(value) ||
            item.advanceReqVoucherAmount.toString().contains(value) ||
            item.accountName.toString().toLowerCase().contains(value) ||
            item.accountName.toString().toUpperCase().contains(value) ||
            item.accountTypeName.toString().toLowerCase().contains(value) ||
            item.accountTypeName.toString().toUpperCase().contains(value) ||
            item.Payfor.toString().toLowerCase().contains(value) ||
            item.Payfor.toString().toUpperCase().contains(value) ||
            item.advanceReqVoucherType.toString().toLowerCase().contains(value) ||
            item.advanceReqVoucherType.toString().toUpperCase().contains(value) ||
            item.preparedName.toString().toLowerCase().contains(value) ||
            item.preparedName.toString().toUpperCase().contains(value) ||



            item.transferEntryDate.toString().toLowerCase().contains(value) ||
            item.transferEntryDate.toString().toUpperCase().contains(value) ||
            item.ReqOrdNo.toString().toLowerCase().contains(value) ||
            item.ReqOrdNo.toString().toUpperCase().contains(value) ||
            item.reqOrdNo.toString().toLowerCase().contains(value) ||
            item.reqOrdNo.toString().toUpperCase().contains(value) ||
            item.reqOrdDate.toString().toLowerCase().contains(value) ||
            item.reqOrdDate.toString().toUpperCase().contains(value) ||
            item.reqOrdDate.toString().toLowerCase().contains(value) ||
            item.reqOrdDate.toString().toUpperCase().contains(value) ||
            item.ReqOrdDate.toString().toLowerCase().contains(value) ||
            item.ReqOrdDate.toString().toUpperCase().contains(value) ||
            item.ReqDueDate.toString().toLowerCase().contains(value) ||
            item.ReqDueDate.toString().toUpperCase().contains(value) ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.FromProjectName.toString().toLowerCase().contains(value) ||
            item.FromProjectName.toString().toUpperCase().contains(value) ||
            item.fromSiteName.toString().toLowerCase().contains(value) ||
            item.fromSiteName.toString().toUpperCase().contains(value) ||
            item.approvedbyname.toString().toLowerCase().contains(value) ||
            item.approvedbyname.toString().toUpperCase().contains(value) ||

            item.Preparedbyname.toString().toLowerCase().contains(value) ||
            item.Preparedbyname.toString().toUpperCase().contains(value) ||
            item.preparedByName.toString().toLowerCase().contains(value) ||
            item.preparedByName.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value) ||

            item.verifiedBy.toString().toLowerCase().contains(value) ||
            item.verifiedBy.toString().toUpperCase().contains(value) ||

            item.TransferNo.toString().toLowerCase().contains(value) ||
            item.TransferNo.toString().toUpperCase().contains(value) ||

            item.ProjectName.toString().toLowerCase().contains(value) ||
            item.ProjectName.toString().toUpperCase().contains(value) ||

            item.SiteName.toString().toLowerCase().contains(value) ||
            item.SiteName.toString().toUpperCase().contains(value) ||

            item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value) ||

            item.netAmount.toString().toLowerCase().contains(value) ||
            item.netAmount.toString().toUpperCase().contains(value) ||

            item.approveByName.toString().toLowerCase().contains(value) ||
            item.approveByName.toString().toUpperCase().contains(value) ||

            item.createdByName.toString().toLowerCase().contains(value) ||
            item.createdByName.toString().toUpperCase().contains(value) ||

            item.preparedby.toString().toLowerCase().contains(value) ||
            item.preparedby.toString().toUpperCase().contains(value) ||

            item.prepareby.toString().toLowerCase().contains(value) ||
            item.prepareby.toString().toUpperCase().contains(value) ||

            item.ToProjectName.toString().toLowerCase().contains(value) ||
            item.ToProjectName.toString().toUpperCase().contains(value) ||

            item.approveName.toString().toLowerCase().contains(value) ||
            item.approveName.toString().toUpperCase().contains(value) ||

            item.CreatedName.toString().toLowerCase().contains(value) ||
            item.CreatedName.toString().toUpperCase().contains(value) ||

            item.PurchaseOrdNo.toString().toLowerCase().contains(value) ||
            item.PurchaseOrdNo.toString().toUpperCase().contains(value) ||

            item.entryType.toString().toLowerCase().contains(value) ||
            item.entryType.toString().toUpperCase().contains(value) ||

            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||

            item.prepareby.toString().toLowerCase().contains(value) ||
            item.prepareby.toString().toUpperCase().contains(value) ||

            item.SubcontractName.toString().toLowerCase().contains(value) ||
            item.SubcontractName.toString().toUpperCase().contains(value) ||

            item.entryNo.toString().toLowerCase().contains(value) ||
            item.entryNo.toString().toUpperCase().contains(value) ||
            item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value) ||
            item.billNo.toString().toLowerCase().contains(value) ||
            item.billNo.toString().toUpperCase().contains(value) ||
            item.SubcontName.toString().toLowerCase().contains(value) ||
            item.SubcontName.toString().toUpperCase().contains(value) ||
            item.billType.toString().toLowerCase().contains(value) ||
            item.billType.toString().toUpperCase().contains(value) ||
            item.billStatus.toString().toLowerCase().contains(value) ||
            item.billStatus.toString().toUpperCase().contains(value) ||
            item.netPayAmount.toString().toLowerCase().contains(value) ||
            item.netPayAmount.toString().toUpperCase().contains(value) ||
            item.reviseNo.toString().toLowerCase().contains(value) ||
            item.reviseNo.toString().toUpperCase().contains(value) ||
            item.qCount.toString().toLowerCase().contains(value) ||
            item.qCount.toString().toUpperCase().contains(value) ||
            item.preparebyname.toString().toLowerCase().contains(value) ||
            item.preparebyname.toString().toUpperCase().contains(value) ||
            item.siteVoucherAmount.toString().toLowerCase().contains(value) ||
            item.siteVoucherAmount.toString().toUpperCase().contains(value) ||
            item.payMode.toString().toLowerCase().contains(value) ||
            item.payMode.toString().toUpperCase().contains(value) ||
            item.payfor.toString().toLowerCase().contains(value) ||
            item.payfor.toString().toUpperCase().contains(value) ||
            item.accountName.toString().toLowerCase().contains(value) ||
            item.accountName.toString().toUpperCase().contains(value) ||
            item.accountTypeName.toString().toLowerCase().contains(value) ||
            item.accountTypeName.toString().toUpperCase().contains(value) ||
            item.vocdate.toString().toLowerCase().contains(value) ||
            item.vocdate.toString().toUpperCase().contains(value) ||
            item.siteVoucherNo.toString().toLowerCase().contains(value) ||
            item.siteVoucherNo.toString().toUpperCase().contains(value) ||
            item.labourAttendanceDate.toString().toLowerCase().contains(value) ||
            item.labourAttendanceDate.toString().toUpperCase().contains(value) ||
            item.labourAttendanceNo.toString().toLowerCase().contains(value) ||
            item.labourAttendanceNo.toString().toUpperCase().contains(value) ||
            item.totNos.toString().toLowerCase().contains(value) ||
            item.totNos.toString().toUpperCase().contains(value) ||
            item.totAmt.toString().toLowerCase().contains(value) ||
            item.totAmt.toString().toUpperCase().contains(value) ||
            item.subcontractName.toString().toLowerCase().contains(value) ||
            item.subcontractName.toString().toUpperCase().contains(value) ||



            item.PurchaseOrdDate.toString().contains(value) ||
            item.ProjectName.toString().toLowerCase().contains(value) ||
            item.ProjectName.toString().toUpperCase().contains(value)  ||
            item.purchaseOrdNo.toString().toLowerCase().contains(value) ||
            item.purchaseOrdNo.toString().toUpperCase().contains(value) ||
            item.SupplierContactNo.toString().contains(value)  ||
            item.delaydays.toString().contains(value)

        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsSiteVouchers(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (
            item.siteVoucherNo.toString().toLowerCase().contains(value) ||
            item.siteVoucherNo.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteVoucherDate.toString().toLowerCase().contains(value) ||
            item.siteVoucherDate.toString().toUpperCase().contains(value) ||
            item.accountName.toString().toLowerCase().contains(value) ||
            item.accountName.toString().toUpperCase().contains(value) ||
            item.accountTypeName.toString().toLowerCase().contains(value) ||
            item.accountTypeName.toString().toUpperCase().contains(value) ||
            item.siteVoucherAmount.toString().toLowerCase().contains(value) ||
            item.siteVoucherAmount.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static filterSearchResultsStaffVouchers(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (
        item.staffVocNo.toString().toLowerCase().contains(value) ||
            item.staffVocNo.toString().toUpperCase().contains(value) ||
            item.employeeName.toString().toLowerCase().contains(value) ||
            item.employeeName.toString().toUpperCase().contains(value) ||
            item.vocDate.toString().toLowerCase().contains(value) ||
            item.vocDate.toString().toUpperCase().contains(value) ||
            item.accountName.toString().toLowerCase().contains(value) ||
            item.accountName.toString().toUpperCase().contains(value) ||
            item.accountType.toString().toLowerCase().contains(value) ||
            item.accountType.toString().toUpperCase().contains(value) ||
            item.amount.toString().toLowerCase().contains(value) ||
            item.amount.toString().toUpperCase().contains(value)
           )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static filterSearchResultstoProjectName(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.toProjectName.toString().toLowerCase().contains(value) ||
            item.toProjectName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsfrProjectName(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.frProjectName.toString().toLowerCase().contains(value) ||
            item.frProjectName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsStaff(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.staff.toString().toLowerCase().contains(value) ||
            item.staff.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultssupplier(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsfrProject(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.frProject.toString().toLowerCase().contains(value) ||
            item.frProject.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsemployee(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (
            item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value) ||
            item.requisitionNo.toString().toLowerCase().contains(value) ||
            item.requisitionNo.toString().toUpperCase().contains(value) ||
            item.requisitionTypeDesc.toString().toLowerCase().contains(value) ||
            item.requisitionTypeDesc.toString().toUpperCase().contains(value) ||
            item.staffName.toString().toLowerCase().contains(value) ||
            item.staffName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.status.toString().toLowerCase().contains(value) ||
            item.status.toString().toUpperCase().contains(value) ||
            item.createdName.toString().toLowerCase().contains(value) ||
            item.createdName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultstransfer(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.fromProject.toString().toLowerCase().contains(value) ||
            item.fromProject.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }



  static projectPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static companyPopupAlert(String value, List list) {
    dummyListData.clear();

    if (value.trim().isEmpty) {
      return list;
    }

    final search = value.toLowerCase();

    for (var item in list) {
      if (item.companyName.toString().toLowerCase().contains(search) ||
          item.companyName.toString().toLowerCase().contains(search)) {
        dummyListData.add(item);
      }
    }

    return dummyListData;
  }

  static subcontLabAttendPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.labourAttendanceDate.toString().contains(value) ||
            item.labourAttendanceNo.toString().contains(value) ||
            item.labourCount.toString().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value)  ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value)  ||
            item.subContractorName.toString().toLowerCase().contains(value) ||
            item.subContractorName.toString().toUpperCase().contains(value)  ||
            item.workTypName.toString().toLowerCase().contains(value) ||
            item.workTypName.toString().toUpperCase().contains(value)  ||
            item.billStatusDesc.toString().toLowerCase().contains(value) ||
            item.billStatusDesc.toString().toUpperCase().contains(value)  ||
            item.employeeName.toString().toLowerCase().contains(value) ||
            item.employeeName.toString().toUpperCase().contains(value)  ||
            item.appType.toString().toLowerCase().contains(value) ||
            item.appType.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static sitePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialSubItemPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialSubname.toString().toLowerCase().contains(value) ||
            item.materialSubname.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialHeadItemPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialHead.toString().toLowerCase().contains(value) ||
            item.materialHead.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static materialName_StockAtSitePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialName.toString().toLowerCase().contains(value) ||
            item.materialName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static subcontPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.subContName.toString().toLowerCase().contains(value) ||
            item.subContName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static supplierNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value) ||
            item.balqty.toString().toLowerCase().contains(value) ||
            item.balqty.toString().toUpperCase().contains(value) ||
            item.scale.toString().toLowerCase().contains(value) ||
            item.scale.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialName_DPRNew(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialName.toString().toLowerCase().contains(value) ||
            item.materialName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static cmpNMRLabourNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.labourName.toString().toLowerCase().contains(value) ||
            item.labourName.toString().toUpperCase().contains(value)  ||
            item.categoryName.toString().toLowerCase().contains(value)  ||
            item.categoryName.toString().toUpperCase().contains(value)  ||
            item.wages.toString().toLowerCase().contains(value)  ||
            item.wages.toString().toUpperCase().contains(value)  ||
            item.wages.toString().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialSubnamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialSubname.toString().toLowerCase().contains(value) ||
            item.materialSubname.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  // static empNameamePopupAlert(String value,list)  {
  //   dummyListData.value.clear();
  //   if (value.isNotEmpty) {
  //     list.forEach((item) {
  //       if (item.staffName.toString().toLowerCase().contains(value) ||
  //           item.staffName.toString().toUpperCase().contains(value))
  //       {
  //         dummyListData.value.add(item);
  //       }
  //     });
  //     return  dummyListData.value;
  //   }
  //   else {
  //     return  list;
  //   }
  // }

  static empNameamePopupAlert(String value, List list,type) {

    if (value.isEmpty) {
      return list;
    }

    return list.where((item) {
      return type == "staffVoucher"
          ? item.employeeName
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase())
          : item.staffName
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase());
    }).toList();
  }

  static bankNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.bank.toString().toLowerCase().contains(value) ||
            item.bank.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static typeNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.typeName.toString().toLowerCase().contains(value) ||
            item.typeName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static paymodePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.paymode.toString().toLowerCase().contains(value) ||
            item.paymode.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static acPayForNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.acPayForName.toString().toLowerCase().contains(value) ||
            item.acPayForName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  //--------poapprovalSupplierlist------------
  static searchPoApproval_SupplierList(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.billdate.toString().toLowerCase().contains(value) ||
            item.billdate.toString().toUpperCase().contains(value) ||
            item.rate.toString().toLowerCase().contains(value) ||
            item.rate.toString().toUpperCase().contains(value) ||
            item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static headItemPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.headItem.toString().toLowerCase().contains(value) ||
            item.headItem.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static accTypePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.accType.toString().toLowerCase().contains(value) ||
            item.accType.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static accNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.accName.toString().toLowerCase().contains(value) ||
            item.accName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static materialPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value) ||
            item.scale.toString().toLowerCase().contains(value) ||
            item.scale.toString().toUpperCase().contains(value) ||
            item.stockQty.toString().toLowerCase().contains(value) ||
            item.stockQty.toString().toUpperCase().contains(value)
        ) {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static itemDescPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.itemDesc.toString().toLowerCase().contains(value) ||
            item.itemDesc.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static filterSearchTodayReport(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.staffName.toString().toLowerCase().contains(value) ||
            item.staffName.toString().toUpperCase().contains(value)  ||
            item.punchInTime.toString().contains(value) ||
            item.punchInProjectName.toString().toUpperCase().contains(value) ||
            item.punchInProjectName.toString().toLowerCase().contains(value) ||
            item.punchOutTime.toString().contains(value) ||
            item.punchOutProjectName.toString().toLowerCase().contains(value) ||
            item.punchOutProjectName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchStaffRequisiton(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.date.toString().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.requisitionType.toString().toLowerCase().contains(value) ||
            item.requisitionType.toString().toUpperCase().contains(value) ||
            item.StaffName.toString().toLowerCase().contains(value) ||
            item.StaffName.toString().toUpperCase().contains(value) ||
            item.empName.toString().toLowerCase().contains(value) ||
            item.empName.toString().toUpperCase().contains(value) ||
            item.requisitionNo.toString().toLowerCase().contains(value) ||
            item.requisitionNo.toString().toUpperCase().contains(value) ||
            item.LeaveReason.toString().toLowerCase().contains(value) ||
            item.LeaveReason.toString().toUpperCase().contains(value) ||
            item.leaveFromDate.toString().toLowerCase().contains(value) ||
            item.leaveFromDate.toString().toUpperCase().contains(value) ||
            item.leaveToDate.toString().toLowerCase().contains(value) ||
            item.leaveToDate.toString().toUpperCase().contains(value) ||
            item.totalLeaveDays.toString().toLowerCase().contains(value) ||
            item.totalLeaveDays.toString().toUpperCase().contains(value) ||
            item.no.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchOndutyPunchIn(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.punchNo.toString().toLowerCase().contains(value) ||
            item.punchNo.toString().toUpperCase().contains(value) ||
            item.punchInDate.toString().toLowerCase().contains(value) ||
            item.punchInDate.toString().toUpperCase().contains(value) ||
            item.punchOutDate.toString().toLowerCase().contains(value) ||
            item.punchOutDate.toString().toUpperCase().contains(value) ||
            item.designationName.toString().toLowerCase().contains(value) ||
            item.designationName.toString().toUpperCase().contains(value) ||
            item.employeeName.toString().toLowerCase().contains(value) ||
            item.employeeName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsPendingList(String value, list) {
    if (value.isEmpty) {
      return list.value;
    } else {
      return list.where((item) {
        return item.no.toString().contains(value) ||
            item.date.toString().toLowerCase().contains(value) ||
            item.date.toString().toUpperCase().contains(value) ||
            item.dueDate.toString().toLowerCase().contains(value) ||
            item.dueDate.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.preparedBy.toString().toLowerCase().contains(value) ||
            item.preparedBy.toString().toUpperCase().contains(value) ||
            item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.netAmt.toString().toLowerCase().contains(value) ||
            item.netAmt.toString().toUpperCase().contains(value) ||
            item.potype.toString().toLowerCase().contains(value) ||
            item.potype.toString().toUpperCase().contains(value)  ||
            item.delaydays.toString().toLowerCase().contains(value) ||
            item.delaydays.toString().toUpperCase().contains(value) ||
            item.quotecount.toString().toLowerCase().contains(value) ||
            item.quotecount.toString().toUpperCase().contains(value);
      }).toList();
    }
  }

  static companyNMRLabPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.NMRLabourAttendanceNo.toString().toLowerCase().contains(value) ||
            item.NMRLabourAttendanceNo.toString().toUpperCase().contains(value) ||
            item.NMRLabourAttendanceDate1.toString().toLowerCase().contains(value) ||
            item.NMRLabourAttendanceDate1.toString().toUpperCase().contains(value) ||
            item.ProjectName.toString().toLowerCase().contains(value) ||
            item.ProjectName.toString().toUpperCase().contains(value) ||
            item.SiteName.toString().toLowerCase().contains(value) ||
            item.SiteName.toString().toUpperCase().contains(value) ||
            item.subcontractName.toString().toLowerCase().contains(value) ||
            item.subcontractName.toString().toUpperCase().contains(value) ||
            item.createdByName.toString().toLowerCase().contains(value) ||
            item.createdByName.toString().toUpperCase().contains(value) ||
            item.Labcount.toString().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static formatDate(DateTime date) => DateFormat.yMd().format(date);

  static String dateformat(String date){
    String data="";
    DateTime format= new DateFormat('yyyy-MM-dd').parse(date);
    var inputDate = DateTime.parse(format.toString());
    var outputFormat = DateFormat('dd / MMM / yyyy');
    var outputDate = outputFormat.format(inputDate);
    data=outputDate.toString();
    return data;
  }


  static String amountFormat(double value) {
    final numberFormatter = NumberFormat(
      "##,##,##0.00",
      "en_IN", // local US
    ).format(value);
    return numberFormatter;
  }

}


