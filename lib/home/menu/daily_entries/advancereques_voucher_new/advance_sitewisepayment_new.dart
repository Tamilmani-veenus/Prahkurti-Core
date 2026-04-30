import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/sitewisepaymenttype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_new_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class advance_sitewisepayment_new extends StatefulWidget {
  const advance_sitewisepayment_new({Key? key}) : super(key: key);

  @override
  State<advance_sitewisepayment_new> createState() => _advance_sitewisepayment_newState();
}

class _advance_sitewisepayment_newState extends State<advance_sitewisepayment_new> {
  AdvanceReqVoucherController_new advanceReqVoucherController_new =Get.put(AdvanceReqVoucherController_new());
  SiteController siteController=Get.put(SiteController());
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState(){
    siteController.Sitename.text="--SELECT--";
    siteController.selectedsiteId = 0.obs;
    commonVoucherController.detVoucherTypeController.text="--SELECT--";
    commonVoucherController.detVocType="0";
    advanceReqVoucherController_new.itemlistDetAmount.text="0.00";
    advanceReqVoucherController_new.itemlistTds_Percent.text="0.00";
    advanceReqVoucherController_new.itemlistTdsamount.text="0.00";
    advanceReqVoucherController_new.itemlistNetAmount.text="0.00";
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
                        color:  advanceReqVoucherController_new.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                      ),
                      alignment: Alignment.center,
                      child: Text("Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                            color:  advanceReqVoucherController_new.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        advanceReqVoucherController_new.checkColor = 1;
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
                        color: advanceReqVoucherController_new.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                      ),
                      alignment: Alignment.center,
                      child: Text( "OK",  style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  advanceReqVoucherController_new.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                    ),
                    onTap: () async {

                      advanceReqVoucherController_new.checkColor = 0;

                      // if(advanceReqVoucherController_new.vocId==0){
                      //
                      // }else{
                      if(siteController.selectedsiteId.value==0){
                        BaseUtitiles.showToast("Please select site name");
                      }
                      else if(commonVoucherController.detVocType=="0"){
                        BaseUtitiles.showToast("Please select payment type");
                      }
                      else{
                        await advanceReqVoucherController_new.itemlistPopup_saveLabTableDatas(context);
                        await advanceReqVoucherController_new.getItemlistTablesDatas();
                        await advanceReqVoucherController_new.netamountCalculation();
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
                            if (value!.isEmpty || value == "--SELECT--") {
                              return '\u26A0 Please select site name';
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
                                  return SitewisepaymentTypeAlert(from: 'Advance req voucher');
                                });
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "--Select--") {
                              return '\u26A0 Please select payment type';
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
                                  controller: advanceReqVoucherController_new.itemlistDetAmount,
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
                                      advanceReqVoucherController_new.calculation(double.parse(advanceReqVoucherController_new.itemlistDetAmount.text), double.parse(advanceReqVoucherController_new.itemlistTds_Percent.text));
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value == "--Select--") {
                                      return '\u26A0 Please select project name.';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    if(advanceReqVoucherController_new.itemlistDetAmount.text=="0.00"){
                                      advanceReqVoucherController_new.itemlistDetAmount.text="";
                                    }
                                  },

                                ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        //     child: Card(
                        //       shape: RoundedRectangleBorder(
                        //         side: BorderSide(color: Colors.white70, width: 1),
                        //         borderRadius: BorderRadius.circular(15),
                        //       ),
                        //       elevation: 3,
                        //       child: Padding(
                        //         padding:
                        //         const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        //         child: TextFormField(
                        //           keyboardType: TextInputType.number,
                        //           controller: advanceReqVoucherController_new.itemlistTds_Percent,
                        //           cursorColor: Colors.black,
                        //           style: TextStyle(color: Colors.black),
                        //           decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.zero,
                        //             border: InputBorder.none,
                        //             labelText: "TDS %",
                        //             labelStyle: TextStyle(
                        //                 color: Colors.grey,
                        //                 fontSize: RequestConstant.Lable_Font_SIZE),
                        //             prefixIconConstraints:
                        //             BoxConstraints(minWidth: 0, minHeight: 0),
                        //             prefixIcon: Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     vertical: 8, horizontal: 8),
                        //                 child: ConstIcons.tds
                        //
                        //             ),
                        //           ),
                        //           onChanged: (value){
                        //             setState(() {
                        //               advanceReqVoucherController_new.calculation(double.parse(advanceReqVoucherController_new.itemlistDetAmount.text), double.parse(advanceReqVoucherController_new.itemlistTds_Percent.text));
                        //             });
                        //           },
                        //           validator: (value) {
                        //             if (value!.isEmpty || value == "--Select--") {
                        //               return '\u26A0 Please select project name.';
                        //             }
                        //             return null;
                        //           },
                        //           onTap: (){
                        //             if(advanceReqVoucherController_new.itemlistTds_Percent.text=="0.00"){
                        //               advanceReqVoucherController_new.itemlistTds_Percent.text="";
                        //             }
                        //           },
                        //
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(color: Colors.white70, width: 1),
                  //             borderRadius: BorderRadius.circular(15),
                  //           ),
                  //           elevation: 3,
                  //           child: Padding(
                  //             padding:
                  //             const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                  //             child: TextFormField(
                  //               readOnly: true,
                  //               controller: advanceReqVoucherController_new.itemlistTdsamount,
                  //               cursorColor: Colors.black,
                  //               style: TextStyle(color: Colors.black),
                  //               decoration: InputDecoration(
                  //                 contentPadding: EdgeInsets.zero,
                  //                 border: InputBorder.none,
                  //                 labelText: "TDS Amount",
                  //                 labelStyle: TextStyle(
                  //                     color: Colors.grey,
                  //                     fontSize: RequestConstant.Lable_Font_SIZE),
                  //                 prefixIconConstraints:
                  //                 BoxConstraints(minWidth: 0, minHeight: 0),
                  //                 prefixIcon: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         vertical: 8, horizontal: 8),
                  //                     child: ConstIcons.amount
                  //
                  //                 ),
                  //               ),
                  //               onChanged: (value){
                  //                 // setState(() {
                  //                 //   staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                  //                 // });
                  //               },
                  //               validator: (value) {
                  //                 if (value!.isEmpty || value == "--Select--") {
                  //                   return '\u26A0 Please select project name.';
                  //                 }
                  //                 return null;
                  //               },
                  //
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(color: Colors.white70, width: 1),
                  //             borderRadius: BorderRadius.circular(15),
                  //           ),
                  //           elevation: 3,
                  //           child: Padding(
                  //             padding:
                  //             const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                  //             child: TextFormField(
                  //               readOnly: true,
                  //               controller: advanceReqVoucherController_new.itemlistNetAmount,
                  //               cursorColor: Colors.black,
                  //               style: TextStyle(color: Colors.black),
                  //               decoration: InputDecoration(
                  //                 contentPadding: EdgeInsets.zero,
                  //                 border: InputBorder.none,
                  //                 labelText: "Net Amount",
                  //                 labelStyle: TextStyle(
                  //                     color: Colors.grey,
                  //                     fontSize: RequestConstant.Lable_Font_SIZE),
                  //                 prefixIconConstraints:
                  //                 BoxConstraints(minWidth: 0, minHeight: 0),
                  //                 prefixIcon: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         vertical: 8, horizontal: 8),
                  //                     child: ConstIcons.netAmt
                  //
                  //                 ),
                  //               ),
                  //               onChanged: (value){
                  //                 // setState(() {
                  //                 //   staffVoucher_Controller.calculation(double.parse(staffVoucher_Controller.DetAmount.text), double.parse(staffVoucher_Controller.Tds.text));
                  //                 // });
                  //               },
                  //               validator: (value) {
                  //                 if (value!.isEmpty || value == "--Select--") {
                  //                   return '\u26A0 Please select project name.';
                  //                 }
                  //                 return null;
                  //               },
                  //
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              )


          )

      ),
    );
  }
}
