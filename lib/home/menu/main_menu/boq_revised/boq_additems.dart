import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/boqrevised_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Boq_AddItems extends StatefulWidget {
  const Boq_AddItems({Key? key}) : super(key: key);

  @override
  State<Boq_AddItems> createState() => _Boq_AddItemsState();
}

class _Boq_AddItemsState extends State<Boq_AddItems> {

  TextEditingController editingController = TextEditingController();
  final Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());

  @override
  void initState() {
    super.initState();

    boq_revised_controller
        .Itemlist_qtyControllers
        .clear();

    boq_revised_controller
        .Itemlist_AmountControllers
        .clear();

    for (var mainItem
    in boq_revised_controller.Boq_MainItemList) {

      for (var subItem
      in mainItem.subItems ?? []) {

        for (var level3
        in subItem.level3Items ?? []) {

          boq_revised_controller
              .Item_itemlist_textControllersInitiate();

          int lastIndex =
              boq_revised_controller
                  .Itemlist_qtyControllers
                  .length - 1;

          boq_revised_controller
              .Itemlist_qtyControllers[lastIndex]
              .text = "1";

          boq_revised_controller
              .Itemlist_AmountControllers[lastIndex]
              .text = "1";
        }
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
            await boq_revised_controller.boqitemlist_Save_DB(context);
            await boq_revised_controller.getItemTablesDatas();
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

                          boq_revised_controller.Boq_MainItemList.value =
                              BaseUtitiles.filterSearchResults_BOQRevised(
                                value,
                                boq_revised_controller.Boq_ItemList,
                              );
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
      if (boq_revised_controller.Boq_MainItemList.isEmpty) {
        return SizedBox();
      }
      return Container(
          height: BaseUtitiles.getheightofPercentage(context, 100),
          child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: boq_revised_controller.Boq_MainItemList.value.length,
                itemBuilder: (context, mainIndex) {
                  var mainItem =
                  boq_revised_controller.Boq_MainItemList.value[mainIndex];

                  return ListView.builder(
                    itemCount: mainItem.subItems?.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, subIndex) {
                      var subItem = mainItem.subItems?[subIndex];

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
                            ListView.builder(
                              itemCount: subItem?.level3Items?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, level3Index) {
                                var level3 =
                                subItem!.level3Items?[level3Index];

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

                                              boq_revised_controller.setCheck(
                                                mainIndex,
                                                subIndex,
                                                level3!.level3ItemId!,
                                                value!,
                                              );
                                            });
                                          },
                                        ),

                                        Expanded(
                                          child: Text(
                                            "${level3?.name} (${level3
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
                  );
                },
              ),

      );
    });
  }
}
