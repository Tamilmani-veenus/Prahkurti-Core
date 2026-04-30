import '../../../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LabourAddBoqPopup extends StatefulWidget {
   LabourAddBoqPopup({Key? key,required this.list}) : super(key: key);
   final List list;

  @override
  State<LabourAddBoqPopup> createState() => _LabourAddBoqPopupState();
}

class _LabourAddBoqPopupState extends State<LabourAddBoqPopup> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());

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
                      setState(() {});
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Colors.white,
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
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (editingController.text.isEmpty) {
                          return InkWell(
                            onTap: (){
                              dailyWrkDone_DPRLabour_Controller.dprLabour_DetTable_Delete();
                              dailyWrkDone_DPRLabour_Controller.dprLabour_DetTableSave(widget.list[index]);
                              dailyWrkDone_DPRLabour_Controller.getDetTablesDatas();
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
                                        child: Text(widget.list[index].itemDesc
                                            .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.App_Font_SIZE),)),
                                    Divider(
                                      color: Theme.of(context).primaryColorLight,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        else if (widget.list[index].itemDesc
                            .toString().toLowerCase()
                            .contains(editingController.text)||widget.list[index].itemDesc
                            .toString().toUpperCase()
                            .contains(editingController.text))   {
                          return InkWell(
                            onTap: (){
                              dailyWrkDone_DPRLabour_Controller.dprLabour_DetTable_Delete();
                              dailyWrkDone_DPRLabour_Controller.dprLabour_DetTableSave(widget.list[index]);
                              dailyWrkDone_DPRLabour_Controller.getDetTablesDatas();
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
                                        child: Text(widget.list[index].itemDesc
                                            .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.App_Font_SIZE),)),
                                    Divider(
                                      color: Theme.of(context).primaryColorLight,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return Container();
                        }
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
