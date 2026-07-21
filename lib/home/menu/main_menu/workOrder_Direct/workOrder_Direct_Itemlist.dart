import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prahkurticore/home/menu/main_menu/workOrder_Direct/workOrder_Direct_Deduction.dart';

import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/workorderDirect_Controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class WorkOrderDirectItemList extends StatefulWidget {
  const WorkOrderDirectItemList({super.key});

  @override
  State<WorkOrderDirectItemList> createState() => _WorkOrderDirectItemListState();
}

class _WorkOrderDirectItemListState extends State<WorkOrderDirectItemList> {

  WorkOrderDirectController workOrderDirectController=Get.put(WorkOrderDirectController());

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
                        "Work Order Direct Item Lists",
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
                        controller: workOrderDirectController.itemDescController,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Item Description",
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
                                controller: workOrderDirectController.itemUnitController,
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                controller: workOrderDirectController.itemQuantityController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Net Qty",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                      RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 4),
                                      child: Icon(Icons.gradient_sharp,color: Theme.of(context).primaryColor,size: 22,)),
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                controller: workOrderDirectController
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
                            color:  Theme.of(context).primaryColor
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (workOrderDirectController.itemDescController.text == "" ||
                              workOrderDirectController.itemUnitController.text ==
                                  "" ||
                              workOrderDirectController.itemUnitController.text ==
                                  "0.0" ||
                              workOrderDirectController.itemUnitController.text ==
                                  "0" ||
                              workOrderDirectController
                                  .itemQuantityController.text ==
                                  "" ||
                              workOrderDirectController
                                  .itemQuantityController.text ==
                                  "0.0" ||
                              workOrderDirectController
                                  .itemQuantityController.text ==
                                  "0" ||
                              workOrderDirectController
                                  .itemRateController.text ==
                                  "" ||
                              workOrderDirectController
                                  .itemRateController.text ==
                                  "0.0" ||
                              workOrderDirectController
                                  .itemRateController.text ==
                                  "0") {
                          } else {
                            workOrderDirectController
                                .workOrder_itemlist_SaveTable();
                            workOrderDirectController
                                .getItemlistTablesDatas();
                            workOrderDirectController
                                .itemDescController.text = "";
                            workOrderDirectController
                                .itemUnitController.text = "";
                            workOrderDirectController
                                .itemQuantityController.text = "";
                            workOrderDirectController
                                .itemRateController.text = "";
                          }
                        });
                      },
                    ),
                  ],
                ),

                Obx(() => Visibility(
                    visible: workOrderDirectController.ItemGetTableListdata.value.isEmpty
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
                              builder: (context) => const WorkOrderDirectDeduction()));
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
        itemCount: workOrderDirectController.ItemGetTableListdata.value.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          workOrderDirectController.ItemListTextInitiate();
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
                          workOrderDirectController.ItemGetTableListdata.value[index].Name.toString(),
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
                                                    workOrderDirectController
                                                        .deleteByIditemlistTableable(
                                                        workOrderDirectController
                                                            .ItemGetTableListdata
                                                            .value[index]);
                                                    workOrderDirectController
                                                        .ItemGetTableListdata
                                                        .value
                                                        .removeAt(index);
                                                    await workOrderDirectController
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
                                controller: workOrderDirectController.itemlist_ListUnitsController[index],
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
                                  if(workOrderDirectController.itemlist_ListQtyController[index].text != "" && workOrderDirectController.itemlist_ListQtyController[index].text != "0" && workOrderDirectController.itemlist_ListQtyController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      workOrderDirectController.itemlist_ListQtyController[index].text = "";
                                      workOrderDirectController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: workOrderDirectController.itemlist_ListQtyController[index],
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
                                  setState(() {
                                    workOrderDirectController.itemListclickChanged();
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
                                  if(workOrderDirectController.itemlist_ListRateController[index].text != "" && workOrderDirectController.itemlist_ListRateController[index].text != "0" && workOrderDirectController.itemlist_ListRateController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      workOrderDirectController.itemlist_ListRateController[index].text = "";
                                      workOrderDirectController.itemListclickChanged();
                                    });
                                  }
                                },
                                controller: workOrderDirectController.itemlist_ListRateController[index],
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
                                    workOrderDirectController.itemListclickChanged();
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
                                controller: workOrderDirectController.itemlist_ListAmtController[index],
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
