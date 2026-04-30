import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../controller/pendinglistcontroller.dart';
import '../models/onclick_pendinglist_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class QuoteApproveAlert extends StatefulWidget {
  final String heading;
  final int? id;
  final String no;
  final int? pId;
  QuoteApproveAlert({Key? key, required this.heading, required this.id, required this.no, required this.pId}) : super(key: key);


  @override
  State<QuoteApproveAlert> createState() => _QuoteApproveAlertState();
}

class _QuoteApproveAlertState extends State<QuoteApproveAlert> {
  PendingListController pendingListController = Get.put(PendingListController());


  @override
  void initState() {
    pendingListController.checkboxval = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Setmybackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: Text('Choose Supplier', style: TextStyle(fontSize: 14),)),
          Expanded(child: Text(
            textAlign: TextAlign.right,
            widget.no.toString(), style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),)),
        ],
      ),
      content: SizedBox(
        height: 400,
        width: double.maxFinite,
        child: listDetails(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: RequestConstant.Lable_Font_SIZE,
                    ),
                  ),
                ),
              ),
              Container(
                height: 24,
                child: VerticalDivider(
                  color: Colors.grey.shade400,
                  width: 20,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    pendingListController.getQuoteDetList.value.clear();
                    if (pendingListController.checkboxval == true) {
                      await pendingListController
                          .quotVerifyAprovalbuttonApi(
                          context,
                          widget.id!,"Approve",quoteMasId: pendingListController.quoteid.value);
                    } else {
                      BaseUtitiles.showToast( "Please select supplier");
                    }
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    RequestConstant.APPROVAL,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: RequestConstant.Lable_Font_SIZE,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget listDetails(){
    return Container(
      height: 400,
      child: Obx(() => ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(), // Smooth scrolling effect
        itemCount: pendingListController.supplierList.length,
        itemBuilder: (context, supplierIndex) {
          return Container(
            color: Setmybackground,
            margin: EdgeInsets.only(bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                          width: 1.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.supplierList.forEach((supplier) => supplier.isChecked = false);
                          pendingListController.setCheck(pendingListController.supplierList[supplierIndex].id, value!);
                          pendingListController.supplierList[supplierIndex].isChecked = value;
                          pendingListController.checkboxval = pendingListController.supplierList[supplierIndex].isChecked;
                        });
                      },
                      value: pendingListController.supplierList[supplierIndex].isChecked,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          width: BaseUtitiles.getWidthtofPercentage(context, 45),
                          child: Text(
                            pendingListController.supplierList[supplierIndex].supplierName ?? "-",
                            style: TextStyle(
                              fontSize: RequestConstant.ALERT_Font_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 3),
                          child: Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Net Amt: ${pendingListController.supplierList[supplierIndex].netAmount ?? "-"}",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: RequestConstant.App_Font_SIZE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      )
      ),
    );
  }

}

