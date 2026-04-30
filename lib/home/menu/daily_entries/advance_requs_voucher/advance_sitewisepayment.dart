import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/sitewisepaymenttype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class advance_sitewisepayment extends StatefulWidget {
  const advance_sitewisepayment({Key? key}) : super(key: key);

  @override
  State<advance_sitewisepayment> createState() => _advance_sitewisepaymentState();
}

class _advance_sitewisepaymentState extends State<advance_sitewisepayment> {

  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  SiteController siteController=Get.put(SiteController());
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState(){
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId = 0.obs;
    commonVoucherController.detVoucherTypeController.text="Advance";
    commonVoucherController.detVocType="A";
    advanceReqVoucherController.itemlistDetAmount.text="0.00";
    advanceReqVoucherController.itemlistTds_Percent.text="0.00";
    advanceReqVoucherController.itemlistTdsamount.text="0.00";
    advanceReqVoucherController.itemlistNetAmount.text="0.00";
  }


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
                        color:  advanceReqVoucherController.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                      ),
                      alignment: Alignment.center,
                      child: Text("Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                            color:  advanceReqVoucherController.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        advanceReqVoucherController.checkColor = 1;
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
                        color: advanceReqVoucherController.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                      ),
                      alignment: Alignment.center,
                      child: Text( "OK",  style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  advanceReqVoucherController.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                    ),
                    onTap: () async {
                      advanceReqVoucherController.checkColor = 0;

                      if(advanceReqVoucherController.vocId==0){

                        }else{
                        await advanceReqVoucherController.itemlistPopup_saveLabTableDatas(context);
                        await advanceReqVoucherController.getItemlistTablesDatas();
                        }

                    },
                  ),
                ),
              ],
            ),
          ),
        body: SingleChildScrollView(
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
                         await siteController.subcontEntry_siteDropdowntList(context,0);
                          bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
                        // siteController.subcontEntry_siteDropdowntList(context,0);
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select project name.';
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
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SitewisepaymentTypeAlert(from: '',);
                            });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select project name.';
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
                              keyboardType: TextInputType.number,
                              controller: advanceReqVoucherController.itemlistDetAmount,
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
                                  advanceReqVoucherController.calculation(double.parse(advanceReqVoucherController.itemlistDetAmount.text), double.parse(advanceReqVoucherController.itemlistTds_Percent.text));
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select project name.';
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
                              keyboardType: TextInputType.number,
                              controller: advanceReqVoucherController.itemlistTds_Percent,
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
                                  advanceReqVoucherController.calculation(double.parse(advanceReqVoucherController.itemlistDetAmount.text), double.parse(advanceReqVoucherController.itemlistTds_Percent.text));
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select project name.';
                                }
                                return null;
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
                            controller: advanceReqVoucherController.itemlistTdsamount,
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
                              // setState(() {
                              //   staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                              // });
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select project name.';
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
                            readOnly: true,
                            controller: advanceReqVoucherController.itemlistNetAmount,
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
                              // setState(() {
                              //   staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                              // });
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select project name.';
                              }
                              return null;
                            },

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),






            ],
          )


        )

      ),
    );
  }
}
