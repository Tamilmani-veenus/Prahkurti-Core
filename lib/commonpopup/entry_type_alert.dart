
import '../controller/dailywrk_done_dpr_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class EntryTypeAlert extends StatefulWidget {
  const EntryTypeAlert({Key? key}) : super(key: key);

  @override
  State<EntryTypeAlert> createState() => _EntryTypeAlertState();
}

class _EntryTypeAlertState extends State<EntryTypeAlert> {

  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  final list=["BOQ"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("Entry Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            if(index==0){
                              dailyWrkDone_DPR_Controller.entryTypeController.text="BOQ";
                              dailyWrkDone_DPR_Controller.entryType="B";
                              dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
                            }
                            else {
                              // dailyWrkDone_DPR_Controller.entryTypeController.text="NMR";
                              // dailyWrkDone_DPR_Controller.entryType="N";
                              // dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
                            }
                            await dailyWrkDone_DPR_Controller.dpr_getSubcotType();
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
                                      width:
                                      BaseUtitiles.getWidthtofPercentage(
                                          context, 60),
                                      child: Text(list[index]
                                          .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
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
      ),
    );
  }
}



class EntryTypeAlert_DPR_New extends StatefulWidget {
  const EntryTypeAlert_DPR_New({Key? key}) : super(key: key);

  @override
  State<EntryTypeAlert_DPR_New> createState() => _EntryTypeAlert_DPR_NewState();
}

class _EntryTypeAlert_DPR_NewState extends State<EntryTypeAlert_DPR_New> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  // final list=["BOQ","NMR"];
  final list=["RATE","NMR"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("Entry Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          if(index==0){
                            dailyWrkDone_DPR_Controller.entryTypeController.text="RATE";
                            dailyWrkDone_DPR_Controller.entryType="B";
                            dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
                          }
                          else {
                            dailyWrkDone_DPR_Controller.entryTypeController.text="NMR";
                            dailyWrkDone_DPR_Controller.entryType="N";
                            dailyWrkDone_DPR_Controller.setSelectedTypeSubcontListName(0);
                          }
                          await dailyWrkDone_DPR_Controller.dpr_getSubcotType();
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
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(list[index]
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
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
      ),
    );
  }
}



