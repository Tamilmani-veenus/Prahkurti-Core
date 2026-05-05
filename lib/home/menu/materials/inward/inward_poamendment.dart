import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/pendinglistcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Inward_PoAmendment extends StatefulWidget {
  const Inward_PoAmendment({Key? key,
    required this.heading,
    required this.ReqNo,
    required this.PoDate,
    required this.ProjectName,
    required this.SiteName,
    required this.SupplierName,
    required this.purOrdMasId,
    required this.projectId,
    required this.siteId,
    required this.inwdType,


  }) : super(key: key);

  final heading;
  final ReqNo;
  final PoDate;
  final ProjectName;
  final SiteName;
  final SupplierName;
  final purOrdMasId;
  final projectId;
  final siteId;
  final inwdType;


  @override
  State<Inward_PoAmendment> createState() => _Inward_PoAmendmentState();
}

class _Inward_PoAmendmentState extends State<Inward_PoAmendment> {

  InwardPending_Controller inwardPending_Controller=Get.put(InwardPending_Controller());
  PendingListController pendingListController = Get.put(PendingListController());


  @override
  void initState() {
    inwardPending_Controller.add_PoAmdaprovalListvalue.value.clear();
    // inwardPending_Controller.ischecked = List<bool>.filled(inwardPending_Controller.PoAmdList.value.length, false);
    super.initState();
  }


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
                  child: Text("Amendment",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: RequestConstant.Lable_Font_SIZE,
                        color: Colors.white),
                  ),
                ),
                onTap: () async {
                  var isCheckboxSelect= inwardPending_Controller.PoAmdList.value.map((value)=>value.isCheck).toList();

                  if(isCheckboxSelect.contains(true)){
                    await SubmitAlert(context);
                  }else{
                    BaseUtitiles.showToast("Please select material");
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
                        "Po Amendment",
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
                                  child: Text(widget.ReqNo.toString(), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      ConstIcons.list_date,
                                      Text(widget.PoDate.toString()),
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
                                child: Text(widget.ProjectName.toString())),
                          ],),
                          SizedBox(height: 5),
                          Row(children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name:")),
                            Expanded(
                                flex: 3,
                                child: Text(widget.SiteName.toString())),
                          ],),
                          SizedBox(height: 5),
                          Row(children: [
                            Expanded(
                                flex: 2,
                                child: Text("Supplier Name:")),
                            Expanded(
                                flex: 3,
                                child: Text(widget.SupplierName.toString())),
                          ],),

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
          child: Obx(() => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: inwardPending_Controller.PoAmdList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Material", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 6,
                          child: Text(inwardPending_Controller.PoAmdList.value[index].MaterialName.toString())),

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
                                  inwardPending_Controller.setCheck(inwardPending_Controller.PoAmdList.value[index].MaterialId, value!);
                                  inwardPending_Controller.PoAmdList.value[index].isCheck=value;
                                });
                              },
                              value: inwardPending_Controller.PoAmdList.value[index].isCheck
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Unit", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 2,
                          child: Text(inwardPending_Controller.PoAmdList.value[index].unitName.toString())),
                      Expanded(
                          flex: 2,
                          child: Text("Po Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(inwardPending_Controller.PoAmdList.value[index].poqty.toString()))
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("GRN Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(inwardPending_Controller.PoAmdList.value[index].grnQty.toString())),
                      Expanded(
                          flex: 2,
                          child: Text("Bal Qty", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Expanded(
                          flex: 2,
                          child: Text(inwardPending_Controller.PoAmdList.value[index].balqty.toString())),
                    ],
                  ),
                  Divider(color: Theme.of(context).primaryColor,)
                ],
              );
            },) ),
        ),
        // Container(
        //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
        //   height: BaseUtitiles.getheightofPercentage(context, 4),
        //   margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        //   decoration: BoxDecoration(),
        //   child: TextField(
        //     style:TextStyle(fontSize: 13),
        //     textAlign: TextAlign.center,
        //     controller: inwardPending_Controller.InwardAmdRemarksText,
        //     decoration: InputDecoration(
        //       labelText: "Remarks",
        //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        //       border: OutlineInputBorder(),
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //             color: Theme.of(context).primaryColor, width: 1.0),
        //       ),
        //     ),
        //   ),
        // ),
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
                            await inwardPending_Controller.PoAmendment_ApprovalButtonsave(
                                context, widget.purOrdMasId, widget.projectId, widget.siteId, widget.inwdType);
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

