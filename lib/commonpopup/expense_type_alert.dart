import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/consumption_controller.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ExpenseTypeAlert extends StatefulWidget {
  const ExpenseTypeAlert({Key? key}) : super(key: key);

  @override
  State<ExpenseTypeAlert> createState() => _ExpenseTypeAlertState();
}

class _ExpenseTypeAlertState extends State<ExpenseTypeAlert> {

  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());

  // final list=["No-Usage","Usage","Scrap","Repair"];


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
                child: Center(child: Text("Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,30),
                child: Obx(()=>
                   ListView.builder(
                    padding: EdgeInsets.zero,
                      itemCount: consumption_controller.Consum_TypeListApiValue.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: ()  {
                            if(consumption_controller.Consum_TypeListApiValue[index].typeId=="NOU" || consumption_controller.Consum_TypeListApiValue[index].typeId=="0"){
                              consumption_controller.delete_Consum_itemlist_Table();
                              consumption_controller.Consum_itemview_GetDbList.clear();
                            }
                            consumption_controller.expenseTypeController.text=consumption_controller.Consum_TypeListApiValue[index].typeName;
                            consumption_controller.expenseType=consumption_controller.Consum_TypeListApiValue[index].typeId;
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
                                      child: Text(consumption_controller.Consum_TypeListApiValue[index].typeName.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                  if (index != consumption_controller.Consum_TypeListApiValue.length - 1) Divider(color: Theme.of(context).primaryColorLight),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
