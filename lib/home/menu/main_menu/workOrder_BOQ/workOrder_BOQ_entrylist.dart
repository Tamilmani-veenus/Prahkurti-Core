import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prahkurticore/controller/workOrderBoq_Controller.dart';
import 'package:prahkurticore/home/menu/main_menu/workOrder_BOQ/workOrder_BOQ_entryScreen.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class WorkOrderBoqEntrylist extends StatefulWidget {
  final String heading;
  const WorkOrderBoqEntrylist({super.key,required this.heading});

  @override
  State<WorkOrderBoqEntrylist> createState() => _WorkOrderBoqEntrylistState();
}

class _WorkOrderBoqEntrylistState extends State<WorkOrderBoqEntrylist> {

  TextEditingController editingController = TextEditingController();
  WorkOrderBoqController workOrderBoqController = Get.put(WorkOrderBoqController());

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    workOrderBoqController.EntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    workOrderBoqController.EntrylistToDate.text = currentDate.toString().substring(0, 10);
    workOrderBoqController.WorkOrdBoq_EntryList();
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              workOrderBoqController.saveButton.value = RequestConstant.SUBMIT;
              workOrderBoqController.delete_WorkOrderBoq_itemlist_Table();
              workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value=[];
              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkOrderBoqEntryScreen(heading: widget.heading,)));
            },
            label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
            icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                  margin: EdgeInsets.only(top: 3),
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
                              controller: workOrderBoqController.EntrylistFrDate,
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
                                    child: ConstIcons.date),
                              ),
                              onTap: () async {
                                workOrderBoqController.workOrderBoq_entryList.clear();
                                var Frdate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),builder: (context, child) {
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
                                workOrderBoqController.EntrylistFrDate.text = Frdate.toString().substring(0, 10);
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
                              controller: workOrderBoqController.EntrylistToDate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "ToDate",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.date),
                              ),
                              onTap: () async {
                                workOrderBoqController.workOrderBoq_entryList.clear();
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
                                workOrderBoqController.EntrylistToDate.text =
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
                                editingController.text = "";
                                workOrderBoqController.WorkOrdBoq_EntryList();
                              });
                            },
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 13, bottom: 13),
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


                SizedBox(height: 10),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: new BorderRadius.only(
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
                                workOrderBoqController.workOrderBoq_entryList.value= BaseUtitiles.filterSearchResults_workOrderDirect(value,workOrderBoqController.main_entryList);
                              });
                            },
                          ),
                        ),

                        ListDetails(),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 69),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: BaseUtitiles.getheightofPercentage(context, 68),
              child: Obx(
                    () => ListView.builder(
                    padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 10)),
                    physics: BouncingScrollPhysics(),
                    itemCount: workOrderBoqController.workOrderBoq_entryList.value.length,

                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                workOrderBoqController.workOrderBoq_entryList.value[index].entryDate.toString(),
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
                                        workOrderBoqController.workOrderBoq_entryList.value[index].workOrderNo.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: 8),

                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Project",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].projectName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Site Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].siteName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Subcontractor",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].subContractorName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Net Amount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].netAmount.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Preparedby",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].createdName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),

                                Divider(thickness: 1),

                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
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
                                        flex: 5,
                                        child: Text(
                                          workOrderBoqController.workOrderBoq_entryList.value[index].verifyStatus == "Y" &&
                                              workOrderBoqController.workOrderBoq_entryList.value[index].approveStatus == "Y" ? "Approved" :
                                          workOrderBoqController.workOrderBoq_entryList.value[index].verifyStatus == "Y" ? "Verified" : "In-Progress".toString() ,
                                          style: TextStyle(color:  workOrderBoqController.workOrderBoq_entryList.value[index].approveStatus== "Y" ? Colors.green:Colors.black),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    // <-- SEE HERE
                                                    borderRadius: BorderRadius.vertical(
                                                        top: Radius.circular(25.0)),
                                                  ),
                                                  builder: (context) {
                                                    return SafeArea(
                                                      top: false,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: 15,
                                                        ),
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
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: 10),
                                                                  child: Text(
                                                                    workOrderBoqController.workOrderBoq_entryList.value[index].workOrderNo.toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: Theme.of(
                                                                            context)
                                                                            .primaryColor),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: ConstIcons.cancle)
                                                              ],
                                                            ),

                                                            InkWell(
                                                                child: Row(
                                                                  children: [
                                                                    Card(
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      child: Padding(
                                                                        padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                        child: Icon(
                                                                          Icons.edit,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 5),
                                                                    Text(
                                                                      "Edit",
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.grey,
                                                                          fontSize: 15),
                                                                    )
                                                                  ],
                                                                ),
                                                                onTap: () async {
                                                                  // workOrderBoqController.workOrder_itemlistTable_Delete();
                                                                  // workOrderBoqController.ItemGetTableListdata.clear();
                                                                  // workOrderBoqController.workOrder_editListApiDatas.value.clear();
                                                                  // FocusScope.of(context).unfocus();
                                                                  // await workOrderBoqController.workOrderEntryList_EditApi(
                                                                  //     workOrderBoqController.workOrderDir_entryList.value[index].id,true,
                                                                  //     widget.heading,
                                                                  //     context,type:"ReSubmit");
                                                                }),

                                                            Container(
                                                                margin: EdgeInsets.only(right: 20),
                                                                child: Divider(thickness: 1)),

                                                            InkWell(
                                                                child: Row(
                                                                  children: [
                                                                    Card(
                                                                      color: Colors.red,
                                                                      child: Padding(
                                                                        padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                        child: Icon(
                                                                          Icons
                                                                              .delete_forever,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 5),
                                                                    Text(
                                                                      "Delete",
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.grey,
                                                                          fontSize: 15),
                                                                    )
                                                                  ],
                                                                ),
                                                                onTap: () async {
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    workOrderBoqController.DeleteAlert(context,index,"EntryList");
                                                                  });
                                                                }),
                                                            SizedBox(height: 20)
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.arrow_drop_down_circle_outlined,
                                              color: Theme.of(context).primaryColor,
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
    );
  }
}
