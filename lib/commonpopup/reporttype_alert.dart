import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class ReportType_Alert extends StatefulWidget {
  const ReportType_Alert({Key? key}) : super(key: key);

  @override
  State<ReportType_Alert> createState() => _ReportType_AlertState();
}

class _ReportType_AlertState extends State<ReportType_Alert> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  final list = ["Detailed Report", "Abstract Report"];

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
              child: Center(
                  child: Text(
                "Report Type",
                style: TextStyle(color: Colors.white),
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 13),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          dailyWrkDone_DPR_Controller.reportTypeController.text = "Detailed Report";
                          dailyWrkDone_DPR_Controller.reportType.value = 1;
                        } else {
                          dailyWrkDone_DPR_Controller
                              .reportTypeController.text = "Abstract Report";
                          dailyWrkDone_DPR_Controller.reportType.value = 2;
                        }
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(
                                    list[index].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                            RequestConstant.ALERT_Font_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )),
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
