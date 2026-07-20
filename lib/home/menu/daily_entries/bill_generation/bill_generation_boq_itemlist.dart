import 'package:flutter/services.dart';

import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/billgeneration_boq_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import 'bill_generation_boq_deduction.dart';

class Bill_Generation_Boq_Itemlist extends StatefulWidget {
  const Bill_Generation_Boq_Itemlist({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_Boq_Itemlist> createState() =>
      _Bill_Generation_Boq_ItemlistState();
}

class _Bill_Generation_Boq_ItemlistState extends State<Bill_Generation_Boq_Itemlist> {
  BillGenerationBoqController billGenerationBoqController=Get.put(BillGenerationBoqController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),

                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Bill Generation BOQ Item Lists",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  ),
                ),



                Obx(() => Visibility(
                    visible: billGenerationBoqController.ItemGetTableListdata.value.isEmpty
                        ? false
                        : true,
                    child: Listdetails())),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color:  Theme.of(context).primaryColor
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  Colors.white
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bill_Generation_Boq_deduction()));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Listdetails() {
    return Container(
      width: BaseUtitiles.getWidthtofPercentage(context, 100),
      margin: const EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: billGenerationBoqController.ItemGetTableListdata.value.length,
        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
        itemBuilder: (BuildContext context, int index) {
          billGenerationBoqController.ItemListTextInitiate();
          return Card(
            color: Colors.white,
            elevation: 3,
            margin: const EdgeInsets.all(3),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: Text(
                          billGenerationBoqController.ItemGetTableListdata.value[index].Name.toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                          width: BaseUtitiles.getWidthtofPercentage(context, 8),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(RequestConstant.DO_YOU_WANT_DELETE),
                                  actions: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 20, right: 20),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE))),
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
                                              endIndent:
                                              15, //Spacing at the bottom of divider.
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () async {
                                                    billGenerationBoqController
                                                        .deleteByIditemlistTableable(
                                                        billGenerationBoqController
                                                            .ItemGetTableListdata
                                                            .value[index]);
                                                    billGenerationBoqController
                                                        .ItemGetTableListdata
                                                        .value
                                                        .removeAt(index);
                                                    await billGenerationBoqController
                                                        .getItemlistTablesDatas();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: ConstIcons.cancle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "Unit",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                              readOnly: true,
                                controller: billGenerationBoqController.itemlist_ListUnitsController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {}),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Rate",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                              readOnly: true,
                                onTap: (){
                                  if(billGenerationBoqController.itemlist_ListRateController[index].text != "" && billGenerationBoqController.itemlist_ListRateController[index].text != "0" && billGenerationBoqController.itemlist_ListRateController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationBoqController.itemlist_ListRateController[index].text = "";
                                      billGenerationBoqController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: billGenerationBoqController.itemlist_ListRateController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationBoqController.itemListclickChanged();
                                  });
                                }),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "Bal.BillQty",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                              readOnly: true,
                                onTap: (){
                                  if(billGenerationBoqController.itemlist_ListRateController[index].text != "" && billGenerationBoqController.itemlist_ListRateController[index].text != "0" && billGenerationBoqController.itemlist_ListRateController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationBoqController.itemlist_ListRateController[index].text = "";
                                      billGenerationBoqController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: billGenerationBoqController.itemlist_ListBalQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationBoqController.itemListclickChanged();
                                  });
                                }),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Cur.BillQty",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height:
                            BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextField(
                                readOnly: true,
                                controller: billGenerationBoqController.itemlist_ListCurQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {}),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "Total qty",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child:  TextFormField(
                              readOnly: true,
                                onTap: (){
                                  if(billGenerationBoqController.itemlist_ListQtyController[index].text != "" && billGenerationBoqController.itemlist_ListQtyController[index].text != "0" && billGenerationBoqController.itemlist_ListQtyController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationBoqController.itemlist_ListQtyController[index].text = "";
                                      billGenerationBoqController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: billGenerationBoqController.itemlist_ListQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {

                                }),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "To Be App Qty",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: (){
                                  if(billGenerationBoqController.itemlist_ListAppQtyController[index].text != "" && billGenerationBoqController.itemlist_ListAppQtyController[index].text != "0" && billGenerationBoqController.itemlist_ListAppQtyController[index].text != "0.0"){
                                    return;
                                  } else {
                                      billGenerationBoqController.itemlist_ListAppQtyController[index].text = "";
                                  }
                                },
                                controller: billGenerationBoqController.itemlist_ListAppQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) async{
                                  await billGenerationBoqController.validateTotalQty(index);
                                  await billGenerationBoqController.itemListclickChanged();
                                  setState(() {
                                    });
                                }),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 2,
                        child: Text(
                          "Amount",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                              readOnly: true,
                                controller: billGenerationBoqController.itemlist_ListAmtController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {}),
                          )),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
