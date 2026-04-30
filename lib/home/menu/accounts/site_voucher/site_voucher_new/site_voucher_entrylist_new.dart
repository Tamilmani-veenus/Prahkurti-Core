import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/home/menu/accounts/site_voucher/site_voucher_new/site_voucher_entry_new.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/comman_controller.dart';
import '../../../../../controller/sitevoucher_controller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';

class SiteVoucher_EntryListNew extends StatefulWidget {
  const SiteVoucher_EntryListNew({Key? key}) : super(key: key);

  @override
  State<SiteVoucher_EntryListNew> createState() => _SiteVoucher_EntryListNewState();
}

class _SiteVoucher_EntryListNewState extends State<SiteVoucher_EntryListNew> {

  TextEditingController editingController = TextEditingController();
  SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
  CommanController commanController = Get.put(CommanController());


  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month - 1, 0);
    siteVoucher_Controller.SiteVocEntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    siteVoucher_Controller.SiteVocEntrylistToDate.text = currentDate.toString().substring(0, 10);
    siteVoucher_Controller.getSiteVoc_EntryList();
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SiteVoucher_EntryScreen()));
            },
            label: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: RequestConstant.Lable_Font_SIZE,
              ),
            ),
            icon: const Icon(
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
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Site Voucher",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: siteVoucher_Controller.SiteVocEntrylistFrDate,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "From Date",
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            onTap: () async {
                              siteVoucher_Controller.SiteVocEtyList.clear();
                              var frDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                      ),
                                    ),
                                      child: child!,
                                    );
                                  }

                              );
                              siteVoucher_Controller.SiteVocEntrylistFrDate.text = frDate.toString().substring(0, 10);
                              // siteVoucher_Controller.getSiteVoc_EntryList();
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
                    SizedBox(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                            siteVoucher_Controller.SiteVocEntrylistToDate,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "ToDate",
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            onTap: () async {
                              siteVoucher_Controller.SiteVocEtyList.clear();
                              var toDate = await showDatePicker(
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
                              siteVoucher_Controller.SiteVocEntrylistToDate.text = toDate.toString().substring(0, 10);
                              // siteVoucher_Controller.getSiteVoc_EntryList();
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () async {
                          await siteVoucher_Controller.getSiteVoc_EntryList();
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 80),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                            siteVoucher_Controller.SiteVocEtyList.value = BaseUtitiles.filterSearchResultsStaffVouchers(value, siteVoucher_Controller.SiteVocEtyList);
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
            child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: siteVoucher_Controller.SiteVocEtyList.value.length,
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
                                      width: BaseUtitiles.getWidthtofPercentage(context, 50),
                                      child: Text(
                                        siteVoucher_Controller.SiteVocEtyList.value[index].projectName
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
                                    siteVoucher_Controller.SiteVocEtyList.value[index].siteVoucherNo
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
                                      siteVoucher_Controller.SiteVocEtyList.value[index].siteVoucherDate,
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
                                      siteVoucher_Controller.SiteVocEtyList.value[index].accountName.toString(),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 10),
                                  child: const Text(""),
                                ),
                                const Expanded(
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
                                      siteVoucher_Controller.SiteVocEtyList.value[index].accountTypeName.toString(),
                                      style: const TextStyle(
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
                                      "Status",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    siteVoucher_Controller.SiteVocEtyList.value[index].status,
                                    style:  TextStyle(color:Colors.black),
                                  ),
                                ),
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
                                      "Voc Amt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    siteVoucher_Controller.SiteVocEtyList.value[index].siteVoucherAmount.toString(),
                                    style:  TextStyle(color:Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(""),
                                ),
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Prepared By",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      siteVoucher_Controller.SiteVocEtyList.value[index].createdName.toString(),
                                      style: TextStyle(color: Colors.black),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          if(siteVoucher_Controller.SiteVocEtyList.value[index].status=="Approved"){
                                         BaseUtitiles.showToast("Approved record cannot be edited or deleted");
                                         }
                                         else {
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(
                                                        25.0)),),
                                              builder: (context) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: 15,),
                                                  height: BaseUtitiles
                                                      .getheightofPercentage(
                                                      context, 25),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                right: 10),
                                                            child: Text(
                                                              siteVoucher_Controller
                                                                  .SiteVocEtyList
                                                                  .value[index]
                                                                  .siteVoucherNo
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Theme
                                                                      .of(
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
                                                                  .cancle
                                                          ),
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: commanController
                                                            .editMode.value == 1
                                                            ? true
                                                            : false,
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
                                                            onTap: () async {
                                                              siteVoucher_Controller
                                                                  .Sitevoucher_itemview_GetDbList
                                                                  .value
                                                                  .clear();
                                                              FocusScope.of(
                                                                  context)
                                                                  .unfocus();
                                                              siteVoucher_Controller
                                                                  .Sitevoucher_EditListApiValue
                                                                  .clear();
                                                              siteVoucher_Controller
                                                                  .getSiteDetList
                                                                  .value
                                                                  .clear();
                                                              await siteVoucher_Controller
                                                                  .ConsumEntryList_EditApi(
                                                                  siteVoucher_Controller
                                                                        .SiteVocEtyList
                                                                      .value[index]
                                                                      .id,
                                                                  context);
                                                            }),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .only(right: 20),
                                                          child: Divider(
                                                              thickness: 1)),
                                                      Visibility(
                                                        visible: commanController
                                                            .deleteMode.value ==
                                                            1 ? true : false,
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
                                                              siteVoucher_Controller
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
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
