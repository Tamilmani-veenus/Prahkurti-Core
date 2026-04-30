import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MaterialPopup extends StatefulWidget {
  const MaterialPopup({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<MaterialPopup> createState() => _MaterialPopupState();
}

class _MaterialPopupState extends State<MaterialPopup> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());

  @override
  void initState() {
    dailyWrkDone_DPRNEW_Controller.mainlist.value=dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value;
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
                        dailyWrkDone_DPRNEW_Controller.mainlist.value=BaseUtitiles.materialNamePopupAlert(value,dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value);
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
                  child:
                 Obx(() =>  ListView.builder(
                      itemCount: dailyWrkDone_DPRNEW_Controller.mainlist.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            dailyWrkDone_DPRNEW_Controller.setSelectedMaterialID(dailyWrkDone_DPRNEW_Controller.mainlist.value[index].materialName!);
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text=dailyWrkDone_DPRNEW_Controller.selectedMatUnit.toString();
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
                                      child: Text(dailyWrkDone_DPRNEW_Controller.mainlist.value[index].materialName
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
                ),)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
