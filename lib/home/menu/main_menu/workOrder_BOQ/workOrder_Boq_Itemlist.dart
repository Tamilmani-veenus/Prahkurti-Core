import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prahkurticore/controller/workOrderBoq_Controller.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class WorkOrderBoqItemList extends StatefulWidget {
  const WorkOrderBoqItemList({super.key});

  @override
  State<WorkOrderBoqItemList> createState() => _WorkOrderBoqItemListState();
}

class _WorkOrderBoqItemListState extends State<WorkOrderBoqItemList> {

  TextEditingController editingController = TextEditingController();
  WorkOrderBoqController workOrderBoqController = Get.put(WorkOrderBoqController());

  @override
  void initState() {
    super.initState();

    workOrderBoqController
        .Itemlist_qtyControllers
        .clear();

    workOrderBoqController
        .Itemlist_AmountControllers
        .clear();

    for (var subItem
    in workOrderBoqController.WorkOrdBoq_MainItemList) {

      for (var level3
        in subItem.measureLevel3ItemS ?? []) {

          workOrderBoqController
              .Item_itemlist_textControllersInitiate();

          int lastIndex =
              workOrderBoqController
                  .Itemlist_qtyControllers
                  .length - 1;

          workOrderBoqController
              .Itemlist_qtyControllers[lastIndex]
              .text = "1";

          workOrderBoqController
              .Itemlist_AmountControllers[lastIndex]
              .text = "1";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await workOrderBoqController.WorkOrdboqitemlist_Save_DB(context);
            await workOrderBoqController.getItemTablesDatas();
          },
          label: Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
          icon: Icon(Icons.library_add_check_outlined, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
          backgroundColor: Theme.of(context).primaryColor,
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
                    Text(
                      "Add Items",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),

                    Container(
                      height: BaseUtitiles.getheightofPercentage(context, 5),
                      width: BaseUtitiles.getWidthtofPercentage(context, 50),
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: editingController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search..",
                          hintStyle: TextStyle(color: Colors.black),
                          isDense: true,
                          // fillColor: Setmybackground,
                          fillColor: Colors.white,
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          // if (onSearch != null) onSearch!(searchcontroller.text);
                        },
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {

                          // workOrderBoqController.WorkOrdBoq_MainItemList.value =
                          //     BaseUtitiles.filterSearchResults_BOQRevised(
                          //       value,
                          //       workOrderBoqController.WorkOrdBoq_ItemList,
                          //     );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              listDetails(),

            ],
          ),
        ),
      ),
    );
  }

  Widget listDetails(){
    return Obx(() {
      if (workOrderBoqController.WorkOrdBoq_MainItemList.isEmpty) {
        return SizedBox();
      }
      return Container(
        height: BaseUtitiles.getheightofPercentage(context, 100),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: workOrderBoqController.WorkOrdBoq_MainItemList.value.length,
          itemBuilder: (context, mainIndex) {
            var subItem =
            workOrderBoqController.WorkOrdBoq_MainItemList.value[mainIndex];

            return Container(
                  margin: EdgeInsets.only(
                      bottom: 2,
                      left: 10,
                      right: 10,
                      top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// SUB ITEM TITLE
                      Text(
                        subItem!.subItem.toString(),
                        style: TextStyle(
                          fontSize: RequestConstant.App_Font_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// LEVEL 3 ITEMS

                      if (subItem.measureLevel3ItemS != null &&
                          subItem.measureLevel3ItemS!.isNotEmpty)
                      ListView.builder(
                        itemCount: subItem.measureLevel3ItemS?.length ?? 0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, level3Index) {
                          var level3 =
                          subItem!.measureLevel3ItemS?[level3Index];

                          return Column(
                            children: [

                              Row(
                                children: [

                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color:
                                      Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),

                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          2.0),
                                    ),
                                    side: MaterialStateBorderSide
                                        .resolveWith(
                                          (states) =>
                                          BorderSide(
                                              width: 1.0, color: Theme
                                              .of(context)
                                              .primaryColor),
                                    ),
                                    checkColor: Colors.white,
                                    activeColor: Theme
                                        .of(context)
                                        .primaryColor,
                                    value: level3?.isCheck ?? false,

                                    onChanged: (value) {
                                      setState(() {
                                        level3?.isCheck = value!;

                                        workOrderBoqController.setCheck(
                                          mainIndex,
                                          level3!.measureid!,
                                          value!,
                                        );
                                      });
                                    },
                                  ),

                                  Expanded(
                                    child: Text(
                                      "${level3?.level3Item} (${level3
                                          ?.scaleName})",
                                      style: TextStyle(
                                        fontSize:
                                        RequestConstant.App_Font_SIZE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                thickness: 1,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },

        ),

      );
    });
  }

}
