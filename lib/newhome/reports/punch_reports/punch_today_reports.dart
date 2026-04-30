import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/punch_in_controller.dart';
import 'package:intl/intl.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/image_view.dart';


class PunchTodayReports extends GetView<PunchInController> {

  LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
    ScreenUtil.init(context);
    return controller.obx((state) => SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          color: Setmybackground,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.r, left: 8.r, right: 8.r, bottom: 8.r),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.todayDate,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Today Date",
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            onTap: () async {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.r, right: 16.r),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            side: const BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            await controller.todayPunchInController("Today Report",controller.todayDate.text);
                          },
                          child: const Text("Show"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loginController.user.value.userType=="A"? Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 8.r),
                child: Container(
                  // margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3,
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: controller.todayRpteditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 12),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 15),
                          child: ConstIcons.list_Search,
                        ),
                        hintText: "Search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        controller.filterSearchTodayReport(value);
                      },
                    ),
                  ),
                ),
              ):SizedBox(),
              Padding(
                padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 8.r),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  child: SizedBox(
                    height: 30.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.r, right: 8.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Staff name",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Align(
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       "Punch In",
                          //       style: TextStyle(
                          //         fontSize: 14.0,
                          //         color: Theme.of(context).primaryColor,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Align(
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       "Punch Out",
                          //       style: TextStyle(
                          //         fontSize: 14.0,
                          //         color: Theme.of(context).primaryColor,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(()=> ListView.builder(
                  itemCount: controller.filteredList?.length,
                  itemBuilder: (context, i) {
                    var employee = controller.filteredList?[i];
                    return  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor, // ✅ correct place
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),  // 🔥 increase for more curve
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (employee!.staffName != "" && employee!.staffName != "null")
                                      ? employee!.staffName!
                                      : "-",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...(employee.punchDetails != null && employee.punchDetails!.isNotEmpty
                                ? employee.punchDetails!.map((detail) {
                              bool isLastItem = detail == employee.punchDetails!.last;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.login, size: 16, color: Theme.of(context).primaryColor,),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text("In Details:", style:  TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor,)),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 50,
                                                          child: Text(
                                                            "In Time :",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 120,
                                                          child: Text(
                                                            '${detail.punchInTime != "" &&
                                                                detail.punchInTime != "null" ?
                                                            DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(detail.punchInTime!)):"-"}',
                                                            style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 50,
                                                          child: Text(
                                                            "In Project :  ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey,
                                                            ),
                                                          ),),
                                                        Container(
                                                          width: 120,
                                                          child: Text(
                                                            '${detail.inLocation != "" &&
                                                                detail.inLocation != "null" ?
                                                            detail.inLocation! :"-"}',

                                                            style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              if (!isLastItem) const Divider(),
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Container(height: height*0.2,width: width*0.2,
                                              child:Image.network(detail.inImageUrl!,fit: BoxFit.cover,),),
                                            onTap:(){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageViewPage(
                                                            imageUrl: detail.inImageUrl!,
                                                            netUrl: true,
                                                          )));},
                                          ),

                                        ]),
                                    const SizedBox(height: 5),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.logout, size: 16, color: Theme.of(context).primaryColor,),
                                                ),
                                                SizedBox(width: 5,),
                                                Text("Out Details :", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color:Theme.of(context).primaryColor,),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 70,
                                                        child: Text(
                                                          "Out Time :",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          '${detail.punchOutTime != null && detail.punchOutTime != "" && detail.punchOutTime != "null" ? DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(detail.punchOutTime!)):"-"}',                                                          style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 70,
                                                        child: Text(
                                                          "Out Project :",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 120,
                                                        child: Text(
                                                          '${detail.outLocation != null &&
                                                              detail.outLocation != "" &&
                                                              detail.outLocation != "null" ?
                                                          detail.outLocation! : "-" }',
                                                          style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        detail.outImageUrl != null &&
                                            detail.outImageUrl!.isNotEmpty &&
                                            detail.outImageUrl != "null"
                                            ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ImageViewPage(
                                                  imageUrl: detail.outImageUrl!,
                                                  netUrl: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: height * 0.2,
                                            width: width * 0.2,
                                            child: Image.network(
                                              detail.outImageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                            : Container(
                                          height: height * 0.2,
                                          width: width * 0.2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                                : [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: const Center(
                                  child: Text(
                                    "No details found",
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ]),

                          ],
                        ),
                      ),
                    );
                  },
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
