import 'dart:io';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/storage_constant.dart';
import '../../controller/auto_yrwise_no_controller.dart';
import '../../controller/comman_controller.dart';
import '../../controller/companycontroller.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../controller/pendinglistcontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/requisitionslip_controller.dart';
import '../../controller/site_location_controller.dart';
import '../../controller/stocksite_controller.dart';
import '../../controller/subcontcontroller.dart';
import '../../home/account_settings/account_setting.dart';
import '../../home/dashboard/button_widget.dart';
import '../../home/dashboard/site_locations_view.dart';
import '../../login/animation_signinpage/Animations/FadeAnimation.dart';
import '../../login/animation_signinpage/signin_page.dart';
import '../../login/animation_signinpage/welcomepage.dart';
import '../../provider/daily_wrkdone_dprNew_provider.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import '../menus/main_menuslist.dart';
import '../pendinglist.dart';
import '../reports/reports.dart';


class DashboardScreen_OtherUser extends StatefulWidget {
  DashboardScreen_OtherUser({Key? key}) : super(key: key);

  @override
  State<DashboardScreen_OtherUser> createState() => _DashboardScreen_OtherUserState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _DashboardScreen_OtherUserState extends State<DashboardScreen_OtherUser> {

  int _currentPage = 0;
  final _pageController = PageController();
  final searchcontroller = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  CompanyController Companycontroller = Get.put(CompanyController());
  StockSiteController stockSiteController = Get.put(StockSiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  // MenuController menuController = Get.put(MenuController());
  Menu_Controller menuController=Get.put(Menu_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  RequisitionSlipController requisitionSlipController = Get.put(RequisitionSlipController());
  CommanController commanController = Get.put(CommanController());
  Dashboard_Controller dashboard_controller = Get.put(Dashboard_Controller());


  @override
  void initState() {
    setState(() {
      punchIn = false;
      loginController.getPunchInStatus();
    });
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () {
      SignInPage.checkVersion(context);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: BottomBar(
            selectedIndex: _currentPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              setState(() => _currentPage = index);
            },
            items: const <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.menu_open),
                title: Text('Menus'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.list_alt),
                title: Text('List'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.file_copy_outlined),
                title: Text('Reports'),
                activeColor: Color(0xFF4B3FFF),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      const Expanded(
                          flex: 3,
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.settings, color: Theme.of(context).primaryColor)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AccountSettings()));
                          },
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.logout,
                                  color: Theme.of(context).primaryColor)),
                          onTap: () {
                            logoutPopup(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 8)
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 84),
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const HomeScreenOtherUser(),),
                        Container(
                          alignment: Alignment.center,
                          child: const MainManusList(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const PendingList_Screen(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Reports_screen(),
                        ),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        }
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  Future logoutPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Logout?'),
        actions: [
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
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ))),
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
                        onPressed: () async {
                          await loginController.usertoken_DeleteApi(context);
                          await loginController.deleteLoginDetails();
                          await SessionStorage.removeUser();
                        },
                        child: const Text("Logout",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}


class HomeScreenOtherUser extends StatefulWidget {
  const
  HomeScreenOtherUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenOtherUser> createState() => _HomeScreenOtherUserState();
}

class _HomeScreenOtherUserState extends State<HomeScreenOtherUser> {
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  Future<bool> showExitPopup(BuildContext context) async {
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
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15, //Spacing at the bottom of divider.
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
                                fontSize:
                                RequestConstant.Lable_Font_SIZE,
                              ))),
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

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
    borderRadius: BorderRadius.circular(32),
  );

  void _handleRadioValueChange(int? value) {
    setState(() {
      punchInController.selectedRadio.value = value!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    punchInController.getProjectPunchInSts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          punchInController.selectedRadio.value = 0;
        });
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () async {
              showExitPopup(context);
              return true;
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  Column(
                    children: [
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
                      FadeAnimation(1.5, Column(
                        children: <Widget>[
                          FadeAnimation(1.8, Container(
                            alignment: Alignment.center,
                            width: BaseUtitiles.getWidthtofPercentage(context, 100),
                            child: Text(loginController.UserName().toString(), style: const TextStyle(color: Colors.indigo,fontSize: RequestConstant.Heading_Font_SIZE, fontWeight: FontWeight.bold),),
                          )),
                          const SizedBox(height: 20,),
                        ],
                      )),
                      FadeAnimation(  1.5,
                        Card(elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32), // Apply rounded corners here
                          ),
                          child: Container(
                            decoration: kGradientBoxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                width: BaseUtitiles.getWidthtofPercentage(context, 70),
                                child: Column(
                                  children: [
                                    SizedBox( height: BaseUtitiles.getheightofPercentage(context, 2),),

                                    FadeAnimation(
                                      1.5,
                                      Obx(()=>
                                          Container(

                                              width: BaseUtitiles.getWidthtofPercentage(context, 65),
                                              height: BaseUtitiles.getheightofPercentage(context, 5),
                                              child: ListTile(
                                                title: GestureDetector(
                                                    onTap: (){
                                                      _handleRadioValueChange(1);
                                                    },
                                                    child: Text('Alloted Projects',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
                                                leading: Radio<int>(
                                                  activeColor: Theme.of(context).primaryColor,
                                                  value: 1,
                                                  groupValue: punchInController.selectedRadio.value,
                                                  onChanged: _handleRadioValueChange,
                                                ),
                                              )),
                                      ),
                                    ),
                                    Obx(()=>
                                        FadeAnimation(
                                          1.5, Container(
                                          width: BaseUtitiles.getWidthtofPercentage(context, 65),
                                          height: BaseUtitiles.getheightofPercentage(context, 5),
                                          child: ListTile(
                                            title: GestureDetector(
                                                onTap: (){
                                                  _handleRadioValueChange(2);
                                                },
                                                child: Text('Non-Alloted Projects',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
                                            leading: Radio<int>(
                                              activeColor: Theme.of(context).primaryColor,
                                              value: 2,
                                              groupValue: punchInController.selectedRadio.value,
                                              onChanged: _handleRadioValueChange,
                                            ),
                                          ),
                                        ),
                                        ),
                                    ),

                                    SizedBox( height: BaseUtitiles.getheightofPercentage(context, 3),),

                                    FadeAnimation(
                                      1.5, Padding(
                                      padding: EdgeInsets.only(bottom: 16.r,left: 16.r,right: 16.r),
                                      child: PunchButtonWidget(
                                        maxHeight: 40.h,
                                        maxWidth: 150.w,
                                        color: Theme.of(context).primaryColor,
                                        title:
                                        Obx(()=>
                                            Text(
                                              punchInController.resPunchSts.value=="TRUE" ?"Punch Out":"Punch In",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                        ),
                                        onTap: () async {
                                          int selected = punchInController.selectedRadio.value;

                                          if (selected == 1 || selected == 2) {
                                            String allotedStatus = selected == 1 ? "Y" : "N";

                                            await punchInController.getProjectPunchInSts();
                                            punchIn = punchInController.resPunchSts.value == "FALSE";

                                            await siteLocationController.getProjectName(allotedStatus, "0");
                                            Get.to(() => SiteLocationView(allotedStatus: allotedStatus, checkValue: "0"));
                                          } else {
                                            BaseUtitiles.showToast("Please select any one");
                                          }

                                        },
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}