import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/reports_controller.dart';
import '../models/onclick_pendinglist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class QuoteApproveAlert extends StatefulWidget {
  final String heading;
  final int? id;
  final String no;
  final int? pId;
  final int? companyId;

  QuoteApproveAlert(
      {Key? key,
        required this.heading,
        required this.id,
        required this.no,
        required this.pId,
        required this.companyId,
      })
      : super(key: key);

  @override
  State<QuoteApproveAlert> createState() => _QuoteApproveAlertState();
}

class _QuoteApproveAlertState extends State<QuoteApproveAlert> {
  PendingListController pendingListController =
  Get.put(PendingListController());
  ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    pendingListController.checkboxval = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppClient.isVrindhavana? AlertDialog(
      backgroundColor: Setmybackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              child: Text(
                'Company Name',
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: Text(
                textAlign: TextAlign.right,
                widget.no.toString(),
                style:
                TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
              )),
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
                    if(reportsController.selectedCompanyId.value==0){
                      BaseUtitiles.showToast("Please select company");
                    }
                    else if (pendingListController.checkboxval == false) {
                      BaseUtitiles.showToast("Please select supplier");
                    }
                    else{
                      if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                        await pendingListController.getPurcharseOrderNo(reportsController.selectedCompanyId.value,type: "companywise");
                        await pendingListController.quotVerifyAprovalbuttonApi(
                            context, widget.id!, "Approve",
                           companyId:reportsController.selectedCompanyId.value,
                            quoteMasId: pendingListController.quoteid.value,
                        );
                      }
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
    ) : AlertDialog(
      backgroundColor: Setmybackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              child: Text(
                'Choose Supplier',
                style: TextStyle(fontSize: 14),
              )),
          Expanded(
              child: Text(
                textAlign: TextAlign.right,
                widget.no.toString(),
                style:
                TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
              )),
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
                    if (pendingListController.checkboxval == true) {
                      if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                        await pendingListController.getPurcharseOrderNo(widget.pId);
                        await pendingListController.quotVerifyAprovalbuttonApi(
                            context, widget.id!, "Approve",
                            quoteMasId: pendingListController.quoteid.value,
                            companyId: widget.companyId
                        );
                      }
                    } else {
                      BaseUtitiles.showToast("Please select supplier");
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

  Widget listDetails() {
    return AppClient.isVrindhavana? Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
              left: 3, bottom: 3),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              const BorderRadius.all(
                  Radius.circular(10)),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 8),
              child: Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Center(
                      child: Text(
                        "--SELECT--",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    value: reportsController.selectedCompanyId.value == 0
                        ? null
                        : reportsController.selectedCompanyId.value.toString(),

                    items: reportsController.getCompanyDropDownvalue.map((item) {
                      return DropdownMenuItem<String>(
                        value: item["id"].toString(),
                        child: Center(
                          child: Text(
                            item["companyName"].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      if (value == null) return;

                      // Store selected ID
                      reportsController.selectedCompanyId.value = int.parse(value);

                      // Store selected Company Name
                      final selectedItem = reportsController.getCompanyDropDownvalue.firstWhere(
                            (e) => e["id"].toString() == value,
                      );

                      reportsController.companyName.text =
                          selectedItem["companyName"].toString();
                    },

                    buttonStyleData: ButtonStyleData(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColor,
                      ),
                      iconSize: 22,
                    ),

                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),

                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
        SizedBox(height: 15,),
        Text(
           "Supplier Name",
           style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
         ),
        SizedBox(height: 10,),
        Container(
          height: 300,
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
                              pendingListController.supplierList.forEach(
                                      (supplier) => supplier.isChecked = false);
                              pendingListController.setCheck(
                                  pendingListController
                                      .supplierList[supplierIndex].id,
                                  value!);
                              pendingListController.supplierList[supplierIndex]
                                  .isChecked = value;
                              pendingListController.checkboxval =
                                  pendingListController
                                      .supplierList[supplierIndex].isChecked;
                            });
                          },
                          value: pendingListController
                              .supplierList[supplierIndex].isChecked,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 45),
                              child: Text(
                                pendingListController
                                    .supplierList[supplierIndex]
                                    .supplierName ??
                                    "-",
                                style: TextStyle(
                                  fontSize: RequestConstant.ALERT_Font_SIZE,
                                  fontWeight: FontWeight.normal,
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
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                          "Net Amt: ${pendingListController.supplierList[supplierIndex].netAmount ?? "-"}",
                                          style: TextStyle(
                                            color:
                                            Theme.of(context).primaryColor,
                                            fontSize:
                                            RequestConstant.App_Font_SIZE,
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
          )),
        ),
      ],
    ) : Container(
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
                          pendingListController.supplierList.forEach(
                                  (supplier) => supplier.isChecked = false);
                          pendingListController.setCheck(
                              pendingListController
                                  .supplierList[supplierIndex].id,
                              value!);
                          pendingListController.supplierList[supplierIndex]
                              .isChecked = value;
                          pendingListController.checkboxval =
                              pendingListController
                                  .supplierList[supplierIndex].isChecked;
                        });
                      },
                      value: pendingListController
                          .supplierList[supplierIndex].isChecked,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          width: BaseUtitiles.getWidthtofPercentage(
                              context, 45),
                          child: Text(
                            pendingListController
                                .supplierList[supplierIndex]
                                .supplierName ??
                                "-",
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
                                      fontSize:
                                      RequestConstant.Lable_Font_SIZE),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                      "Net Amt: ${pendingListController.supplierList[supplierIndex].netAmount ?? "-"}",
                                      style: TextStyle(
                                        color:
                                        Theme.of(context).primaryColor,
                                        fontSize:
                                        RequestConstant.App_Font_SIZE,
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
      )),
    );
  }
}
