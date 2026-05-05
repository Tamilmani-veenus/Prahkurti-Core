import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../../controller/bottomsheet_Controllers.dart';
import '../../../../../controller/commonvoucher_controller.dart';
import '../../../../../controller/projectcontroller.dart';
import '../../../../../controller/sitecontroller.dart';
import '../../../../../controller/sitevoucher_controller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';

class Site_Voucher_Sitewise extends StatefulWidget {
  const Site_Voucher_Sitewise({Key? key}) : super(key: key);

  @override
  State<Site_Voucher_Sitewise> createState() => _Site_Voucher_SitewiseState();
}

class _Site_Voucher_SitewiseState extends State<Site_Voucher_Sitewise> {

  SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());
  ProjectController projectController=Get.put(ProjectController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  final SiteController siteController=Get.put(SiteController());
  CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());
  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());


  @override
  void initState() {
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId.value=0;
    commonVoucherController.detVoucherTypeController.text="--SELECT--";
    commonVoucherController.detVocType="0";
    siteVoucher_Controller.DetAmount.text="0.0";
    siteVoucher_Controller.Tds.text="0.0";
    siteVoucher_Controller.Tdsamount.text="0.0";
    siteVoucher_Controller.NetAmount.text="0.0";
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        bottomNavigationBar: Container(
          height: BaseUtitiles.getheightofPercentage(context, 4),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:  Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text("Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: (){
                      Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20 , right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: Text( "OK",  style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                        color:   Colors.white),),
                  ),
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      await siteVoucher_Controller.Sitevoucher_Save_DB(context);
                      await siteVoucher_Controller.getsitevoucherTablesDatas();
                      siteVoucher_Controller.netamountCalculation();
                    }
                    },
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SiteWise Payment",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: siteController.Sitename,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Site Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.siteName

                            ),
                          ),
                          onTap: () async {
                            await siteController.subcontEntry_siteDropdowntList(context, 0);
                              bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                              return '\u26A0 Required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.detVoucherTypeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "PaymentType",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types

                            ),
                          ),
                          onTap: () async {
                            await commonVoucherController.getPaymentTypeList();
                            bottomsheetControllers.PaymentType(
                                context,
                                commonVoucherController
                                    .paymentTypeList.value);
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
                              return '\u26A0 Required';
                            }
                            return null;
                          },

                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  controller: siteVoucher_Controller.DetAmount,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Amount",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.amount

                                    ),
                                  ),
                                  onTap: (){
                                    if(siteVoucher_Controller.DetAmount.text=="0.0"){
                                      siteVoucher_Controller.DetAmount.text="";
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value == 0.00 || value == 0 || value == "0.0") {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value){
                                    siteVoucher_Controller.calculation(double.parse(
                                        siteVoucher_Controller.DetAmount.text == "" ? "0" :
                                        siteVoucher_Controller.DetAmount.text),
                                        double.parse(siteVoucher_Controller.Tds.text == "" ? "0" :
                                        siteVoucher_Controller.Tds.text));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  controller: siteVoucher_Controller.Tds,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "TDS %",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.tds

                                    ),
                                  ),
                                  onChanged: (value){
                                      siteVoucher_Controller.calculation(double.parse(
                                          siteVoucher_Controller.DetAmount.text == "" ? "0" :
                                          siteVoucher_Controller.DetAmount.text),
                                          double.parse(siteVoucher_Controller.Tds.text == "" ? "0" :
                                          siteVoucher_Controller.Tds.text));
                                  },
                                  onTap: (){
                                    if(siteVoucher_Controller.Tds.text == "0.0"){
                                      siteVoucher_Controller.Tds.text = "";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                readOnly: true,
                                controller: siteVoucher_Controller.Tdsamount,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "TDS Amount",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.amount

                                  ),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    siteVoucher_Controller.calculation(double.parse(siteVoucher_Controller.DetAmount.text), double.parse(siteVoucher_Controller.Tds.text));
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                readOnly: true,
                                controller: siteVoucher_Controller.NetAmount,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Net Amount",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.netAmt

                                  ),
                                ),
                                onChanged: (value){
                                  setState(() {
                                    siteVoucher_Controller.calculation(double.parse(siteVoucher_Controller.DetAmount.text),
                                        double.parse(siteVoucher_Controller.Tds.text));
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
