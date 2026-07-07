import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../controller/logincontroller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  LoginController loginController = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    loginController.userName.text = "";
    loginController.password.text = "";
    loginController.conformPassword.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Row(
              children: [
                Text(
                  "Registration",
                  style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    // child: Lottie.asset(
                    //     repeat: false, 'assets/images/registerform.json'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          readOnly: false,
                          controller: loginController.userName,
                          validator: (userName) {
                            if (userName == null || userName.isEmpty) {
                              return "Enter a user name";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Username",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Icon(Icons.account_circle_outlined)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: _isObscure,
                          cursorColor: Colors.black,
                          controller: loginController.password,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Enter a password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Password",
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                // color: Colors.indigo,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: _isObscure,
                          cursorColor: Colors.black,
                          controller: loginController.conformPassword,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Enter a confirm password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                // color: Colors.indigo,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (loginController.password.text == loginController.conformPassword.text) {
                                  await loginController.registerDetails(context);
                                } else {
                                  BaseUtitiles.showToast(
                                      "Please check password mismatch");
                                }
                              }
                            },
                            child: const Text("Submit"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class RegHome extends StatefulWidget {
  const RegHome({super.key});

  @override
  State<RegHome> createState() => _RegHomeState();
}

class _RegHomeState extends State<RegHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Menu rights allocation is only available to administrators. Please contact your administrator.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: RequestConstant.Heading_Font_SIZE),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
