import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/expensencecontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../home/dashboard/expenses_chartalert.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/companycontroller.dart';
import '../../controller/subcontcontroller.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final ProjectController projectController = Get.put(ProjectController());
  final SubcontractorController subcontractorController = Get.put(SubcontractorController());
  final AttendanceController attendanceController = Get.put(AttendanceController());
  final CompanyController companycontroller = Get.put(CompanyController());
  ProjectController projectcontroller = Get.put(ProjectController());
  final ExpensesController expensesController = Get.put(ExpensesController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  final CompanyController companyController = Get.put(CompanyController());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      expensesController.reportExpensesList.value.clear();
      expensesController.prjttotalamtcontroller.text = "0";
      companycontroller.getProjectList_CompanyWise(context, 0);
      companycontroller.getCompanyList(context, 0);
      companycontroller.selectedCompanyName.value = "--SELECT--";
      companycontroller.selectedCompanyId(0);
      companycontroller.CompanyName.text = "--Select--";
      companycontroller.projectname_CompanyWise.text = "--Select--";
      companycontroller.selectedProjectId_CompanyWise.value = 0;
      companycontroller.projectname_CompanyWise.text = "";
      companycontroller.selectedCompanyId.value = 0;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expenses",
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

              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: companycontroller.CompanyName,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: RequestConstant.COMPANY_NAME,
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
                          setState(() {
                            bottomsheetControllers.CompanyName(context,companyController.getdropDownvalue.value );
                          });
                          companycontroller.projectname_CompanyWise.text = "";
                          companycontroller.selectedProjectId_CompanyWise.value = 0;
                          expensesController.reportExpensesList.value.clear();
                        });
                      },
                    ),
                  ),
                ),
              ),


              // Container(
              //   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(color: Colors.white70, width: 1),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     elevation: 3,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
              //       child: TextFormField(
              //         readOnly: true,
              //         controller: companycontroller.projectname_CompanyWise,
              //         cursorColor: Colors.black,
              //         style: TextStyle(color: Colors.black),
              //         decoration: InputDecoration(
              //           contentPadding: EdgeInsets.zero,
              //           border: InputBorder.none,
              //           labelText: "Project Name",
              //           labelStyle: TextStyle(
              //               color: Colors.grey,
              //               fontSize: RequestConstant.Lable_Font_SIZE),
              //           prefixIconConstraints:
              //           BoxConstraints(minWidth: 0, minHeight: 0),
              //           prefixIcon: Padding(
              //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              //               child: ConstIcons.siteName),
              //         ),
              //         onTap: () {
              //           setState(() {
              //             bottomsheetControllers.projectname_CompanyWise(context, companycontroller.getdropDownvalue_Companywise.value);
              //             expensesController.reportExpensesList.value.clear();
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20,top:10),
                      width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Text("Show",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: ()  {

                      setState(() {
                        expensesController.getProjectExpensesList();
                        expensesController.totalAmtProject();
                      });
                      var duration = Duration(seconds: 1);
                      Future.delayed(duration, () async {
                        setState((){
                          expensesController.totalAmtProject();
                        });
                      });
                    },
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 5),
                width: BaseUtitiles.getWidthtofPercentage(context, 100),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Project Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontWeight:  FontWeight.bold),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            "Expenses",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),

              Divider(color: Theme.of(context).primaryColor),

              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: BaseUtitiles.getheightofPercentage(context, 6),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text("Total Cr/Dr Amount:",style: TextStyle(fontWeight: FontWeight.bold, fontSize:17),)),
                        // Expanded(
                        //     flex: 2,
                        //     child: Align(
                        //         alignment: Alignment.centerRight,
                        //         child: Text("Total Amt: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE),))),
                        Expanded(
                            flex: 4,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("₹ " +
                                    expensesController.prjttotalamtcontroller.text,
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 17),))),
                      ],
                    ),
                  ),
                ),
              ),


              ListDetails(),

              // Container(
              //   margin: EdgeInsets.only(top: 10,bottom: 10),
              //   height: BaseUtitiles.getheightofPercentage(context, 5),
              //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
              //   child: TextField(
              //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
              //     readOnly: true,
              //     controller: companycontroller.CompanyName,
              //     decoration: new InputDecoration(
              //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              //       labelText: RequestConstant.COMPANY_NAME,
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              //       ),
              //     ),
              //     onTap: () {
              //       companycontroller.getCompanyList(context,0);
              //     },
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.only(left: 10,right: 10),
              //   height: BaseUtitiles.getheightofPercentage(context, 5),
              //   width: BaseUtitiles.getWidthtofPercentage(context, 100),
              //   child: Card(
              //     shape: BeveledRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     color: Colors.indigo,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Container(
              //           margin: EdgeInsets.only(left: 5),
              //           child: Text(
              //               "Project Name",
              //               textAlign: TextAlign.center
              //             ,style: TextStyle(color: Colors.white),),
              //         ),
              //         Container(
              //             margin: EdgeInsets.only(right: 5),
              //             child: Text("Expenses",textAlign: TextAlign.center,style: TextStyle(color: Colors.yellow),)),
              //       ],
              //     ),
              //   ),
              // ),
              // Divider(),
              // ListDetails(),

            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      height: BaseUtitiles.getheightofPercentage(context, 70),
      child: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: expensesController.reportExpensesList.value.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ExpensesChart_Alert(
                            list: expensesController.reportExpensesList.value[index]);
                      });
                },
                child: Container(
                  margin: EdgeInsets.all(3),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Container(
                                    child: Text(
                                      expensesController.reportExpensesList.value[index].project.toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  ("₹ " + BaseUtitiles.amountFormat(expensesController.reportExpensesList.value[index].totExpAmt)),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
