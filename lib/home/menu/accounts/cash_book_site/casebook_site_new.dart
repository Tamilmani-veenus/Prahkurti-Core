import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/attendancecontroller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/cashbook_site_controller.dart';
import '../../../../controller/expensencecontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class CashBook_Site extends StatefulWidget {
  const CashBook_Site({Key? key}) : super(key: key);

  @override
  State<CashBook_Site> createState() => _CashBook_SiteState();
}

class _CashBook_SiteState extends State<CashBook_Site> {

  final ProjectController projectController=Get.put(ProjectController());

  final AttendanceController attendanceController=Get.put(AttendanceController());

  final ExpensesController expensesController=Get.put(ExpensesController());

  CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());

  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    // TODO: implement initState
    projectController.getProjectList();
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    cashBookSiteController.cashbooksite_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
    cashBookSiteController.cashbooksite_todateController.text = currentDate.toString().substring(0, 10);
    projectController.projectname.text="--SELECT--";
    projectController.selectedProjectId.value=0;
    cashBookSiteController.cashsiteDatas.clear();
    cashBookSiteController.totalDebit.text = "0.0";
    cashBookSiteController.totalCredit.text ="0.0";
    cashBookSiteController.closingDebit.text = "0.0";
    cashBookSiteController.closingCredit.text ="0.0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        bottomNavigationBar: bouttomNavigation(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cash Book/Site",
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
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: cashBookSiteController.cashbooksite_frdateController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "From Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.App_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
                                  onTap: () async {
                                    cashBookSiteController.cashsiteDatas.clear();
                                    var Frdate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: Colors.black, // body text color
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors.black, // button text color
                                              ),
                                            ),
                                          ),
                                            child: child!,
                                          );
                                        });
                                    cashBookSiteController.cashbooksite_frdateController.text = Frdate.toString().substring(0, 10);
                                    await cashBookSiteController.getcashbooksitedetails();
                                    cashBookSiteController.calculations();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select Date';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 38),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: cashBookSiteController.cashbooksite_todateController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "ToDate",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.App_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
                                  onTap: () async {
                                    cashBookSiteController.cashsiteDatas.clear();
                                    var Todate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: Colors.black, // body text color
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors.black, // button text color
                                              ),
                                            ),
                                          ),
                                            child: child!,
                                          );
                                        });
                                    cashBookSiteController.cashbooksite_todateController.text = Todate.toString().substring(0, 10);
                                    await cashBookSiteController.getcashbooksitedetails();
                                    cashBookSiteController.calculations();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select Date';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
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
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: projectController.projectname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "ProjectName",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.staffName),
                          ),
                          onTap: () {
                            setState(() {
                              // projectController.getProjectList(context,0);
                              bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
                              FocusScope.of(context).unfocus();
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: BaseUtitiles.getWidthtofPercentage(context, 25),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: cashBookSiteController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            RequestConstant.SUBMIT,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: cashBookSiteController.checkColor == 0
                                    ? Colors.white
                                    : Theme.of(context).primaryColor),
                          ),
                        ),
                        onTap: () async {
                          cashBookSiteController.checkColor = 0;
                          cashBookSiteController.getcashbooksitedetails();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2),),
                  list(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bouttomNavigation() {
    return Card(
      child: Container(
        height: BaseUtitiles.getheightofPercentage(context, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total   ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    child: TextField(
                      readOnly: true,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      controller: cashBookSiteController.totalDebit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    child: TextField(
                      readOnly: true,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      controller: cashBookSiteController.totalCredit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Closing",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    child: TextField(
                      readOnly: true,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      controller: cashBookSiteController.closingDebit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    child: TextField(
                      readOnly: true,
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      controller: cashBookSiteController.closingCredit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget list() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 54),
      child: Column(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5),
                height: BaseUtitiles.getheightofPercentage(context, 52),
                child: Obx(
                      () => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cashBookSiteController.cashsiteDatas.value.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Left side (date)
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        cashBookSiteController.cashsiteDatas.value[index].vocdate.toString(),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                    // Right side (amount + arrow)
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end, // push to right
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "₹ ${cashBookSiteController.cashsiteDatas.value[index].debit.toString() == "0.0"
                                                  ? cashBookSiteController.cashsiteDatas.value[index].credit.toString()
                                                  : cashBookSiteController.cashsiteDatas.value[index].debit.toString()} ",
                                              textAlign: TextAlign.right, // right-align within Expanded
                                              style: TextStyle(
                                                color: cashBookSiteController.cashsiteDatas.value[index].debit.toString() == "0.0"
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            cashBookSiteController.cashsiteDatas.value[index].debit.toString() == "0.0"
                                                ? Icons.north_east
                                                : Icons.south_west,
                                            size: 15,
                                            color:  Colors.black, // match text color
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    // Expanded(
                                    //     flex: 3,
                                    //     child: Text("Descriptions",
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          cashBookSiteController.cashsiteDatas
                                              .value[index].descriptions
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        )),
                                  ],
                                ),
                                // Visibility(
                                //   visible: cashBookSiteController.cashsiteDatas
                                //       .value[index].descriptions ==
                                //       "OPENING BALANCE"
                                //       ? false
                                //       : true,
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 7),
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //             flex: 3,
                                //             child: Text("Voucher Type",
                                //                 style: TextStyle(
                                //                     fontWeight:
                                //                     FontWeight.bold))),
                                //         Expanded(
                                //             flex: 4,
                                //             child: Text(
                                //               cashBookSiteController.cashsiteDatas
                                //                   .value[index]
                                //                   .vocType
                                //                   .toString(),
                                //               textAlign: TextAlign.left,
                                //             )),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 7,
                                // ),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //         flex: 3,
                                //         child: Text(
                                //           "Debit",
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold),
                                //         )),
                                //     Expanded(
                                //         flex: 4,
                                //         child: Text(
                                //           cashBookSiteController.cashsiteDatas.value[index].debit.toString(),
                                //           textAlign: TextAlign.left,
                                //         )),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 7,
                                // ),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //         flex: 3,
                                //         child: Text("Credit",
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold))),
                                //     Expanded(
                                //         flex: 4,
                                //         child: Text(
                                //           cashBookSiteController.cashsiteDatas.value[index].credit.toString(),
                                //           textAlign: TextAlign.left,
                                //         )),
                                //   ],
                                // ),
                                // Divider(
                                //   thickness: 1,
                                // ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("Remarks:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          cashBookSiteController.cashsiteDatas.value[index].remarks.toString(),
                                          textAlign: TextAlign.left,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}



