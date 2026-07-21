import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/man_power_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Subcontractor_Site_Category extends StatefulWidget {
  const Subcontractor_Site_Category({super.key, required this.type});
  final String type;

  @override
  State<Subcontractor_Site_Category> createState() =>
      _Subcontractor_Site_CategoryState();
}

class _Subcontractor_Site_CategoryState
    extends State<Subcontractor_Site_Category> {
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());
  ManPowerController manPowerController = Get.put(ManPowerController());

  @override
  void initState() {
    super.initState();
    if (widget.type == "subcontAttendance") {
      dailyEntriesController
          .nosAndothrsZerovalueset(dailyEntriesController.store_ShowList);
    } else {
      manPowerController
          .nosAndothrsZerovalueset(manPowerController.manpowerCategoryList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      alignment: Alignment.center,
                      child: Text(
                        "Clear",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      if (widget.type == "subcontAttendance") {
                        dailyEntriesController.store_ShowList.value = [];
                      } else {
                        manPowerController.manpowerCategoryList.value = [];
                      }
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Text(
                        "OK",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      if (widget.type == "subcontAttendance") {
                        await dailyEntriesController
                            .saveSubContDetTableDatas(context);
                        await dailyEntriesController.getDetTablesDatas();
                      } else {
                        await manPowerController.saveManPowerDetTableDatas(context);
                        await manPowerController.getDetTablesDatas();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
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
                        "Category",
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
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 85),
                  child: widget.type == "subcontAttendance"
                      ? Obx(
                          () => ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: dailyEntriesController
                                .store_ShowList.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              dailyEntriesController.textControllersInitiate();
                              return Container(
                                  color: const Color.fromRGBO(240, 240, 240, 1),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 1,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: dailyEntriesController
                                                      .store_ShowList
                                                      .value[index]
                                                      .categoryName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          "   ( ${RequestConstant.CURRENCY_SYMBOL}${dailyEntriesController.store_ShowList.value[index].wages} )",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.white70,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3,
                                                          left: 10,
                                                          bottom: 5),
                                                  child: TextFormField(
                                                    onTap: () {
                                                      setState(() {
                                                        if (dailyEntriesController
                                                                    .NosControllers[
                                                                        index]
                                                                    .text !=
                                                                "" &&
                                                            dailyEntriesController
                                                                    .NosControllers[
                                                                        index]
                                                                    .text !=
                                                                "0" &&
                                                            dailyEntriesController
                                                                    .NosControllers[
                                                                        index]
                                                                    .text !=
                                                                "0.0") {
                                                          return;
                                                        } else {
                                                          dailyEntriesController
                                                              .NosControllers[
                                                                  index]
                                                              .text = "";
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        dailyEntriesController
                                                                .NosControllers[
                                                            index],
                                                    cursorColor: Colors.black,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                            r'^\d+\.?\d{0,2}'),
                                                      ),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      labelText: RequestConstant
                                                          .HEAD_NOS,
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: RequestConstant
                                                            .Lable_Font_SIZE,
                                                      ),
                                                      prefixIconConstraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 8),
                                                        child: Icon(
                                                          Icons
                                                              .supervisor_account,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return '\u26A0 Enter user name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.white70,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3,
                                                          left: 10,
                                                          bottom: 5),
                                                  child: TextFormField(
                                                    onTap: () {
                                                      setState(() {
                                                        if (dailyEntriesController
                                                                    .OtHrsController[
                                                                        index]
                                                                    .text !=
                                                                "" &&
                                                            dailyEntriesController
                                                                    .OtHrsController[
                                                                        index]
                                                                    .text !=
                                                                "0" &&
                                                            dailyEntriesController
                                                                    .OtHrsController[
                                                                        index]
                                                                    .text !=
                                                                "0.0") {
                                                          return;
                                                        } else {
                                                          dailyEntriesController
                                                              .OtHrsController[
                                                                  index]
                                                              .text = "";
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        dailyEntriesController
                                                                .OtHrsController[
                                                            index],
                                                    cursorColor: Colors.black,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                            r'^\d+\.?\d{0,2}'),
                                                      ),
                                                    ],
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      labelText:
                                                          "Morning OT Hrs",
                                                      labelStyle: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE),
                                                      prefixIconConstraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                          child: Icon(
                                                              Icons.timelapse,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return '\u26A0 Enter user name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      )
                                    ],
                                  ));
                            },
                          ),
                        )
                      : Obx(
                          () => ListView.builder(
                            padding: EdgeInsets.only(
                                bottom: BaseUtitiles.getheightofPercentage(
                                    context, 15)),
                            physics: const ScrollPhysics(),
                            itemCount: manPowerController
                                .manpowerCategoryList.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              manPowerController.textControllersInitiate();
                              return Container(
                                  color: const Color.fromRGBO(240, 240, 240, 1),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              manPowerController
                                                  .manpowerCategoryList
                                                  .value[index]
                                                  .labourCategoryName
                                                  .toString(),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.white70,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3,
                                                          left: 10,
                                                          bottom: 5),
                                                  child: TextFormField(
                                                    onTap: () {
                                                      if (manPowerController
                                                                  .NosControllers[
                                                                      index]
                                                                  .text !=
                                                              "" &&
                                                          manPowerController
                                                                  .NosControllers[
                                                                      index]
                                                                  .text !=
                                                              "0" &&
                                                          manPowerController
                                                                  .NosControllers[
                                                                      index]
                                                                  .text !=
                                                              "0.0") {
                                                        return;
                                                      } else {
                                                        manPowerController
                                                            .NosControllers[
                                                                index]
                                                            .text = "";
                                                      }
                                                    },
                                                    controller:
                                                        manPowerController
                                                                .NosControllers[
                                                            index],
                                                    cursorColor: Colors.black,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                            r'^\d+\.?\d{0,2}'),
                                                      ),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      labelText: RequestConstant
                                                          .HEAD_NOS,
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: RequestConstant
                                                            .Lable_Font_SIZE,
                                                      ),
                                                      prefixIconConstraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 8),
                                                        child: Icon(
                                                          Icons
                                                              .supervisor_account,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.white70,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3,
                                                          left: 10,
                                                          bottom: 5),
                                                  child: TextFormField(
                                                    onTap: () {
                                                      setState(() {
                                                        if (manPowerController
                                                                    .RemarksControllers[
                                                                        index]
                                                                    .text !=
                                                                "" &&
                                                            manPowerController
                                                                    .RemarksControllers[
                                                                        index]
                                                                    .text !=
                                                                "0" &&
                                                            manPowerController
                                                                    .RemarksControllers[
                                                                        index]
                                                                    .text !=
                                                                "0.0") {
                                                          return;
                                                        } else {
                                                          manPowerController
                                                              .RemarksControllers[
                                                                  index]
                                                              .text = "";
                                                        }
                                                      });
                                                    },
                                                    controller: manPowerController
                                                            .RemarksControllers[
                                                        index],
                                                    cursorColor: Colors.black,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      labelText: "Remarks",
                                                      labelStyle: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE),
                                                      prefixIconConstraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                          child: Icon(
                                                              Icons.receipt_long,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
