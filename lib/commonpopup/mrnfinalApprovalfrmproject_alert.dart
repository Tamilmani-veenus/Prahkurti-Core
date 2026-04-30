import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/utilities/print_logger.dart';
import '../controller/mrn_finalapproval_controller.dart';
import '../controller/mrn_preapproval_controller.dart';
import '../controller/mrn_request_indent_controller.dart';
import '../controller/pendinglistcontroller.dart';
import '../models/project_name_response.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import '../models/project_dropdownlist_model.dart';

class MrnFinalAprFrProjectAlert extends StatefulWidget {
  MrnFinalAprFrProjectAlert({Key? key,required this.list,required this.data}) : super(key: key);
  List<Result> list = [];
  var data;

  @override
  State<MrnFinalAprFrProjectAlert> createState() => _MrnFinalAprFrProjectAlertState();
}

class _MrnFinalAprFrProjectAlertState extends State<MrnFinalAprFrProjectAlert> {
  MrnFinalApprovalController mrnFinalApprovalController=Get.put(MrnFinalApprovalController());
  PendingListController pendingListController=Get.put(PendingListController());
  MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
  final editingController = TextEditingController();
  var id=0;

  @override
  void initState() {
    mrnFinalApprovalController.mainlist!.clear();
    mrnFinalApprovalController.mainlist = widget.list;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: BaseUtitiles.getheightofPercentage(context, 4),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    mrnFinalApprovalController.mainlist = BaseUtitiles.projectPopupAlert(value,widget.list);
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    labelText: "Search",
                    labelStyle: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                    prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 55),
              child: ListView.builder(
                  itemCount: mrnFinalApprovalController.mainlist!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {

                        var result = mrnFinalApprovalController.mrnfinalAppDetList.value.first;

                        if (result.mMatReqMasLink != null) {

                          // ✅ INIT ONCE
                          mrnFinalApprovalController.itemlist_textControllersInitiate();

                          // ✅ FIND CORRECT INDEX
                          int indexFound = result.mMatReqMasLink!
                              .indexWhere((e) => e.reqMasDetId == widget.data);

                          if (indexFound != -1) {

                            mrnFinalApprovalController.TransfrProject_ListController[indexFound].text =
                            mrnFinalApprovalController.mainlist![index].project!;

                            mrnFinalApprovalController.projectId[indexFound].text =
                                mrnFinalApprovalController.mainlist![index].projectId.toString();

                            print("Updated Index: $indexFound");
                            print("Value: ${mrnFinalApprovalController.TransfrProject_ListController[indexFound].text}");
                          }

                          // ✅ CALL ONLY ONCE
                          await mrnFinalApprovalController.finalApproval_updateConsumTables();
                        }

                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  width:
                                  BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(mrnFinalApprovalController.mainlist![index].project.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                              Divider(
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}


class MrnPreaproProjectAlert extends StatefulWidget {
    MrnPreaproProjectAlert({Key? key,required this.list,required this.data}) : super(key: key);
  List<Result> list = [];
  var data;

  @override
  State<MrnPreaproProjectAlert> createState() => _MrnPreaproProjectAlertState();
}

class _MrnPreaproProjectAlertState extends State<MrnPreaproProjectAlert> {
  MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
  PendingListController pendingListController=Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  final editingController = TextEditingController();
  var id=0;

  @override
  void initState() {
    mrnPreApprovalController.mainlist!.clear();
    mrnPreApprovalController.mainlist = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              height: BaseUtitiles.getheightofPercentage(context, 4),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    mrnPreApprovalController.mainlist = BaseUtitiles.projectPopupAlert(value,widget.list);
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    labelText: "Search",
                    labelStyle: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                    prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 55),
              child: ListView.builder(
                  itemCount: mrnPreApprovalController.mainlist!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () async {
                          var result = mrnPreApprovalController.mrnPreAppDetList.value.first;
                          if (result.mMatReqMasLink != null) {
                            mrnPreApprovalController.itemlist_textControllersInitiate();
                            int indexFound = result.mMatReqMasLink!
                                .indexWhere((e) => e.reqMasDetId == widget.data);
                            if (indexFound != -1) {
                              mrnPreApprovalController.mrnpre_TransfrProject_ListController[indexFound].text =
                              mrnPreApprovalController.mainlist![index].project!;

                              mrnPreApprovalController.mrnpre_projectId[indexFound].text =
                                  mrnPreApprovalController.mainlist![index].projectId.toString();

                              print("Updated Index: $indexFound");
                              print("Value: ${mrnPreApprovalController.mrnpre_TransfrProject_ListController[indexFound].text}");
                            }
                            await mrnPreApprovalController.Approval_updateConsumTables();
                          }
                          Navigator.pop(context);

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                  child: Text(mrnPreApprovalController.mainlist![index].project.toString(), textAlign: TextAlign.center,style: const TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                              Divider(
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}



