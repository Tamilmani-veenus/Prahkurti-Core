import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/company_nmr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';


class CompanyNmr_ListAlert extends StatefulWidget {
  const CompanyNmr_ListAlert({Key? key}) : super(key: key);

  @override
  State<CompanyNmr_ListAlert> createState() => _CompanyNmr_ListAlertState();

}

class _CompanyNmr_ListAlertState extends State<CompanyNmr_ListAlert> {
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  TextEditingController editingController = TextEditingController();
  String datas="";

@override
  void initState() {
  companyNmrAttendanceController.list.value.clear();
  companyNmrAttendanceController.isChecked=List<bool>.filled(companyNmrAttendanceController.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: BaseUtitiles.getheightofPercentage(context, 71),
            width: BaseUtitiles.getWidthtofPercentage(context, 100),
            child: Column(
              children: <Widget>[
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 100),
                  color: Colors.indigo.shade800,
                  child: Center(child: Text("Labour Lists",style: TextStyle(color: Colors.white,fontSize: 18))),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  child: TextField(
                    onChanged: (value) async{
                      setState(() {
                         datas=value;
                         companyNmrAttendanceController.list.value=  BaseUtitiles.cmpNMRLabourNamePopupAlert(value,companyNmrAttendanceController.AlldataList.value);
                      });
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        labelText: "Search",
                        labelStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                        prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Container(
                    height: BaseUtitiles.getheightofPercentage(context, 54),
                    margin: const EdgeInsets.only(top: 10),
                    child: ListSDetatils()),

                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  width: BaseUtitiles.getWidthtofPercentage(context, 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      //background color of button
                      side: BorderSide(width: 3, color: Colors.black),
                      //border width and color
                      elevation: 3,
                      //elevation of button
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),),
                    child: Text(RequestConstant.OK),
                    onPressed: () async{
                      await companyNmrAttendanceController.cmpNmr_Det_Save_DB(context);
                      //Navigator.pop(context);
                      await companyNmrAttendanceController.getcmpNMRTablesDatas();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }


  Widget ListSDetatils(){
    if(datas.isEmpty){
      return ListView.builder(
          itemCount: companyNmrAttendanceController.AlldataList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(companyNmrAttendanceController.AlldataList[index].Labour_No.toString(),style: TextStyle(color: Colors.red,fontSize: 14),)),
                      Expanded(
                          flex: 2,
                          child: Text(companyNmrAttendanceController.AlldataList[index].categaryName.toString(),style: TextStyle(color: Colors.indigo,fontSize: 14))),
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                            onChanged: (value) {
                              setState(() {
                                companyNmrAttendanceController.setCheck(companyNmrAttendanceController.AlldataList[index].labourId,value!);
                                companyNmrAttendanceController.AlldataList[index].ischeck=value;

                              });

                            },
                            value:  companyNmrAttendanceController.AlldataList[index].ischeck

                        ),
                      ),
                    ],

                  ),
                  Text(companyNmrAttendanceController.AlldataList[index].labourName.toString(),style: TextStyle(color: Colors.black,fontSize: 14)),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            );
          });
    }
    else if(companyNmrAttendanceController.list.isNotEmpty){
      return ListView.builder(
          itemCount: companyNmrAttendanceController.list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                BaseUtitiles.showToast("$index");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(companyNmrAttendanceController.list[index].Labour_No.toString(),style: TextStyle(color: Colors.red,fontSize: 14),),
                      Text(companyNmrAttendanceController.list[index].categaryName.toString(),style: TextStyle(color: Colors.indigo,fontSize: 14)),
                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              companyNmrAttendanceController.serachsetCheck(companyNmrAttendanceController.list[index].labourId,value!);
                              companyNmrAttendanceController.list[index].ischeck=value;

                            });

                          },
                          value:  companyNmrAttendanceController.list[index].ischeck

                      ),
                    ],

                  ),
                  Text(companyNmrAttendanceController.list[index].labourName.toString(),style: TextStyle(color: Colors.black,fontSize: 14)),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            );
          });
    }
    else{
      return Container();
    }

  }
}
