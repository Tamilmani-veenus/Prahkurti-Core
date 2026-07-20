import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/expensencecontroller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/companycontroller.dart';

class Supplieroutstanding extends StatefulWidget {
  const Supplieroutstanding({Key? key}) : super(key: key);

  @override
  State<Supplieroutstanding> createState() => _SupplierState();
}

class _SupplierState extends State<Supplieroutstanding> {

  final CompanyController companyController = Get.put(CompanyController());
  final BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  final ExpensesController expensesController = Get.put(ExpensesController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      expensesController.supplierOSExpensesList.value.clear();
      companyController.CompanyName.text = "--SELECT--";
      companyController.selectedCompanyId.value = 0;
      expensesController.totalamtcontroller.text = "0";
      expensesController.totalamt.value = 0.0;
      DateTime currentDate = DateTime.now();
      DateTime oneWeekBefore = currentDate.subtract(const Duration(days: 7));
      companyController.SupplierlistFrDate.text = oneWeekBefore.toString().substring(0, 10);
      companyController.SupplierlistToDate.text = currentDate.toString().substring(0, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
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
                        "Supplier O/S",
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
                            style:
                            TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
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
                              controller:
                              companyController.SupplierlistFrDate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "From Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date,
                                ),
                              ),
                              onTap: () async {
                                DateTime today = DateTime.now();
                                DateTime initialDate = today.subtract(const Duration(days: 7));

                                if (initialDate.isBefore(DateTime(1900))) {
                                  initialDate = DateTime(1900);
                                }
                                var Frdate = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1900),
                                    lastDate: today,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                            Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            onSurface:
                                            Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors
                                                  .black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                companyController.SupplierlistFrDate.text =
                                    Frdate.toString().substring(0, 10);
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
                      Container(
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
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
                              controller:
                              companyController.SupplierlistToDate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon(Icons.calendar_month,
                                        color: Theme.of(context).primaryColor)),
                              ),
                              onTap: () async {
                                DateTime today = DateTime.now();
                                DateTime fromDate = DateTime.parse(companyController.SupplierlistFrDate.text);
                                var Todate = await showDatePicker(
                                    context: context,
                                    initialDate: today.isBefore(fromDate) ? fromDate : today,
                                    firstDate: fromDate,
                                    lastDate: today,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                            Theme.of(context).primaryColor,
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
                                            onSurface:
                                            Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors
                                                  .black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                companyController.SupplierlistToDate.text =
                                    Todate.toString().substring(0, 10);
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
                      padding: const EdgeInsets.only(
                          top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: companyController.CompanyName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.siteName),
                        ),
                        onTap: () async {
                          await companyController.getCompanyList();
                            if(mounted) {
                              bottomsheetControllers.CompanyName(context,
                                  companyController.getdropDownvalue.value);
                            }},
                        validator: (value) {
                            if (value!.isEmpty ||
                                value == "--Select--" ||
                                value == "--SELECT--") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
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
                          color: Theme.of(context).primaryColor
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          RequestConstant.SUBMIT,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white),
                        ),
                      ),
                      onTap: ()  {
                        setState(() {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            expensesController.getSupplierOS_ExpensesList(companyController.SupplierlistFrDate.text,companyController.SupplierlistToDate.text);
                          }

                        });
                      },
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top:5),
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
                            "Supplier Name",
                            textAlign: TextAlign.center
                            ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text("Cr/Dr Amount",textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
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
                            Expanded(
                                flex: 4,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Obx(()=>
                                       Text("₹ ${expensesController.totalamt.value.toStringAsFixed(2)}",
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 17),),
                                    ))),
                        ],
                      ),
                    ),
                  ),
                ),

                // Divider(color: Theme.of(context).primaryColor),

                ExpandedList(),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget ExpandedList() {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        height: BaseUtitiles.getheightofPercentage(context, 60),
        width: BaseUtitiles.getWidthtofPercentage(context, 100),
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 10)),
          itemCount: expensesController.supplierOSExpensesList.value.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          expensesController.supplierOSExpensesList[index].supplierName.toString(),style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ("₹ " + expensesController.supplierOSExpensesList.value[index].totalBalanceAmount.toStringAsFixed(2)),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
              ),
            );
          },
        )));
  }
}
