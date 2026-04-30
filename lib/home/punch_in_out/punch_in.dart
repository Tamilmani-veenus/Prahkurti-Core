import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../../constants/storage_constant.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/punch_in_controller.dart';
import '../../newhome/maindashboard/dashboard_otheruser.dart';
import '../../splash/internetissue.dart';
import '../../splash/splash.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/print_logger.dart';
import '../../utilities/requestconstant.dart';
import 'camera_screen.dart';

String? apiLoading;

class PunchIn extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? radius;
  final String? allotedStatus;
  const PunchIn({Key? key, this.latitude, this.longitude, this.radius, this.allotedStatus})
      : super(key: key);

  @override
  State<PunchIn> createState() => _PunchInState();
}

class _PunchInState extends State<PunchIn> {
  PunchInController punchInController = Get.put(PunchInController());
  bool? status = false;
  bool? loading = true;

  @override
  void initState() {
    setState(() {
      apiLoading = "false";
      punchInController.isSelect.value = false;
    });
    punchInController.punchInRemarks.text="";
    punchInController.imageFile.value = null;

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
      printToLog("Permission Status :: $permissionStatus");
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
    print('distanceInMeters...${distanceInMeters}');
    if (distanceInMeters <= num.parse(widget.radius!)) {
      setState(() {
        status = true;
        loading = false;
        printToLog("Status :: You are inside the location");
        Fluttertoast.showToast(msg: "You are inside the location");
      });
    } else {
      setState(() {
        status = false;
        loading = false;
      });
      printToLog("Status :: You are outside the location");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text("Punch In"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: apiLoading == "false"
                ? loading == false
                ? status == true
                ? punchInController.isSelect == false
                ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Please capture your photo for punch in",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CameraCapturePage(fromScreen: 'Punch In',)),
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
                        File(punchInController.imageFile.value!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                widget.allotedStatus=="N"? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 25, right: 25),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: false,
                            controller: punchInController.punchInRemarks,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Remarks",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.remarks),
                            ),
                            minLines: 1,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox( height: BaseUtitiles.getheightofPercentage(context, 2),),
                  ],
                ):SizedBox(),
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
                        if (punchInController.imageFile.value != null) {
                          if(widget.allotedStatus=="N" && punchInController.punchInRemarks.text.trim()==''){
                            BaseUtitiles.showToast("Please enter PunchIn remarks");
                          }
                          else{
                            setState(() {});
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              await punchInController.getNetworkTime();
                              await punchInController.punchInSave(widget.allotedStatus,context);
                            }
                          }
                        } else {
                          BaseUtitiles.showToast("Please capture your photo");
                        }
                      },
                      child: const Text(
                        "Punch In",
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
            )),
      ),
    );
  }
}
