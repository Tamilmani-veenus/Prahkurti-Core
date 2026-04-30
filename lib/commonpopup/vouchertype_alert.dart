import '../controller/commonvoucher_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VoucherTypeAlert extends StatefulWidget {
  const VoucherTypeAlert({Key? key}) : super(key: key);

  @override
  State<VoucherTypeAlert> createState() => _VoucherTypeAlertState();
}

class _VoucherTypeAlertState extends State<VoucherTypeAlert> {

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());

  final list=["--Select--","Site Petty Cash","Advance"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("voc Type ",style: TextStyle(color: Colors.white),)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,12),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            commonVoucherController.VoucherTypeController.text = "--Select--";
                            commonVoucherController.VocType.value = "S";
                            break;
                          case 1:
                            commonVoucherController.VoucherTypeController.text = "Site Petty Cash";
                            commonVoucherController.VocType.value = "P";
                            commonVoucherController.payforController.text = "SUSPENSE";
                            commonVoucherController.payfor.value = "SU";
                            setState(() {
                              commonVoucherController.getdropDownvalue.value.clear();
                              commonVoucherController.AccountTypename.text = "--SELECT--";
                              commonVoucherController.selectedAccId.value = 0;
                              commonVoucherController.getaccdropDownvalue.value.clear();
                              commonVoucherController.setSelectedaccountName(0);
                              commonVoucherController.Accountname.text = "--Select--";
                              commonVoucherController.namethrough.text = "--Select--";
                              commonVoucherController.selectedAccnameId.value = 0;
                            });
                            break;
                          default:
                            commonVoucherController.VoucherTypeController.text = "Advance";
                            commonVoucherController.VocType.value = "A";
                            commonVoucherController.payforController.text = "Advance - Direct";
                            commonVoucherController.payfor.value = "AD";
                            break;

                        }

                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 60),
                            child: Text(
                              list[index].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (index < list.length - 1)
                            Divider(
                              color: Theme.of(context).primaryColorLight,
                            ),
                        ],
                      ),
                    );
                  },
                ),

                // ListView.builder(
                //     itemCount: list.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return InkWell(
                //         onTap: ()  {
                //           if(index==0){
                //             commonVoucherController.VoucherTypeController.text="--Select--";
                //             commonVoucherController.VocType.value = "S";
                //           }else if(index==1){
                //             commonVoucherController.VoucherTypeController.text="Site Petty Cash";
                //             commonVoucherController.VocType.value = "P";
                //             commonVoucherController.payforController.text = "SUSPENSE";
                //             commonVoucherController.payfor.value = "SU";
                //             Future.delayed(Duration(seconds: 0){
                //             setState(() {
                //             commonVoucherController.getdropDownvalue.value.clear();
                //             commonVoucherController.AccountTypename.text == "--SELECT--";
                //             commonVoucherController.selectedAccId.value = 0;
                //             });
                //             });
                //
                //
                //           }
                //           else{
                //             commonVoucherController.VoucherTypeController.text="Advance";
                //             commonVoucherController.VocType.value = "A";
                //             commonVoucherController.payforController.text = "Advance";
                //             commonVoucherController.payfor.value = "A";
                //           }
                //           Navigator.pop(context);
                //         },
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             Column(
                //               mainAxisAlignment:
                //               MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Container(
                //                     width:
                //                     BaseUtitiles.getWidthtofPercentage(
                //                         context, 60),
                //                     child: Text(list[index]
                //                         .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                //
                //                 if(index < list.length - 1)
                //                 Divider(
                //                   color: Theme.of(context).primaryColorLight,
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //       );
                //     }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class VoucherPaidForm extends StatefulWidget {
  const VoucherPaidForm({super.key});

  @override
  State<VoucherPaidForm> createState() => _VoucherPaidFormState();
}

class _VoucherPaidFormState extends State<VoucherPaidForm> {

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  final list=["PETTY CASH","PREPAID CARD"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("Paid Form ",style: TextStyle(color: Colors.white),)),
              ),


              Container(
                margin: const EdgeInsets.only(top: 10),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          if(index==0){
                            commonVoucherController.voucherPaidForm.text="PETTY CASH";
                            commonVoucherController.vocPaidformId=1;
                          }
                          else{
                            commonVoucherController.voucherPaidForm.text="PREPAID CARD";
                            commonVoucherController.vocPaidformId=2;
                          }
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(list[index]
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SiteAndStaffVoucherType extends StatefulWidget {
  const SiteAndStaffVoucherType({super.key});

  @override
  State<SiteAndStaffVoucherType> createState() => _SiteAndStaffVoucherTypeState();
}

class _SiteAndStaffVoucherTypeState extends State<SiteAndStaffVoucherType> {

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());

  final list=["Payment","Receipt"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("voc Type ",style: TextStyle(color: Colors.white),)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          if(index==0){
                            commonVoucherController.VoucherTypeController.text="Payment";
                            commonVoucherController.VocType.value = "P";
                          }
                          else{
                            commonVoucherController.VoucherTypeController.text="Receipt";
                            commonVoucherController.VocType.value = "R";
                          }
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                    child: Text(list[index]
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


