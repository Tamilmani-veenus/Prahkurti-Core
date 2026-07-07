import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app_theme/app_colors.dart';
import '../../controller/pendinglistcontroller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';

class PunchVerifyApprovalScreen extends StatefulWidget {
  const PunchVerifyApprovalScreen({super.key,
    required this.id,
    required this.heading,
    required this.punchNo,
    required this.staffName,
    required this.inLocation,
    required this.inDate,
    required this.inTime,
    required this.outLocation,
    required this.outDate,
    required this.outTime,
    required this.todayTask,
    required this.tommTask,
    required this.remarks,
    required this.buttonValue,
    required this.inNAPRemarks,
    required this.outNAPRemarks,
    required this.onDutyRemarks,
    required this.type,
  });

  final  String id;
  final  String heading;
  final  String punchNo;
  final  String staffName;
  final  String inLocation;
  final  String inDate;
  final  String inTime;
  final  String outLocation;
  final  String outDate;
  final  String outTime;
  final  String todayTask;
  final  String tommTask;
  final  String remarks;
  final  String buttonValue;
  final  String inNAPRemarks;
  final  String outNAPRemarks;
  final  String onDutyRemarks;
  final  String type;

  @override
  State<PunchVerifyApprovalScreen> createState() => _PunchVerifyApprovalScreenState();
}

class _PunchVerifyApprovalScreenState extends State<PunchVerifyApprovalScreen> {
  PendingListController pendingListController = Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 10 ),
                  width: BaseUtitiles.getWidthtofPercentage(context, 27),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor),
                  alignment: Alignment.center,
                  child: Text(widget.buttonValue,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: RequestConstant.Lable_Font_SIZE,
                        color: Colors.white),
                  ),
                ),
                onTap: () async {
                  verifyAndApproveAlert(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 6),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.heading,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Punch No", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),)),
                          SizedBox(width: 10,),
                          Expanded(
                              flex: 2,
                              child: Text("Staff Name", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),)),

                        ],
                      ),
                        SizedBox(height: 5,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.punchNo,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "Punch No",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.qr_code, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.staffName,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: "Staff name",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.person_outline_sharp, color: Color(0xFF4B3FFF),size: 22,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle,color:  Theme.of(context).primaryColor,size: 10,),
                            Text("  Punch In", style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Punch in status", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child: Text("Project in location", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: "OnDuty",
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "PunchInStatus",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.arrow_circle_right_outlined, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.inLocation,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: "ProjectInLocation",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.location_pin, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Punch in date", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child: Text("Punch in time", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.inDate,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "PunchInDate",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.calendar_month_sharp, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.inTime,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: "PunchInTime",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.access_time_outlined, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if(widget.type=="NonAlloted")
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: BaseUtitiles.getheightofPercentage(context, 2),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text("Punch in NAP remarks", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                              ],
                            ),
                            SizedBox(
                              height: BaseUtitiles.getheightofPercentage(context, 1),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    maxLength: 5,
                                    initialValue: widget.inNAPRemarks,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                    decoration:  InputDecoration(
                                      counterText: "",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      contentPadding: EdgeInsets.zero,
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      labelText: "InNAPRemarks",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.App_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if(widget.type=="Onduty")
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: BaseUtitiles.getheightofPercentage(context, 2),
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text("Punch in Onduty remarks", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                                ],
                              ),
                              SizedBox(
                                height: BaseUtitiles.getheightofPercentage(context, 1),
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      maxLength: 5,
                                      initialValue: widget.onDutyRemarks,
                                      cursorColor: Colors.black,
                                      style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                      decoration:  InputDecoration(
                                        counterText: "",
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.zero,
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(10))),
                                        labelText: "InNAPRemarks",
                                        labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: RequestConstant.App_Font_SIZE),
                                        prefixIconConstraints:
                                        BoxConstraints(minWidth: 0, minHeight: 0),
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle,color:  Theme.of(context).primaryColor,size: 10,),
                            Text("  Punch Out", style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Punch out status", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child: Text("Project out location", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: "OnDuty",
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "PunchOutStatus",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.arrow_circle_left_outlined, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.outLocation,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: "ProjectOutLocation",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.location_pin, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Punch out date", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child: Text("Punch out time", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.outDate,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "PunchOutDate",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.calendar_month_sharp, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.outTime,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: "PunchOutTime",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.access_time_outlined, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Today Task", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                maxLength: 5,
                                initialValue: widget.todayTask,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "TodayTask",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Tomorrow Task", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                maxLength: 5,
                                initialValue: widget.tommTask,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "TomarrowTask",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                          ],
                        ),
                        SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                maxLength: 5,
                                initialValue: widget.remarks,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                decoration:  InputDecoration(
                                  counterText: "",
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "Remarks",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.App_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if(widget.type=="NonAlloted")Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: BaseUtitiles.getheightofPercentage(context, 2),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text("Punch out NAP remarks", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                              ],
                            ),
                            SizedBox(
                              height: BaseUtitiles.getheightofPercentage(context, 1),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    maxLength: 5,
                                    initialValue: widget.outNAPRemarks,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black,fontSize: RequestConstant.Dropdown_Font_SIZE),
                                    decoration:  InputDecoration(
                                      counterText: "",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      contentPadding: EdgeInsets.zero,
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      labelText: "InNAPRemarks",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.App_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: Icon( Icons.receipt_long, color: Color(0xFF4B3FFF),size: 20,)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future verifyAndApproveAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to ${widget.buttonValue}?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
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
                    child: TextButton(
                        onPressed: () async {
                          if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                            await pendingListController.punchInVerifyApprovalApi(widget.id,widget.buttonValue=="Verify"?true:false,context);
                          }
                        },
                        child: Text(widget.buttonValue,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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

