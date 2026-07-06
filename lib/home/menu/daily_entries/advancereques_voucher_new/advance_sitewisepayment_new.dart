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
  State<advance_sitewisepayment_new> createState() =>
      _advance_sitewisepayment_newState();
}

class _advance_sitewisepayment_newState
    extends State<advance_sitewisepayment_new> {
  AdvanceReqVoucherController_new advanceReqVoucherController_new =
      Get.put(AdvanceReqVoucherController_new());
  SiteController siteController = Get.put(SiteController());
  CommonVoucherController commonVoucherController =
      Get.put(CommonVoucherController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    siteController.Sitename.text = "--SELECT--";
    siteController.selectedsiteId = 0.obs;
    commonVoucherController.detVoucherTypeController.text = "--SELECT--";
    commonVoucherController.detVocType = "0";
    advanceReqVoucherController_new.itemlistDetAmount.text = "0.00";
    advanceReqVoucherController_new.itemlistTds_Percent.text = "0.00";
    advanceReqVoucherController_new.itemlistTdsamount.text = "0.00";
    advanceReqVoucherController_new.itemlistNetAmount.text = "0.00";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Form(
        key: _formKey,
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
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "OK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white),
                        ),
                      ),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (siteController.selectedsiteId.value == 0) {
                            BaseUtitiles.showToast("Please select site name");
                          } else if (commonVoucherController.detVocType ==
                              "0") {
                            BaseUtitiles.showToast(
                                "Please select payment type");
                          } else {
                            await advanceReqVoucherController_new
                                .itemlistPopup_saveLabTableDatas(context);
                            await advanceReqVoucherController_new
                                .getItemlistTablesDatas();
                            await advanceReqVoucherController_new
                                .netamountCalculation();
                          }
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
                        autovalidateMode:
                        AutovalidateMode.always,
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
                              child: ConstIcons.siteName),
                        ),
                        onTap: () async {
                          await siteController.subcontEntry_siteDropdowntList(
                              context, 0);
                          bottomsheetControllers.SiteName(context,
                              siteController.getSiteDropdownvalue.value);
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == "--SELECT--") {
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
                        autovalidateMode:
                        AutovalidateMode.always,
                        readOnly: true,
                        controller:
                            commonVoucherController.detVoucherTypeController,
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
                              child: ConstIcons.types),
                        ),
                        onTap: () async {
                          await commonVoucherController.getPaymentTypeList();
                          bottomsheetControllers.PaymentType(context,
                              commonVoucherController.paymentTypeList.value);
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == "--SELECT--") {
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
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.always,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                controller: advanceReqVoucherController_new
                                    .itemlistDetAmount,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Amount",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.amount),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    advanceReqVoucherController_new.calculation(
                                        double.tryParse(
                                                advanceReqVoucherController_new
                                                    .itemlistDetAmount.text) ??
                                            0.0,
                                        double.tryParse(
                                                advanceReqVoucherController_new
                                                    .itemlistTds_Percent
                                                    .text) ??
                                            0.0);
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty || (double.tryParse(value) ?? 0) <= 0) {
                                    return '\u26A0 Required';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  if (advanceReqVoucherController_new
                                          .itemlistDetAmount.text ==
                                      "0.00") {
                                    advanceReqVoucherController_new
                                        .itemlistDetAmount.text = "";
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
              ],
            ))),
      ),
    );
  }
}
