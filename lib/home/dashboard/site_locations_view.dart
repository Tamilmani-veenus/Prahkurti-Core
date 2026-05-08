import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/home/dashboard/radius_view.dart';
import 'package:prahkurticore/home/dashboard/search_field.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/logincontroller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/site_location_controller.dart';
import '../../splash/splash.dart';
import '../../utilities/baseutitiles.dart';
import '../punch_in_out/punch_in.dart';
import '../punch_in_out/punch_out.dart';

class SiteLocationView extends StatefulWidget {
  const SiteLocationView(
      {super.key, required this.allotedStatus, required this.checkValue});
  final String allotedStatus;
  final String checkValue;

  @override
  State<SiteLocationView> createState() => _SiteLocationViewState();
}

class _SiteLocationViewState extends State<SiteLocationView> {
  SiteLocationController siteLocationController =
      Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());
  LoginController loginController = Get.put(LoginController());
  Timer? _debounce;

  @override
  void initState() {
    siteLocationController.projectNameSearch.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        siteLocationController.projectNameSearch.text = "";
        punchIn = false;
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Select your project name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20.r,
                  ),
                  onPressed: () {
                    Get.back();
                    siteLocationController.projectNameSearch.text = "";
                    punchIn = false;
                  }),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 16.r,
                          left: 16.r,
                        ),
                        child: TextInputSearchField(
                          keyboardType: TextInputType.text,
                          hintText: "Search",
                          controller: siteLocationController.projectNameSearch,
                          onChange: (value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce!.cancel();
                            }

                            _debounce = Timer(
                              const Duration(milliseconds: 500),
                              () async {
                                await siteLocationController.getProjectName(
                                  widget.allotedStatus,
                                  widget.checkValue,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Text(
                          "Discover your Project",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AzoSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.r, right: 4.r, left: 4.r),
                    child: Obx(() {
                      if (siteLocationController.projectNameRxList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No details found",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount:
                        siteLocationController.projectNameRxList.length,
                        itemBuilder: (context, i) {
                          return Obx(() =>
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  siteLocationController
                                      .projectNameSearch.text = "";
                                  if (loginController.user.value.userType ==
                                      "A") {
                                    siteLocationController.projectId =
                                        siteLocationController
                                            .projectNameRxList[i].projectId
                                            .toString();
                                    Get.to(() =>
                                        RadiusView(
                                            ProjectId: siteLocationController
                                                .projectId));
                                  } else {
                                    await punchInController
                                        .getProjectPunchInSts();
                                    if (punchIn == true) {
                                      if (siteLocationController
                                          .projectNameRxList[i]
                                          .pinStatus ==
                                          "True") {
                                        siteLocationController.projectId =
                                            siteLocationController
                                                .projectNameRxList[i]
                                                .projectId
                                                .toString();
                                        siteLocationController.locId =
                                            siteLocationController
                                                .projectNameRxList[i].locid
                                                .toString();
                                        Get.to(() =>
                                            PunchIn(
                                                latitude: siteLocationController
                                                    .projectNameRxList[i]
                                                    .latitude
                                                    .toString(),
                                                longitude: siteLocationController
                                                    .projectNameRxList[i]
                                                    .longitude
                                                    .toString(),
                                                radius: siteLocationController
                                                    .projectNameRxList[i].radius
                                                    .toString(),
                                                allotedStatus:
                                                widget.allotedStatus));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                            "This project doesn't pin the map");
                                      }
                                    } else if (punchIn == false) {
                                      if (siteLocationController
                                          .projectNameRxList[i]
                                          .pinStatus ==
                                          "True") {
                                        siteLocationController.projectId =
                                            siteLocationController
                                                .projectNameRxList[i]
                                                .projectId
                                                .toString();
                                        siteLocationController.locId =
                                            siteLocationController
                                                .projectNameRxList[i].locid
                                                .toString();
                                        Get.to(() =>
                                            PunchOut(
                                                latitude: siteLocationController
                                                    .projectNameRxList[i]
                                                    .latitude
                                                    .toString(),
                                                longitude: siteLocationController
                                                    .projectNameRxList[i]
                                                    .longitude
                                                    .toString(),
                                                radius: siteLocationController
                                                    .projectNameRxList[i].radius
                                                    .toString(),
                                                allotedStatus:
                                                widget.allotedStatus));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                            "This project doesn't pin the map");
                                      }
                                    } else {
                                      null;
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.r, vertical: 4.r),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor:
                                            Color(0xFFF5F5F5),
                                            child: ConstIcons.projectName,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(16.r),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 250.r,
                                                    child: Text(
                                                      siteLocationController
                                                          .projectNameRxList![
                                                      i]
                                                          .projectName
                                                          .toString(),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                        FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          siteLocationController
                                              .projectNameRxList![i]
                                              .pinStatus
                                              .toString() ==
                                              "True"
                                              ? Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                  "assets/select_check.png"),
                                            ),
                                          )
                                              : Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: const Color(
                                                      0xFF69e772)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black12,
                                        height: 2,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },

                      );
                    }),
                ),
                )],
            )),
      ),
    );
  }
}
