import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class TypeSubcontAlert extends StatefulWidget {
  const TypeSubcontAlert({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<TypeSubcontAlert> createState() => _TypeSubcontAlertState();
}

class _TypeSubcontAlertState extends State<TypeSubcontAlert> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());

  @override
  void initState() {

    dailyWrkDone_DPR_Controller.dpr_subcontractorList.value=dailyWrkDone_DPR_Controller.submainList.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
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
                        dailyWrkDone_DPR_Controller.dpr_subcontractorList.value=BaseUtitiles.subcontPopupAlert(value,dailyWrkDone_DPR_Controller.submainList.value);
                      });
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor,
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
                      itemCount: dailyWrkDone_DPR_Controller.dpr_subcontractorList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            dailyWrkDone_DPR_Controller.SelectedTypeSubcontID(dailyWrkDone_DPR_Controller.dpr_subcontractorList.value[index].subContName!);
                            await dailyWrkDone_DPRNEW_Controller.getLabourList();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourTableSave();
                            dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
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
                                      child: Text(dailyWrkDone_DPR_Controller.dpr_subcontractorList.value[index].subContName
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
      ]),
    );


  }






}
