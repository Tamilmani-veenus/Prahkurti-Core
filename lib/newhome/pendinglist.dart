import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/pending_list/onclickpending_list.dart';
import '../utilities/requestconstant.dart';
import '../app_theme/app_colors.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../models/pendinglist_model.dart';
import '../utilities/baseutitiles.dart';
import 'maindashboard/dashboard.dart';
import 'maindashboard/dashboard_otheruser.dart';


class PendingList_Screen extends StatefulWidget {
  const PendingList_Screen({Key? key}) : super(key: key);

  @override
  State<PendingList_Screen> createState() => _PendingList_ScreenState();
}

class _PendingList_ScreenState extends State<PendingList_Screen> {
  LoginController loginController = Get.find();
  PendingListController pendingListController = Get.put(PendingListController());

  @override
  void initState() {
    super.initState();
    // Call the pending list on initialization
    Future.delayed(Duration.zero, () async {
      await pendingListController.getPendingList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Ensure it returns a boolean to prevent or allow back navigation
          homeScreen();
          return false;
        },
        child: Obx(() => SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " Pending List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(child: ListDetails()),
            ],
          ),
        )),
      ),
    );
  }

  Widget ListDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: BaseUtitiles.getheightofPercentage(context, 100),
          child: RefreshIndicator(
            onRefresh: () async {
              await pendingListController.getPendingList();
            },
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 30)),
                itemCount: pendingListController.pendingList_datas.value.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () async {
                            await pendingListController.getSubcontractor_ExpensesList(pendingListController.pendingList_datas.value[index].mobilemenuname!, context);
                          },
                          child: Container(
                              height: BaseUtitiles.getheightofPercentage(context, 5),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 70),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(pendingListController.pendingList_datas.value[index].mobilemenuname!),
                                  ),

                                  Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 15),
                                    height: BaseUtitiles.getheightofPercentage(context, 4),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),

                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        pendingListController.pendingList_datas.value[index].count.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: RequestConstant.Lable_Font_SIZE),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }

  Future<bool> homeScreen() async {
    if (loginController.user.value.userType == "A") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
    return false; // Prevent the default back navigation
  }
}

