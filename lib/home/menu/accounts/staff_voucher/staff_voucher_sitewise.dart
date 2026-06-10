import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/sitewisepaymenttype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/sitevoucher_controller.dart';
import '../../../../controller/staffvoucher_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class staff_voucher_sitewise extends StatefulWidget {
  const staff_voucher_sitewise({Key? key}) : super(key: key);

  @override
  State<staff_voucher_sitewise> createState() => _staff_voucher_sitewiseState();
}

class _staff_voucher_sitewiseState extends State<staff_voucher_sitewise> {

  StaffVoucher_Controller staffVoucher_Controller=Get.put(StaffVoucher_Controller());
  ProjectController projectController=Get.put(ProjectController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  final SiteController siteController=Get.put(SiteController());
  CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());
  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());

  @override
  void initState() {
    staffVoucher_Controller.DetAmount.text="0.0";
    staffVoucher_Controller.Tds.text="0.0";
    staffVoucher_Controller.Tdsamount.text="0.0";
    staffVoucher_Controller.NetAmount.text="0.0";
    projectController.projectname.text="--SELECT--";
    projectController.selectedProjectId.value= 0;
    siteController.Sitename.text="--SELECT--";
    siteController.selectedsiteId.value=0;
    commonVoucherController.detVoucherTypeController.text="--SELECT--";
    commonVoucherController.detVocType="0";
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
                      color:   Colors.white ,
                    ),
                    alignment: Alignment.center,
                    child: Text("Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.pop(context);
                    });
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
                        color:  Colors.white),),
                  ),
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      await staffVoucher_Controller.Sitevoucher_Save_DB(context);
                      await staffVoucher_Controller.getstaffvouchersiteTablesDatas();
                      staffVoucher_Controller.netamountCalculation();
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
                        controller: projectController.projectname,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Project Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.projectName),
                        ),
                        onTap: () async {
                          await projectController.getProjectList();
                          bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
                        },

                        validator: (value) {
                          if (value!.isEmpty || value == "--SELECT--" || value == "--Select--") {
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
                        onTap: () {
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
                                controller: staffVoucher_Controller.DetAmount,
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
                                onChanged: (value){
                                  setState(() {
                                    staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                                  });
                                },
                                onTap: (){
                                  if(staffVoucher_Controller.DetAmount.text=="0.0"){
                                    staffVoucher_Controller.DetAmount.text="";
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == 0.00 || value == 0 || value == "0.0") {
                                    return '\u26A0 Required';
                                  }
                                  return null;
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
                                controller: staffVoucher_Controller.Tds,
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
                                  setState(() {
                                    staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                                  });
                                },
                                onTap: (){
                                  if(staffVoucher_Controller.Tds.text == "0.0"){
                                    staffVoucher_Controller.Tds.text = "";
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
                              controller: staffVoucher_Controller.Tdsamount,
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
                                  staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
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
                              controller: staffVoucher_Controller.NetAmount,
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
                                  staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
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
