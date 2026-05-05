import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/punch_in_controller.dart';
import '../../../controller/staffcontroller.dart';
import '../../../utilities/image_view.dart';

class PunchSearchReports extends GetView<PunchInController> {
  PunchSearchReports({super.key});

  final PunchInController punchInController = Get.put(PunchInController());
  final LoginController loginController = Get.put(LoginController());
  final StaffController staffController = Get.put(StaffController());
  final BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    ScreenUtil.init(context);
    return controller.obx(
      (state) => StatefulBuilder(builder: (BuildContext context, setState) {
        return SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Setmybackground,
              body: SizedBox(
                height: ScreenUtil().screenHeight,
                width: ScreenUtil().screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, top: 16.r),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: punchInController.fromDate,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "From Date",
                                    labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    var fromDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        });
                                    if (fromDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(fromDate);
                                      punchInController.fromDate.text =
                                          formattedDate;
                                    } else {
                                      if (kDebugMode) {
                                        print("Date is not selected");
                                      }
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
                          Expanded(
                            flex: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: punchInController.toDate,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "To Date",
                                    labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Icon(Icons.calendar_month,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ),
                                  onTap: () async {
                                    DateTime now = DateTime.now();
                                    DateTime? fromDateParsed;
                                    if (punchInController
                                        .fromDate.text.isNotEmpty) {
                                      fromDateParsed = DateFormat('yyyy-MM-dd')
                                          .parse(
                                              punchInController.fromDate.text);
                                    }
                                    var todate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          fromDateParsed ?? DateTime(2010),
                                      lastDate: now,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.black,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (todate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(todate);
                                      punchInController.toDate.text =
                                          formattedDate;
                                    }
                                  },
                                  // onTap: () async {
                                  //   var todate = await showDatePicker(
                                  //       context: context,
                                  //       initialDate: DateTime.now(),
                                  //       firstDate: DateTime(2010),
                                  //       lastDate: DateTime.now(),
                                  //       builder: (context, child) {
                                  //         return Theme(
                                  //           data: Theme.of(context).copyWith(
                                  //             colorScheme: ColorScheme.light(
                                  //               primary:
                                  //               Theme.of(context).primaryColor,
                                  //               onPrimary: Colors.white,
                                  //               onSurface: Colors.black,
                                  //             ),
                                  //             textButtonTheme: TextButtonThemeData(
                                  //               style: TextButton.styleFrom(
                                  //                 foregroundColor: Colors
                                  //                     .black, // button text color
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           child: child!,
                                  //         );
                                  //       });
                                  //   if (todate != null) {
                                  //     String formattedDate =
                                  //     DateFormat('yyyy-MM-dd').format(todate);
                                  //     punchInController.toDate.text = formattedDate;
                                  //   } else {
                                  //     if (kDebugMode) {
                                  //       print("Date is not selected");
                                  //     }
                                  //   }
                                  // },
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.r),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: staffController.Staffname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Staff Name *",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.siteName,
                              ),
                            ),
                            onTap: () async {
                              if (loginController.user.value.userType == "A") {
                                await staffController
                                    .get_staffDropdowntList(context);
                                bottomsheetControllers.StaffName(
                                    context,
                                    staffController
                                        .getStaffDropdownvalue.value);
                                FocusScope.of(context).unfocus();
                              } else {
                                null;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--SELECT--") {
                                return '\u26A0 Please select staff name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.r, right: 16.r),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            side:
                                const BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await punchInController.todayPunchInController(
                                  "Old Reports",
                                  punchInController.fromDate.text,
                                  todate: punchInController.toDate.text,
                                  empId: staffController.selectedstaffId.value);
                            } else {
                              punchInController.punchFilterRxList.value = [];
                            }
                          },
                          child: const Text("Show"),
                        ),
                      ),
                    ),
                    Expanded(
                      child:
                          Obx(
                              () =>
                                  (punchInController.punchFilterRxList.length !=
                                          0)
                                      ? ListView.builder(
                                          itemCount: punchInController
                                              .punchFilterRxList.length,
                                          itemBuilder: (context, index) {
                                            var listItem = punchInController
                                                .punchFilterRxList[index];

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                elevation: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor, // ✅ correct place
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft: Radius.circular(
                                                              10), // 🔥 increase for more curve
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          (listItem!.staffName !=
                                                                      "" &&
                                                                  listItem!
                                                                          .staffName !=
                                                                      "null")
                                                              ? listItem!
                                                                  .staffName!
                                                              : "-",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: Colors.white,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    ...(listItem.punchDetails !=
                                                                null &&
                                                            listItem
                                                                .punchDetails!
                                                                .isNotEmpty
                                                        ? listItem.punchDetails!
                                                            .map((index) {
                                                            bool isLastItem =
                                                                index ==
                                                                    listItem
                                                                        .punchDetails!
                                                                        .last;
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "${index.punchInDate.toString() != "" && index.punchInDate.toString() != "null" ? index.punchInDate.toString() : "        -   "}",
                                                                              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.all(6),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Icon(
                                                                                    Icons.access_time,
                                                                                    size: 16,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  "In Details:",
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 20),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 70,
                                                                                        child: Text(
                                                                                          "In Time :",
                                                                                          style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            color: Colors.grey,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 120,
                                                                                        child: Text(
                                                                                          index.punchInTime != null && index.punchInTime != "" && index.punchInTime != "null"
                                                                                              ? DateFormat("hh:mm a").format(
                                                                                                  DateFormat("hh:mm:ss a").parse(index.punchInTime!),
                                                                                                )
                                                                                              : "-",
                                                                                          style: const TextStyle(
                                                                                            fontSize: 13,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 20),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 70,
                                                                                        child: Text(
                                                                                          "In Project :  ",
                                                                                          style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            color: Colors.grey,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 120,
                                                                                        child: Text(
                                                                                          '${index.inLocation != "" && index.inLocation != "null" ? index.inLocation! : "-"}',
                                                                                          style: const TextStyle(
                                                                                            fontSize: 13,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            if (!isLastItem)
                                                                              const Divider(),
                                                                          ],
                                                                        ),
                                                                        GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                height * 0.2,
                                                                            width:
                                                                                width * 0.2,
                                                                            child:
                                                                                Image.network(
                                                                              index.inImageUrl!,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => ImageViewPage(
                                                                                          imageUrl: index.inImageUrl!,
                                                                                          netUrl: true,
                                                                                        )));
                                                                          },
                                                                        ),
                                                                      ]),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  Divider(),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                padding: EdgeInsets.all(6),
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Icon(
                                                                                  Icons.access_time,
                                                                                  size: 16,
                                                                                  color: Theme.of(context).primaryColor,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                "Out Details:",
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Theme.of(context).primaryColor,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 20),
                                                                                child: Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 70,
                                                                                      child: Text(
                                                                                        "Out Time :",
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 120,
                                                                                      child: Text(
                                                                                        index.punchOutTime != null && index.punchOutTime != "" && index.punchOutTime != "null"
                                                                                            ? DateFormat("hh:mm a").format(
                                                                                                DateFormat("hh:mm:ss a").parse(index.punchOutTime!),
                                                                                              )
                                                                                            : "-",
                                                                                        style: const TextStyle(
                                                                                          fontSize: 13,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 20),
                                                                                child: Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 70,
                                                                                      child: Text(
                                                                                        "Out Project : ",
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 120,
                                                                                      child: Text(
                                                                                        '${index.outLocation != null && index.outLocation != "" && index.outLocation != "null" ? index.outLocation! : "-"}',
                                                                                        style: const TextStyle(
                                                                                          fontSize: 13,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      index.outImageUrl != null &&
                                                                              index.outImageUrl!.isNotEmpty &&
                                                                              index.outImageUrl != "null"
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => ImageViewPage(
                                                                                      imageUrl: index.outImageUrl!,
                                                                                      netUrl: true,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: height * 0.2,
                                                                                width: width * 0.2,
                                                                                child: Image.network(
                                                                                  index.outImageUrl!,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: height * 0.2,
                                                                              width: width * 0.2,
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList()
                                                        : [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16.0),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "No details found",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : SizedBox()),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
