import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../utilities/baseutitiles.dart';
import '../maindashboard/dashboard.dart';
import '../maindashboard/dashboard_otheruser.dart';

class MainManusList extends StatefulWidget {
  const MainManusList({Key? key}) : super(key: key);

  @override
  State<MainManusList> createState() => _MainManusListState();
}

class _MainManusListState extends State<MainManusList> {
  CommanController commanController = Get.put(CommanController());
  Menu_Controller menuController = Get.put(Menu_Controller());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    menuController.formMenuId.value = 0;
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      await menuController.getMenuList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: WillPopScope(
        onWillPop: () => homeScreen(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(child: rowDetails()),
            )
          ],
        ),
      ),
    );
  }

  homeScreen() {
    if (loginController.user.value.userType == "A") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }

  Widget rowDetails() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.05),
          itemCount: menuController.menuListDatas.value.length,
          itemBuilder: (context, index) {
            final moduleName =
                menuController.menuListDatas.value[index].moduleName;

            if (![
              "Materials",
              "Daily Entries",
              "Main Menu",
              "Accounts",
              "Payroll",
              "Project Planning"
            ].contains(moduleName)) {
              return const SizedBox.shrink();
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(
                      moduleName ?? "-",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (menuController.menuListDatas.value[index].moduleName ==
                      "Materials")
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      // height: BaseUtitiles.getheightofPercentage(context, 26),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(5),
                          itemCount: menuController.subMatList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      menuController
                                                  .subMatList[index].menuName ==
                                              "MRN Request (Indent)"
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .penToSquare,
                                                    // FontAwesomeIcons.clipboardList,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            )
                                          : menuController.subMatList[index]
                                                      .menuName ==
                                                  "Site Request (Issue Slip)"
                                              ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .fileInvoice,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : menuController.subMatList[index]
                                                          .menuName ==
                                                      "Inward"
                                                  ? Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .listCheck,
                                                            color: Colors.white,
                                                            size: 20,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : menuController
                                                              .subMatList[index]
                                                              .menuName ==
                                                          "Transfer Between Projects"
                                                      ? Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .arrowsTurnToDots,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : menuController
                                                                  .subMatList[
                                                                      index]
                                                                  .menuName ==
                                                              "Transfer Between Sites"
                                                          ? Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .arrowsSpin,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  )
                                                                  // Image.asset('assets/images/ic_wallet.png',
                                                                  //     width: 22),
                                                                ],
                                                              ),
                                                            )
                                                          : menuController
                                                                      .subMatList[
                                                                          index]
                                                                      .menuName ==
                                                                  "Material Transfer Request"
                                                              ? Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .trailer,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : menuController
                                                                          .subMatList[
                                                                              index]
                                                                          .menuName ==
                                                                      "Consumption"
                                                                  ? Container(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              10),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          const Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            FontAwesomeIcons.personDigging,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                20,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : SizedBox
                                                                      .shrink(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          // menuController.subMatList[index].menuName == "MRN Request (Indent)"
                                          //     ? "MRN(Indent)"
                                          //     : menuController.subMatList[index].menuName == "Site Request (Issue Slip)"
                                          //     ? "Site Request \n(Issue Slip)"
                                          //     : menuController.subMatList[index].menuName == "Inward"
                                          //         ? "Inward"
                                          //         : menuController.subMatList[index].menuName == "Transfer Between Projects"
                                          //             ? "Transfer \n B/w  Projects"
                                          //             : menuController.subMatList[index].menuName == "Transfer Between Sites"
                                          //                 ? "Transfer \n B/w Sites"
                                          // : menuController.subMatList[index].menuName == "Material Transfer Request"
                                          //     ? "Material\nTransfer Request"
                                          //                 : menuController.subMatList[index].menuName == "Consumption"
                                          //                     ? "Consumption"
                                          //                     : "",
                                          menuController.subMatList[index]
                                                  .dynamicMenuName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () async {
                                menuController.MaterialScreen(
                                    menuController.subMatList[index].menuName!,
                                    menuController.subMatList[index].dynamicMenuName!,
                                    context);
                                menuController.formName.value =
                                    menuController.subMatList[index].menuName!;
                                menuController.formMenuId.value =
                                    menuController.subMatList[index].menuId!;
                                await commanController
                                    .getControllEntryListRights();
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 6 / 6,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    ),
                  if (menuController.menuListDatas.value[index].moduleName ==
                      "Project Planning")
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      //height: BaseUtitiles.getheightofPercentage(context, 33),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GridView.builder(
                          // scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(5),
                          itemCount: menuController.projPlanningList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      menuController.projPlanningList[index]
                                                  .menuName ==
                                              "BOQ - Revised"
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                // gradient: LinearGradient(
                                                //   begin:
                                                //       Alignment.topLeft,
                                                //   end: Alignment
                                                //       .bottomRight,
                                                //   colors: [
                                                //     purple,
                                                //     blue,
                                                //   ],
                                                // ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .diagramSuccessor,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                  // Image.asset('assets/images/ic_wallet.png',
                                                  //     width: 22),
                                                ],
                                              ),
                                            )
                                      :menuController.projPlanningList[index]
                                          .menuName ==
                                          "Work Order - Direct"
                                          ? Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor,
                                          borderRadius:
                                          const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          // gradient: LinearGradient(
                                          //   begin:
                                          //       Alignment.topLeft,
                                          //   end: Alignment
                                          //       .bottomRight,
                                          //   colors: [
                                          //     purple,
                                          //     blue,
                                          //   ],
                                          // ),
                                        ),
                                        child:  Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons
                                                .fileContract,color: Colors.white,
                                              size: 20,)
                                            // Image.asset('assets/images/ic_wallet.png',
                                            //     width: 22),
                                          ],
                                        ),
                                      )
                                          : SizedBox()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          // menuController.projPlanningList[
                                          // index].menuName ==
                                          //     "BOQ - Revised"
                                          //     ? "BOQ - Revised"
                                          //     : "",
                                          menuController.projPlanningList[index]
                                                  .dynamicMenuName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () async {
                                menuController.MainmenuScreen(
                                    menuController
                                        .projPlanningList[index].menuName!,
                                    menuController.projPlanningList[index]
                                    .dynamicMenuName!,
                                    context);
                                menuController.formName.value = menuController
                                    .projPlanningList[index].menuName!;
                                menuController.formMenuId.value = menuController
                                    .projPlanningList[index].menuId!;
                                await commanController
                                    .getControllEntryListRights();
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 6 / 6,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    ),
                  if (menuController.menuListDatas.value[index].moduleName ==
                      "Daily Entries")
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(5),
                          itemCount: menuController.dailyEntryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      menuController.dailyEntryList[index]
                                                  .menuName ==
                                              "SubContractor Attendance"
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                // gradient: LinearGradient(
                                                //   begin:
                                                //       Alignment.topLeft,
                                                //   end: Alignment
                                                //       .bottomRight,
                                                //   colors: [
                                                //     purple,
                                                //     blue,
                                                //   ],
                                                // ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.how_to_reg,
                                                    color: Colors.white,
                                                    size: 25,
                                                  )
                                                ],
                                              ),
                                            )
                                          : menuController.dailyEntryList[index]
                                                      .menuName ==
                                                  "Company NMR Attendance"
                                              ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    // gradient:
                                                    //     LinearGradient(
                                                    //   begin: Alignment
                                                    //       .topLeft,
                                                    //   end: Alignment
                                                    //       .bottomRight,
                                                    //   colors: [
                                                    //     purple,
                                                    //     blue,
                                                    //   ],
                                                    // ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.engineering,
                                                        color: Colors.white,
                                                        size: 25,
                                                      )
                                                      // Image.asset('assets/images/ic_wallet.png',
                                                      //     width: 22),
                                                    ],
                                                  ),
                                                )
                                              : menuController
                                                          .dailyEntryList[index]
                                                          .menuName ==
                                                      "SubCont NMR Wkly Bill - Generation"
                                                  ? Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                        // gradient:
                                                        // LinearGradient(
                                                        //   begin: Alignment
                                                        //       .topLeft,
                                                        //   end: Alignment
                                                        //       .bottomRight,
                                                        //   colors: [
                                                        //     purple,
                                                        //     blue,
                                                        //   ],
                                                        // ),
                                                      ),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .receipt_long_outlined,
                                                            color: Colors.white,
                                                            size: 25,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : menuController
                                                              .dailyEntryList[
                                                                  index]
                                                              .menuName ==
                                                          "Daily Work Done (DPR)"
                                                      ? Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            // gradient:
                                                            //     LinearGradient(
                                                            //   begin: Alignment
                                                            //       .topLeft,
                                                            //   end: Alignment
                                                            //       .bottomRight,
                                                            //   colors: [
                                                            //     purple,
                                                            //     blue,
                                                            //   ],
                                                            // ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .trowelBricks,
                                                                // FontAwesomeIcons.peopleCarryBox,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : menuController
                                                                  .dailyEntryList[
                                                                      index]
                                                                  .menuName ==
                                                              "Daily Work Done [DPR New]"
                                                          ? Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                // gradient:
                                                                //     LinearGradient(
                                                                //   begin: Alignment
                                                                //       .topLeft,
                                                                //   end: Alignment
                                                                //       .bottomRight,
                                                                //   colors: [
                                                                //     purple,
                                                                //     blue,
                                                                //   ],
                                                                // ),
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .trowel,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : menuController
                                                                      .dailyEntryList[
                                                                          index]
                                                                      .menuName ==
                                                                  "Daily Work Done (DPR Labour)"
                                                              ? Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                    // gradient:
                                                                    //     LinearGradient(
                                                                    //   begin:
                                                                    //       Alignment.topLeft,
                                                                    //   end:
                                                                    //       Alignment.bottomRight,
                                                                    //   colors: [
                                                                    //     purple,
                                                                    //     blue,
                                                                    //   ],
                                                                    // ),
                                                                  ),
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .account_tree,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : menuController
                                                                          .dailyEntryList[
                                                                              index]
                                                                          .menuName ==
                                                                      "Bill Generation"
                                                                  ? Container(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              10),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          const Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.description,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                25,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : menuController
                                                                              .dailyEntryList[
                                                                                  index]
                                                                              .menuName ==
                                                                          "Bill Generation - Direct"
                                                                      ? Container(
                                                                          width:
                                                                              40,
                                                                          height:
                                                                              40,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(10),
                                                                            ),
                                                                            // gradient: LinearGradient(
                                                                            //   begin: Alignment.topLeft,
                                                                            //   end: Alignment.bottomRight,
                                                                            //   colors: [
                                                                            //     purple,
                                                                            //     blue,
                                                                            //   ],
                                                                            // ),
                                                                          ),
                                                                          child:
                                                                              const Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.fileSignature,
                                                                                color: Colors.white,
                                                                                size: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : menuController.dailyEntryList[index].menuName ==
                                                                              "Advance Requisition Voucher"
                                                                          ? Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: BoxDecoration(
                                                                                color: Theme.of(context).primaryColor,
                                                                                borderRadius: const BorderRadius.all(
                                                                                  Radius.circular(10),
                                                                                ),
                                                                                // gradient: LinearGradient(
                                                                                //   begin: Alignment.topLeft,
                                                                                //   end: Alignment.bottomRight,
                                                                                //   colors: [
                                                                                //     purple,
                                                                                //     blue,
                                                                                //   ],
                                                                                // ),
                                                                              ),
                                                                              child: const Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.add_business_outlined,
                                                                                    color: Colors.white,
                                                                                    size: 25,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                      :menuController.dailyEntryList[index].menuName ==
                                          "Man Power"
                                          ? Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          // gradient: LinearGradient(
                                          //   begin: Alignment.topLeft,
                                          //   end: Alignment.bottomRight,
                                          //   colors: [
                                          //     purple,
                                          //     blue,
                                          //   ],
                                          // ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.diversity_3,
                                              color: Colors.white,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                      )
                                                                          : SizedBox()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          // menuController.dailyEntryList[
                                          //             index].menuName ==
                                          //         "SubContractor Attendance"
                                          //     ? "SubContractor\nAttendance"
                                          //     : menuController.dailyEntryList[
                                          //                 index].menuName ==
                                          //             "Company NMR Attendance"
                                          //         ? "Company NMR \nAttendance"
                                          //         : menuController.dailyEntryList[
                                          //                     index].menuName ==
                                          //                 "SubCont NMR Wkly Bill - Generation"
                                          //             ? "NMR Wkly Bill"
                                          //             : menuController.dailyEntryList[
                                          //                         index].menuName ==
                                          //                     "Daily Work Done (DPR)"
                                          //                 ? "DPR"
                                          //                 : menuController.dailyEntryList[
                                          //                             index].menuName ==
                                          //                         "Daily Work Done [DPR New]"
                                          //                     ? "DPR NEW"
                                          //                     : menuController.dailyEntryList[index].menuName ==
                                          //                             "Daily Work Done (DPR Labour)"
                                          //                         ? "Work Done(DPR Labour)"
                                          //                   : menuController.dailyEntryList[index].menuName ==
                                          //                   "Bill Generation"
                                          //                   ? "Bill Generation"
                                          //                         : menuController.dailyEntryList[index].menuName ==
                                          //                                 "Bill Generation - Direct"
                                          //                             ? "Bill Direct"
                                          //                             : menuController.dailyEntryList[index].menuName == "Advance Requisition Voucher"
                                          //                                 ? "Advance Req\nVoucher"
                                          //                                 : menuController.dailyEntryList[index].menuName == "Pre Approval"
                                          //                                     ? "Pre Approval"
                                          //                                     : "",
                                          menuController.dailyEntryList[index]
                                                  .dynamicMenuName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () async {
                                menuController.NavigateScreen(
                                    menuController
                                        .dailyEntryList[index].menuName!,
                                    menuController.dailyEntryList[index].dynamicMenuName!,
                                    context);
                                menuController.formName.value = menuController
                                    .dailyEntryList[index].menuName!;
                                menuController.formMenuId.value = menuController
                                    .dailyEntryList[index].menuId!;
                                await commanController
                                    .getControllEntryListRights();
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 6 / 6,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    ),
                  if (menuController.menuListDatas.value[index].moduleName ==
                      "Accounts")
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.all(5),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: menuController.accountsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      menuController.accountsList[index]
                                                  .menuName ==
                                              "Site Voucher"
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                // gradient: LinearGradient(
                                                //   begin:
                                                //       Alignment.topLeft,
                                                //   end: Alignment
                                                //       .bottomRight,
                                                //   colors: [
                                                //     purple,
                                                //     blue,
                                                //   ],
                                                // ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .vertical_split_outlined,
                                                    color: Colors.white,
                                                    size: 25,
                                                  )
                                                ],
                                              ),
                                            )
                                          : menuController.accountsList[index]
                                                      .menuName ==
                                                  "Staff Voucher"
                                              ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    // gradient:
                                                    //     LinearGradient(
                                                    //   begin: Alignment
                                                    //       .topLeft,
                                                    //   end: Alignment
                                                    //       .bottomRight,
                                                    //   colors: [
                                                    //     purple,
                                                    //     blue,
                                                    //   ],
                                                    // ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .laptopFile,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : menuController
                                                          .accountsList[index]
                                                          .menuName ==
                                                      "Cash Book/Staff"
                                                  ? Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                        // gradient:
                                                        //     LinearGradient(
                                                        //   begin: Alignment
                                                        //       .topLeft,
                                                        //   end: Alignment
                                                        //       .bottomRight,
                                                        //   colors: [
                                                        //     purple,
                                                        //     blue,
                                                        //   ],
                                                        // ),
                                                      ),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .fileInvoiceDollar,
                                                            color: Colors.white,
                                                            size: 20,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : menuController
                                                              .accountsList[
                                                                  index]
                                                              .menuName ==
                                                          "Cash Book/Site"
                                                      ? Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            // gradient:
                                                            //     LinearGradient(
                                                            //   begin: Alignment
                                                            //       .topLeft,
                                                            //   end: Alignment
                                                            //       .bottomRight,
                                                            //   colors: [
                                                            //     purple,
                                                            //     blue,
                                                            //   ],
                                                            // ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.add_card,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          // menuController.accountsList[
                                          //             index].menuName ==
                                          //         "Site Voucher"
                                          //     ? "Site Voucher"
                                          //     : menuController.accountsList[
                                          //                 index].menuName ==
                                          //             "Staff Voucher"
                                          //         ? "Staff Voucher"
                                          //         : menuController.accountsList[
                                          //                     index].menuName ==
                                          //                 "Cash Book/Staff"
                                          //             ? "Cash Book/Staff"
                                          //             : menuController.accountsList[
                                          //                         index].menuName ==
                                          //                     "Cash Book/Site"
                                          //                 ? "Cash Book/Site"
                                          //                 : "",
                                          menuController.accountsList[index]
                                                  .dynamicMenuName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () async {
                                menuController.AccountsScreen(
                                    menuController
                                        .accountsList[index].menuName!,
                                    menuController.accountsList[index]
                                    .dynamicMenuName!,
                                    context);
                                menuController.formName.value = menuController
                                    .accountsList[index].menuName!;
                                menuController.formMenuId.value =
                                    menuController.accountsList[index].menuId!;
                                await commanController
                                    .getControllEntryListRights();
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 6 / 6,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    ),
                  if (menuController.menuListDatas.value[index].moduleName ==
                      "Payroll")
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.all(5),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: menuController.payrollList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      menuController.payrollList[index]
                                                  .menuName ==
                                              "Staff L & P Slip"
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                // gradient: LinearGradient(
                                                //   begin: Alignment.topLeft,
                                                //   end: Alignment.bottomRight,
                                                //   colors: [
                                                //     purple,
                                                //     blue,
                                                //   ],
                                                // ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.receipt_long_outlined,
                                                    color: Colors.white,
                                                    size: 25,
                                                  )
                                                ],
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          // menuController.payrollList[index].menuName == "Staff L & P Slip"
                                          //   ? "Staff L & P Slip"
                                          //   : "",
                                          menuController.payrollList[index]
                                                  .dynamicMenuName ??
                                              "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () async {
                                menuController.PayrollScreen(
                                    menuController.payrollList[index].menuName!,menuController.payrollList[index]
                                    .dynamicMenuName!,
                                    context);
                                menuController.formName.value =
                                    menuController.payrollList[index].menuName!;
                                menuController.formMenuId.value =
                                    menuController.payrollList[index].menuId!;
                                await commanController
                                    .getControllEntryListRights();
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 6 / 6,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ));
  }
}
