import '../controller/billgenerationdirect_controller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/nmrweeklybill_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/subcontcontroller.dart';

class SubcontractorShowPopup extends StatefulWidget {
  const SubcontractorShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<SubcontractorShowPopup> createState() => _SubcontractorShowPopupState();
}

class _SubcontractorShowPopupState extends State<SubcontractorShowPopup> {
  TextEditingController editingController = TextEditingController();
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  NMRWklyController nmrWklyController=Get.put(NMRWklyController());
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  var id=0;



  @override
  void initState() {

    subcontractorController.mainlist.value.clear();
    subcontractorController.mainlist.value=widget.list;
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
        child: Container(
          //height: BaseUtitiles.getheightofPercentage(context, 60),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      subcontractorController.mainlist.value=BaseUtitiles.subcontPopupAlert(value,widget.list);
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      labelText: "Search",
                      labelStyle: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                      prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: subcontractorController.mainlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async{
                          if(subcontractorController.selectedSubcontId!=0){
                            await showDialog(
                              context: context,
                              builder: (BuildContext context)  {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text('Do you want change the SubContractor?'),
                                  actions: [
                                    ElevatedButton(
                                      // textColor: Colors.black,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'),
                                    ),
                                    ElevatedButton(
                                      // textColor: Colors.black,
                                      onPressed: () async{
                                        id=1;
                                        subcontractorController.setSelectedSubcontID(subcontractorController.mainlist.value[index].subContName!);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if(id==1){
                              await nmrWklyController.getNmrAdvance();
                              await billGenerationDirectController.getNmrAdvance();
                              dailyEntriesController.deleteSubcontDetTableDatas();
                              dailyEntriesController.readListdata.clear();
                              Navigator.pop(context);
                            }
                            else{
                              await nmrWklyController.getNmrAdvance();
                              await billGenerationDirectController.getNmrAdvance();
                              Navigator.pop(context);
                            }
                          }
                          else{
                            subcontractorController.setSelectedSubcontID(subcontractorController.mainlist.value[index].subContName!);
                            await nmrWklyController.getNmrAdvance();
                            await billGenerationDirectController.getNmrAdvance();
                            Navigator.pop(context);
                          }
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
                                    child: Text(subcontractorController.mainlist.value[index].subContName
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


class LabourDetailsAlert extends StatefulWidget {
  const LabourDetailsAlert({Key? key, required this.list}) : super(key: key);
  final List list;


  @override
  State<LabourDetailsAlert> createState() => _LabourDetailsAlertState();
}

class _LabourDetailsAlertState extends State<LabourDetailsAlert> {
  TextEditingController editingController = TextEditingController();
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());

  @override
  void initState() {
    subcontractorController.labourmainList.value.clear();
    subcontractorController.labourmainList.value=widget.list;
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
        child: Container(
          //height: BaseUtitiles.getheightofPercentage(context, 60),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      subcontractorController.labourmainList.value=BaseUtitiles.subcontPopupAlert(value,widget.list);
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      labelText: "Search",
                      labelStyle: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                      prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: subcontractorController.labourmainList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async{
                          subcontractorController.setSelectedLabourID(subcontractorController.labourmainList.value[index].labourName!);
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
                                    child: Text(subcontractorController.labourmainList.value[index].labourName.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
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

