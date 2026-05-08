import '../../../../constants/ui_constant/textfont_style.dart';
import '../../../../controller/material_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/stocksite_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/reports_controller.dart';

class PrjectWise extends StatefulWidget {
  const PrjectWise({Key? key}) : super(key: key);

  @override
  State<PrjectWise> createState() => _PrjectWiseState();
}

class _PrjectWiseState extends State<PrjectWise> {
  final StockSiteController stockSiteController = Get.put(StockSiteController());
  final ProjectController projectController = Get.put(ProjectController());
  final SiteController siteController = Get.put(SiteController());
  final BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ReportsController reportsController = Get.put(ReportsController());
  MaterialController materialController = Get.put(MaterialController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      stockSiteController.getStockList.value=[];
      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";
      stockSiteController.materialHeadName.text = "--ALL--";
      stockSiteController.matHeadDropdowntId.value = 0;
      stockSiteController.Materialsubname.text = "--ALL--";
      stockSiteController.matDropdowntId.value = 0;

      reportsController.materialDropdowntId.value=0;
      reportsController.Subheadername.text="--ALL--";

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea( top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
      
              Container(
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: reportsController.projectname,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Project Name",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: ConstIcons.projectName),
                      ),
                      onTap: () async {
                        await reportsController.getReportProjectList();
                        bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: reportsController.sitename,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Site Name",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: ConstIcons.siteName),
                      ),
                      onTap: () async {
                        await siteController.subcontEntry_siteDropdowntList(context, 0,type: "StockReport");
                        if (mounted) {
                        bottomsheetControllers.siteNameReport(context, siteController.getSiteDropdownvalue.value);
                        }
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
                    padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
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
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: ConstIcons.siteName,
                        ),
                      ),
                      onTap: () async {
                        await stockSiteController.getMaterialHeadReportList();
                        if (mounted) {
                          bottomsheetControllers.materialHeadItem(context, stockSiteController.getmaterialHeadDropDownvalue.value);
                        }
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
                    padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
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
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: ConstIcons.siteName),
                      ),
                      onTap: () async {
                        await stockSiteController.getProjectWiseSubmatList(stockSiteController.matHeadDropdowntId.value);

                        if (mounted) {
                          bottomsheetControllers.MaterialSubItem(context, stockSiteController.matHeadDropdowntId.value, stockSiteController.getmaterialSubdropDownvalue.value);
                        }
                      },
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: BaseUtitiles.getWidthtofPercentage(context, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: const BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            await  stockSiteController.getProjectwiseshow("Projectwise");
                          },
                          child: const Text("Show"),
                        ),
                      ),
                      SizedBox(
                        width: BaseUtitiles.getWidthtofPercentage(context, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: const BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            stockSiteController.getProjectDetailisList(context, reportsController.projectname.text);
                          },
                          child: const Text("Details"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              ListDetails(),
      
              // ListDatas(),
            ],
          ),
        ),
      ),
    );
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
