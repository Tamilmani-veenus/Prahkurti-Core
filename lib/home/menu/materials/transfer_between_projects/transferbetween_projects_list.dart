import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'transferbetween_projects_entry.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/pendinglistcontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class TransferBtweenProjects_Entrylist extends StatefulWidget {
  const TransferBtweenProjects_Entrylist({Key? key}) : super(key: key);

  @override
  State<TransferBtweenProjects_Entrylist> createState() =>
      _TransferBtweenProjects_EntrylistState();
}

class _TransferBtweenProjects_EntrylistState extends State<TransferBtweenProjects_Entrylist> {
  TextEditingController editingController = TextEditingController();
  TransferBW_project_Controller transferBW_project_Controller = Get.put(TransferBW_project_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    transferBW_project_Controller.mainEntrylist.value.clear();
    transferBW_project_Controller.TRPEtyList.value.clear();

    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month - 1, 0);
    transferBW_project_Controller.TRPEntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    transferBW_project_Controller.TRPEntrylistToDate.text = currentDate.toString().substring(0, 10);
    transferBW_project_Controller.getTransproject_EntryList();
    transferBW_project_Controller.TRPEtyList.value = transferBW_project_Controller.mainEntrylist.value;
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
                  onPressed: () {
                    transferBW_project_Controller.saveButton.value = RequestConstant.SUBMIT;
                    transferBW_project_Controller.type.value ="Direct";
                    transferBW_project_Controller.clearDatas();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TrasferBetweenProjects_Entry()));
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
                            "Transfer Between Projects",
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
                                  controller: transferBW_project_Controller
                                      .TRPEntrylistFrDate,
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
                                    transferBW_project_Controller.TRPEntrylistFrDate
                                        .text = Frdate.toString().substring(0, 10);
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
                                  controller: transferBW_project_Controller
                                      .TRPEntrylistToDate,
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
                                    transferBW_project_Controller.TRPEntrylistToDate
                                        .text = Todate.toString().substring(0, 10);
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
                                    transferBW_project_Controller
                                        .getTransproject_EntryList();
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
                      padding: EdgeInsets.zero,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
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
                                    transferBW_project_Controller.TRPEtyList.value =
                                        BaseUtitiles
                                            .filterSearchResults_TransferBtwnProjects(
                                            value,
                                            transferBW_project_Controller
                                                .mainEntrylist);
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
                ))),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      height: MediaQuery.of(context).size.height * 69/100,
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 68/100,
              child: Obx(
                    () => ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                    itemCount: transferBW_project_Controller.TRPEtyList.value.length,
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
                                                      left: 5, right: 5),
                                                  child: ConstIcons.list_date),
                                              Text(
                                                transferBW_project_Controller
                                                    .TRPEtyList
                                                    .value[index]
                                                    .entryDate
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
                                        transferBW_project_Controller
                                            .TRPEtyList.value[index].transferNo
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 8, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "From Project",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller
                                              .TRPEtyList.value[index].frProjectName
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
                                          "To Project",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller
                                              .TRPEtyList.value[index].toProjectName
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
                                          "From Site",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller
                                              .TRPEtyList.value[index].frSiteName
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
                                          "DC No",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller.TRPEtyList.value[index].dcNo.toString(),
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
                                          "Vehicle No",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller.TRPEtyList.value[index].vehicleName.toString(),
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
                                          "Trans Type",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          transferBW_project_Controller.TRPEtyList.value[index].entryName.toString(),
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
                                          "Prepared By ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          transferBW_project_Controller
                                              .TRPEtyList.value[index].createdName
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () async{
                                              if(await transferBW_project_Controller.
                                              TransferStatusCheckApi(transferBW_project_Controller.TRPEtyList.value[index].transferId)) {
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape: RoundedRectangleBorder(
                                                      // <-- SEE HERE
                                                      borderRadius:
                                                      BorderRadius.vertical(
                                                          top:
                                                          Radius.circular(
                                                              25.0)),
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
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      10),
                                                                  child: Text(
                                                                    transferBW_project_Controller
                                                                        .TRPEtyList
                                                                        .value[
                                                                    index]
                                                                        .transferNo
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .primaryColor),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .pop(
                                                                          context);
                                                                    },
                                                                    icon: ConstIcons
                                                                        .cancle)
                                                              ],
                                                            ),
                                                            Visibility(
                                                              visible: commanController
                                                                  .editMode
                                                                  .value ==
                                                                  1
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
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                          child:
                                                                          Icon(
                                                                            Icons
                                                                                .edit,
                                                                            color:
                                                                            Colors
                                                                                .white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                          5),
                                                                      Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                            15),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    transferBW_project_Controller
                                                                        .itemlistTable_Delete();
                                                                    transferBW_project_Controller
                                                                        .ItemGetTableListdata
                                                                        .clear();
                                                                    transferBW_project_Controller
                                                                        .getTransfferbetDetList
                                                                        .clear();
                                                                    transferBW_project_Controller
                                                                        .editListApiDatas
                                                                        .value
                                                                        .clear();

                                                                    FocusScope
                                                                        .of(
                                                                        context)
                                                                        .unfocus();
                                                                    await transferBW_project_Controller
                                                                        .EntryList_EditApi(
                                                                        transferBW_project_Controller
                                                                            .TRPEtyList
                                                                            .value[
                                                                        index]
                                                                            .transferId,
                                                                        context);
                                                                  }),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    20),
                                                                child: Divider(
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
                                                                  child: Row(
                                                                    children: [
                                                                      Card(
                                                                        color: Colors
                                                                            .red,
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                          child:
                                                                          Icon(
                                                                            Icons
                                                                                .delete_forever,
                                                                            color:
                                                                            Colors
                                                                                .white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                          5),
                                                                      Text(
                                                                        "Delete",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                            15),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    Navigator
                                                                        .pop(
                                                                        context);
                                                                    setState(() {
                                                                      transferBW_project_Controller
                                                                          .DeleteAlert(
                                                                          context,
                                                                          index);
                                                                    });
                                                                  }),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }},
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
    );
  }

}
