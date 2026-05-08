import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/stocksite_controller.dart';
import '../../utilities/requestconstant.dart';


class ProjectDetailsPopup extends StatefulWidget {
  const ProjectDetailsPopup({Key? key,required this.list, required this.ProjectName}) : super(key: key);
  final List list;
  final String ProjectName;
  @override
  State<ProjectDetailsPopup> createState() => _ProjectDetailsPopupState();
}

class _ProjectDetailsPopupState extends State<ProjectDetailsPopup> {
  final StockSiteController stockSiteController=Get.put(StockSiteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
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
                      "Stock At Site Material Details",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(widget.ProjectName.toString(),
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                          ),)),
                  ),
                ],
              ),
              Divider(),
              ListDetails(context),
            ],
          ),
        ));
  }
  Widget ListDetails(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 10)),
      itemCount: stockSiteController.projectDetailsList.value.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 3, right: 3),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Materials:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Theme
                              .of(context)
                              .primaryColor),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: Text(stockSiteController.projectDetailsList.value[index].materialName.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Scale:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].scaleName.toString())),
                      Expanded(
                          flex: 3,
                          child: Text("Op Qty" + ":  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].opQty.toString())),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Pur Qty:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].purQty.toString())),
                      Expanded(
                        flex: 3,
                        child: Text("Trans In Qty:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].transInQty.toString())),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Trans Out Qty:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].transOutQty.toString())),
                      Expanded(
                        flex: 3,
                        child: Text("Usage Qty:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].usageQty.toString())),
                    ],
                  ),


                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Cl Qty:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(stockSiteController.projectDetailsList.value[index].clQty.toString())),
                      Expanded(
                          flex: 6,
                          child: Container())
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },);
  }
}

