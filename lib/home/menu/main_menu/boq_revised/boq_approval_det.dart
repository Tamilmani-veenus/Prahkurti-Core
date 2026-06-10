import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/boqrevised_controller.dart';
import '../../../../controller/pendinglistcontroller.dart';
import '../../../../models/boq_approval_det_model.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class BOQ_Approve_Det_List extends StatefulWidget {
  const BOQ_Approve_Det_List({Key? key,
    required this.entryNo,
    required this.entryDate,
    required this.projectName,
    required this.siteName,
  }) : super(key: key);

  final entryNo;
  final entryDate;
  final projectName;
  final siteName;


  @override
  State<BOQ_Approve_Det_List> createState() => _BOQ_Approve_Det_ListState();
}

class _BOQ_Approve_Det_ListState extends State<BOQ_Approve_Det_List> {
  PendingListController pendingListController = Get.put(PendingListController());
  Boq_Revised_Controller boq_revised_controller = Get.put(Boq_Revised_Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        bottomNavigationBar: Container(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  width: BaseUtitiles.getWidthtofPercentage(context, 27),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor),
                  alignment: Alignment.center,
                  child: Text("Approve",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: RequestConstant.Lable_Font_SIZE,
                        color: Colors.white),
                  ),
                ),
                onTap: () async {
                  bool isCheckboxSelected = boq_revised_controller
                      .approvalGetByIdList[0]
                      .boqReviseDets
                      .any((BoqReviseDet value) =>
                  value.isCheck == true);

                  bool isAppQtyEmpty = boq_revised_controller
                      .approvalGetByIdList[0]
                      .boqReviseDets
                      .any((BoqReviseDet value) {
                    String qtyText = value.qtyController.text.trim();
                    double qty = double.tryParse(qtyText) ?? 0;
                    return value.isCheck == true && (qtyText.isEmpty || qty <= 0);
                  });

                  if (isCheckboxSelected) {
                    if (isAppQtyEmpty) {
                      BaseUtitiles.showToast(
                          "Please enter Approved Qty");
                    } else {
                      await SubmitAlert(context);
                    }
                  } else {
                    BaseUtitiles.showToast(
                        "Please select item");
                  }
                },
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
                      const Text(
                        "BOQ REVISED - APPROVAL",
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
                  margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: Text(widget.entryNo.toString(), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      ConstIcons.list_date,
                                      Text(widget.entryDate.toString()),
                                    ],
                                  )),
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                flex: 2,
                                child: Text("Project Name:")),
                            Expanded(
                                flex: 3,
                                child: Text(widget.projectName.toString())),
                          ],),
                          SizedBox(height: 5),
                          Row(children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name:")),
                            Expanded(
                                flex: 3,
                                child: Text(widget.siteName.toString())),
                          ],),
                          SizedBox(height: 5),

                        ],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1,
                    color: Theme.of(context).primaryColor
                ),
                ListDetails(),
              ],)
        ),
      ),
    );
  }

  Widget ListDetails(){
    return Column(
      children: [
        Container(
          height: BaseUtitiles.getheightofPercentage(context, 68),
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Obx(() => boq_revised_controller.approvalGetByIdList[0].boqReviseDets.length==0?SizedBox():ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: boq_revised_controller.approvalGetByIdList[0].boqReviseDets.length,
            itemBuilder: (BuildContext context, int index) {
              var det = boq_revised_controller
                  .approvalGetByIdList[0]
                  .boqReviseDets[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Text(det.itemDescription.toString(),style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor ),)),

                      Expanded(
                        flex: 1,
                        child: Container(
                          child:  Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(width: 1.0, color: Colors.grey),
                              ),
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  boq_revised_controller.setCheckApproval(det.id, value!);
                                  det.isCheck=value;
                                });
                              },
                              value: det.isCheck
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("BOQ Code", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 2,
                          child: Text(det.boQcode.toString())),
                      Expanded(
                          flex: 2,
                          child: Text("Head Name", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(det.measureHeadItemName.toString()))
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Unit", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(det.scaleName.toString())),
                      Expanded(
                          flex: 2,
                          child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(det.rate.toString())),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Boq Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(det.qty.toString())),
                      Expanded(
                          flex: 2,
                          child: Text("Revised Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(det.reviseQty.toString())),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Approved Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold),)),

                    ],
                  ),
                  SizedBox(height: 5,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              controller: det.qtyController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration:  InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                labelText: "Approved Qty",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon( Icons.launch_sharp, color: Color(0xFF4B3FFF),size: 20,)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              controller: det.remarksController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                contentPadding: EdgeInsets.zero,
                                labelText: "Remarks",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// REMARKS

                  SizedBox(height: 5,),

                  Divider(color: Theme.of(context).primaryColor,),
                ],
              );
            },) ),
        ),
      ],
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Approve?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),

                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                            await boq_revised_controller.ApproveBoqRevisedScreen(
                                context, boq_revised_controller.approvalGetByIdList[0]);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(RequestConstant.APPROVAL,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
