import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../home/menu/accounts/staff_voucher/staff_voucher_entry.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controller/staffvoucher_controller.dart';
import '../../../../utilities/baseutitiles.dart';

class Staff_Voucher_EntryListScreen extends StatefulWidget {
  const Staff_Voucher_EntryListScreen({Key? key}) : super(key: key);

  @override
  State<Staff_Voucher_EntryListScreen> createState() =>
      _Staff_Voucher_EntryListScreenState();
}

class _Staff_Voucher_EntryListScreenState
    extends State<Staff_Voucher_EntryListScreen> {
  TextEditingController editingController = TextEditingController();
  StaffVoucher_Controller staffVoucher_Controller = Get.put(StaffVoucher_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    staffVoucher_Controller.StaffVocEtyList.clear();
    // staffVoucher_Controller.mainentrylist.value.clear();
    // staffVoucher_Controller.StaffVocEtyList.value.clear();

    if (staffVoucher_Controller.Active == 1) {
      staffVoucher_Controller.Active = 0;
    } else {
      staffVoucher_Controller.Active = 2;
    }

    staffVoucher_Controller.editcheck = 0;
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    staffVoucher_Controller.StaffVocEntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    staffVoucher_Controller.StaffVocEntrylistToDate.text = currentDate.toString().substring(0, 10);
    staffVoucher_Controller.getStaffVoc_EntryList();
    staffVoucher_Controller.StaffVocEtyList.value = staffVoucher_Controller.mainentrylist.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton:
        Obx(()=> Visibility(
          visible: commanController.addMode.value == 1 ? true : false,
          child: FloatingActionButton.extended(
            onPressed: () {
              staffVoucher_Controller.editcheck = 0;
              staffVoucher_Controller.itemcheck = 0;
              staffVoucher_Controller.Active = 0;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Staff_Voucher_EntryScreen()));
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
        ), ),
      
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
                      "Staff Voucher",
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
                                staffVoucher_Controller.StaffVocEntrylistFrDate,
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
                                  child: Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor)),
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
                              staffVoucher_Controller.StaffVocEntrylistFrDate
                                  .text = Frdate.toString().substring(0, 10);
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
                                staffVoucher_Controller.StaffVocEntrylistToDate,
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
                              staffVoucher_Controller.StaffVocEntrylistToDate
                                  .text = Todate.toString().substring(0, 10);
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
                            await  staffVoucher_Controller.getStaffVoc_EntryList();
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
                              staffVoucher_Controller.StaffVocEtyList.value = BaseUtitiles.filterSearchResultsStaffVouchers(value, staffVoucher_Controller.mainentrylist);
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
            child:
            Obx(
              () => ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount:
                      staffVoucher_Controller.StaffVocEtyList.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 3, right: 3),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 50),
                                      child: Text(
                                        staffVoucher_Controller
                                            .StaffVocEtyList.value[index].staff
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    staffVoucher_Controller
                                        .StaffVocEtyList.value[index].vocNo
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                      "Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(
                                      staffVoucher_Controller
                                          .StaffVocEtyList.value[index].vocDate
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
                                  child: Text(""),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "A/C Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(
                                      staffVoucher_Controller
                                          .StaffVocEtyList.value[index].accName
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
                                  child: Text(""),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "A/C Type",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(
                                      staffVoucher_Controller
                                          .StaffVocEtyList.value[index].accType
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
                                      "Voc Amt",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      staffVoucher_Controller
                                          .StaffVocEtyList.value[index].vocAmt
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
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Text(
                                                              staffVoucher_Controller
                                                                  .StaffVocEtyList
                                                                  .value[index]
                                                                  .vocNo
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
                                                            onTap: () async {
                                                              staffVoucher_Controller
                                                                  .delete_Sitevoucher_itemlist_Table();
                                                              staffVoucher_Controller
                                                                  .getSiteDetList
                                                                  .value
                                                                  .clear();
                                                              staffVoucher_Controller
                                                                  .Sitevoucher_EditListApiValue
                                                                  .value
                                                                  .clear();
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              await staffVoucher_Controller
                                                                  .StaffvoucherEntryList_EditApi(
                                                                      staffVoucher_Controller
                                                                          .StaffVocEtyList
                                                                          .value[
                                                                              index]
                                                                          .vocId,
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
                                                        visible: commanController.deleteMode.value == 1 ? true : false,
                                                        child: InkWell(
                                                            child: Row(
                                                              children: [
                                                                Card(
                                                                  color:
                                                                      Colors.red,
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
                                                              staffVoucher_Controller
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
                                          Icons.arrow_drop_down_circle_outlined,
                                          color: Theme.of(context).primaryColor,
                                        )))
                              ],
                            ),
                          ],
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
