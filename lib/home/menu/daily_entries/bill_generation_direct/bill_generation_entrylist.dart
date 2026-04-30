import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utilities/baseutitiles.dart';
import 'bill_generationdirect_entry.dart';

class Bill_Generation_direct_Entrylist extends StatefulWidget {
  const Bill_Generation_direct_Entrylist({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_direct_Entrylist> createState() =>
      _Subcont_NMR_EntryListScreenState_Site();
}

class _Subcont_NMR_EntryListScreenState_Site
    extends State<Bill_Generation_direct_Entrylist> {
  TextEditingController editingController = TextEditingController();
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    if(billGenerationDirectController.entrycheck==2){
      billGenerationDirectController.entrycheck=0;
    }
    else if(billGenerationDirectController.entrycheck==0){

    }
    else{
      billGenerationDirectController.entrycheck=1;
    }

    setState(() {
      billGenerationDirectController.main_entryList.value.clear();
      billGenerationDirectController.bill_entryList.value.clear();
    });
    billGenerationDirectController.editCheck=0;
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    billGenerationDirectController.EntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    billGenerationDirectController.EntrylistToDate.text = currentDate.toString().substring(0, 10);
    billGenerationDirectController.DirectBill_EntryList();
    billGenerationDirectController.bill_entryList.value = billGenerationDirectController.main_entryList.value;
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
      child: GestureDetector(
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
                billGenerationDirectController.editCheck =0;
                billGenerationDirectController.entrycheck =0;
                Navigator.push(context, MaterialPageRoute(builder: (context) => Bill_Generation_EntryScreen()));
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
                        Text(
                          "Direct - Bill",
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
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Expanded(
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
                                  controller: billGenerationDirectController.EntrylistFrDate,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
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
                                    billGenerationDirectController.bill_entryList.clear();
                                    var Frdate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),builder: (context, child) {
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
                                    billGenerationDirectController.EntrylistFrDate.text = Frdate.toString().substring(0, 10);
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
                                  controller: billGenerationDirectController.EntrylistToDate,
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
                                    billGenerationDirectController.bill_entryList.clear();
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
                                    billGenerationDirectController.EntrylistToDate.text =
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
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor),
                              onPressed: () async {
                                setState(() {
                                  billGenerationDirectController.DirectBill_EntryList();
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
                                  billGenerationDirectController.bill_entryList.value = BaseUtitiles.filterSearchResults_billGenerationDirect(value, billGenerationDirectController.main_entryList.value);
                                  // dailyWrkDone_DPR_Controller.searchentryList.value= BaseUtitiles.filterSearchResults_dprlist(value,dailyWrkDone_DPR_Controller.dpr_entryList);
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
                        padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: billGenerationDirectController.bill_entryList.value.length,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [

                                        Container(
                                          width: BaseUtitiles.getWidthtofPercentage(context, 50),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(left:5,right: 5),
                                                  child: ConstIcons.list_date),
                                              Text(
                                                billGenerationDirectController.bill_entryList.value[index].workDate.toString(),
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        billGenerationDirectController.bill_entryList.value[index].workNo.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 10),
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
                                          billGenerationDirectController.bill_entryList.value[index].subconName.toString(),
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
                                          billGenerationDirectController.bill_entryList.value[index].project.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),

                                SizedBox(height: 5),

                                Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 5, left: 10),
                                          child: Text(""),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              "From Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              billGenerationDirectController.bill_entryList.value[index].fdate.toString(),
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
                                              "To Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              billGenerationDirectController.bill_entryList.value[index].tdate.toString(),
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
                                          billGenerationDirectController.bill_entryList.value[index].siteName.toString(),
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
                                          "Preparedby",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          billGenerationDirectController.bill_entryList.value[index].preparedbyName.toString(),
                                          style: TextStyle(color: Colors.black),
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
                                                    return Container(
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
                                                                  billGenerationDirectController.bill_entryList.value[index].workNo.toString(),
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
                                                                billGenerationDirectController.entrycheck=1;
                                                                billGenerationDirectController.billgen_itemlistTable_Delete();
                                                                billGenerationDirectController.ItemGetTableListdata.clear();
                                                                billGenerationDirectController.bill_editListApiDatas.value.clear();
                                                                await billGenerationDirectController.directBillEntryList_EditApi(billGenerationDirectController.bill_entryList.value[index].workId,context);
                                                                FocusScope.of(context).unfocus();
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
                                                                  billGenerationDirectController.DeleteAlert(context,index);
                                                                });
                                                              }),
                                                          SizedBox(height: 20)
                                                        ],
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

                      //   Slidable(
                      //   actionPane: SlidableDrawerActionPane(),
                      //   secondaryActions: [
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: <Widget>[
                      //         Visibility(
                      //           visible: commanController.deleteMode == 1 ? true : false,
                      //           child: IconSlideAction(
                      //               icon: Icons.delete,
                      //               color: Colors.white10,
                      //               foregroundColor: Colors.red,
                      //               caption: RequestConstant.DELETE,
                      //               onTap: () {
                      //                 setState(() {
                      //                   billGenerationDirectController.DeleteAlert(context,index);
                      //                 });
                      //               }),
                      //         ),
                      //         Visibility(
                      //           visible: commanController.editMode == 1 ? true : false,
                      //           child: IconSlideAction(
                      //               icon: Icons.edit,
                      //               color: Colors.white10,
                      //               foregroundColor: Colors.green,
                      //               caption: RequestConstant.EDIT,
                      //               onTap: () async {
                      //                 billGenerationDirectController.entrycheck=1;
                      //                 billGenerationDirectController.billgen_itemlistTable_Delete();
                      //                 billGenerationDirectController.ItemGetTableListdata.clear();
                      //                 billGenerationDirectController.getDetList.clear();
                      //                 billGenerationDirectController.bill_editListApiDatas.value.clear();
                      //                 FocusScope.of(context).unfocus();
                      //                 await billGenerationDirectController.directBillEntryList_EditApi(billGenerationDirectController.bill_entryList.value[index].workId,context);
                      //               }),
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 3,right: 3),
                      //     height: BaseUtitiles.getheightofPercentage(context, 18),
                      //     width: BaseUtitiles.getWidthtofPercentage(context, 100),
                      //     child: Card(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       color: Colors.indigo.shade800,
                      //       child: Container(
                      //         margin: EdgeInsets.all(3),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: <Widget>[
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //               children: <Widget>[
                      //                 Expanded(
                      //                     flex: 1,
                      //                     child: Container(
                      //                       height: BaseUtitiles.getheightofPercentage(context, 2),
                      //                       child: Text(
                      //                         billGenerationDirectController.bill_entryList.value[index].workNo
                      //                             .toString(),
                      //                         style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
                      //                       ),
                      //                     )),
                      //                 Expanded(
                      //                     flex: 1,
                      //                     child: Container(
                      //                       margin: EdgeInsets.only(left: 70),
                      //                       height: BaseUtitiles.getheightofPercentage(context, 2),
                      //                       child: Text(
                      //                         billGenerationDirectController.bill_entryList.value[index].workDate
                      //                             .toString(),
                      //                         style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
                      //                       ),
                      //                     )),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: <Widget>[
                      //                 Expanded(flex: 2, child: Text("Cont Name",style: TextStyle(color: Colors.white),)),
                      //                 Expanded(
                      //                   flex: 3,
                      //                   child: Text(billGenerationDirectController.bill_entryList.value[index].subconName
                      //                       .toString(),style: TextStyle(color: Colors.white),
                      //
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: <Widget>[
                      //                 Expanded(flex: 2, child: Text("Project Name",style: TextStyle(color: Colors.white),)),
                      //                 Expanded(
                      //                     flex: 3,
                      //                     child: Text(billGenerationDirectController
                      //                         .bill_entryList.value[index].project
                      //                         .toString(),style: TextStyle(color: Colors.white),)),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: <Widget>[
                      //                 Expanded(flex: 2, child: Text("Site Name",style: TextStyle(color: Colors.white),)),
                      //                 Expanded(
                      //                     flex: 3,
                      //                     child: Text(billGenerationDirectController
                      //                         .bill_entryList.value[index].siteName
                      //                         .toString(),style: TextStyle(color: Colors.white),)),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: <Widget>[
                      //                 Expanded(flex: 2, child: Text("From Date",style: TextStyle(color: Colors.white),)),
                      //                 Expanded(
                      //                     flex: 3,
                      //                     child: Text(billGenerationDirectController
                      //                         .bill_entryList.value[index].fdate
                      //                         .toString(),style: TextStyle(color: Colors.white),)),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: <Widget>[
                      //                 Expanded(flex: 2, child: Text("To Date",style: TextStyle(color: Colors.white),)),
                      //                 Expanded(
                      //                     flex: 3,
                      //                     child: Text(billGenerationDirectController
                      //                         .bill_entryList.value[index].tdate
                      //                         .toString(),style: TextStyle(color: Colors.white),)),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );

                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
