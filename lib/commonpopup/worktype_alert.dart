
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/attendancecontroller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

//-----DPR------------
class WorkTypeAlert extends StatefulWidget {
  const WorkTypeAlert({Key? key}) : super(key: key);

  @override
  State<WorkTypeAlert> createState() => _WorkTypeAlertState();
}

class _WorkTypeAlertState extends State<WorkTypeAlert> {

  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());

  // final list=["No Work","NMR","RATE"];
  final list=["NMR","RATE"];

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
                child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          dailyEntriesController.deleteSubcontDetTableDatas();
                          dailyEntriesController.readListdata.value=[];
                          // if(index==0){
                          //   dailyEntriesController.WorkTypeTextController.text="No Work";
                          //   dailyEntriesController.Nmr_Rate.value = RequestConstant.W;
                          // }else
                            if(index==0){
                            dailyEntriesController.WorkTypeTextController.text="NMR";
                            dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
                          }
                          else {
                            dailyEntriesController.WorkTypeTextController.text="RATE";
                            dailyEntriesController.Nmr_Rate.value = RequestConstant.R;

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
                                    child: Text(list[index].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),

                                if (index < list.length - 1)
                                  Divider(color: Theme.of(context).primaryColorLight),
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

//---Subcontractor Attendance----------------
class ShiftAlert extends StatefulWidget {
  const ShiftAlert({super.key});

  @override
  State<ShiftAlert> createState() => _ShiftAlertState();
}

class _ShiftAlertState extends State<ShiftAlert> {

  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  final list=["Half Mor (6Am - 9Am)","Full Day (9Am - 6Pm)","Half Night (6Pm - 10Pm)","Full Night (6Pm - 2Am)" ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8, // Set max height
          maxWidth: MediaQuery.of(context).size.width * 0.8,  // Set max width
        ),
        child: SizedBox(

          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Container(
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  color: Theme.of(context).primaryColor,
                  child: Center(child: Text("Shift Type",style: TextStyle(color: Colors.white),)),
                ),


                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.18, // Set max height
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: ()  {
                            dailyEntriesController.deleteSubcontDetTableDatas();
                            dailyEntriesController.readListdata.value=[];

                            if(index==0){
                              dailyEntriesController.shiftTextController.text=list[index];
                              dailyEntriesController.shiftType.value = "M";
                            }else if(index==1){
                              dailyEntriesController.shiftTextController.text=list[index];
                              dailyEntriesController.shiftType.value = "D";
                            }else if(index==2){
                              dailyEntriesController.shiftTextController.text=list[index];
                              dailyEntriesController.shiftType.value = "N";
                            }
                            else if(index==3) {
                              dailyEntriesController.shiftTextController.text=list[index];
                              dailyEntriesController.shiftType.value = "F";
                            }
                            dailyEntriesController.deleteSubcontDetTableDatas();
                            dailyEntriesController.readListdata.value.clear();
                            // dailyEntriesController.getDetTablesDatas();
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
                                      child: Text(list[index].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                  Divider(color: Theme.of(context).primaryColorLight)
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
      ),
    );
  }
}

//--------Attendance Report-----------

class WorkType_AttendRPT extends StatefulWidget {
  const WorkType_AttendRPT({Key? key}) : super(key: key);

  @override
  State<WorkType_AttendRPT> createState() => _WorkType_AttendRPTState();
}

class _WorkType_AttendRPTState extends State<WorkType_AttendRPT> {
  AttendanceController attendanceController =Get.put(AttendanceController());

  final list=["Nmr","Rate"];
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
              height: BaseUtitiles.getheightofPercentage(context, 4),
              color: Theme.of(context).primaryColor,
              child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context,13),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()  {
                        if(index==0){
                          attendanceController.workTypeController.text="Nmr";
                          attendanceController.wrktype.value = RequestConstant.N;
                        }
                        else {
                          attendanceController.workTypeController.text="Rate";
                          attendanceController.wrktype.value= RequestConstant.R;
                        }
                        attendanceController.attendanceDatas.value=[];
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
    );
  }
}

//---------DPR REPORT-------------
class wrkTypeAlertAll extends StatefulWidget {
  const wrkTypeAlertAll({Key? key}) : super(key: key);

  @override
  State<wrkTypeAlertAll> createState() => _wrkTypeAlertAllState();
}

class _wrkTypeAlertAllState extends State<wrkTypeAlertAll> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());

  final list=["NMR","RATE"];
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
              height: BaseUtitiles.getheightofPercentage(context, 4),
              color: Theme.of(context).primaryColor,
              child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context,13),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()  {
                        if(index==0){
                          dailyWrkDone_DPR_Controller.workType_DPR_Controller.text="NMR";
                          dailyWrkDone_DPR_Controller.wrktype_DPR.value = "NMR";
                        }
                        else {
                        dailyWrkDone_DPR_Controller.workType_DPR_Controller.text="RATE";
                        dailyWrkDone_DPR_Controller.wrktype_DPR.value= "RATE";
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
    );
  }
}




