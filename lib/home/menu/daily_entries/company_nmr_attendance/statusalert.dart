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
  final list=["Present","Absent","Half-Day","Just"];
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
                margin: const EdgeInsets.only(top: 10),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,15),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      companyNmrAttendanceController.textControllersInitiate();
                      return InkWell(
                        onTap: ()  async {
                          int i=0;
                          companyNmrAttendanceController.cmpNmr_getDbDetList.forEach((element) {
                            companyNmrAttendanceController.textControllersInitiate();
                            if(widget.value==element.labourId){
                              if(index==0){
                                companyNmrAttendanceController.statusText[i].text="Present";
                              }
                              else if(index==1){
                                companyNmrAttendanceController.statusText[i].text="Absent";
                              }else if(index==2){
                                companyNmrAttendanceController.statusText[i].text="Half-Day";
                              }
                              else if(index==3){
                                companyNmrAttendanceController.statusText[i].text="Just";
                              }
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
      ),
    );
  }

}
