
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/company_nmr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'company_nmr_entryscreen.dart';

class Company_nmr_entrylist extends StatefulWidget {
  final String heading;
  const Company_nmr_entrylist({Key? key,required this.heading}) : super(key: key);

  @override
  State<Company_nmr_entrylist> createState() => _Company_nmr_entrylistState();
}

class _Company_nmr_entrylistState extends State<Company_nmr_entrylist> {

  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  CommanController commanController=Get.put(CommanController());
  TextEditingController editingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth =
    new DateTime(currentDate.year, currentDate.month - 1, 0);
    companyNmrAttendanceController.Company_EntrylistFrdate.text = lastDayOfMonth.toString().substring(0, 10);
    companyNmrAttendanceController.Company_EntrylistTodate.text = currentDate.toString().substring(0, 10);
    companyNmrAttendanceController.getCompanyEntryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          floatingActionButton: Obx(
                () => Visibility(
              visible: commanController.addMode.value == 1 ? true : false,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  companyNmrAttendanceController.saveButton.value = RequestConstant.SUBMIT;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Company_nmr_entryscreen(heading: widget.heading,)));

                },
                label: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: RequestConstant.Lable_Font_SIZE,
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: RequestConstant.Heading_Font_SIZE,
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                         widget.heading,
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
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
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
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
                              controller:
                              companyNmrAttendanceController.Company_EntrylistFrdate,
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
                                var Frdate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
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
                                companyNmrAttendanceController.Company_EntrylistFrdate.text =
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
                              controller:
                              companyNmrAttendanceController.Company_EntrylistTodate,
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
                                var Todate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
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
                                companyNmrAttendanceController.Company_EntrylistTodate.text =
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
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            onPressed: () async {
                              setState(() {
                                editingController.text="";
                                companyNmrAttendanceController.getCompanyEntryList();
                              });
                            },
                            child: Center(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 13, bottom: 13),
                                  child: Text("SHOW",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: RequestConstant.App_Font_SIZE,
                                          fontWeight: FontWeight.bold)),
                                ))),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 15),
                                child: ConstIcons.list_Search,
                              ),
                              hintText: "Search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                companyNmrAttendanceController.CompanyEntrylist.value =
                                    BaseUtitiles
                                        .subcontLabAttendPopupAlert(
                                        value,
                                        companyNmrAttendanceController.Entrylist);
                              });
                            },
                          ),
                        ),
                        ListDetails(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return SingleChildScrollView(
      child: Container(
        height: BaseUtitiles.getheightofPercentage(context, 69),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: Obx(
                      () => ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 12) ),
                      itemCount: companyNmrAttendanceController.CompanyEntrylist.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 3, right: 3),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: BaseUtitiles
                                                .getWidthtofPercentage(
                                                context, 50),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 3),
                                                  child: ConstIcons.list_date,
                                                ),
                                                Text(
                                                  companyNmrAttendanceController.CompanyEntrylist[index]
                                                      .labourAttendanceDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          companyNmrAttendanceController.CompanyEntrylist
                                              .value[index].labourAttendanceNo.trim()
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Project",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist
                                                .value[index].projectName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Site",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist
                                                .value[index].siteName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "SubContractor",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist
                                                .value[index].subContractorName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Labour Count",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist[index].labourCount.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Type",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist[index].workTypName.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Bill Status",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist[index].billStatusDesc.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Prepared By",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist[index].employeeName.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Divider(thickness: 1),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.only( left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Status",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            companyNmrAttendanceController.CompanyEntrylist
                                                .value[index].appType
                                                .toString(),
                                            style: TextStyle(color: companyNmrAttendanceController.CompanyEntrylist
                                                .value[index].appType=="Approved"?Colors.green:Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      // <-- SEE HERE
                                                      borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius
                                                              .circular(
                                                              25.0)),
                                                    ),
                                                    builder: (context) {
                                                      return SafeArea(
                                                        top: false,
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: 15),
                                                          height: BaseUtitiles
                                                              .getheightofPercentage(
                                                              context, 25),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                          10),
                                                                      child: Text(
                                                                        companyNmrAttendanceController.CompanyEntrylist
                                                                            .value[index]
                                                                            .labourAttendanceNo
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                            Theme.of(context).primaryColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: ConstIcons
                                                                        .cancle,
                                                                  )
                                                                ],
                                                              ),
                                                              Visibility(
                                                                visible: commanController.editMode.value == 1
                                                                    ? true
                                                                    : false,
                                                                child: InkWell(
                                                                    child: Row(
                                                                      children: [
                                                                        Card(
                                                                          color: Colors
                                                                              .lightGreen,
                                                                          child:
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                8),
                                                                            child:
                                                                            Icon(
                                                                              Icons.edit,
                                                                              color:
                                                                              Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                            5),
                                                                        Text(
                                                                          "Edit",
                                                                          style: TextStyle(
                                                                              color:
                                                                              Colors.grey,
                                                                              fontSize: 15),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                          companyNmrAttendanceController.delete_cmpNmrdetTable();
                                                                          companyNmrAttendanceController.cmpNmr_getDbDetList.clear();
                                                                      await companyNmrAttendanceController.entryList_EditApi(
                                                                          companyNmrAttendanceController.CompanyEntrylist[index].id,true,"Edit",
                                                                          widget.heading,
                                                                          context);
                                                                    }),
                                                              ),
                                                              Container(
                                                                  margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      20),
                                                                  child:
                                                                  const Divider(
                                                                      thickness:
                                                                      1)),
                                                              Visibility(
                                                                visible: commanController
                                                                    .deleteMode
                                                                    .value ==
                                                                    1
                                                                    ? true
                                                                    : false,
                                                                child: InkWell(
                                                                    child:
                                                                    const Row(
                                                                      children: [
                                                                        Card(
                                                                          color: Colors
                                                                              .red,
                                                                          child:
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.all(8),
                                                                            child:
                                                                            Icon(
                                                                              Icons.delete_forever,
                                                                              color:
                                                                              Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                            5),
                                                                        Text(
                                                                          "Delete",
                                                                          style: TextStyle(
                                                                              color:
                                                                              Colors.grey,
                                                                              fontSize: 15),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      companyNmrAttendanceController
                                                                          .DeleteAlert(
                                                                          context,
                                                                          index);
                                                                    }),
                                                              ),
                                                              SizedBox(height: 20)
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .arrow_drop_down_circle_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}