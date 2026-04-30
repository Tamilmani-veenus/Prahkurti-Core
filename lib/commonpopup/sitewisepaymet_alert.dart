import '../commonpopup/sitewisepaymenttype_alert.dart';
import '../controller/commonvoucher_controller.dart';

import '../controller/sitevoucher_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/sitecontroller.dart';

class SitewisePaymentAlert extends StatefulWidget {
  const SitewisePaymentAlert({Key? key}) : super(key: key);

  @override
  State<SitewisePaymentAlert> createState() => _SitewisePaymentAlertState();
}

class _SitewisePaymentAlertState extends State<SitewisePaymentAlert> {
  SiteController siteController = Get.put(SiteController());
  SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
  CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());

  @override
  void initState(){
    siteController.Sitename.text=RequestConstant.SELECT;
    commonVoucherController.detVoucherTypeController.text="Advance";
    commonVoucherController.detVocType="A";
    siteVoucher_Controller.DetAmount.text="0.00";
    siteVoucher_Controller.Tds.text="0.00";
    siteVoucher_Controller.Tdsamount.text="0.00";
    siteVoucher_Controller.NetAmount.text="0.00";

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
                child: Text("SiteWise Payment",style: TextStyle(fontSize: 13,color: Colors.white),),
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
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
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
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
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
                          controller: siteVoucher_Controller.DetAmount,
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
                              siteVoucher_Controller.calculation(double.parse(siteVoucher_Controller.DetAmount.text), double.parse(siteVoucher_Controller.Tds.text));
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
                          controller: siteVoucher_Controller.Tds,
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
                              siteVoucher_Controller.calculation(double.parse(siteVoucher_Controller.DetAmount.text), double.parse(siteVoucher_Controller.Tds.text));
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
                          controller: siteVoucher_Controller.Tdsamount,
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
                          controller: siteVoucher_Controller.NetAmount,
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
                        onTap: ()async{
                          if(siteController.selectedsiteId.value==0){
                            BaseUtitiles.showToast("Please select Site");

                          }else{
                            await siteVoucher_Controller.Sitevoucher_Save_DB(context);
                            await  siteVoucher_Controller.getsitevoucherTablesDatas();
                            siteVoucher_Controller.netamountCalculation();
                          }
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
    );
  }
}
