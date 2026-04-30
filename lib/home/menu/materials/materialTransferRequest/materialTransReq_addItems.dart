import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/material_transreq_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class MatTransReqAddItems extends StatefulWidget {
  const MatTransReqAddItems({super.key});

  @override
  State<MatTransReqAddItems> createState() => _MatTransReqAddItemsState();
}

class _MatTransReqAddItemsState extends State<MatTransReqAddItems> {

  MaterialTransferReqController materialTransferReqController = Get.put(MaterialTransferReqController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // materialTransferReqController.ItemGetTableListdata.clear();
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
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await materialTransferReqController.itemlistSaveTable(context);
            await materialTransferReqController.getItemlistTablesDatas();
          },
          label: const Text(
            "Done", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: RequestConstant.Lable_Font_SIZE,
            ),
          ),
          icon: const Icon(
            Icons.library_add_check_outlined,
            color: Colors.white,
            size: RequestConstant.Heading_Font_SIZE,
          ),
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
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "Add Items",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 5),
                        width: BaseUtitiles.getWidthtofPercentage(context, 40),
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
                            prefixIcon: const Icon(
                              Icons.search,
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
                            setState(() {
                              materialTransferReqController.mainListAddItems.value = BaseUtitiles.materialPopupAlert(value, materialTransferReqController.mattransreqItemList);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              ListDetails(),

            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    if (editingController.text.isEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: materialTransferReqController.mattransreqItemList.length,
        itemBuilder: (BuildContext context, int index) {
          materialTransferReqController.itemlist_textControllersInitiate();
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Container(
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              margin: EdgeInsets.all(1),
              child: Row(
                children: [
                  Container(
                    child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                              width: 1.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            materialTransferReqController.setCheck(materialTransferReqController.mattransreqItemList[index].materialId, value!);
                            materialTransferReqController.mattransreqItemList[index].check = value;
                          });
                        },
                        value: materialTransferReqController.mattransreqItemList[index].check),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width:
                            BaseUtitiles.getWidthtofPercentage(context, 59),
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              materialTransferReqController.mattransreqItemList.value[index].material.toString() + " (  " + materialTransferReqController.mattransreqItemList.value[index].scale.toString() + "  ) ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Stock Qty : "),
                          Text(
                            materialTransferReqController.mattransreqItemList.value[index].stockQty.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if (materialTransferReqController.mainListAddItems.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: materialTransferReqController.mainListAddItems.length,
        itemBuilder: (BuildContext context, int index) {
          materialTransferReqController.itemlist_textControllersInitiate();
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Container(
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              margin: EdgeInsets.all(1),
              child: Row(
                children: [
                  Container(
                    child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                              width: 1.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            materialTransferReqController.serachsetCheck(materialTransferReqController.mainListAddItems[index].materialid, value!);
                            materialTransferReqController.mainListAddItems[index].check = value;
                          });
                        },
                        value: materialTransferReqController.mainListAddItems[index].check),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width:
                            BaseUtitiles.getWidthtofPercentage(context, 59),
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              materialTransferReqController.mainListAddItems.value[index].material.toString() + " (  " + materialTransferReqController.mainListAddItems.value[index].scale.toString() + "  ) ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Stock Qty : "),
                          Text(
                            materialTransferReqController.mainListAddItems.value[index].stockQty.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
