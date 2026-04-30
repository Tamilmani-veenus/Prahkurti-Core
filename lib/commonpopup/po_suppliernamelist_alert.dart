import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/ui_constant/icons_const.dart';
import '../controller/pendinglistcontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class PoApproval_supplierList_Alert extends StatefulWidget {
  const PoApproval_supplierList_Alert({Key? key,required this.MaterialId,required this.MaterialName, required this.Scale }) : super(key: key);

  final int MaterialId;
  final String MaterialName;
  final String Scale;

  @override
  State<PoApproval_supplierList_Alert> createState() => _PoApproval_supplierList_AlertState();
}

class _PoApproval_supplierList_AlertState extends State<PoApproval_supplierList_Alert> {

  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //
            //     Expanded(
            //       child: Container(
            //         alignment: Alignment.center,
            //         child: Text("Rate List",
            //             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
            //         ),
            //       ),
            //     ),
            //
            //
            //     // Expanded(
            //     //   flex: 4,
            //     //   child: Container(
            //     //     child: Text(widget.MaterialName.toString() + "  (" + widget.Scale.toString() + ") ",
            //     //         style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)
            //     //     ),
            //     //   ),
            //     // ),
            //
            //
            //   ],
            // ),


            Container(
              height: MediaQuery.of(context).size.height*7/100,
              width: MediaQuery.of(context).size.width*25/100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    thickness: 1.5,
                    color: Colors.red,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("RATE LIST",
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.red,
                  ),
                ],
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width*80/100,
              alignment: Alignment.center,
              child: Text(widget.MaterialName.toString() + "  (" + widget.Scale.toString() + ") ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 60),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: pendingListController.poapprovalSupplierList.length,
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

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("Supplier" + ":   ",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text( pendingListController.poapprovalSupplierList[index].supplier.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstIcons.list_date,
                                Expanded(
                                    flex: 8,
                                    child: Text(pendingListController.poapprovalSupplierList[index].billdate.toString())),
                                Expanded(
                                  flex: 3,
                                  child: Text("Rate:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(pendingListController.poapprovalSupplierList[index].rate.toString())),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
            ),

          ],
        ),
      ),
    );
  }

  // Widget ListDetails(BuildContext context){
  //   return Container(
  //     height: BaseUtitiles.getheightofPercentage(context, 90),
  //     child: ListView.builder(
  //       physics: BouncingScrollPhysics(),
  //       padding: EdgeInsets.zero,
  //       itemCount: pendingListController.poapprovalSupplierList.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Container(
  //           margin: EdgeInsets.only(left: 3, right: 3),
  //           child: Card(
  //             elevation: 5,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //             child: Container(
  //               margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text("Supplier" + ":   ",
  //                         style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
  //                       ),
  //                       Expanded(
  //                           flex: 3,
  //                           child: Text( pendingListController.poapprovalSupplierList[index].supplier.toString(),
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           )),
  //                       // Expanded(
  //                       //     flex: 3,
  //                       //     child: InkWell(
  //                       //       child: Row(
  //                       //         mainAxisAlignment: MainAxisAlignment.end,
  //                       //         children: [
  //                       //           Icon(Icons.arrow_circle_right_outlined, color: Theme.of(context).primaryColor,),
  //                       //           Container(child: Text("    "),)
  //                       //         ],
  //                       //       ),
  //                       //       onTap: (){
  //                       //         showDialog(
  //                       //             context: context,
  //                       //             builder: (BuildContext context) {
  //                       //               return PoApproval_supplierList_Alert(
  //                       //                 // list: onclickPendingListDet, ReqNo: Reqno
  //                       //               );
  //                       //             });
  //                       //       },
  //                       //     ))
  //                     ],
  //                   ),
  //                   Divider(),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 2,
  //                         child: Text("Rate:",
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Expanded(
  //                           flex: 10,
  //                           child: Text(pendingListController.poapprovalSupplierList[index].rate.toString())),
  //                     ],
  //                   ),
  //                   Divider(),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 2,
  //                         child: Text("Bill Date" + ":  ",
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Expanded(
  //                           flex: 4,
  //                           child: Text(pendingListController.poapprovalSupplierList[index].billdate.toString())),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },),
  //   );
  // }



}
