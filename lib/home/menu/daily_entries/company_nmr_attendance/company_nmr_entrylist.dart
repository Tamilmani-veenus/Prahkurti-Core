
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../controller/comman_controller.dart';
import '../../../../controller/company_nmr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Company_nmr_entrylist extends StatefulWidget {
  const Company_nmr_entrylist({Key? key}) : super(key: key);

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
    companyNmrAttendanceController.getCompanyEntryList(companyNmrAttendanceController.Company_EntrylistFrdate.text,companyNmrAttendanceController.Company_EntrylistTodate.text);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 20),
                    decoration: BoxDecoration(),
                    child: TextField(
                      style: TextStyle(fontSize: 13),
                      readOnly: true,
                      controller:
                      companyNmrAttendanceController.Company_EntrylistFrdate,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                        companyNmrAttendanceController.getCompanyEntryList(companyNmrAttendanceController.Company_EntrylistFrdate.text, companyNmrAttendanceController.Company_EntrylistTodate.text);
                        var Frdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(context)
                                        .primaryColor, // header background color
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
                        companyNmrAttendanceController.Company_EntrylistFrdate.text = Frdate.toString().substring(0, 10);
                        companyNmrAttendanceController.getCompanyEntryList(companyNmrAttendanceController.Company_EntrylistFrdate.text, companyNmrAttendanceController.Company_EntrylistTodate.text);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 20),
                    decoration: BoxDecoration(),
                    child: TextField(
                      style: TextStyle(fontSize: 13),
                      readOnly: true,
                      controller:
                      companyNmrAttendanceController.Company_EntrylistTodate,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                        companyNmrAttendanceController.getCompanyEntryList(companyNmrAttendanceController.Company_EntrylistFrdate.text, companyNmrAttendanceController.Company_EntrylistTodate.text);
                        var Todate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(context)
                                        .primaryColor, // header background color
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
                        companyNmrAttendanceController.Company_EntrylistTodate
                            .text = Todate.toString().substring(0, 10);
                        companyNmrAttendanceController.getCompanyEntryList(
                            companyNmrAttendanceController
                                .Company_EntrylistFrdate.text,
                            companyNmrAttendanceController
                                .Company_EntrylistTodate.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: BaseUtitiles.getheightofPercentage(context, 5),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  companyNmrAttendanceController.Entrylist.value = BaseUtitiles.filterSearchResults(value, companyNmrAttendanceController.CompanyEntrylist);
                });
              },
              controller: editingController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  labelText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          ListDetails(),
        ],
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 3),
      height: BaseUtitiles.getheightofPercentage(context, 69),
      width: BaseUtitiles.getWidthtofPercentage(context, 100),
      child: Obx(
            () => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: companyNmrAttendanceController.Entrylist.value.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Visibility(
                        visible: commanController.deleteMode == 1 ? true : false,
                        child: IconSlideAction(
                            icon: Icons.delete,
                            color: Colors.white10,
                            foregroundColor: Colors.red,
                            caption: RequestConstant.DELETE,
                            onTap: () {
                              setState(() {
                                companyNmrAttendanceController.entrycheck=0;
                                companyNmrAttendanceController.DeleteAlert(context,index);
                              });
                            }),
                      ),
                      Visibility(
                        visible: commanController.editMode == 1 ? true : false,
                        child: IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.white10,
                            foregroundColor: Colors.green,
                            caption: RequestConstant.EDIT,
                            onTap: () async {
                              companyNmrAttendanceController.edicheck=1;
                              companyNmrAttendanceController.entrycheck=1;
                              companyNmrAttendanceController.screencheck.value="";
                              FocusScope.of(context).unfocus();
                             companyNmrAttendanceController.entryList_EditApi(companyNmrAttendanceController.Entrylist.value[index].nmrLbrAttnId, context);
                            }),
                      ),
                    ],
                  )
                ],
                child: Container(
                  margin: EdgeInsets.only(left: 3,right: 3),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.indigo.shade800,
                    child: Container(
                      margin: EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(companyNmrAttendanceController
                                  .Entrylist.value[index].nmrLbrAttnNo
                                  .toString(),style: TextStyle(color: Colors.yellow)),
                              Text(
                                  companyNmrAttendanceController.Entrylist.value[index].labrAttnDate.toString(),
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text("Project",style: TextStyle(color: Colors.white),)),
                              Expanded(
                                flex: 3,
                                child: Text(companyNmrAttendanceController
                                    .Entrylist.value[index].project
                                    .toString(),style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text("Bill Status",style: TextStyle(color: Colors.white),)),
                              Expanded(
                                flex: 3,
                                child: Text(companyNmrAttendanceController
                                    .Entrylist.value[index].billstatus
                                    .toString(),style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text("Status",style: TextStyle(color: Colors.white),)),
                              Expanded(
                                flex: 3,
                                child: Text(companyNmrAttendanceController
                                    .Entrylist.value[index].appstatus
                                    .toString(),style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text("Site Name",style: TextStyle(color: Colors.white),)),
                              Expanded(
                                flex: 3,
                                child: Text(companyNmrAttendanceController
                                    .Entrylist.value[index].siteName
                                    .toString(),style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text("Prepared By",style: TextStyle(color: Colors.white),)),
                              Expanded(
                                flex: 3,
                                child: Text(companyNmrAttendanceController
                                    .Entrylist.value[index].preparedByName
                                    .toString(),style: TextStyle(color: Colors.yellow),
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