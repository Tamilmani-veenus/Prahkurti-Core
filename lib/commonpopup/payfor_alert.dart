import '../controller/advance_reqvoucher_new_controller.dart';
import '../controller/commonvoucher_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayforShowPopup extends StatefulWidget {
  const PayforShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<PayforShowPopup> createState() => _PayforShowPopupState();
}

class _PayforShowPopupState extends State<PayforShowPopup> {
  TextEditingController editingController = TextEditingController();

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());


  @override
  void initState() {
    commonVoucherController.payforNamelist.value.clear();
    commonVoucherController.payforNamelist.value=widget.list;
    super.initState();
  }

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
                margin: EdgeInsets.only(top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      commonVoucherController.payforNamelist.value=BaseUtitiles.acPayForNamePopupAlert(value,widget.list);
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
                    itemCount: commonVoucherController.payforNamelist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          commonVoucherController.setSelectedacPayForID(commonVoucherController.payforNamelist.value[index].acPayForName!);
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
                                    child: Text(commonVoucherController.payforNamelist.value[index].acPayForName
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


class Payfor_Alert extends StatefulWidget {
  const Payfor_Alert({Key? key}) : super(key: key);

  @override
  State<Payfor_Alert> createState() => _Payfor_AlertState();
}

class _Payfor_AlertState extends State<Payfor_Alert> {

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  AdvanceReqVoucherController_new advanceReqVoucherController_new = Get.put(AdvanceReqVoucherController_new());
  final list=["Advance"];

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
                child: Center(child: Text("Pay For ",style: TextStyle(color: Colors.white),)),
              ),


              Container(
                margin: const EdgeInsets.only(top: 10),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          if(index==0){
                            commonVoucherController.payforController.text="Advance";
                            commonVoucherController.payfor.value="AD";
                            // advanceReqVoucherController_new.getAdvList();
                          }
                          else{
                            commonVoucherController.payforController.text="NMR Advance";
                            commonVoucherController.payfor.value="NM";
                          }

                          advanceReqVoucherController_new.listButton.value = commonVoucherController.payfor.value == "AD" ? RequestConstant.LIST : "SiteWise List";
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

