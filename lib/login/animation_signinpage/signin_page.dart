import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../../controller/logincontroller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'Animations/FadeAnimation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Future<void> checkVersion(BuildContext context) async {
     final newVersion = NewVersionPlus(
       androidId: 'com.veenus.prahkurti',
     );

    final status = await newVersion.getVersionStatus();

    if (status != null && status.canUpdate) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        dialogTitle: "Update App?",
        dialogText:
        "A new version of Prahkurti Constructions is available!\n\n"
            "Version ${status.storeVersion} is now available!",
        updateButtonText: "UPDATE NOW",
      );
    }
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  LoginController loginController = Get.put(LoginController());

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
    borderRadius: BorderRadius.circular(32),
  );

  bool _isObscure = true;

  @override
  void initState() {
    loginController.password_controller.clear();
    loginController.username_controller.clear();
    SignInPage.checkVersion(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () =>showExit_Popup(context),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*15/100),
                  FadeAnimation(
                    1.2,
                    Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.rotationZ(
                        3.1415926535897932 / 4,
                      ),
                      child: Container(
                        height: 210,
                        width: 210,
                        decoration: kGradientBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: kInnerDecoration,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                -3.1415926535897932 / 4,
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "assets/images/resizelogo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeAnimation(
                      1.2, const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 30),
                  FadeAnimation(
                    1.5, Column(
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: loginController.username_controller,
                        validator: (validater) {
                          if (validater!.isEmpty) {
                            return 'Enter UserName';
                          } else {
                            return null;
                          }
                          // return value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: "User Name",
                          labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            color: Colors.indigo,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.indigo,
                                // color: Color(0xFFEC407A),
                              )),
                          filled: null,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: _isObscure,
                        cursorColor: Colors.black,
                        controller: loginController.password_controller,
                        validator: (validater) {
                          if (validater!.isEmpty) {
                            return "Enter Password";
                          } else {
                            return null;
                          }
                          // return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          labelText: "Password",
                          labelStyle:
                          const TextStyle(fontSize: 14, color: Colors.black),
                          prefixIcon: IconButton(
                            icon: Icon(
                              _isObscure?Icons.visibility_off:
                                   Icons.visibility,
                              color: Colors.indigo,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                // color: Color(0xFFEC407A),
                                color: Colors.indigo,
                              )),
                        ),
                      ),
                    ],
                  ),
                  ),
                  const SizedBox(height: 20),
                  FadeAnimation(
                      1.8,
                      InkWell(
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.indigo.shade50),
                          child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.indigo, fontWeight: FontWeight.bold),
                              )),
                        ),
                        onTap: () async {
                          if(loginController.username_controller.text.trim().isNotEmpty && loginController.password_controller.text.trim().isNotEmpty){
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              loginController.getLoginDetails(context);
                            }
                          }
                          else{
                            BaseUtitiles.showToast("Please enter username or password");
                          }
                        },
                      )),

                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
                  FadeAnimation(
                    1.8,
                    const Column(
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                        //   child: const Text(
                        //     "New User? Create an account.",
                        //     style: TextStyle(color: Colors.indigo),
                        //   ),
                        // ),
                        Text("POWERED BY VEENUS SOFTWARE TECHNOLOGY",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showExit_Popup(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit App!'),
      content: const Text('Do you want to exit an App?'),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE))),
                ),
                VerticalDivider(
                  color: Colors.grey.shade400,
                  width: 5,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Expanded(
                  child: SizedBox(
                    width: BaseUtitiles.getWidthtofPercentage(context, 15),
                    child: TextButton(
                      onPressed: (){
                        exit(0);
                      },
                      // onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Exit",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ) ??
      false;
}
