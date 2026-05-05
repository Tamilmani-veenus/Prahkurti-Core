
import '../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../utilities/baseutitiles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/requestconstant.dart';
import 'advance_sitewisepayment.dart';

class Advance_Req_Voucher_Itemlist extends StatefulWidget {
  const Advance_Req_Voucher_Itemlist({Key? key}) : super(key: key);

  @override
  State<Advance_Req_Voucher_Itemlist> createState() => _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site extends State<Advance_Req_Voucher_Itemlist> {

  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());


  @override
  void initState(){
    advanceReqVoucherController.entrycheck=1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(width: 3, color: Colors.brown),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return SitewisePaymentAlert();
                      //     });

                      Navigator.push(context, MaterialPageRoute(builder: (context) => advance_sitewisepayment()));

                    },
                    child: Text("Add Item"),
                  ),
                ),
              ),
              Visibility(
                  visible: advanceReqVoucherController.ItemGetTableListdata.value.isEmpty?false:true,
                  child: ListDetails()),

              Container(
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  height: BaseUtitiles.getheightofPercentage(context, 4),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(width: 3, color: Colors.brown),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                     if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                       advanceReqVoucherController.SaveApi_ItemlistScreen(context, advanceReqVoucherController.vocId);
                       advanceReqVoucherController.getItemlistTablesDatas();
                     }
                     },
                    child: Text(advanceReqVoucherController.saveButton.value),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      child:
      Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            height: BaseUtitiles.getheightofPercentage(context,69),
            child: Column(
              children: <Widget>[
                Container(
                  height: BaseUtitiles.getheightofPercentage(context,65),
                  child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: advanceReqVoucherController.ItemGetTableListdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      advanceReqVoucherController.itemlist_textControllersInitiate();
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              margin: EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            advanceReqVoucherController.ItemGetTableListdata[index].siteName.toString(),
                                            style: TextStyle(
                                                color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15),
                                          ),
                                        ),
                                        InkWell(
                                          child:
                                          Container(
                                            height:
                                            BaseUtitiles.getheightofPercentage(context,2),
                                            width: BaseUtitiles.getWidthtofPercentage(context, 8),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(RequestConstant.DO_YOU_WANT_DELETE),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                              child: Text(RequestConstant.NO),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              }
                                                          ),
                                                          ElevatedButton(
                                                              child: Text(RequestConstant.YES),
                                                              onPressed: () {
                                                                advanceReqVoucherController.deleteParticularList(advanceReqVoucherController.ItemGetTableListdata.value[index]);
                                                                advanceReqVoucherController.ItemGetTableListdata.remove(advanceReqVoucherController.ItemGetTableListdata[index]);
                                                                advanceReqVoucherController.getItemlistTablesDatas();
                                                                Navigator.pop(context);
                                                              }
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              },
                                              child: Image.asset('assets/cancle.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:<Widget> [
                                        Text("Site Name",style: TextStyle(color: Colors.white),),
                                        Text(advanceReqVoucherController.ItemGetTableListdata[index].siteName.toString(),style: TextStyle(color: Colors.yellow),), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:<Widget> [
                                        Text("Payment Type",style: TextStyle(color: Colors.white),),
                                        Text(advanceReqVoucherController.ItemGetTableListdata[index].paymentType.toString(),style: TextStyle(color: Colors.yellow),), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:<Widget> [
                                        Text("Amount",style: TextStyle(color: Colors.white),),
                                        Text(advanceReqVoucherController.ItemGetTableListdata[index].amount.toString(),style: TextStyle(color: Colors.yellow),), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:<Widget> [
                                        Text("Net Amount",style: TextStyle(color: Colors.white),),
                                        Text(advanceReqVoucherController.ItemGetTableListdata[index].netAmount.toString(),style: TextStyle(color: Colors.yellow),), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





}
