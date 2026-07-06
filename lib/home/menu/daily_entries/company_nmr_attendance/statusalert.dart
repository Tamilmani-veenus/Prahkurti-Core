import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/company_nmr_controller.dart';
import '../../../../db_model/companynmr_atd_labourlist_dbmodel.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class StatusAlert extends StatefulWidget {
    StatusAlert( {Key? key,required this.value}) : super(key: key);
    var value;
  @override
  State<StatusAlert> createState() => _StatusAlertState();
}

class _StatusAlertState extends State<StatusAlert> {
  var companyNMRTableModel =new CompanyNMRDetTableModel();
  // final list=["Present","Absent","Half-Day","Just"];
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());

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
                child: Center(child: Text("Status",style: TextStyle(color: Colors.white),)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,15),
                child: ListView.builder(
                    itemCount: companyNmrAttendanceController.labourStatusList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  async {
                          int i=0;
                          companyNmrAttendanceController.cmpNmr_getDbDetList.forEach((element) {
                            if(widget.value==element.labourId){
                                companyNmrAttendanceController.statusText[i].text=companyNmrAttendanceController.labourStatusList[index]["name"];
                                companyNmrAttendanceController.statusKeyText[i].text= companyNmrAttendanceController.labourStatusList[index]["type"];
                            }
                            i++;
                          });
                         await companyNmrAttendanceController.updateDBTables();
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
                                    child: Text(companyNmrAttendanceController.labourStatusList[index]["name"]
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
