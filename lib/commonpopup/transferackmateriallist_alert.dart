import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../controller/pendinglistcontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class TransferAckMaterialList extends StatefulWidget {
  const TransferAckMaterialList({Key? key,required this.list,required this.ReqNo}) : super(key: key);

  final List list;
  final String ReqNo;

  @override
  State<TransferAckMaterialList> createState() => _TransferAckMaterialListState();
}

class _TransferAckMaterialListState extends State<TransferAckMaterialList> {

  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
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
                      "Transfer ACK Pending",
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
              ListDetails(context),
            ],
          ),
        ));
  }

  Widget ListDetails(BuildContext context){
    return
      Container(
        height: BaseUtitiles.getheightofPercentage(context, 90),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: pendingListController.onclickPendingListDet.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 3, right: 3),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Material" + ":   ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text( pendingListController.onclickPendingListDet[index].materialName.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Scale" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text( pendingListController.onclickPendingListDet[index].scaleName.toString())),

                          Expanded(
                              flex: 2,
                              child: Text("Trans Qty" + ":  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text("  "
                                  + pendingListController.onclickPendingListDet[index].TransQty.toString()
                              )),

                        ],
                      ),
                      SizedBox(height: 3,)
                    ],
                  ),
                ),
              ),
            );
          },),
      );
  }
}
