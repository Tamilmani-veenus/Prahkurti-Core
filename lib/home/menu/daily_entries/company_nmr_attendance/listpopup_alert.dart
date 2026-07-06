import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../controller/company_nmr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';


class CompanyNmr_ListAlert extends StatefulWidget {
  const CompanyNmr_ListAlert({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<CompanyNmr_ListAlert> createState() => _CompanyNmr_ListAlertState();

}

class _CompanyNmr_ListAlertState extends State<CompanyNmr_ListAlert> {
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    companyNmrAttendanceController.list.value=[];
    companyNmrAttendanceController.isChecked = List<bool>.filled(widget.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await companyNmrAttendanceController.cmpNmr_Det_Save_DB(context);
              await companyNmrAttendanceController.getcmpNMRTablesDatas();
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
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Labour \nDetails",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: BaseUtitiles.getheightofPercentage(context, 5),
                        width: BaseUtitiles.getWidthtofPercentage(context, 50),
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
                            fillColor: Colors.white,
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            // if (onSearch != null) onSearch!(searchcontroller.text);
                          },
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() {
                              companyNmrAttendanceController.list.value = BaseUtitiles.cmpNMRLabourNamePopupAlert(value, companyNmrAttendanceController.AlldataList.value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                listDetails(),
              ],
            ),
          )),
    );


  }


  Widget listDetails() {
    if (editingController.text.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    itemCount:  companyNmrAttendanceController.AlldataList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Setmybackground,
                        margin: EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                          width: 1.0,
                                          // color: Colors.white
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          companyNmrAttendanceController.setCheck(
                                              companyNmrAttendanceController.AlldataList[index].labourId, value!);
                                          companyNmrAttendanceController.AlldataList[index].ischeck = value;
                                        });
                                      },
                                      value: companyNmrAttendanceController.AlldataList[index].ischeck),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 3),
                                        width: BaseUtitiles.getWidthtofPercentage(
                                            context, 85),
                                        child: Text(
                                          companyNmrAttendanceController.AlldataList[index].labourName.toString(),
                                          style: TextStyle(
                                              fontSize:
                                              RequestConstant.ALERT_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 3),
                                      child:  Row(
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  RequestConstant.Lable_Font_SIZE),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:  companyNmrAttendanceController.AlldataList[index].categoryName.toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: RequestConstant.ALERT_Font_SIZE,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                    RequestConstant.Lable_Font_SIZE),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "  ( " + "Wages: " + companyNmrAttendanceController.AlldataList[index].wages.toString() + " ) ",
                                                    style: TextStyle(
                                                        color: Theme.of(context).primaryColor,
                                                        fontSize: RequestConstant.App_Font_SIZE,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
      );
    }
    else if (companyNmrAttendanceController.list.isNotEmpty) {
      return  Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child: ListView.builder(
              itemCount: companyNmrAttendanceController.list.value.length,
              itemBuilder: (BuildContext context, int index) {
                companyNmrAttendanceController.textControllersInitiate();
                return Container(
                  color: Setmybackground,
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).primaryColor,
                                    // color: Colors.white
                                  ),
                                ),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    companyNmrAttendanceController.serachsetCheck(
                                        companyNmrAttendanceController.list[index].labourId, value!);
                                    companyNmrAttendanceController.list[index].ischeck = value;
                                  });
                                },
                                value: companyNmrAttendanceController
                                    .list.value[index].ischeck),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 3),
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 85),
                                  child: Text(
                                    companyNmrAttendanceController.list[index].labourName.toString(),
                                    style: TextStyle(
                                        fontSize:
                                        RequestConstant.ALERT_Font_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 3),
                                child:  Row(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:  companyNmrAttendanceController.list[index].categoryName.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "  ( " + "₹ " + companyNmrAttendanceController.list[index].wages.toString() + " ) ",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: RequestConstant.App_Font_SIZE,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    } else {
      return SizedBox();
    }
  }

}
