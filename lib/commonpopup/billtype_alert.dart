import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auto_yrwise_no_controller.dart';
import '../controller/billgeneration_boq_controller.dart';
import '../controller/billgenerationdirect_controller.dart';
import '../controller/inward_pending_controller.dart';
import '../controller/nmrweeklybill_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class BillType_Alert extends StatefulWidget {
  const BillType_Alert({Key? key}) : super(key: key);


  @override
  State<BillType_Alert> createState() => _BillType_AlertState();
}

class _BillType_AlertState extends State<BillType_Alert> {

  BillGenerationDirectController billGenerationDirectController = Get.put(BillGenerationDirectController());
  BillGenerationBoqController billGenerationBoqController=Get.put(BillGenerationBoqController());


  List<String> list = ["Company","Client"];

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
                child: const Center(child: Text("Bill Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,15),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  async {
                          if(index==0){
                            billGenerationDirectController.DirectBillTypeText.text="Company";
                            billGenerationDirectController.directBillTypeID.value="C";
                            billGenerationBoqController.DirectBillTypeText.text = "Company";
                            billGenerationBoqController.directBillTypeID.value="C";

                          }
                          else{
                            billGenerationDirectController.DirectBillTypeText.text="Client";
                            billGenerationDirectController.directBillTypeID.value="I";
                            billGenerationBoqController.DirectBillTypeText.text="Client";
                            billGenerationBoqController.directBillTypeID.value="C";

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