import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'daily_wrkdone_dpr_entrynew.dart';

class DailyWork_done_DPR_EntryListNew extends StatefulWidget {
  const DailyWork_done_DPR_EntryListNew({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_EntryListNew> createState() => _DailyWork_done_DPR_EntryListNewState();
}

class _DailyWork_done_DPR_EntryListNewState extends State<DailyWork_done_DPR_EntryListNew> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    if(dailyWrkDone_DPRNEW_Controller.entrycheck==2){
      dailyWrkDone_DPRNEW_Controller.entrycheck=0;
    }
    else if( dailyWrkDone_DPRNEW_Controller.entrycheck==0){

    }
    else{
      dailyWrkDone_DPRNEW_Controller.entrycheck=1;
    }
    setState(() {
      dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value.clear();
      dailyWrkDone_DPRNEW_Controller.main_entryList.value.clear();
    });
    dailyWrkDone_DPRNEW_Controller.editcheck=0;
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
    dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_todateController.text = BaseUtitiles.initiateCurrentDateFormat();
    dailyWrkDone_DPRNEW_Controller.dpr_New_getEntryList();
    dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value = dailyWrkDone_DPRNEW_Controller.main_entryList.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
          floatingActionButton:
          Obx(()=> Visibility(
            visible: commanController.addMode.value == 1 ? true : false,
            child: FloatingActionButton.extended(
              onPressed: (){
                setState(() {
                  dailyWrkDone_DPRNEW_Controller.entrycheck =0;
                  dailyWrkDone_DPRNEW_Controller.editcheck =0;
                  dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_Entry_New()));
                });
              },
              label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
              icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),),
        
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daily Work Done DPR NMR",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back", style: TextStyle(color: Colors.grey, fontSize: 18),
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
                              controller: dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_frdateController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
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
                                dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_frdateController.text = Frdate.toString().substring(0, 10);
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
                              controller: dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_todateController,
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
                                dailyWrkDone_DPRNEW_Controller.dpr_New_entryList_todateController.text =
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
                            style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                            onPressed: () {
                              setState(() {
                                dailyWrkDone_DPRNEW_Controller.dpr_New_getEntryList();
                              });
                            },
                            child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 13, bottom: 13),
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
                                dailyWrkDone_DPR_Controller.searchentryList.value= BaseUtitiles.filterSearchResults_dprlist(value,dailyWrkDone_DPR_Controller.dpr_entryList);
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
          Container(
            height: BaseUtitiles.getheightofPercentage(context, 68),
            child: Obx(
                  () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                      itemCount: dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value.length,
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
                                              dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workDate.toString(),
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
                                      dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workNo.toString(),
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
                                  Expanded(
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
                                        dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].project.toString(),
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
                                        dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].siteName.toString(),
                                        style: TextStyle(
                                          color: Colors.black),
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
                                      flex: 3,
                                      child: Text(
                                        "Subcontractor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].subconName.toString(),
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
                                      flex: 3,
                                      child: Text(
                                        "Entry Type",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].entrytype=="BOQ"?"RATE":dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].entrytype,
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
                                        dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].AppStatusName.toString(),
                                        style: TextStyle(
                                          color: dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].AppStatusName.toString() == "Approved" ? Colors.green : Colors.black,),
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
                                      flex: 2,
                                      child: Text(
                                        "Prepared By :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                          dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].preparedbyName.toString(),
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            if( dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].appStatus.toString() == "Y"){
                                              BaseUtitiles.showToast("${ dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].AppStatusName.toString()} list can not be edit or delete");
                                            }else{
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
                                                                  dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workNo.toString(),
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
                                                          Visibility(
                                                            visible: commanController.editMode.value == 1 ? true : false,
                                                            child: InkWell(
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
                                                                onTap: () async {
                                                                  dailyWrkDone_DPRNEW_Controller.entrycheck=1;
                                                                  dailyWrkDone_DPRNEW_Controller.editcheck=0;
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_MaterialTable_Delete();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNewGetMatreadListdata.value.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_MSRTable_Delete();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.getDprNewDetList.value.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.getDprNewLabList.value.clear();
                                                                  // dailyWrkDone_DPRNEW_Controller.getDprNewMatList.value.clear();
                                                                  // dailyWrkDone_DPRNEW_Controller.getDprNewMSRList.value.clear();
                                                                  dailyWrkDone_DPRNEW_Controller.dprNew_EditApiList.value.clear();
                                                                  FocusScope.of(context).unfocus();
                                                                  await dailyWrkDone_DPRNEW_Controller.Dpr_New_EntryList_EditApi(dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workId,context,0);
                                                                }),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets.only(right: 20),
                                                              child: Divider(thickness: 1)),
                                                          Visibility(
                                                            visible: commanController.deleteMode.value == 1 ? true : false,
                                                            child: InkWell(
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
                                                                onTap: ()  {
                                                                  setState(() {
                                                                    Navigator.pop(context);
                                                                    DeleteAlert(context,index);
                                                                  });

                                                                  // setState(() {
                                                                  //   Navigator.pop(context);
                                                                  //   dailyWrkDone_DPR_Controller.DeleteAlert(context, index);
                                                                  // });

                                                                }),
                                                          ),
                                                          SizedBox(height: 20)
                                                        ],
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

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                       Navigator.of(context).pop();
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            dailyWrkDone_DPRNEW_Controller. entrycheck=0;
                            dailyWrkDone_DPRNEW_Controller. editcheck=0;
                            dailyWrkDone_DPRNEW_Controller. dprNew_EntryDetReadList.clear();
                            dailyWrkDone_DPRNEW_Controller. dprNew_LabourReadList.clear();
                            dailyWrkDone_DPRNEW_Controller. totalNetAmnt=0.0;
                            dailyWrkDone_DPRNEW_Controller. dprNewGetMatreadListdata.value.clear();
                            dailyWrkDone_DPRNEW_Controller. dprNewGetMSRreadListdata.value.clear();
                            dailyWrkDone_DPRNEW_Controller.DprNew_EntryList_DeleteApi(dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workId, dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workNo);
                            dailyWrkDone_DPRNEW_Controller.  dpr_New_entryList.value.removeAt(index);
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () async{
          //     setState(() {
          //       dailyWrkDone_DPRNEW_Controller. entrycheck=0;
          //       dailyWrkDone_DPRNEW_Controller. editcheck=0;
          //       dailyWrkDone_DPRNEW_Controller. dprNew_EntryDetReadList.clear();
          //       dailyWrkDone_DPRNEW_Controller. dprNew_LabourReadList.clear();
          //       dailyWrkDone_DPRNEW_Controller. totalNetAmnt=0.0;
          //       dailyWrkDone_DPRNEW_Controller. dprNewGetMatreadListdata.value.clear();
          //       dailyWrkDone_DPRNEW_Controller. dprNewGetMSRreadListdata.value.clear();
          //        dailyWrkDone_DPRNEW_Controller.DprNew_EntryList_DeleteApi(dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workId, dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.value[index].workNo);
          //       dailyWrkDone_DPRNEW_Controller.  dpr_New_entryList.value.removeAt(index);
          //       Navigator.of(context).pop();
          //     });
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }
}
