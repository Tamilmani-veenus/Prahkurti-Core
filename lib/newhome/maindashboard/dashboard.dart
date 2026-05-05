import 'dart:io';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../../constants/storage_constant.dart';
import '../../constants/ui_constant/textfont_style.dart';
import '../../controller/auto_yrwise_no_controller.dart';
import '../../controller/comman_controller.dart';
import '../../controller/companycontroller.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/expensencecontroller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../controller/pendinglistcontroller.dart';
import '../../controller/site_location_controller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/requisitionslip_controller.dart';
import '../../controller/stocksite_controller.dart';
import '../../controller/subcontcontroller.dart';
import '../../home/account_settings/account_setting.dart';
import '../../home/dashboard/expenses.dart';
import '../../home/dashboard/site_locations_view.dart';
import '../../home/dashboard/subcontractor_outstanding.dart';
import '../../home/dashboard/supplier_outstanding.dart';
import '../../login/animation_signinpage/signin_page.dart';
import '../../login/animation_signinpage/welcomepage.dart';
import '../../sample.dart';
import '../pendinglist.dart';
import '../reports/reports.dart';
import '../../app_theme/app_colors.dart';
import '../../provider/daily_wrkdone_dprNew_provider.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import '../menus/main_menuslist.dart';

class Dashboard_screen extends StatefulWidget {
  const Dashboard_screen({Key? key}) : super(key: key);

  @override
  State<Dashboard_screen> createState() => _Dashboard_screenState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  int _currentPage = 0;
  final _pageController = PageController();
  final searchcontroller = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  CompanyController Companycontroller = Get.put(CompanyController());
  StockSiteController stockSiteController = Get.put(StockSiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  Menu_Controller menuController=Get.put(Menu_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  RequisitionSlipController requisitionSlipController = Get.put(RequisitionSlipController());
  CommanController commanController = Get.put(CommanController());
  Dashboard_Controller dashboard_controller = Get.put(Dashboard_Controller());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: BottomBar(
            selectedIndex: _currentPage,
            onTap: (int index) {
              menuController.formMenuId.value = 0;
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.settings, color: Theme.of(context).primaryColor)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AccountSettings()));
                            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  VoiceToTextExample()));
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
                          child: const Home_Dashboard(),),
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
                                fontSize: RequestConstant.Lable_Font_SIZE))),
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
  }
}

class Home_Dashboard extends StatefulWidget {
  const Home_Dashboard({Key? key}) : super(key: key);

  @override
  State<Home_Dashboard> createState() => _Home_DashboardState();
}

class _Home_DashboardState extends State<Home_Dashboard> {
  Dashboard_Controller dashboard_controller = Get.put(Dashboard_Controller());
  ProjectController projectController = Get.put(ProjectController());
  final ExpensesController expensesController = Get.put(ExpensesController());
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      SignInPage.checkVersion(context);
      dashboard_controller.Date.text = BaseUtitiles.initiateCurrentDateFormat();
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: WillPopScope(
          onWillPop: () =>showExit_Popup(context),
          child: Container(
            height: BaseUtitiles.getheightofPercentage(context, 90),
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 83),
                    child:
                    // Obx(() =>
                        ListView.builder(
                      padding: EdgeInsets.zero,
                      // itemCount: dashboard_controller.main_List.value.length,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: BaseUtitiles.getheightofPercentage(context, 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/dashboard_img1.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Projects Summary',
                                    style: subHeader,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: double.infinity,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            purple,
                                            blue,
                                          ],
                                        ),
                                      ),
                                      child: InkWell(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(child: Container()),
                                                const Expanded(
                                                  flex: 3,
                                                  child: Icon(
                                                    Icons.import_export_outlined,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: Icon(
                                                      Icons.arrow_circle_right_outlined,
                                                      color: Colors.white
                                                  ),
                                                )

                                              ],
                                            ),

                                            SizedBox(height: 14),
                                            Container(
                                              margin: EdgeInsets.only(left: 5, right: 5),
                                              width: double.infinity,
                                              child: Text(
                                                // dashboard_controller.main_List.value[index].totalProjects.toString(),
                                                "0",
                                                style: header,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 14),
                                            Text(
                                              'Project',
                                              style: label,
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) {
                                          //       return OverAllProjectsList();
                                          //     });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: double.infinity,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            purple,
                                            blue,
                                          ],
                                        ),
                                      ),
                                      child: InkWell(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(child: Container()),
                                                Expanded(
                                                  flex: 3,
                                                  child: Icon(
                                                    Icons.mobile_screen_share_rounded,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Icon(
                                                      Icons.arrow_circle_right_outlined,
                                                      color: Colors.white
                                                  ),
                                                )

                                              ],
                                            ),
                                            SizedBox(height: 14),
                                            Container(
                                              margin: EdgeInsets.only(left: 5, right: 5),
                                              width: double.infinity,
                                              child: Text(
                                                // '\₹ ' + BaseUtitiles.amountFormat(dashboard_controller.main_List.value[index].expensesAmt),
                                                '\₹ ' + '0',
                                                style: header,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 14),
                                            Text(
                                              'Expenses',
                                              style: label,
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          // expensesController.reportExpensesList.value.clear();
                                          // expensesController.prjttotalamtcontroller.text = "0";
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => Expenses()),
                                          // );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Business Transactions',
                                    style: subHeader,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          purple,
                                          blue,
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.wallet,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cash In Hand',
                                        style: subHeader,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        // '\₹ ' + BaseUtitiles.amountFormat(dashboard_controller.main_List.value[index].cashinHand
                                        '\₹ ' + '0',
                                        style: TextStyle(
                                          fontSize: RequestConstant.Lable_Font_SIZE,
                                          fontWeight: FontWeight.bold,
                                          color:
                                          // dashboard_controller.main_List.value[index].cashinHand > 0
                                          //     ? Colors.lightGreen
                                          //     :
                                          Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(height: 14),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          purple,
                                          blue,
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_balance,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bank A/C',
                                        style: subHeader,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        // '\₹ ' + BaseUtitiles.amountFormat(dashboard_controller.main_List
                                        //     .value[index].bankAmt),
                                        '\₹ ' + '0',
                                        // style: label2,
                                        style: TextStyle(
                                          fontSize: RequestConstant
                                              .Lable_Font_SIZE,
                                          fontWeight: FontWeight.bold,
                                          color:
                                          // dashboard_controller
                                          //     .main_List
                                          //     .value[index]
                                          //     .bankAmt >
                                          //     0
                                          //     ? Colors.lightGreen :
                                          Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: Image.asset(
                                  //     'assets/images/ic_arrow.png',
                                  //     height: 24,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          purple,
                                          blue,
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .supervised_user_circle_sharp,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Suppliers',
                                        style: subHeader,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        // '\₹ ' +
                                        //     BaseUtitiles.amountFormat(
                                        //         dashboard_controller
                                        //             .main_List
                                        //             .value[index]
                                        //             .supplierAmt),
                                        '\₹ ' + '0',
                                        style: TextStyle(
                                          fontSize: RequestConstant
                                              .Lable_Font_SIZE,
                                          fontWeight: FontWeight.bold,
                                          color:
                                          // dashboard_controller
                                          //     .main_List
                                          //     .value[index]
                                          //     .supplierAmt >
                                          //     0
                                          //     ? Theme.of(context)
                                          //     .primaryColor
                                          Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      // expensesController.supplierOSExpensesList.value.clear();
                                      // expensesController.totalamtcontroller.text = "0";
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => Supplieroutstanding()),
                                      // );
                                    },
                                    icon: Image.asset(
                                      'assets/images/ic_arrow.png',
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          purple,
                                          blue,
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.safety_divider,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                        // Image.asset('assets/images/ic_wallet.png',
                                        //     width: 22),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SubContractors',
                                        style: subHeader,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        // '\₹ ' +
                                        //     BaseUtitiles.amountFormat(
                                        //         dashboard_controller
                                        //             .main_List
                                        //             .value[index]
                                        //             .subContAmt),
                                        '\₹ ' + '0',
                                        style: TextStyle(
                                          fontSize: RequestConstant
                                              .Lable_Font_SIZE,
                                          fontWeight: FontWeight.bold,
                                          color:
                                          // dashboard_controller
                                          //     .main_List
                                          //     .value[index]
                                          //     .subContAmt >
                                          //     0
                                          //     ? Theme.of(context)
                                          //     .primaryColor:
                                              Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      // expensesController.subcontractorOSExpensesList.value.clear();
                                      // expensesController.totalamtSubcontcontroller.text="0";
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Subcontractoroutstanding()),);
                                    },
                                    icon: Image.asset(
                                      'assets/images/ic_arrow.png',
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          purple,
                                          blue,
                                        ],
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.gps_fixed,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                        // Image.asset('assets/images/ic_wallet.png',
                                        //     width: 22),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'Pin Site Locations',
                                    style: subHeader,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      await siteLocationController
                                          .getProjectName("0", "1");
                                      Get.to(() => const SiteLocationView(
                                        allotedStatus: "0",
                                        checkValue: "1",
                                      ));
                                    },
                                    icon: Image.asset(
                                      'assets/images/ic_arrow.png',
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                          ],
                        );
                      },
                    )
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class OverAllProjectsList extends StatefulWidget {
  const OverAllProjectsList({super.key});

  @override
  State<OverAllProjectsList> createState() => _OverAllProjectsListState();
}

class _OverAllProjectsListState extends State<OverAllProjectsList> {

  ProjectController projectController = Get.put(ProjectController());

  @override
  void initState() {
    projectController.getProjectListAll(context, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return  AlertDialog(
      title: Text('Project List', style:  TextStyle(color: Theme.of(context).primaryColor, fontSize: RequestConstant.Lable_Font_SIZE),),
      content: SizedBox(
        width: double.maxFinite,
        height: 300.h,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: projectController.getdropDownvalueAll.value.length -1, // Set your item count
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  InkWell(
                    child: Container(
                      child:   Padding(
                        padding:  EdgeInsets.all(6.r),
                        child: Text(projectController.getdropDownvalueAll.value[index + 1].project.toString(),
                          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  const Divider(thickness: 1,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}




