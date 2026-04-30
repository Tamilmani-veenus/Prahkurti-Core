import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/logincontroller.dart';

import '../constants/storage_constant.dart';
import '../login/animation_signinpage/welcomepage.dart';
import '../provider/dashboard_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class Dashboard_Controller extends GetxController {

  LoginController loginController = Get.put(LoginController());

  final Date = TextEditingController();

  RxList main_List = [].obs;

  Future DirectBill_EntryList() async {
    main_List.value.clear();
    await Dashboard_Provider.getDashboardAPI_List(loginController.user.value.userType.toString()).then((value) async {
      if (value != null && value.length > 0) {
        main_List.value = value;
        return main_List.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future logoutPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to logout?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          return Navigator.of(context).pop();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color:
                                Colors.grey,
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontSize:
                                RequestConstant
                                    .Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          BaseUtitiles.showToast('Logout Successfully');
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomePage()),
                          );
                        },
                        child: Text("Logout",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),


          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     primary: Theme.of(context).primaryColor,
          //   ),
          //   onPressed: () {
          //     return Navigator.of(context).pop();
          //   },
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: (){
          //     SessionStorage.removeUser();
          //     BaseUtitiles.showToast('Logout Successfully');
          //     Navigator.of(context).pop();
          //     Navigator.pushReplacement(
          //       context,
          //       // MaterialPageRoute(builder: (context) => LoginScreen()),
          //       MaterialPageRoute(builder: (context) => Welcome_Page()),
          //     );
          //   },
          //   child:Text('Yes'),
          //   style: ElevatedButton.styleFrom(
          //     primary: Theme.of(context).primaryColor,
          //   ),
          // ),
        ],
      ),
    );
  }

}
