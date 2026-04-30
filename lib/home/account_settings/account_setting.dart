import '../../utilities/requestconstant.dart';
import '../../controller/accountsettings_controller.dart';
import '../../controller/logincontroller.dart';
import '../../login/animation_signinpage/Animations/FadeAnimation.dart';
import '../../newhome/maindashboard/dashboard.dart';
import '../../newhome/maindashboard/dashboard_otheruser.dart';
import '../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  LoginController loginController = Get.put(LoginController());
  AccountSetingController accountSetingController = Get.put(AccountSetingController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
    borderRadius: BorderRadius.circular(32),
  );

  bool isObscureNewPassword = true;
  bool isObscureConfirmPassword = true;

  @override
  void initState() {
    accountSetingController.password_controller.clear();
    accountSetingController.repassword_controller.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child:
            Form(
              key: formkey,
              child: WillPopScope(
                onWillPop: () => homeScreen(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FadeAnimation(1.2, const Text("Account Settings",
                              style: TextStyle(color: Colors.indigo, fontSize: RequestConstant.Heading_Font_SIZE, fontWeight: FontWeight.bold),)),
                            FadeAnimation(1.2, InkWell(
                              child: SizedBox(
                                width: BaseUtitiles.getWidthtofPercentage(context, 13),
                                child: const Text( "Back",
                                  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),),
                              ),
                              onTap: (){
                                homeScreen();
                              },
                            )),
        
                          ],
                        ),
                      ),
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 10)),
                      FadeAnimation(1.2,
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
                      SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
                      FadeAnimation(1.5,
                        Column(
                          children: <Widget>[
                            FadeAnimation(1.8, Container(
                              alignment: Alignment.center,
                              width: BaseUtitiles.getWidthtofPercentage(context, 100),
                              child: Text(loginController.UserName().toString(), style: const TextStyle(color: Colors.indigo,fontSize: RequestConstant.Heading_Font_SIZE, fontWeight: FontWeight.bold),),
                            )),
                            const SizedBox(height: 20,),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: isObscureNewPassword,
                              cursorColor: Colors.black,
                              controller: accountSetingController.password_controller,
                              validator: (newPassword){
                                if(newPassword!.isEmpty){
                                  return "Enter new password";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "New password",
                                labelStyle: const TextStyle(fontSize: 14,color: Colors.black),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                      isObscureNewPassword ? Icons.visibility : Icons.visibility_off,color:Colors.indigo,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscureNewPassword = !isObscureNewPassword;
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
                                      color: Colors.indigo,
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: isObscureConfirmPassword,
                              cursorColor: Colors.black,
                              controller: accountSetingController.repassword_controller,
                              validator: (validator){
                                if(validator!.isEmpty ){
                                  return "Enter confirm password";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Confirm password",
                                labelStyle: const TextStyle(fontSize: 14,color: Colors.black),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                      isObscureConfirmPassword ? Icons.visibility : Icons.visibility_off,color:Colors.indigo,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                        isObscureConfirmPassword = !isObscureConfirmPassword;
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
                                      color: Colors.indigo,
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeAnimation(1.8, InkWell(
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.indigo.shade50
                          ),
                          child: const Center(child: Text("UPDATE", style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            if(accountSetingController.password_controller.text == accountSetingController.repassword_controller.text) {
                              accountSetingController.changePasswordDetails(context);
                            } else {
                              BaseUtitiles.showToast("Password not matched");
                            }
                          } else {
                            null;
                          }
                        },
                      )),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  homeScreen(){
    if(loginController.user.value.userType=="A"){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    }
    else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }
}
