import 'package:prahkurticore/home/menu/daily_entries/subcontractor_attendance_VCPL/subattendance_site_entry.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SubAttendanceSiteEntryList extends StatefulWidget {
  const SubAttendanceSiteEntryList({Key? key}) : super(key: key);

  @override
  State<SubAttendanceSiteEntryList> createState() =>
      _SubAttendanceSiteEntryListState();
}

class _SubAttendanceSiteEntryListState
    extends State<SubAttendanceSiteEntryList> {
  TextEditingController editingController = TextEditingController();
  final DailyEntriesController dailyEntryController = Get.put(DailyEntriesController());
  CommanController commanController = Get.put(CommanController());
  final SiteController siteController = Get.put(SiteController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      setState(() {
        dailyEntryController.Entrylist.value.clear();
        dailyEntryController.AttenEtyList.value.clear();
      });
      dailyEntryController.Entrylist.value.clear();
      dailyEntryController.AttenEtyList.value.clear();
      DateTime currentDate = DateTime.now();
      DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month, 0);
      dailyEntryController.FromdateController.text = lastDayOfMonth.toString().substring(0, 10);
      dailyEntryController.TodateController.text = BaseUtitiles.initiateCurrentDateFormat();
      await dailyEntryController.getAttenEntryList();
      dailyEntryController.Entrylist.value = dailyEntryController.AttenEtyList.value;
    });
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
              setState(() {
                dailyEntryController.readListdata.value=[];
                dailyEntryController.gettingNetworkImages.value = [];
                dailyEntryController.imageFiles.value=[];
                dailyEntryController.deleteSubcontDetTableDatas();
                dailyEntryController.saveButton.value = RequestConstant.SUBMIT;
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubattendanceSiteEntry()));
              });
            },
            label: const Text("Add",
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
        ),),

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
                      "SubContractor Attendance",
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
                            controller: dailyEntryController.FromdateController,
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
                              dailyEntryController.FromdateController.text = Frdate.toString().substring(0, 10);
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
                            controller: dailyEntryController.TodateController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
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
                              dailyEntryController.TodateController.text = Todate.toString().substring(0, 10);
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
                            primary: Theme.of(context).primaryColor),
                        onPressed: () async {
                          setState(() {
                            dailyEntryController.getAttenEntryList();
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 80),
                  decoration:const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                              dailyEntryController.Entrylist.value =
                                  BaseUtitiles.filterSearchResults_SubcontAttend(
                                      value, dailyEntryController.AttenEtyList);
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
    return SizedBox(
      height: BaseUtitiles.getheightofPercentage(context, 69),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: BaseUtitiles.getheightofPercentage(context, 68),
              child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 10)),
                    physics: const BouncingScrollPhysics(),
                    itemCount: dailyEntryController.Entrylist.value.length,
                    itemBuilder: (context, index) {

                      return Container(
                        margin: const EdgeInsets.only(left: 3, right: 3),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(3),
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
                                          margin: const EdgeInsets.only(left: 5),
                                          width: BaseUtitiles.getWidthtofPercentage(context, 50),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.only(left: 5, right: 3),
                                                  child: ConstIcons.list_date),
                                              Text(
                                                dailyEntryController.Entrylist.value[index].labourAttendanceDate.toString(),
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
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        dailyEntryController.Entrylist.value[index].labourAttendanceNo.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 5, left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Project ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          dailyEntryController.Entrylist.value[index].projectName.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Site ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          dailyEntryController.Entrylist.value[index].siteName.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "SubCont ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          dailyEntryController.Entrylist.value[index].subContractorName.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10),
                                      child: const Text(""),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Labours",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          "${dailyEntryController.Entrylist.value[index].totNos} Nos" ,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                // const SizedBox(height: 5),
                                // Row(
                                //   children: [
                                //     Container(
                                //       margin: const EdgeInsets.only(left: 10),
                                //       child: const Text(""),
                                //     ),
                                //     Expanded(
                                //         flex: 3,
                                //         child: Text(
                                //           "Shift Type",
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //             color: Colors.black,
                                //           ),
                                //         )),
                                //     Expanded(
                                //         flex: 8,
                                //         child: Text(
                                //           dailyEntryController
                                //               .Entrylist.value[index].workshift
                                //               .toString(),
                                //           style: const TextStyle(
                                //             color: Colors.black,
                                //           ),
                                //         )),
                                //   ],
                                // ),

                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
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
                                          dailyEntryController.Entrylist.value[index].approveStatus.toString() == "Y" ? "Approved" : "Unapproved" ,
                                          style: TextStyle(
                                            color: dailyEntryController.Entrylist.value[index].approveStatus.toString() == "Y" ? Colors.green :  Colors.black,
                                          ),
                                        )),
                                  ],
                                ),

                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Work Type",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          // dailyEntryController.Entrylist.value[index].workType.toString() == 'NMR'
                                          //     ? 'Claimable NMR'
                                          //     : dailyEntryController.Entrylist.value[index].workType.toString() == 'NO-WORK'
                                          //     ? 'No Work'
                                          //     : dailyEntryController.Entrylist.value[index].workType.toString()=='RATE'?'Daily attendance':
                                          dailyEntryController.Entrylist.value[index].workTypeName.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Amount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "₹ ${dailyEntryController
                                              .Entrylist.value[index].totAmt}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),

                                const Divider(thickness: 1),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Text(""),
                                    ),
                                    // Expanded(
                                    //     flex: 3,
                                    //     child: Text(
                                    //       "Subcontractor",
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.black),
                                    //     )),
                                    // Expanded(
                                    //     flex: 6,
                                    //     child: Text(
                                    //       dailyEntryController
                                    //           .Entrylist.value[index].subconName
                                    //           .toString(),
                                    //       style: TextStyle(color: Colors.black),
                                    //     )),
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Prepared By :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                          dailyEntryController
                                              .Entrylist.value[index].employeeName
                                              .toString(),
                                          // +  " | " +
                                          // dailyEntryController.Entrylist
                                          //     .value[index].workshift
                                          //     .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),

                                    Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () {
                                              DLRId = dailyEntryController.Entrylist[index].id;

                                              if( dailyEntryController.Entrylist.value[index].approveStatus.toString() == "Y"){
                                                BaseUtitiles.showToast("Approved records cannot be edited or deleted");
                                              }else{
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape: const RoundedRectangleBorder(
                                                      // <-- SEE HERE
                                                      borderRadius:
                                                      BorderRadius.vertical(
                                                          top:
                                                          Radius.circular(
                                                              25.0)),
                                                    ),
                                                    builder: (context) {
                                                      return Container(
                                                        margin: const EdgeInsets.only(
                                                          left: 15,
                                                        ),
                                                        height: BaseUtitiles
                                                            .getheightofPercentage(
                                                            context, 25),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets.only(right: 10),
                                                                  child: Text(
                                                                    dailyEntryController.Entrylist.value[index].labourAttendanceNo.toString(),
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
                                                                      Navigator.pop(context);
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
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.all(
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
                                                                  onTap: () async {
                                                                    dailyEntryController.deleteSubcontDetTableDatas();
                                                                    dailyEntryController.readListdata.value=[];
                                                                    dailyEntryController.getAttendanceDetailsDto.value=[];
                                                                    FocusScope.of(context).unfocus();
                                                                    await dailyEntryController.subContEntryList_EditApi(dailyEntryController.Entrylist.value[index].id, context);
                                                                  }),
                                                            ),
                                                            Container(
                                                                margin: const EdgeInsets.only(right: 20),
                                                                child: const Divider(thickness: 1)),
                                                            Visibility(
                                                              visible: commanController.deleteMode.value == 1 ? true : false,
                                                              child: InkWell(
                                                                  child: const Row(
                                                                    children: [
                                                                      Card(
                                                                        color: Colors
                                                                            .red,
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.all(
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
                                                                    dailyEntryController
                                                                        .DeleteAlert(
                                                                        context,
                                                                        index);
                                                                  }),
                                                            ),
                                                            const SizedBox(height: 20)
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }

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
    );
  }
}
