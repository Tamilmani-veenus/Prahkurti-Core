import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prahkurticore/app_theme/app_colors.dart';
import 'package:prahkurticore/home/punch_in_out/punch_in.dart';
import '../../constants/storage_constant.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/punch_in_controller.dart';
import '../../newhome/maindashboard/dashboard_otheruser.dart';
import '../../splash/internetissue.dart';
import '../../splash/splash.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/print_logger.dart';
import '../../utilities/requestconstant.dart';
import 'package:path/path.dart' as path;

import 'camera_screen.dart';

class PunchOut extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? radius;
  final String? allotedStatus;
  const PunchOut({Key? key, this.latitude, this.longitude, this.radius, this.allotedStatus})
      : super(key: key);

  @override
  State<PunchOut> createState() => _PunchOutState();
}

class _PunchOutState extends State<PunchOut> {
  PunchInController punchInController = Get.put(PunchInController());
  bool? status = false;
  bool? loading = true;
  bool? isImageCaptured = false;

  @override
  void initState() {
    punchInController.tomorrowPlanPunchOut.text="";
    punchInController.todayTaskPunchOut.text="";
    punchInController.punchOutRemarks.text="";
    setState(() {
      apiLoading = "false";
      punchInController.isSelect.value = false;
      isImageCaptured = false;
    });
    punchInController.punchOutImageFile.value = null;
    punchInController.getNetworkTime();
    checkLocationPermission();
    super.initState();
  }

  Future<void> checkLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied || permissionStatus.isRestricted) {
      await Permission.location.request();
      await determinePosition();
      permissionStatus = await Permission.location.status;
      if (kDebugMode) {
        printToLog("Permission Status :: $permissionStatus");
      }
    } else if (permissionStatus.isGranted) {
      await determinePosition();
    } else {
      await determinePosition();
    }
  }

  Future determinePosition() async {
    bool? serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
      Navigator.pop(context);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        Navigator.pop(context);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
          'Location permissions are permanently denied, we cannot request permissions.');
      Navigator.pop(context);
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    checkGeoFence(position);
  }

  void checkGeoFence(Position position) {
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      double.parse(widget.latitude!),
      double.parse(widget.longitude!),
    );

    if (distanceInMeters <= num.parse(widget.radius!)) {
      setState(() {
        status = true;
        loading = false;
        if (kDebugMode) {
          printToLog("Status :: You are inside the location");
        }
        Fluttertoast.showToast(msg: "You are inside the location");
      });
    } else {
      setState(() {
        status = false;
        loading = false;
      });
      if (kDebugMode) {
        printToLog("Status :: You are outside the location");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea (
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Punch Out"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: apiLoading == "false"
              ? loading == false
              ? status == true
              ? punchInController.isSelect == false
              ? isImageCaptured == true
              ? Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
                  Text(
                    "Today Task",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
                  TextFormField(
                    readOnly: false,
                    controller: punchInController.todayTaskPunchOut,
                    cursorColor: Colors.black,
                    maxLines: 6,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // 🎯 Rounded corners for the border
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Theme.of(context).primaryColor, // 💠 Border color when not focused
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, // 🌟 Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
              
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context,  widget.allotedStatus=="N"?3:6)),
                  Text(
                    "Tomorrow Plan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
                  TextFormField(
                    readOnly: false,
                    controller: punchInController.tomorrowPlanPunchOut,
                    cursorColor: Colors.black,
                    maxLines: 6,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // 🎯 Rounded corners for the border
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Theme.of(context).primaryColor, // 💠 Border color when not focused
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, // 🌟 Border color when focused
                          width: 2.0,
                        ),
                      ),
                      prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 3)),
                  widget.allotedStatus=="N"?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remarks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
                      TextFormField(
                        readOnly: false,
                        controller: punchInController.punchOutRemarks,
                        cursorColor: Colors.black,
                        maxLines: 6,
                        style: TextStyle(color: Colors.black,fontSize: 15),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // 🎯 Rounded corners for the border
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color:  Theme.of(context).primaryColor, // 💠 Border color when not focused
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, // 🌟 Border color when focused
                              width: 2.0,
                            ),
                          ),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ),
                    ],
                  ):SizedBox(),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, widget.allotedStatus=="N"?8:12)),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: SizedBox(
                      height: 40.h,
                      width: ScreenUtil().screenWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          if (punchInController.punchOutImageFile != null) {
                            if( punchInController.todayTaskPunchOut.text.trim()==''){
                              BaseUtitiles.showToast("Please enter Today task");
                            }
                            else if( punchInController.tomorrowPlanPunchOut.text.trim()==''){
                              BaseUtitiles.showToast("Please enter Tomarrow plan");
                            }
                            else if( punchInController.punchOutRemarks.text.trim()=='' && widget.allotedStatus=="N"){
                              BaseUtitiles.showToast("Please enter Punch Out Remarks");
                            }
                            else{
                              setState(() {});
                              if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                await punchInController.getNetworkTime();
                                await punchInController.punchOutUpdate(context,widget.allotedStatus);
                              }}
                          }
                          else {
                            BaseUtitiles.showToast("Please capture your photo");
                          }
                        },
                        child: const Text("Punch out",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Please capture your photo for punch out",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // await takePicture();
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CameraCapturePage(fromScreen: "Punch Out",)),
                  );
                  if (result == "Camera") {
                    setState(() {});
                  }
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0XFFeff9fb),
                  radius: 80.r,
                  child: Image.asset(
                    "assets/images/camera.png",
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
              ),
              const Text(
                "Capture image using your device camera and upload",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          )
              : Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.file(
                      File(punchInController.punchOutImageFile.value!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 32.r, right: 32, left: 32.r),
                child: SizedBox(
                  height: 40.h,
                  width: ScreenUtil().screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        isImageCaptured=true;
                        punchInController.isSelect.value = false;
                      });
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.r),
                child: SizedBox(
                  height: 120.h,
                  width: 120.h,
                  child: Lottie.asset('assets/outside.json'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: const Text("You are outside the location",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 32.r,
                    right: 64.r,
                    left: 64.r,
                    top: 8.r),
                child: SizedBox(
                  height: 40.h,
                  width: ScreenUtil().screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      Get.back();
                    },
                    child: const Text("Try again",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.h,
                width: 150.h,
                child: Lottie.asset('assets/loading.json'),
              ),
              const Text("Loading please wait.....",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.h,
                width: 150.h,
                child: Lottie.asset('assets/loading.json'),
              ),
              const Text("Loading please wait.....",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

