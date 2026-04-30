import '../../../../app_theme/app_colors.dart';
import '../../../../controller/fromproject_ccontroller.dart';
import '../../../../controller/fromsite_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/requestconstant.dart';

class Transfer_Between_Project_ItemList extends StatefulWidget {
  Transfer_Between_Project_ItemList({Key? key}) : super(key: key);

  @override
  State<Transfer_Between_Project_ItemList> createState() =>
      _Transfer_Between_Project_ItemListState();
}

class _Transfer_Between_Project_ItemListState extends State<Transfer_Between_Project_ItemList> {
  TransferBW_project_Controller transferBW_project_Controller = Get.put(TransferBW_project_Controller());
  FromProjectController fromprojectController = Get.put(FromProjectController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  bool _isInitialized = false;

  Future<void> _loadData() async {
    if (_isInitialized) return; // prevents multiple calls
    _isInitialized = true;

    final controller = transferBW_project_Controller;

    if (controller.type == "Against Mrn Approval" &&
        fromprojectController.selectedProjectId.value != 0 &&
        fromsiteController.selectedsiteId.value != 0) {

      controller.itemlistTable_Delete();
      controller.ItemGetTableListdata.clear();
      controller.itemlist_SaveTable();
      controller.getItemlistTablesDatas();

    } else if (controller.saveButton.value == RequestConstant.SUBMIT) {

      controller.mainlist.clear();
      controller.ItemGetTableListdata.clear();
      controller.itemlistTable_Delete();

    }
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
            await transferBW_project_Controller.itemlistPopup_saveLabTableDatas(context);
            await transferBW_project_Controller.getItemlistTablesDatas();
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
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                              transferBW_project_Controller.mainlist.value = BaseUtitiles.materialPopupAlert(value, transferBW_project_Controller.transferItemListdatas);
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
        itemCount: transferBW_project_Controller.transferItemListdatas.value.length,
        itemBuilder: (BuildContext context, int index) {
          transferBW_project_Controller.itemlist_textControllersInitiate();
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
                            transferBW_project_Controller.setCheck(transferBW_project_Controller.transferItemListdatas[index].materialId, value!);
                            transferBW_project_Controller.transferItemListdatas[index].check = value;
                          });
                        },
                        value: transferBW_project_Controller.transferItemListdatas[index].check),
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
                              transferBW_project_Controller.transferItemListdatas.value[index].material.toString() +
                                  " (  " + transferBW_project_Controller.transferItemListdatas.value[index].scale.toString() + "  ) ",
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
                            transferBW_project_Controller.transferItemListdatas.value[index].stockQty.toString(),
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
    else if (transferBW_project_Controller.mainlist.value.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: transferBW_project_Controller.mainlist.length,
        itemBuilder: (BuildContext context, int index) {
          transferBW_project_Controller.itemlist_textControllersInitiate();
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
                            transferBW_project_Controller.serachsetCheck(
                                transferBW_project_Controller
                                    .mainlist[index].materialId,
                                value!);
                            transferBW_project_Controller
                                .mainlist[index].check = value;
                          });
                        },
                        value: transferBW_project_Controller
                            .mainlist[index].check),
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
                              transferBW_project_Controller
                                      .mainlist.value[index].material
                                      .toString() +
                                  " (  " +
                                  transferBW_project_Controller
                                      .mainlist.value[index].scale
                                      .toString() +
                                  "  ) ",
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
                            transferBW_project_Controller.mainlist.value[index].stockQty.toString(),
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


