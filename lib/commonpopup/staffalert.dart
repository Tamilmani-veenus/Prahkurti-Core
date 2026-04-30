import '../controller/cashbookstaff_controller.dart';
import '../controller/staffcontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffShowPopup extends StatefulWidget {
  const StaffShowPopup({Key? key, required this.list,required this.value}) : super(key: key);
  final List list;
  final int value;

  @override
  State<StaffShowPopup> createState() => _StaffShowPopupState();
}

class _StaffShowPopupState extends State<StaffShowPopup> {

  var id=0;
  TextEditingController editingController = TextEditingController();
  StaffController staffController=Get.put(StaffController());
  CashBookStaffController cashBookStaffController=Get.put(CashBookStaffController());

  @override
  void initState() {
    staffController.mainlist.value.clear();
    staffController.mainlist.value=widget.list;
    super.initState();
  }

  @override
  Widget  build(BuildContext context)  {
    return  AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
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
                      staffController.mainlist.value=BaseUtitiles.empNameamePopupAlert(value,widget.list);
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      labelText: "Search",
                      labelStyle: TextStyle(

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
                    itemCount: staffController.mainlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async{
                          staffController.setSelectedStaffID(staffController.mainlist.value[index].empName!);
                          await cashBookStaffController.getcashbookstaffdetails();
                          cashBookStaffController.calculations();
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
                                    child: Text(staffController.mainlist.value[index].empName
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
