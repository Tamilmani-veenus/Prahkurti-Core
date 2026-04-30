import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/comman_controller.dart';
import '../../../../../controller/mrn_request_indent_controller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/punch_in_controller.dart';
import '../../../../sample.dart';
import 'mrnrequest_entry.dart';

class MRN_RequestIndent_Entrylist extends StatefulWidget {
  const MRN_RequestIndent_Entrylist({Key? key}) : super(key: key);

  @override
  State<MRN_RequestIndent_Entrylist> createState() =>
      _MRN_RequestIndent_EntrylistState();
}

class _MRN_RequestIndent_EntrylistState
    extends State<MRN_RequestIndent_Entrylist> {
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());
  CommanController commanController = Get.put(CommanController());
  TextEditingController editingController = TextEditingController();
  PunchInController punchInController = Get.put(PunchInController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    setState(() {
      mrn_request_controller.mainEtyList.value.clear();
      mrn_request_controller.MrnReqEtyList.value.clear();
    });
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth =
        new DateTime(currentDate.year, currentDate.month - 1, 0);
    mrn_request_controller.MrnEntrylistFrDate.text =
        lastDayOfMonth.toString().substring(0, 10);
    mrn_request_controller.MrnEntrylistToDate.text =
        currentDate.toString().substring(0, 10);
    mrn_request_controller.getMrn_Req_EntryList();
    mrn_request_controller.MrnReqEtyList.value =
        mrn_request_controller.mainEtyList.value;
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
                  mrn_request_controller.saveButton.value = RequestConstant.SUBMIT;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MRNRequest_Indent_Entry()));

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
                      Text(
                        "MRN Request (Indent)",
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
                              controller:
                                  mrn_request_controller.MrnEntrylistFrDate,
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
                                mrn_request_controller.MrnEntrylistFrDate.text =
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
                                  mrn_request_controller.MrnEntrylistToDate,
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
                                mrn_request_controller.MrnEntrylistToDate.text =
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
                                mrn_request_controller.getMrn_Req_EntryList();
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
                                mrn_request_controller.MrnReqEtyList.value =
                                    BaseUtitiles
                                        .filterSearchResults_MRNRequestIndent(
                                            value,
                                            mrn_request_controller.mainEtyList);
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
                      padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                      itemCount:
                          mrn_request_controller.MrnReqEtyList.value.length,
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
                                                  mrn_request_controller
                                                      .MrnReqEtyList
                                                      .value[index]
                                                      .reqOrdDate
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
                                          mrn_request_controller.MrnReqEtyList
                                              .value[index].reqOrdNo.trim()
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
                                          flex: 2,
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
                                            mrn_request_controller.MrnReqEtyList
                                                .value[index].project
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
                                          flex: 2,
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
                                            mrn_request_controller.MrnReqEtyList
                                                .value[index].sitename
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
                                          flex: 2,
                                          child: Text(
                                            "Due Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            mrn_request_controller.MrnReqEtyList
                                                .value[index].reqDueDate
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
                                          flex: 2,
                                          child: Text(
                                            "Req Type",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            mrn_request_controller.MrnReqEtyList
                                                .value[index].purchaseType=="PO "?"General Items":"Asset Materials",
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
                                            "Prepared By :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            mrn_request_controller.MrnReqEtyList
                                                .value[index].Preparedby
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 1,
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
                                                      return Container(
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
                                                                      mrn_request_controller.MrnReqEtyList.value[index]
                                                                          .reqOrdNo
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
                                                                    mrn_request_controller
                                                                        .delete_MaterialIntent_itemlist_Table();
                                                                    mrn_request_controller
                                                                            .Material_itemview_GetDbList
                                                                        .clear();
                                                                    mrn_request_controller
                                                                        .getRequestDetList
                                                                        .clear();
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    await mrn_request_controller.MaterialIntentList_EditApi(
                                                                        mrn_request_controller
                                                                            .MrnReqEtyList[
                                                                                index]
                                                                            .reqMasId,
                                                                        mrn_request_controller
                                                                            .MrnReqEtyList[
                                                                                index]
                                                                            .projectid,
                                                                        mrn_request_controller
                                                                            .MrnReqEtyList[index]
                                                                            .siteid,
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
                                                                    mrn_request_controller
                                                                        .DeleteAlert(
                                                                            context,
                                                                            index);
                                                                  }),
                                                            ),
                                                            SizedBox(height: 20)
                                                          ],
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
