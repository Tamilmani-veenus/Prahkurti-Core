
import '../../../../commonpopup/sitewisepaymenttype_alert.dart';
import '../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';



class SitewisePaymentAlert extends StatefulWidget {
  const SitewisePaymentAlert({Key? key}) : super(key: key);

  @override
  State<SitewisePaymentAlert> createState() => _SitewisePaymentAlertState();
}

class _SitewisePaymentAlertState extends State<SitewisePaymentAlert> {
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  SiteController siteController=Get.put(SiteController());

  @override
  void initState(){
    siteController.Sitename.text=RequestConstant.SELECT;
    commonVoucherController.detVoucherTypeController.text="Advance";
    commonVoucherController.detVocType="A";

    advanceReqVoucherController.itemlistDetAmount.text="0.00";
    advanceReqVoucherController.itemlistTds_Percent.text="0.00";
    advanceReqVoucherController.itemlistTdsamount.text="0.00";
    advanceReqVoucherController.itemlistNetAmount.text="0.00";

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: BaseUtitiles.getWidthtofPercentage(context, 100),
            height: BaseUtitiles.getheightofPercentage(context,40),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: Text("SiteWise Payment",style: TextStyle(fontSize: 10),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 5),
                  width: BaseUtitiles.getWidthtofPercentage(context, 90),
                  child: TextField(
                    style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                    readOnly: true,
                    controller: siteController.Sitename,
                    decoration: new InputDecoration(
                      labelText:RequestConstant.SITE_NAME,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                    ),
                    onTap: () {
                      siteController.subcontEntry_siteDropdowntList(context,0);
                    },
                  ),
                ),
                Container(
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(),
                  child: TextField(
                    readOnly: true,
                    controller: commonVoucherController.detVoucherTypeController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "PaymentType",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                    ),
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  SitewisepaymentTypeAlert(from: '',);
                          });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 1,top: 10),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          child: Text("Amount",style: TextStyle(fontSize: 13),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(),
                          child: TextField(
                            style: TextStyle(fontSize: 10),
                            keyboardType: TextInputType.number,
                            controller: advanceReqVoucherController.itemlistDetAmount,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              border: OutlineInputBorder(),

                            ),
                            onChanged: (value){
                              setState(() {
                                advanceReqVoucherController.calculation(double.parse(advanceReqVoucherController.itemlistDetAmount.text), double.parse(advanceReqVoucherController.itemlistTds_Percent.text));
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,top: 10),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          child: Text("TDS %",style: TextStyle(fontSize: 13),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(),
                          child: TextField(
                            style: TextStyle(fontSize: 10),
                            keyboardType: TextInputType.number,
                            controller: advanceReqVoucherController.itemlistTds_Percent,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              border: OutlineInputBorder(),

                            ),
                            onChanged: (value){
                              setState(() {
                                advanceReqVoucherController.calculation(double.parse(advanceReqVoucherController.itemlistDetAmount.text), double.parse(advanceReqVoucherController.itemlistTds_Percent.text));
                              });
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 1,top: 10),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          child: Text("TDS Amount",style: TextStyle(fontSize: 13),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(),
                          child: TextField(
                            readOnly: true,
                            style: TextStyle(fontSize: 13),
                            controller: advanceReqVoucherController.itemlistTdsamount,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              border: OutlineInputBorder(),

                            ),
                            onChanged: (value){
                              //nmrWklyController.deduction_paymentCalculation();
                            },
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 1,top: 10),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          child: Text("Net Amount",style: TextStyle(fontSize: 13),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(),
                          child: TextField(
                            readOnly: true,
                            style: TextStyle(fontSize: 13),
                            keyboardType: TextInputType.number,
                            controller: advanceReqVoucherController.itemlistNetAmount,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value){
                              //nmrWklyController.deduction_paymentCalculation();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 1,top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: Image.asset('assets/tick.png'),
                          ),
                          onTap: () async {

                           await advanceReqVoucherController.itemlistPopup_saveLabTableDatas(context);
                           await advanceReqVoucherController.getItemlistTablesDatas();

                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 1,top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: Image.asset('assets/cancle.png'),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ]),
    );
  }
}
