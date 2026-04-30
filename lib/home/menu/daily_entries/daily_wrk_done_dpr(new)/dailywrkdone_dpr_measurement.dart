import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';

class DailyWork_done_DPR_Measurement extends StatefulWidget {
  const DailyWork_done_DPR_Measurement({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_Measurement> createState() =>
      _DailyWork_done_DPR_MeasurementState();
}

class _DailyWork_done_DPR_MeasurementState
    extends State<DailyWork_done_DPR_Measurement> {
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller = Get.put(DailyWrkDone_DPRNEW_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());

  @override
  void initState() {
    dailyWrkDone_DPRNEW_Controller.entrycheck=1;
    dailyWrkDone_DPRNEW_Controller.saveId=0;
    dailyWrkDone_DPRNEW_Controller.saveButton.value=RequestConstant.SUBMIT;
    if(dailyWrkDone_DPRNEW_Controller.editcheck==1){
      dailyWrkDone_DPRNEW_Controller.ButtonChanges(dailyWrkDone_DPRNEW_Controller.dprNew_EditApiList[0].workId, dailyWrkDone_DPRNEW_Controller.aprovedButton);
    }
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
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DPR - NEW (Measurement)",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Description of work",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: ConstIcons.discription,
                            ),
                          ),
                          onChanged: (value) {

                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only( left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Nos",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.nos),
                                  ),
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Enter user name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only( left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Length",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.length),
                                  ),
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Enter user name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only( left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Breath",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.breath),
                                  ),
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Enter user name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only( left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Depth",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.depth),
                                  ),
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Enter user name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20 , right: 20, top:5),
                          width: BaseUtitiles.getWidthtofPercentage(context, 25),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: dailyWrkDone_DPRNEW_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                          ),
                          alignment: Alignment.center,
                          child: Text("ADD",  style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color:  dailyWrkDone_DPRNEW_Controller.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                        ),
                        onTap: () async {
                            dailyWrkDone_DPRNEW_Controller.checkColor = 0;

                            if (dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController.text == "" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_DepthController.text ==
                                    "" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_DepthController.text ==
                                    "0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_DepthController.text ==
                                    "0.0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_NosController.text ==
                                    "" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_NosController.text ==
                                    "0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_NosController.text ==
                                    "0.0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_LengthController.text ==
                                    "" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_LengthController.text ==
                                    "0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_LengthController.text ==
                                    "0.0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_BreathController.text ==
                                    "" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_BreathController.text ==
                                    "0" ||
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Measur_BreathController.text ==
                                    "0.0") {
                              BaseUtitiles.showToast("Some field is empty");
                            }
                            else if(dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value.isEmpty){
                              BaseUtitiles.showToast("Please select BOQ details");
                            }
                            else {
                              await dailyWrkDone_DPRNEW_Controller.dprNew_MesurmentTableSave();
                              await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                              dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController .text="";
                              dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController .text="";
                              dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController.text="";
                              dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController.text="";
                              dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController.text="";
                            }
                        },
                      ),
                    ],
                  ),

                  // Container(
                  //   height: BaseUtitiles.getheightofPercentage(context, 4),
                  //   margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //   decoration: BoxDecoration(),
                  //   child: TextField(
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         color: Theme.of(context).primaryColor,
                  //         fontWeight: FontWeight.bold),
                  //     controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController,
                  //     textAlign: TextAlign.justify,
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //       labelText: "Description of work",
                  //       border: OutlineInputBorder(),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Theme.of(context).primaryColor, width: 1.0),
                  //       ),
                  //     ),
                  //     onChanged: (value) {
                  //       //nmrWklyController.deduction_paymentCalculation();
                  //     },
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 5),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height:
                  //               BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Theme.of(context).primaryColor,
                  //                 fontWeight: FontWeight.bold),
                  //             controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController,
                  //             textAlign: TextAlign.center,
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Nos",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: Theme.of(context).primaryColor,
                  //                     width: 1.0),
                  //               ),
                  //             ),
                  //             onChanged: (value) {
                  //               //nmrWklyController.deduction_paymentCalculation();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height:
                  //               BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Theme.of(context).primaryColor,
                  //                 fontWeight: FontWeight.bold),
                  //             controller: dailyWrkDone_DPRNEW_Controller
                  //                 .dpr_new_Measur_LengthController,
                  //             textAlign: TextAlign.center,
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Length",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: Theme.of(context).primaryColor,
                  //                     width: 1.0),
                  //               ),
                  //             ),
                  //             onChanged: (value) {
                  //               //nmrWklyController.deduction_paymentCalculation();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height: BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Theme.of(context).primaryColor,
                  //                 fontWeight: FontWeight.bold),
                  //             controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController,
                  //             textAlign: TextAlign.center,
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Breath",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: Theme.of(context).primaryColor,
                  //                     width: 1.0),
                  //               ),
                  //             ),
                  //             onChanged: (value) {
                  //               //nmrWklyController.deduction_paymentCalculation();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height:
                  //               BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 color: Theme.of(context).primaryColor,
                  //                 fontWeight: FontWeight.bold),
                  //             controller: dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController,
                  //             textAlign: TextAlign.center,
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Depth",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: Theme.of(context).primaryColor,
                  //                     width: 1.0),
                  //               ),
                  //             ),
                  //             onChanged: (value) {
                  //               //nmrWklyController.deduction_paymentCalculation();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height: BaseUtitiles.getheightofPercentage(context, 5),
                  //   width: BaseUtitiles.getWidthtofPercentage(context,30),
                  //   margin: EdgeInsets.only(top: 25),
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: Theme.of(context).primaryColor,
                  //         side: BorderSide(width: 3, color: Colors.black),
                  //         elevation: 3,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(30)),
                  //       ),
                  //       child: Text("ADD"),
                  //       onPressed: () async {
                  //         if (dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController.text == "" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_DepthController.text ==
                  //                 "" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_DepthController.text ==
                  //                 "0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_DepthController.text ==
                  //                 "0.0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_NosController.text ==
                  //                 "" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_NosController.text ==
                  //                 "0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_NosController.text ==
                  //                 "0.0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_LengthController.text ==
                  //                 "" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_LengthController.text ==
                  //                 "0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_LengthController.text ==
                  //                 "0.0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_BreathController.text ==
                  //                 "" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_BreathController.text ==
                  //                 "0" ||
                  //             dailyWrkDone_DPRNEW_Controller
                  //                     .dpr_new_Measur_BreathController.text ==
                  //                 "0.0") {
                  //           BaseUtitiles.showToast("Some field is empty");
                  //         }
                  //         else if(dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value.isEmpty){
                  //           BaseUtitiles.showToast("Please select BOQ details");
                  //         }
                  //         else {
                  //           dailyWrkDone_DPRNEW_Controller.dprNew_MesurmentTableSave();
                  //           await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                  //          dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController .text="";
                  //          dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController .text="";
                  //          dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController.text="";
                  //          dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController.text="";
                  //          dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController.text="";
                  //         }
                  //       }),
                  // ),

                ],
              ),

              Obx(() => Visibility(
                  visible: dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.isEmpty ? false : true,
                  child: Listdetails())),
               ],
          )),

          bottomNavigationBar: Obx(()=> Visibility(
            visible: dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.isEmpty ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: BaseUtitiles.getheightofPercentage(context, 6),
                  width: BaseUtitiles.getWidthtofPercentage(context, 40),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child:   InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20 , right: 20, top: 15),
                      // width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      // height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: dailyWrkDone_DPRNEW_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        dailyWrkDone_DPRNEW_Controller.saveButton.value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                            color:  dailyWrkDone_DPRNEW_Controller.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                    ),
                    onTap: () async {
                      dailyWrkDone_DPRNEW_Controller.checkColor = 0;
                      SubmitAlert(context);
                    },
                  ),
                ),

              ],
            ),
          )),

        ),
      ),
    );
  }

  Widget Listdetails() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5,top: 10),
      height: BaseUtitiles.getheightofPercentage(context, 52),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.length,
        itemBuilder: (BuildContext context, int index) {
          dailyWrkDone_DPRNEW_Controller.textMSRTextInitiate();
          return Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value[index].Name.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 2),
                          width: BaseUtitiles.getWidthtofPercentage(context, 8),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:
                                      const Text(RequestConstant.DO_YOU_WANT_DELETE),
                                  actions: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
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
                                                  onPressed: ()  {
                                                    setState(() {
                                                      dailyWrkDone_DPRNEW_Controller.deleteByIdMSRTable(dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value[index]);
                                                      dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.removeAt(index);
                                                      dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: const Text("Delete",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.red,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          RequestConstant
                                                              .Lable_Font_SIZE))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: ConstIcons.cancle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "Nos",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: (){
                                  dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListNosController[index].text = "";
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                },
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListNosController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                }),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Length",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: (){
                                  dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListLengthController[index].text = "";
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                },
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListLengthController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                }),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only( left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "Breath",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: () {
                                  dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListBreathController[index].text = "";
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                },
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListBreathController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                }),
                          )),
                      const Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Depth",
                            style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                                onTap: (){
                                  dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListDepthController[index].text = "";
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                },
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListDepthController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {
                                  dailyWrkDone_DPRNEW_Controller.MSRclickChanged();
                                }),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only( left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 2,
                        child: Text(
                          "Qty",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 9,
                          child: SizedBox(
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextField(
                              readOnly: true,
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_MeasurListQtyController[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                onChanged: (value) {}),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    dailyWrkDone_DPRNEW_Controller.buttonControl=0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(dailyWrkDone_DPRNEW_Controller.aprovedButton == 1 ? 'Are you sure to Approval?' :
        dailyWrkDone_DPRNEW_Controller.editcheck == 1 ? 'Are you sure to Re-Submit?' : 'Are you sure to Submit?' ),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         if(dailyWrkDone_DPRNEW_Controller.buttonControl==0){
                  //           await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                  //           dailyWrkDone_DPRNEW_Controller. addMessListQty();
                  //           if(dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty!=0){
                  //             if(dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty!<=dailyWrkDone_DPRNEW_Controller.AddQty){
                  //               BaseUtitiles.showToast("Your Qty value is greater than BalQty  ${dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty!}");
                  //               Navigator.pop(context);
                  //             }
                  //             else if(projectController.selectedProjectId.value==0 ||siteController.selectedsiteId.value==0 || dailyWrkDone_DPR_Controller.TypeSubcontId.value==0){
                  //               BaseUtitiles.showToast("Please check EntryScreen some filed is missing");
                  //             } else if(dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.isEmpty){
                  //               BaseUtitiles.showToast("Please Add Measurements");
                  //             }
                  //             else{
                  //               // BaseUtitiles.showLoadingDialog(context,Theme.of(context).primaryColor);
                  //               await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                  //               await dailyWrkDone_DPRNEW_Controller.getDetTablesDatas();
                  //               await dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                  //               await dailyWrkDone_DPRNEW_Controller.getMaterialTablesDatas();
                  //               await  dailyWrkDone_DPRNEW_Controller.SaveButton_dprNew_MSR_SaveAPI(context,dailyWrkDone_DPRNEW_Controller.saveId);
                  //             }
                  //         } else if(dailyWrkDone_DPRNEW_Controller.buttonControl == 1){
                  //             dailyWrkDone_DPRNEW_Controller.buttonControl = 0;
                  //             BaseUtitiles.showToast("Please wait... processing.");
                  //           }
                  //
                  //
                  //         }
                  //       },
                  //       child: Text(dailyWrkDone_DPRNEW_Controller.aprovedButton == 1 ? RequestConstant.APPROVAL :
                  //       dailyWrkDone_DPRNEW_Controller.editcheck == 1 ? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
                  //           style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  // ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {

                          await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                          dailyWrkDone_DPRNEW_Controller.addMessListQty();

                          if (dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty != 0) {
                            if (dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty! <= dailyWrkDone_DPRNEW_Controller.AddQty) {
                              BaseUtitiles.showToast(
                                  "Your Qty value is greater than BalQty  ${dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value[0].balQty!}");
                              Navigator.pop(context);
                            } else if (projectController.selectedProjectId.value == 0 ||
                                siteController.selectedsiteId.value == 0 ||
                                dailyWrkDone_DPR_Controller.TypeSubcontId.value == 0) {
                              BaseUtitiles.showToast("Please check EntryScreen, some fields are missing");
                            } else if (dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.isEmpty) {
                              BaseUtitiles.showToast("Please Add Measurements");
                            } else {
                              // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
                              await dailyWrkDone_DPRNEW_Controller.getMesurmentTablesDatas();
                              await dailyWrkDone_DPRNEW_Controller.getDetTablesDatas();
                              await dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                              await dailyWrkDone_DPRNEW_Controller.getMaterialTablesDatas();
                              if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                await dailyWrkDone_DPRNEW_Controller.SaveButton_dprNew_MSR_SaveAPI(
                                    context, dailyWrkDone_DPRNEW_Controller.saveId);
                              }
                            }
                          }
                        },
                        child: Text(
                          dailyWrkDone_DPRNEW_Controller.aprovedButton == 1
                              ? RequestConstant.APPROVAL
                              : dailyWrkDone_DPRNEW_Controller.editcheck == 1
                              ? RequestConstant.RESUBMIT
                              : RequestConstant.SUBMIT,
                          style: TextStyle(
                            color:  Theme.of(context).primaryColor, // Change color when disabled
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }

}
