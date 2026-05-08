
import 'dart:ffi';

import '../../../../controller/stocksite_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/material_controller.dart';
import '../../controller/reports_controller.dart';

class MaterialWise extends StatefulWidget {
  const MaterialWise({Key? key}) : super(key: key);

  @override
  State<MaterialWise> createState() => _MaterialWiseState();
}

class _MaterialWiseState extends State<MaterialWise> {
  StockSiteController stockSiteController = Get.put(StockSiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  MaterialController materialController = Get.put(MaterialController());
  ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      stockSiteController.getStockList.value=[];
      stockSiteController.matDropdowntId.value=0;
      reportsController.materialDropdowntId.value=0;
      reportsController.Subheadername.text="--ALL--";
      stockSiteController.materialHeadName.text = "--ALL--";
      stockSiteController.matHeadDropdowntId.value = 0;
      stockSiteController.Materialsubname.text = "--ALL--";

      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
      
              SizedBox(height: MediaQuery.of(context).size.height * 2/100),
      
              Container(
                margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                      readOnly: true,
                      controller: stockSiteController.materialHeadName,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Material Head Item",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: ConstIcons.projectName),
                      ),
                      onTap: () async {
                        await stockSiteController.getMaterialHeadReportList();
                        if (mounted) {
                          bottomsheetControllers.materialHeadItem(context, stockSiteController.getmaterialHeadDropDownvalue.value);
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select project name.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
      
              Container(
                margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                      readOnly: true,
                      controller: stockSiteController.Materialsubname,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Material Sub Item",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: ConstIcons.projectName),
                      ),
                      onTap: () async{
                        await stockSiteController.getProjectWiseSubmatList(stockSiteController.matHeadDropdowntId.value);

                        if (mounted) {
                          bottomsheetControllers.MaterialSubItem(context, stockSiteController.matHeadDropdowntId.value, stockSiteController.getmaterialSubdropDownvalue.value);
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select project name.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: reportsController.Subheadername,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Material Name",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: ConstIcons.projectName

                        ),
                      ),
                      onTap: () async {
                        await reportsController.getReportMaterialList();
                        bottomsheetControllers.MRNMaterialName(context, reportsController.getMaterialdropDownvalue.value);

                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '\u26A0 Please select Material Name.';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
              ),
      
      
      
              Center(
                child: Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: const BorderSide(width: 3, color: Colors.white),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      await  stockSiteController.getProjectwiseshow("Materialwise");
                    },
                    child: const Text("Show"),
                  ),
                ),
              ),
      
                ListDetails(),
      
            ],
          ),
        ),
      ),
    );
  }


  void textclear(){
    stockSiteController.getMaterialDropdownName.clear();
    reportsController.Subheadername.text="--All--";
  }

  Widget ListDetails() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: BaseUtitiles.getheightofPercentage(context, 60),
      width: BaseUtitiles.getWidthtofPercentage(context, 100),
      child: Obx(
            () => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: stockSiteController.getStockList.value!.length,
          itemBuilder: (context, projectIndex) {
            final project =
            stockSiteController.getStockList.value![projectIndex];
            final details = project.stockRepDetails ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Project Name
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    project.projectName.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                /// 🔹 Project Card
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, details.length==1?15: details.length==2?25:40),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Scrollbar(
                        thumbVisibility: false,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: details.length,
                          itemBuilder: (context, detailIndex) {
                            final item = details[detailIndex];

                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      /// 🔹 Material Name
                                      Text(
                                        item.footer.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      /// 🔹 Unit & Stock
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                            flex: 6,
                                            child: Text("Unit:"),
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child: Text(
                                              item.unit.toString(),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 8,
                                            child: Text("Stock Qty:"),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              item.stockQty.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                /// 🔹 Divider
                                if (detailIndex != details.length - 1)
                                  const Divider(
                                    color: Colors.indigo,
                                    thickness: 1,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
