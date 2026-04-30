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

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      expensesController.supplierOSExpensesList.value.clear();
      expensesController.totalamtcontroller.text = "0";
     await companyController.getCompanyList(context, 0);
      companyController.selectedCompanyName.value = "--SELECT--";
      companyController.selectedCompanyId(0);
      companyController.CompanyName.text = "--Select--";
      companyController.selectedCompanyId.value = 0;

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onTap: () {
                      setState(() {
                        bottomsheetControllers.CompanyName(context,companyController.getdropDownvalue.value );
                      });
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
                      expensesController.getSupplierOS_ExpensesList();
                      expensesController.totalAmt();
                    });
                    var duration = Duration(seconds: 1);
                    Future.delayed(duration, () async {
                      setState((){
                        expensesController.totalAmt();
                      });
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
                // shape: BeveledRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
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
                                    expensesController.totalamtcontroller.text,
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 17),))),
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
    );
  }


  Widget ExpandedList() {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        height: BaseUtitiles.getheightofPercentage(context, 75),
        width: BaseUtitiles.getWidthtofPercentage(context, 100),
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
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
                          expensesController.supplierOSExpensesList[index].supplier.toString(),style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ("₹ " + BaseUtitiles.amountFormat(expensesController.supplierOSExpensesList.value[index].balamt)),
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
