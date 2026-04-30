import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import 'bill_generation_deduction.dart';

class Bill_Generation_Itemlist extends StatefulWidget {
  const Bill_Generation_Itemlist({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_Itemlist> createState() =>
      _Bill_Generation_ItemlistState();
}

class _Bill_Generation_ItemlistState extends State<Bill_Generation_Itemlist> {
  BillGenerationDirectController billGenerationDirectController =
      Get.put(BillGenerationDirectController());

  @override
  void initState() {
    if (billGenerationDirectController.entrycheck == 0) {
      billGenerationDirectController.entrycheck = 0;
    } else {
      billGenerationDirectController.entrycheck = 1;
    }

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
                        "Bill Generation Direct Item Lists",
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

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        controller: billGenerationDirectController.itemDescController,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Description",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.Description),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Enter user name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController
                                    .itemUnitController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Unit",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.unit),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller: billGenerationDirectController
                                    .itemQuantityController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Quantity",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.quantity),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller: billGenerationDirectController
                                    .itemRateController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Rate",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.rate),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 15),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: billGenerationDirectController.checkColor == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color:
                                  billGenerationDirectController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          billGenerationDirectController.checkColor = 0;

                          if (billGenerationDirectController.itemDescController.text == "" ||
                              billGenerationDirectController.itemUnitController.text ==
                                  "" ||
                              billGenerationDirectController.itemUnitController.text ==
                                  "0.0" ||
                              billGenerationDirectController.itemUnitController.text ==
                                  "0" ||
                              billGenerationDirectController
                                      .itemQuantityController.text ==
                                  "" ||
                              billGenerationDirectController
                                      .itemQuantityController.text ==
                                  "0.0" ||
                              billGenerationDirectController
                                      .itemQuantityController.text ==
                                  "0" ||
                              billGenerationDirectController
                                      .itemRateController.text ==
                                  "" ||
                              billGenerationDirectController
                                      .itemRateController.text ==
                                  "0.0" ||
                              billGenerationDirectController
                                      .itemRateController.text ==
                                  "0") {
                          } else {
                            billGenerationDirectController
                                .billgen_itemlist_SaveTable();
                            billGenerationDirectController
                                .getItemlistTablesDatas();
                            billGenerationDirectController
                                .itemDescController.text = "";
                            billGenerationDirectController
                                .itemUnitController.text = "";
                            billGenerationDirectController
                                .itemQuantityController.text = "";
                            billGenerationDirectController
                                .itemRateController.text = "";
                          }
                        });
                      },
                    ),
                  ],
                ),

                Obx(() => Visibility(
                    visible: billGenerationDirectController.ItemGetTableListdata.value.isEmpty
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

                // Expanded(
                //   child: InkWell(
                //     child: Container(
                //       margin: EdgeInsets.only(left: 20,right: 20),
                //       height: BaseUtitiles.getheightofPercentage(context, 4),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         color:  billGenerationDirectController.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                //       ),
                //       alignment: Alignment.center,
                //       child: Text("Reset",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                //             color:  billGenerationDirectController.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                //       ),
                //     ),
                //     onTap: (){
                //       setState(() {
                //         billGenerationDirectController.checkColor = 1;
                //       });
                //     },
                //   ),
                // ),

                // Expanded(
                //   child:

                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: billGenerationDirectController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: billGenerationDirectController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      billGenerationDirectController.checkColor = 0;
                      // billGenerationDirectController.deductionPaymentCalculation();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bill_Generation_direct_deduction()));
                    });
                  },
                ),

                // ),
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
      height: BaseUtitiles.getheightofPercentage(context, 58),
      child: ListView.builder(
        itemCount: billGenerationDirectController.ItemGetTableListdata.value.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          billGenerationDirectController.ItemListTextInitiate();
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
                          billGenerationDirectController.ItemGetTableListdata.value[index].Name.toString(),
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
                                                    billGenerationDirectController
                                                        .deleteByIditemlistTableable(
                                                            billGenerationDirectController
                                                                .ItemGetTableListdata
                                                                .value[index]);
                                                    billGenerationDirectController
                                                        .ItemGetTableListdata
                                                        .value
                                                        .removeAt(index);
                                                    await billGenerationDirectController
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
                                controller: billGenerationDirectController.itemlist_ListUnitsController[index],
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
                            "Qty",
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
                                  if(billGenerationDirectController.itemlist_ListQtyController[index].text != "" && billGenerationDirectController.itemlist_ListQtyController[index].text != "0" && billGenerationDirectController.itemlist_ListQtyController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController.itemlist_ListQtyController[index].text = "";
                                      billGenerationDirectController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: billGenerationDirectController.itemlist_ListQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                  setState(() {
                                    billGenerationDirectController.itemListclickChanged();
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
                          "Rate",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: (){
                                  if(billGenerationDirectController.itemlist_ListRateController[index].text != "" && billGenerationDirectController.itemlist_ListRateController[index].text != "0" && billGenerationDirectController.itemlist_ListRateController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController.itemlist_ListRateController[index].text = "";
                                      billGenerationDirectController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: billGenerationDirectController.itemlist_ListRateController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                    billGenerationDirectController.itemListclickChanged();
                                  });
                                }),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Amt",
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
                                controller: billGenerationDirectController.itemlist_ListAmtController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
