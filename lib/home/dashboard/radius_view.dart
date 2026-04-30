import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prahkurticore/home/dashboard/text_form_field.dart';
import '../../controller/site_location_controller.dart';
import 'app_bar.dart';
import 'button_widget.dart';
import 'map_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class RadiusView extends StatefulWidget {
  final String? ProjectId;
  const RadiusView({super.key, required this.ProjectId});

  @override
  State<RadiusView> createState() => _RadiusViewState();
}

class _RadiusViewState extends State<RadiusView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  bool? loading = true;

  @override
  void initState() {
    checkLocationPermission();
    siteLocationController.radius.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
            leading: Padding(
              padding: EdgeInsets.only(
                top: 16.r,
              ),
              child: Builder(
                builder: (context) {
                  return InkWell(
                    radius: 24.0,
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: SizedBox(
                          height: 18,
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
            title: "Set your site radius"),
        body: Form(
          key: formKey,
          child: Container(
            color: Colors.white,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: loading == false ?
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.r, right: 16.r, bottom: 16.r,top: 16.r),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.r),
                        child: SizedBox(
                          height: 200.h,
                          width: 200.h,
                          child: Lottie.asset('assets/radius.json'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.r),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: SizedBox(
                            child: TextInputField(
                              controller: siteLocationController.radius,
                              labelText: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: "Enter a radius",
                                      ),
                                      TextSpan(
                                        text: " *",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(256),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 10.0,
                              ),
                              keyboardType: TextInputType.number,
                              hintText: "Enter a radius",
                              validator: (radius) {
                                if (radius == null || radius.isEmpty) {
                                  return 'Enter a radius';
                                } else if (int.tryParse(radius)! < 100) {
                                  return 'Radius must be at least 100';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.r),
                        child: ButtonWidget(
                          maxHeight: 40.h,
                          color: Theme.of(context).primaryColor,
                          title: const Text(
                            "Enter the map",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (siteLocationController.latitude != "" && siteLocationController.longitude != "") {
                                if (kDebugMode) {
                                  print("Hello One");
                                }
                                Get.to(()=> SetMapView(latitude: siteLocationController.latitude, longitude: siteLocationController.longitude, ProjectId: widget.ProjectId));
                                FocusScope.of(context).unfocus();
                                if (kDebugMode) {
                                  print("Latitude :: ${siteLocationController.latitude}");
                                }
                                if (kDebugMode) {
                                  print("Latitude :: ${siteLocationController.longitude}");
                                }
                              } else {
                                if (kDebugMode) {
                                  print("Hello Two");
                                }
                                null;
                              }
                            } else {
                              if (kDebugMode) {
                                print("Hello Three");
                              }
                              null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ) : Column(
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
      ),
    );
  }

  Future<void> checkLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied || permissionStatus.isRestricted) {
      await Permission.location.request();
      await determinePosition();
      permissionStatus = await Permission.location.status;
      if (kDebugMode) {
        print("Permission Status :: $permissionStatus");
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
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      // 📍 Call Nominatim instead of placemarkFromCoordinates
      final url = Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&addressdetails=1");

      print('url...${url}');

      final response = await http.get(url, headers: {
        "User-Agent": "FlutterApp/1.0 (https://skconstructions.in/contact)"
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final displayName = data["display_name"] ?? "Unknown address";

        setState(() {
          loading = false;
          siteLocationController.punchInAddress = displayName;
          siteLocationController.latitude = position.latitude.toString();
          siteLocationController.longitude = position.longitude.toString();
          if (kDebugMode) {
            print("Punch In Address :: $displayName");
            print("Punch In latitude :: ${position.latitude}");
            print("Punch In longitude :: ${position.longitude}");
          }
        });
      } else {
        // Fluttertoast.showToast(msg: "Failed to get address from Nominatim");
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
