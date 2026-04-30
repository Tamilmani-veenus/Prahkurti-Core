import '../controller/commonvoucher_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymodeShowPopup extends StatefulWidget {
  const PaymodeShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<PaymodeShowPopup> createState() => _PaymodeShowPopupState();
}

class _PaymodeShowPopupState extends State<PaymodeShowPopup> {
  TextEditingController editingController = TextEditingController();

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());


  @override
  void initState() {
    commonVoucherController.paymodeList.value.clear();
    commonVoucherController.paymodeList.value=widget.list;
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
                      commonVoucherController.paymodeList.value=BaseUtitiles.paymodePopupAlert(value,widget.list);
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
                    itemCount: commonVoucherController.paymodeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          commonVoucherController.setSelectedPaymodeID(commonVoucherController.paymodeList.value[index].paymode!);
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
                                    child: Text(commonVoucherController.paymodeList.value[index].paymode
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
