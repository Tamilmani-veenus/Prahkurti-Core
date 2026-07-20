import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/workorderDirect_Controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class WorkOrderType_Alert extends StatefulWidget {
  const WorkOrderType_Alert({Key? key}) : super(key: key);


  @override
  State<WorkOrderType_Alert> createState() => _WorkOrderType_AlertState();
}

class _WorkOrderType_AlertState extends State<WorkOrderType_Alert> {

  WorkOrderDirectController workOrderDirectController=Get.put(WorkOrderDirectController());

  List<String> list = ["Active","Inactive"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: const Center(child: Text("Active Status",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,12),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  async {
                          if(index==0){
                            workOrderDirectController.WorkOrdActiveTypeText.text="Active";
                            workOrderDirectController.workOrdActTypeID.value="Y";
                          }
                          else{
                            workOrderDirectController.WorkOrdActiveTypeText.text="Inactive";
                            workOrderDirectController.workOrdActTypeID.value="N";
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
                                    child: Text(list[index].toString(), textAlign: TextAlign.center,style: const TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(color: Theme.of(context).primaryColorLight,)
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
      ),
    );
  }
}




class WorkOrderStsType_Alert extends StatefulWidget {
  const WorkOrderStsType_Alert({Key? key}) : super(key: key);

  @override
  State<WorkOrderStsType_Alert> createState() => _WorkOrderStsType_AlertState();
}

class _WorkOrderStsType_AlertState extends State<WorkOrderStsType_Alert> {

  WorkOrderDirectController workOrderDirectController=Get.put(WorkOrderDirectController());

  List<String> list = ["Pending","Completed"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: const Center(child: Text("Work Status",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,12),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  async {
                          if(index==0){
                            workOrderDirectController.WorkStatusTypeText.text="Pending";
                            workOrderDirectController.workOrdStsTypeId.value="P";
                          }
                          else{
                            workOrderDirectController.WorkStatusTypeText.text="Completed";
                            workOrderDirectController.workOrdStsTypeId.value="C";
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
                                    child: Text(list[index].toString(), textAlign: TextAlign.center,style: const TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(color: Theme.of(context).primaryColorLight,)
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
      ),
    );
  }
}