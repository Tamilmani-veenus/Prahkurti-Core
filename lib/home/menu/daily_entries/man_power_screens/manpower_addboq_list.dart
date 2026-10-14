import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/man_power_controller.dart';
import '../../../../models/manpowerlevel3_model.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class ManPowerAddBOQList extends StatefulWidget {
  const ManPowerAddBOQList({Key? key, required this.list}) : super(key: key);
  final RxList<Level3Result> list;

  @override
  State<ManPowerAddBOQList> createState() => _ManPowerAddBOQListState();
}

class _ManPowerAddBOQListState extends State<ManPowerAddBOQList> {
  ManPowerController manPowerController=Get.put(ManPowerController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
      print(manPowerController.selectedIds);
      Navigator.pop(context);
},
            label: Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: RequestConstant.Lable_Font_SIZE,
              ),
            ),
            icon: Icon(
              Icons.library_add_check_outlined,
              color: Colors.white,
              size: RequestConstant.Heading_Font_SIZE,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Level 3 Items",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: BaseUtitiles.getheightofPercentage(context, 5),
                        width: BaseUtitiles.getWidthtofPercentage(context, 50),
                        margin: EdgeInsets.only(left: 15),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: manPowerController.editingController,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.only(top: 5),
                            hintText: "Search..",
                            hintStyle: TextStyle(color: Colors.black),
                            isDense: true,
                            fillColor: Colors.white,
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            // if (onSearch != null) onSearch!(searchcontroller.text);
                          },
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() {
                              manPowerController.list.assignAll(
                                BaseUtitiles.addBoqPopupAlert(
                                  value,
                                  manPowerController.manpowerLevel3ItemList,
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                listDetails(),
              ],
            ),
          )),
    );
  }

  Widget listDetails() {
    final data = manPowerController.editingController.text.isEmpty
        ? manPowerController.manpowerLevel3ItemList
        : manPowerController.list;

    if (data.isEmpty) {
      return Container();
    }
      return SizedBox(
        height: BaseUtitiles.getheightofPercentage(context,90),
        child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(bottom: 50),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:  data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: data[index].isCheck == true
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.white70,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: data[index].isCheck == true
                          ? Colors.white.withOpacity(0.12)
                          : Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 2), // Horizontal, Vertical
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                            width: 1.0,
                            // color: Colors.white
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            manPowerController.setCheck(
                              data[index].id!,
                              value!,
                            );
                          });

                          if (value == true && !manPowerController.hasShownSelectedHint.value) {
                            manPowerController.hasShownSelectedHint.value = true;

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Selected items are moved to the top."),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
                          }

                          if (manPowerController.selectedIds.isEmpty) {
                            manPowerController.hasShownSelectedHint.value = false;
                          }
                        },
                        value: data[index].isCheck),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 58),
                                    child: Text(
                                      data[index].headandSubName.toString(),
                                      style: TextStyle(
                                          fontSize:
                                          RequestConstant.ALERT_Font_SIZE,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Qty:  ",
                                          style: TextStyle(
                                              color:Colors.black45,
                                              fontSize: RequestConstant.ALERT_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:  data[index].qty.toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: RequestConstant.App_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 58),
                                    child: Text(
                                      data[index].level3Item.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                          fontSize:
                                          RequestConstant.ALERT_Font_SIZE,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Scale:  ",
                                          style: TextStyle(
                                              color:Colors.black45,
                                              fontSize: RequestConstant.ALERT_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:  data[index].scaleName.toString(),
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: RequestConstant.App_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      );
  }
}
