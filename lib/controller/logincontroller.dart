import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/storage_constant.dart';
import '../db_model/login_details_model.dart';
import '../db_services/login_details_service.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../login/animation_signinpage/welcomepage.dart';
import '../models/deviceIDres_model.dart';
import '../models/login_details_payload.dart';
import '../models/punch_in_model.dart';
import '../models/usertokenrequest_model.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../models/authendication_model.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../provider/authendication_provider.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  String deviceTokenToSendPushNotification = "";
  bool? punchInStatus = false;
  bool? punchOutStatus = false;
  List<LoginDetailsPayload> loginDetails= [];
  RxInt firstLogin=0.obs;

  var user = User().obs;
  var version;

  bool ckeck = true;
  var seassion_values;

  var getDeviceseassion_values;

  XFile? imageFile;

  String UserId() => user.value.userId.toString();

  String UserName() => user.value.userName.toString();

  // String UserPassword() => user.value.userPassword.toString();

  String UserType() => user.value.userType.toString();

  // String UserActive() => user.value.userActive.toString();

  String EmpName() => user.value.empName.toString();

  String EmpId() => user.value.empId.toString();

  getLoginDetails(BuildContext context) async {

    Map<String, String> body = {
      "userName": username_controller.text.trim(),
      "password": password_controller.text.trim(),
    };

    var value = await AuthendicationProvider.getAuthendication( body, context);

    user.value = value;
    await SessionStorage.writeUser(value);

    if (value.success == true) {
      await getDeviceTokenToSendNotification();
      await Savetoken(context);

      if (value.userType == "A") {

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard_screen()),
        );

      } else {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()),
        );
      }

    } else {
      Navigator.pop(context);
      BaseUtitiles.showToast(value.message.toString());
    }

    await deleteLoginDetails();
    await storeLoginDetails();
    await getLoginDetailsShared();

  }

  Future getLoginNew_seassionvalues(BuildContext context) async {

    Map<String, String> body = {
      "userName": seassion_values.userName.toString().trim(),
      "password": seassion_values.userPassword.toString().trim(),
    };

    var value = await AuthendicationProvider.getAuthendication( body, context);

    user.value = value;

    if (value.success == true) {
      SessionStorage.writeUser(value);
      await getDeviceTokenToSendNotification();
      await Savetoken(context);
    } else {
      return null;
    }
  }

  /// ----- ****************** ------

  List logincheck = [];


  Future getAppVersion() async {
    await AuthendicationProvider.getVersion().then((value) {
      if (value.isNotEmpty) {
        if (Platform.isAndroid) {
          version = value[0].appVersion;
          if (kDebugMode) {
            print("GetAndroidVersion :::: $version");
          }
          return version;
        } else if (Platform.isIOS) {
          version = value[0].iosVersion;
          if (kDebugMode) {
            print("GetIosVersion :::: $version");
          }
          return version;
        }
      }
      return version;
    });
  }

  Future<void> getDeviceTokenToSendNotification() async {
    FirebaseMessaging.instance.requestPermission();
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token " + deviceTokenToSendPushNotification);
  }

  Future Savetoken(BuildContext context) async {
    await CommonProvider.Savetoken(deviceTokenToSendPushNotification);
  }

  Future usertoken_DeleteApi(context) async {
    final value = await CommonProvider.Usertoken_deleteAPI();
    if (value != null ) {
      if (value["success"] == true) {
        BaseUtitiles.showToast(value["message"]);
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      }
      else{
        BaseUtitiles.showToast(value["message"]);
        Navigator.of(context).pop();
      }
    }
    else{
      BaseUtitiles.showToast( "Something went wrong..");
      Navigator.of(context).pop();
    }
  }

  ///---- Device Model Data-----------
  Future deviceModelData(BuildContext context) async {
    String body = deviceIDmodelToJson(DeviceIDmodel(
      deviceId: BaseUtitiles.deviceName.toString(),
    ));
    final response =  await AuthendicationProvider.deviceModelCheck(body);
    print('DeviceModelRes :: $response}');
    return response;
  }

  /// Get punch in status .....
  Future getPunchInStatus() async {
    final value =  await AuthendicationProvider.getPunchInStatusProvider();
    if(value!=null) {
      if(value.success==true ) {
        return value.result;
      }
      else{
        BaseUtitiles.showToast(value.message ?? "Something Went Wrong..");
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong..");
    }
  }


  /// Save to local DB login user details......

  var loginInsert = LoginDetailsModel();
  var loginservices = LoginDetailsService();
  List<LoginDetailsModel> loginvalues = <LoginDetailsModel>[];
  RxList getloginvalues = [].obs;

  /// ----- Stored login details values -----

  Future<void> storeLoginDetails() async {
    loginDetails.clear();
    loginDetails.add(LoginDetailsPayload(
      success:user.value.success,
      message:user.value.message,
      accessToken:user.value.accessToken,
      refreshToken:user.value.refreshToken,
      tokenType:user.value.tokenType,
      empId:user.value.empId,
      expiresIn:user.value.expiresIn,
      userIdleTime:user.value.userIdleTime,
      empName:user.value.empName,
      userName:user.value.userName,
      userType:user.value.userType,
      userId:user.value.userId,
      userPassword:user.value.userPassword,
    ));
    await ServiceLocalDatabaseService.saveLoginDetails(loginDetails, "login");
  }

  /// ----- Get the stored login details values -----

  Future<void> getLoginDetailsShared() async {
    List<LoginDetailsPayload> loginDetail = await ServiceLocalDatabaseService.getLoginDetails("login");
    loginDetails = loginDetail;
    if(loginDetails.isNotEmpty){
      print("Getting values :: ${loginDetails[0].userId}");
    } else {
      print("No details found");
    }
  }

  /// ----- Delete the stored login details values -----

  Future<void> deleteLoginDetails() async {
    await ServiceLocalDatabaseService.deleteLoginDetails("login");
  }
}
