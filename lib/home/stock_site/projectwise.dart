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
      stockSiteController.reportScreen = 1;
      await siteController.subcontEntry_siteDropdowntList(context, 0);
      // await stockSiteController.getMaterialHeadReportList();
      // await stockSiteController.getProjectWiseSubmatList(context,  stockSiteController.reportScreen);

      await reportsController.getReportProjectList();
      await reportsController.getSiteReportList(context,0);


      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";

      stockSiteController.materialHeadName.text = "--ALL--";
      stockSiteController.matHeadDropdowntId.value = 0;
      stockSiteController.Materialsubname.text = "--ALL--";
      stockSiteController.matDropdowntId.value = 0;
      siteController.siteDropdownName.clear();
      setState(() {
        stockSiteController.projectShowList.value.clear();
        stockSiteController.getStockReportList!.clear();
        stockSiteController.getStockReportDetList!.clear();
        stockSiteController.getStockList.clear();
        stockSiteController.getStockDetList.clear();
      });
    });
    super.initState();
  }

  var groupedlist;

  // list.forEach((product) {
  // product.groups.forEach((group) {
  // if (groupedLists['$group'] == null) {
  // groupedLists['$group'] = <Product>[];
  // }
  // (groupedLists['$group'] as List<Product>).add(product);
  // });
  // });

  // print(groupedLists);

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
                      onTap: () {
                        // await projectController.getProjectList(context, 0);
                        setState(() {
                          bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                        });
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
                      onTap: () {
                        setState(() {
                          bottomsheetControllers.siteNameReport(context, reportsController.getSiteDropdownvalue.value);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '\u26A0 Please select site name.';
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
                      onTap: () {
                        setState(() {
                          bottomsheetControllers.materialHeadItem(context, stockSiteController.getmaterialHeadDropDownvalue.value);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select site name';
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
                      onTap: () {
                        setState(() {
                          bottomsheetControllers.MaterialSubItem(context, stockSiteController.matHeadDropdowntId.value, stockSiteController.getmaterialSubdropDownvalue.value);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select site name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              // -----------Need for reference------------
      
              //   Container(
              //     alignment: Alignment.center,
              //     margin:
              //     EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              //     height: BaseUtitiles.getheightofPercentage(context, 5),
              //     width: BaseUtitiles.getWidthtofPercentage(context, 90),
              //     child: TextField(
              //       style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
              //       readOnly: true,
              //       controller: projectController.projectname,
              //       decoration: new InputDecoration(
              //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              //         labelText: "ProjectName",
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black, width: 1.0),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black, width: 1.0),
              //         ),
              //
              //       ),
              //
              //       onTap: () {
              //         projectController.getProjectList(context,0);
              //         textclear();
              //       },
              //     ),
              //
              //   ),
              //   Container(
              //     alignment: Alignment.center,
              //     margin:
              //     EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              //     height: BaseUtitiles.getheightofPercentage(context, 5),
              //     width: BaseUtitiles.getWidthtofPercentage(context, 90),
              //     child: TextField(
              //       style: TextStyle(fontSize:RequestConstant.Dropdown_Font_SIZE),
              //       readOnly: true,
              //       controller: siteController.Sitename,
              //       decoration: new InputDecoration(
              //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              //         labelText: "SiteName",
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black, width: 1.0),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black, width: 1.0),
              //         ),
              //
              //       ),
              //
              //       onTap: () {
              //         siteController.subcont_SiteEntry_SiteDropdowntList(context,0);
              //       },
              //     ),
              //
              //   ),
              //   Container(
              //   alignment: Alignment.center,
              //   margin:
              //   EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              //   height: BaseUtitiles.getheightofPercentage(context, 5),
              //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
              //   child: TextField(
              //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
              //     readOnly: true,
              //     controller: stockSiteController.Materialsubname,
              //     decoration: new InputDecoration(
              //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              //       labelText: "Material Sub Item",
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black, width: 1.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black, width: 1.0),
              //       ),
              //     ),
              //
              //     onTap: () {
              //       stockSiteController.getProjectWisesubmaterialDropdownList(context);
              //     },
              //   ),
              //
              // ),
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
                            await  stockSiteController.getProjectwiseshow();
                            // Future.delayed(Duration(milliseconds: 500), () {
                            //   setState(() {
                            //       stockSiteController.getProjectwiseshow();
                            //   });
                            // });
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
                            // if(reportsController.selectedProjectId.value == 0) {
                            //   Fluttertoast.showToast(msg: "Please select a project name");
                            // }
                            // else if(reportsController.selectedsiteId.value == 0){
                            //   Fluttertoast.showToast(msg: "Please select a site name");
                            // }
                            // else{
                            //   stockSiteController.getProjectDetailisList(context,reportsController.projectname.text);
                            // }
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
      child:
      Obx(
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
                        // thumbVisibility: true,
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

// Widget ListDatas(){
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     height:BaseUtitiles.getheightofPercentage(context,60),
//     width: BaseUtitiles.getWidthtofPercentage(context,100),
//     child: Obx(()=>ListView.builder(
//         shrinkWrap: true,
//         physics: const ScrollPhysics(),
//         itemCount: stockSiteController.projectShowList.value.length,
//         itemBuilder: (context, index) {
//           bool isNewGroup = false;
//           if (index == 0) {
//             isNewGroup = true;
//           } else {
//             var currentGroup = stockSiteController.projectShowList.value[index].group;
//             var previousGroup = stockSiteController.projectShowList.value[index - 1].group;
//             if (currentGroup != previousGroup) {
//               isNewGroup = true;
//             }
//           }
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (isNewGroup)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     stockSiteController.projectShowList.value[index].header.group,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ),
//               Container(
//                 margin: const EdgeInsets.all(1),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.white,
//                   child: Container(
//                     margin: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         SizedBox(
//                           width: BaseUtitiles.getWidthtofPercentage(context, 75),
//                           child: Text(
//                             // "${stockSiteController.projectShowList.value[index].header} "
//                                 "( ${stockSiteController.projectShowList.value[index].footer} )",
//                             style: TextStyle(color: Theme.of(context).primaryColor),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               const Expanded(
//                                 flex: 6,
//                                 child: Text("Unit:", style: TextStyle(color: Colors.black)),
//                               ),
//                               Expanded(
//                                 flex: 9,
//                                 child: Text(
//                                   stockSiteController.projectShowList.value[index].unit.toString(),
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               const Expanded(
//                                 flex: 8,
//                                 child: Text("Stock Qty:", style: TextStyle(color: Colors.black)),
//                               ),
//                               Expanded(
//                                 flex: 5,
//                                 child: Text(
//                                   stockSiteController.projectShowList.value[index].stockQty.toString(),
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//     ),
//   );
//
// }
}
