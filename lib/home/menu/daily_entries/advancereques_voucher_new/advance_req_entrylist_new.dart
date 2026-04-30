import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_new_controller.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'advance_req_entry_new.dart';

class AdvReq_Voucher_EntryList_new extends StatefulWidget {
  const AdvReq_Voucher_EntryList_new({Key? key}) : super(key: key);

  @override

  State<AdvReq_Voucher_EntryList_new> createState() => _AdvReq_Voucher_EntryList_newState();
}

class _AdvReq_Voucher_EntryList_newState extends State<AdvReq_Voucher_EntryList_new> {

  TextEditingController editingController = TextEditingController();
  AdvanceReqVoucherController_new advanceReqVoucherController_new =Get.put(AdvanceReqVoucherController_new());
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    advanceReqVoucherController_new.entrycheck=0;
    advanceReqVoucherController_new.editcheck=0;
      advanceReqVoucherController_new.mainlist.value.clear();
      advanceReqVoucherController_new.entryList.value.clear();
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    advanceReqVoucherController_new.entrlistFdateController.text = lastDayOfMonth.toString().substring(0, 10);
    advanceReqVoucherController_new.entrlistTdateController.text = currentDate.toString().substring(0, 10);
    advanceReqVoucherController_new.getEntryList();
    advanceReqVoucherController_new.entryList.value =advanceReqVoucherController_new.mainlist.value;
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: Obx(()=> Visibility(
          visible: commanController.addMode.value == 1 ? true : false,
          child: FloatingActionButton.extended(
            onPressed: (){
              advanceReqVoucherController_new.entrycheck =0;
              advanceReqVoucherController_new.editcheck =0;
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdvReq_voucher_New()));
            },
            label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
            icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Advance Requisition Voucher",
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
                            controller: advanceReqVoucherController_new.entrlistFdateController,
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
                                          onSurface: Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black, // ✅ updated from `primary`
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (Frdate != null) {
                                  advanceReqVoucherController_new.entrlistFdateController.text =
                                      Frdate.toString().substring(0, 10);
                                }
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
                            controller: advanceReqVoucherController_new.entrlistTdateController,
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
                              advanceReqVoucherController_new.entrlistTdateController.text =
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
                              advanceReqVoucherController_new.getEntryList();
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
                              // dailyWrkDone_DPR_Controller.searchentryList.value= BaseUtitiles.filterSearchResults_dprlist(value,dailyWrkDone_DPR_Controller.dpr_entryList);
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
      // margin: EdgeInsets.only(bottom: 20),
      height: BaseUtitiles.getheightofPercentage(context, 65),
      child: Obx(
            () => ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            itemCount: advanceReqVoucherController_new.entryList.value.length,
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
                                          margin: EdgeInsets.only(left: 5, right: 3),
                                          child: ConstIcons.list_date),
                                      Text(
                                        advanceReqVoucherController_new
                                            .entryList.value[index].vocDate
                                            .toString(),
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
                                advanceReqVoucherController_new.entryList.value[index].vocNo.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
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
                                  advanceReqVoucherController_new
                                      .entryList.value[index].project
                                      .toString(),
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
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Text(""),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "A/c Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,),
                                )),
                            Expanded(
                                flex: 8,
                                child: Text(
                                  advanceReqVoucherController_new
                                      .entryList.value[index].accName
                                      .toString(),
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
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Text(""),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "Voc Amt",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,),
                                )),
                            Expanded(
                                flex: 8,
                                child: Text(
                                  advanceReqVoucherController_new
                                      .entryList.value[index].vocAmt
                                      .toString(),
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
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Text(""),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "PayFor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,),
                                )),
                            Expanded(
                                flex: 8,
                                child: Text(
                                  advanceReqVoucherController_new.entryList.value[index].payFor.toString(),
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
                              margin: EdgeInsets.only(left: 10),
                              child: Text(""),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Status ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  advanceReqVoucherController_new.entryList.value[index].status.toString(),
                                  style: TextStyle(color: advanceReqVoucherController_new.entryList.value[index].status == "APPROVED"?Colors.green:Colors.black),
                                )),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: () {
                                      if(advanceReqVoucherController_new.entryList.value[index].status == "APPROVED"){
                                        Fluttertoast.showToast(msg: "Approved list can't be edit and delete");
                                      }
                                      else{
                                        showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              // <-- SEE HERE
                                              borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(25.0)),
                                            ),
                                            builder: (context) {
                                              return Container(
                                                margin: EdgeInsets.only(left: 15,),
                                                height: BaseUtitiles.getheightofPercentage(context, 25),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10),
                                                          child: Text(
                                                            advanceReqVoucherController_new.entryList.value[index].project.toString(),
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon:  ConstIcons.cancle,)
                                                      ],
                                                    ),
                                                    Visibility(
                                                      visible: commanController.editMode.value == 1 ? true : false,
                                                      child: InkWell(
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
                                                              advanceReqVoucherController_new.editcheck=1;
                                                              advanceReqVoucherController_new.editListApiDatas.value.clear();
                                                              advanceReqVoucherController_new.delete_ListTable();
                                                              advanceReqVoucherController_new.GetTableList.value.clear();
                                                              advanceReqVoucherController_new.getDetList_Advance.clear();
                                                              advanceReqVoucherController_new.itemlistTable_Delete();
                                                              advanceReqVoucherController_new.ItemGetTableListdata.clear();
                                                              advanceReqVoucherController_new.getDetList_NMR.clear();
                                                              FocusScope.of(context).unfocus();
                                                             await advanceReqVoucherController_new.EntryList_EditApi(
                                                                  advanceReqVoucherController_new.entryList.value[index].vocId,
                                                                  advanceReqVoucherController_new.entryList.value[index].acctypeid,
                                                                  advanceReqVoucherController_new.entryList.value[index].accnameid,
                                                                  advanceReqVoucherController_new.entryList.value[index].projectId,
                                                                  context);
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
                                                          onTap: () async {
                                                            Navigator.pop(context);
                                                            advanceReqVoucherController_new.DeleteAlert(context, index);
                                                          }),
                                                    ),
                                                    SizedBox(height: 20,)
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
    );
  }
}
