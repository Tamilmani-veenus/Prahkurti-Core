import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'daily_wrkdone_dpr_entry.dart';

class DailyWork_done_DPR_EntryList extends StatefulWidget {
  final String heading;
  const DailyWork_done_DPR_EntryList({Key? key,required this.heading}) : super(key: key);

  @override
  State<DailyWork_done_DPR_EntryList> createState() => _DailyWork_done_DPR_EntryListState();
}

class _DailyWork_done_DPR_EntryListState extends State<DailyWork_done_DPR_EntryList> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {

    var duration = Duration(seconds: 0);

    Future.delayed(duration,() async {
      dailyWrkDone_DPR_Controller.dpr_entryList.value=[];
      dailyWrkDone_DPR_Controller.searchentryList.value=[];
      DateTime currentDate = DateTime.now();
      DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
      dailyWrkDone_DPR_Controller.entryList_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
      dailyWrkDone_DPR_Controller.entryList_todateController.text = BaseUtitiles.initiateCurrentDateFormat();
      dailyWrkDone_DPR_Controller.searchentryList.value=dailyWrkDone_DPR_Controller.dpr_entryList.value;
      dailyWrkDone_DPR_Controller.dpr_getEntryList();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            setState(() {
              dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
              dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
              dailyWrkDone_DPR_Controller.saveButton.value=RequestConstant.SUBMIT;
              Navigator.push(context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_Entry(heading: widget.heading)));
            });
            },
          label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
          icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
          backgroundColor: Theme.of(context).primaryColor,
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
                            controller: dailyWrkDone_DPR_Controller.entryList_frdateController,
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
                              var Frdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          onPrimary: Colors.white,
                                          onSurface:
                                          Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                            Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              dailyWrkDone_DPR_Controller.entryList_frdateController.text = Frdate.toString().substring(0, 10);
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
                            controller: dailyWrkDone_DPR_Controller.entryList_todateController,
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
                              var Todate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          // header background color
                                          onPrimary: Colors.white,
                                          // header text color
                                          onSurface:
                                          Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                            Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              dailyWrkDone_DPR_Controller.entryList_todateController.text =
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
                              dailyWrkDone_DPR_Controller.dpr_getEntryList();
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
              SizedBox(height: 30),
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
                          decoration: const InputDecoration(
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
                              dailyWrkDone_DPR_Controller.dpr_entryList.value= BaseUtitiles.filterSearchResults_dprlist(value,dailyWrkDone_DPR_Controller.searchentryList);
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
    );
  }

  Widget ListDetails() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 69),
      child: Column(
        children: [
          Container(
            height: BaseUtitiles.getheightofPercentage(context, 68),
            child: Obx(
                  () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 10)),
                  physics: BouncingScrollPhysics(),
                  itemCount: dailyWrkDone_DPR_Controller.dpr_entryList.value.length,
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
                                                margin: EdgeInsets.only(left: 10, right: 3),
                                                child: ConstIcons.list_date),
                                            Text(
                                              dailyWrkDone_DPR_Controller.dpr_entryList.value[index].workDate.toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      dailyWrkDone_DPR_Controller
                                          .dpr_entryList.value[index].workNo
                                          .toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(height: 10),

                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Project",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller.dpr_entryList.value[index].projectName.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Site Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].siteName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,),
                                      )),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Contractor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].subcontractorName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,),
                                      )),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller.dpr_entryList.value[index].status.toString(),
                                        style: TextStyle(color:  dailyWrkDone_DPR_Controller.dpr_entryList.value[index].status.toString() == "Approved" ? Colors.green : Colors.black),
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
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Prepared By ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].createdName
                                            .toString(),
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            WorkId = dailyWrkDone_DPR_Controller.dpr_entryList.value[index].id;
                                            if( dailyWrkDone_DPR_Controller.dpr_entryList.value[index].approveStatus.toString() == "Y"){
                                              BaseUtitiles.showToast("${ dailyWrkDone_DPR_Controller.dpr_entryList.value[index].AppStatusName.toString()} list can not be edit or delete");
                                            }else{
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
                                                                  margin: EdgeInsets.only(right: 10),
                                                                  child: Text(
                                                                    dailyWrkDone_DPR_Controller.dpr_entryList.value[index].workNo.toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        color: Theme.of(context).primaryColor),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    icon: ConstIcons.cancle)
                                                              ],
                                                            ),
                                                            InkWell(
                                                                child: const Row(
                                                                  children: [
                                                                    Card(
                                                                      color: Colors.lightGreen,
                                                                      child: Padding(
                                                                        padding:
                                                                        EdgeInsets
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
                                                                onTap: () {
                                                                  dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
                                                                  dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
                                                                  dailyWrkDone_DPR_Controller.getDprDetList.value.clear();
                                                                  dailyWrkDone_DPR_Controller.DprEntryList_EditApi(
                                                                      dailyWrkDone_DPR_Controller.searchentryList.value[index].id,
                                                                      widget.heading,context,0);
                                                                  FocusScope.of(context).unfocus();
                                                                  Navigator.pop(context);
                                                                }),
                                                            Container(
                                                                margin: EdgeInsets.only(right: 20),
                                                                child: Divider(thickness: 1)),
                                                            InkWell(
                                                                child: const Row(
                                                                  children: [
                                                                    Card(
                                                                      color: Colors.red,
                                                                      child: Padding(
                                                                        padding:
                                                                        EdgeInsets
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
                                                                onTap: ()  {
                                                                  setState(() {
                                                                    Navigator.pop(context);
                                                                    dailyWrkDone_DPR_Controller.DeleteAlert(context, index);

                                                                  });
                                                                }),
                                                            SizedBox(height: 20)
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }
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
        ],
      ),
    );
  }
}