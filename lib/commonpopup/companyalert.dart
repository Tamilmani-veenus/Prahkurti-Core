
import '../controller/expensencecontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/companycontroller.dart';

class CompanyShowPopup extends StatefulWidget {
  const CompanyShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<CompanyShowPopup> createState() => _CompanyShowPopupState();
}

class _CompanyShowPopupState extends State<CompanyShowPopup> {
  TextEditingController editingController = TextEditingController();
  final ProjectController projectController=Get.put(ProjectController());
  final SiteController siteController=Get.put(SiteController());
  final CompanyController companycontroller=Get.put(CompanyController());
  final ExpensesController expensesController=Get.put(ExpensesController());


  @override
  void initState() {
    companycontroller.mainlist.value.clear();
    companycontroller.mainlist.value=widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          //height: BaseUtitiles.getheightofPercentage(context, 60),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      companycontroller.mainlist.value=BaseUtitiles.companyPopupAlert(value,widget.list);
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      labelText: "Search",
                      labelStyle: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                      prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: companycontroller.mainlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          // setState(() {
                            await companycontroller.setSelectedCompanyID(companycontroller.mainlist.value[index].company!);
                            expensesController.reportExpensesList.value.clear();
                            await companycontroller.getProjectList_CompanyWise(context, 0);
                            await expensesController.getProjectExpensesList();
                            await expensesController.totalAmtProject();
                            await expensesController.getSupplierOS_ExpensesList();
                            await expensesController.totalAmt();
                            await expensesController.getSubcontractor_ExpensesList();
                            await expensesController.totalSubAmt();
                            expensesController.update();
                          // });

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(companycontroller.mainlist.value[index].company
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
