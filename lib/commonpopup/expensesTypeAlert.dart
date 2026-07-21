import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/expensencecontroller.dart';
import '../controller/mrn_request_indent_controller.dart';
import '../controller/mrnrequest_preIndent_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class ExpensesRequestType_Alert extends StatefulWidget {
  const ExpensesRequestType_Alert({Key? key}) : super(key: key);

  @override
  State<ExpensesRequestType_Alert> createState() => _ExpensesRequestType_AlertState();
}

class _ExpensesRequestType_AlertState extends State<ExpensesRequestType_Alert> {

   ExpensesController expensesController = Get.put(ExpensesController());

   final list = ["ProjectWise","SiteWise"];

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
                child: const Center(child: Text("Report Type",style: TextStyle(color: Colors.white),)),
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

                          Navigator.pop(context);

                          setState(() {
                            if(index==0){
                              expensesController.ReportTypeController.text="ProjectWise";
                              expensesController.ReportType.value = "P";
                            }
                            else{
                              expensesController.ReportTypeController.text="SiteWise";
                              expensesController.ReportType.value = "S";
                            }
                          });
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