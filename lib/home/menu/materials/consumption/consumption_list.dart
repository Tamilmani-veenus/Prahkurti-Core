import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/consumption_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'consumption_entryscreen.dart';

class Consumption_List extends StatefulWidget {
  const Consumption_List({Key? key}) : super(key: key);

  @override
  State<Consumption_List> createState() => _Consumption_ListState();
}

class _Consumption_ListState extends State<Consumption_List> {
  TextEditingController editingController = TextEditingController();
  Consumption_Controller consumption_controller =
      Get.put(Consumption_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    consumption_controller.mainEtyList.value.clear();
    consumption_controller.ConsumEtyList.value.clear();
    consumption_controller.ConsumEtyList.clear();
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth =
        new DateTime(currentDate.year, currentDate.month - 1, 0);
    consumption_controller.ConsumEntrylistFrDate.text =
        lastDayOfMonth.toString().substring(0, 10);
    consumption_controller.ConsumEntrylistToDate.text =
        currentDate.toString().substring(0, 10);
    consumption_controller.getConsum_EntryList();
    consumption_controller.ConsumEtyList.value =
        consumption_controller.mainEtyList.value;
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
                      consumption_controller.saveButton.value =
                          RequestConstant.SUBMIT;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consumption_Entry()));
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
                          "Consumption",
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
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
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 38),
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
                                controller: consumption_controller
                                    .ConsumEntrylistFrDate,
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
                                  consumption_controller.ConsumEtyList.clear();
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
                                              onPrimary: Colors
                                                  .white, // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      });
                                  consumption_controller
                                          .ConsumEntrylistFrDate.text =
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
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 38),
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
                                controller: consumption_controller
                                    .ConsumEntrylistToDate,
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
                                  consumption_controller.ConsumEtyList.clear();
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
                                              onPrimary: Colors
                                                  .white, // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      });
                                  consumption_controller
                                          .ConsumEntrylistToDate.text =
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
                              onPressed: () {
                                setState(() {
                                  consumption_controller.getConsum_EntryList();
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
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 10, left: 15),
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
                                  consumption_controller.ConsumEtyList.value =
                                      BaseUtitiles
                                          .filterSearchResults_Consumption(
                                              value,
                                              consumption_controller
                                                  .mainEtyList);
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
        ));
  }

  Widget ListDetails() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 70),
      child: Column(
        children: [
          Container(
            height: BaseUtitiles.getheightofPercentage(context, 69),
            child: Obx(
              () => ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: consumption_controller.ConsumEtyList.value.length,
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
                                        width:
                                            BaseUtitiles.getWidthtofPercentage(
                                                context, 50),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: ConstIcons.list_date),
                                            Text(
                                              consumption_controller
                                                  .ConsumEtyList
                                                  .value[index]
                                                  .entryDt
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                                      consumption_controller
                                          .ConsumEtyList.value[index].expenseNo
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
                                    margin: EdgeInsets.only(top: 8, left: 10),
                                    child: Text(""),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Entry Type",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        consumption_controller.ConsumEtyList
                                            .value[index].expenseName
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
                                        "Project Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        consumption_controller.ConsumEtyList
                                            .value[index].projectName
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
                                        "Site Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        consumption_controller
                                            .ConsumEtyList.value[index].siteName
                                            .toString(),
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
                                        "PreparedBy",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        consumption_controller.ConsumEtyList
                                            .value[index].createdName
                                            .toString(),
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
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
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
                                                                consumption_controller
                                                                    .ConsumEtyList
                                                                    .value[
                                                                        index]
                                                                    .expenseNo
                                                                    .toString(),
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
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
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
                                                              onTap: () {
                                                                consumption_controller
                                                                        .saveButton
                                                                        .value =
                                                                    RequestConstant
                                                                        .RESUBMIT;
                                                                consumption_controller
                                                                    .delete_Consum_itemlist_Table();
                                                                consumption_controller
                                                                        .Consum_itemview_GetDbList
                                                                    .clear();
                                                                consumption_controller
                                                                    .getusageDetList
                                                                    .clear();
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                                consumption_controller.ConsumEntryList_EditApi(
                                                                    consumption_controller
                                                                        .ConsumEtyList
                                                                        .value[
                                                                            index]
                                                                        .id,
                                                                    context);
                                                              }),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Divider(
                                                                thickness: 1)),
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
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
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
                                                              onTap: () async {
                                                                Navigator.pop(
                                                                    context);
                                                                await DeleteAlert(
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
                                            color:
                                                Theme.of(context).primaryColor,
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

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await consumption_controller.Consum_EntryList_DeleteApi(consumption_controller.ConsumEtyList.value[index].id);
                          if (result) {
                            await consumption_controller
                                .delete_Consum_itemlist_Table();
                            consumption_controller
                                .Consum_itemview_GetDbList.value
                                .clear();
                            consumption_controller.ConsumEtyList.removeAt(
                                index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
