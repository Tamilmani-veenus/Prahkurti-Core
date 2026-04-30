import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/pendinglistcontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../models/onclick_pendinglist_model.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commonpopup/quoteapprove_alert.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/advance_reqvoucher_new_controller.dart';
import '../../controller/company_nmr_controller.dart';
import '../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../controller/dailywrk_done_dprnew_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/material_transreq_controller.dart';
import '../../controller/mrn_finalapproval_controller.dart';
import '../../controller/mrn_preapproval_controller.dart';
import '../../controller/mrn_request_indent_controller.dart';
import '../../controller/mrnrequest_preIndent_controller.dart';
import '../../controller/preapproval_controller.dart';
import '../../controller/requisitionslip_controller.dart';
import '../../controller/transfer_acknowledgment_pending_controller.dart';
import '../../controller/transferbw_site_controller.dart';
import '../../utilities/apiconstant.dart';
import '../menu/materials/inward/inward_poamendment.dart';

class OnclickPendingList extends StatefulWidget {
  OnclickPendingList(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<OnclickPendingList> createState() => _OnclickPendingListState();
}

class _OnclickPendingListState extends State<OnclickPendingList> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      widget.pendingListController.pendingmainlist.value.clear();
      widget.pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      widget.pendingListController.mainlist.value =
          widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await widget.pendingListController.getPendingList();
          return true;
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.heading.toString(),
                            style: const TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 40),
                                margin: EdgeInsets.only(
                                    top: 10, left: 15, bottom: 5),
                                child: TextField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    hintText: "search..",
                                    hintStyle: TextStyle(color: Colors.black),
                                    isDense: true,
                                    fillColor: Setmybackground,
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    // if (onSearch != null) onSearch!(searchcontroller.text);
                                  },
                                  textInputAction: TextInputAction.search,
                                  onChanged: (value) {
                                    setState(() {
                                      pendingListController.mainlist.value =
                                          BaseUtitiles
                                              .filterSearchResults_PendingList(
                                                  value,
                                                  pendingListController
                                                      .pendingmainlist);
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height:
                                BaseUtitiles.getheightofPercentage(context, 80),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: BouncingScrollPhysics(),
                                itemCount: widget
                                    .pendingListController.mainlist.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          right: 10.0,
                                          left: 10.0,
                                          bottom: 10.0),
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      widget
                                                          .pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .no
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 8, left: 10),
                                                    child: Text(""),
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        "Date",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        widget
                                                            .pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .date
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 10),
                                                    child: Text(""),
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        "Due Date",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        widget
                                                            .pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .dueDate
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 10),
                                                    child: Text(""),
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        "Project Name",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        widget
                                                            .pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .projectName
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              Divider(thickness: 1),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 10),
                                                    child: Text(""),
                                                  ),
                                                  Text(
                                                    "Prepared By       ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 7,
                                                      child: Text(
                                                        widget
                                                            .pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .preparedBy
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

// class MrnFinalApproval extends StatefulWidget {
//   MrnFinalApproval({Key? key,required this.onclickPendingListData, required this.heading}) : super(key: key);
//   List<OnClickListResult> onclickPendingListData;
//   String heading;
//   @override
//   State<MrnFinalApproval> createState() => _MrnFinalApprovalState();
// }
//
// class _MrnFinalApprovalState extends State<MrnFinalApproval> {
//
//
//   PendingListController pendingListController = Get.put(PendingListController());
//   TextEditingController editingController = TextEditingController();
//   late List<bool> _isChecked;
//
//
//   @override
//   void initState() {
//     setState(() {
//       pendingListController.pendingmainlist.value.clear();
//       pendingListController.pendingmainlist.value=widget.onclickPendingListData;
//       pendingListController.mainlist.value=widget.onclickPendingListData;
//     });
//
//     pendingListController.add_MrnFinalaprovalListvalue.value.clear();
//     _isChecked = List<bool>.filled(pendingListController.mainlist.value.length, false);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         await pendingListController.getPendingList();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text(widget.heading.toString()),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(left: 6,right: 6,top: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       pendingListController.mainlist.value=BaseUtitiles.filterSearchResultsStaffVouchers(value,pendingListController.pendingmainlist);
//                     });
//                   },
//                   controller: editingController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText: RequestConstant.SEARCH,
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                 ),
//               ),
//
//               Container(
//                 margin: EdgeInsets.all(6),
//                 height: BaseUtitiles.getheightofPercentage(context, 70),
//                 child: Obx(() =>  ListView.builder(
//                     itemCount: pendingListController.mainlist.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {},
//                         child: Container(
//                           margin: EdgeInsets.all(5),
//                           child: Card(
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children:<Widget> [
//                                       Text(pendingListController.mainlist.value[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                       InkWell(
//                                           onTap: (){
//                                             pendingListController.GetMrnFinalDetDetails("MRN FINAL APPROVAL",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);
//                                           },
//                                           child: Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,)),
//                                     ],
//                                   ),
//                                   Row(
//
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 8,
//                                           child: Text("Req Date")),
//                                       Expanded(
//                                           flex: 11,
//                                           child: Text(pendingListController.mainlist.value[index].date.toString())),
//                                       // Expanded(
//                                       //   flex: 1,
//                                       //   child: Checkbox(
//                                       //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                       //     value: _isChecked[index],
//                                       //     onChanged: (val) {
//                                       //       setState(() {
//                                       //         if(val==true){
//                                       //           _isChecked[index] = val!;
//                                       //           pendingListController.add_MrnFinalaprovalListvalue.value.add(pendingListController.mainlist.value[index]);
//                                       //         }
//                                       //         else{
//                                       //           _isChecked[index] = val!;
//                                       //           pendingListController.add_MrnFinalaprovalListvalue.value.remove(pendingListController.mainlist.value[index]);
//                                       //         }
//                                       //       },
//                                       //       );
//                                       //     },
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Due Date")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].dueDate.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Project Name")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].projectName.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 8,
//                                           child: Text("PreApp By")),
//                                       Expanded(
//                                           flex: 11,
//                                           child: Text(pendingListController.mainlist.value[index].preparedBy.toString())),
//
//                                       Expanded(
//                                         flex: 1,
//                                         child: Checkbox(
//                                           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                           value: _isChecked[index],
//                                           onChanged: (val) {
//                                             setState(() {
//                                               if(val==true){
//                                                 _isChecked[index] = val!;
//                                                 pendingListController.add_MrnFinalaprovalListvalue.value.add(pendingListController.mainlist.value[index]);
//                                               }
//                                               else{
//                                                 _isChecked[index] = val!;
//                                                 pendingListController.add_MrnFinalaprovalListvalue.value.remove(pendingListController.mainlist.value[index]);
//                                               }
//                                             },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top:15),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     side: BorderSide(width: 3, color: Colors.brown),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),),
//                   child: Text("Approve"),
//                   onPressed: () async{
//                     pendingListController.getMrnFinalAprovalDetList.value.clear();
//                     await pendingListController.MrnFinalAproval_buttonApi(context);
//                     await pendingListController.getPendingList();
//                   },
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// -----------Change new designs-------------

class WorkPreApproval extends StatefulWidget {
  WorkPreApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<WorkPreApproval> createState() => _WorkPreApprovalState();
}

class _WorkPreApprovalState extends State<WorkPreApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  // PreApprovalController preApprovalController =
  // Get.put(PreApprovalController());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 40),
                          margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              // await preApprovalController
                              //     .getPendingList_Alldatas(
                              //     pendingListController.mainlist.value[index]
                              //         .id!,
                              //     context);
                            },
                            child: Container(
                              // height: BaseUtitiles.getheightofPercentage(context, 16),
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerfication extends StatefulWidget {
  MrnVerfication(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List onclickPendingListData;
  String heading;

  @override
  State<MrnVerfication> createState() => _MrnVerficationState();
}

class _MrnVerficationState extends State<MrnVerfication> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.samplemainlist.value =
          widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: RequestConstant.ALERT_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller
                                  .delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller
                                  .Material_itemview_GetDbList.value
                                  .clear();
                              await mrn_request_controller
                                  .getPendingList_Alldatas(
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].reqOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 10),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 8, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Req Date",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 7,
                                      //         child: Text(
                                      //           pendingListController
                                      //               .mainlist.value[index].date
                                      //               .toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqdueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Request Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .requestType ==
                                                        "PO"
                                                    ? "General Items"
                                                    : "Asset Materials"
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      // Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Prepared By       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].createdName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .GetDetDetails(
                                                          "MRN VERIFICATION",
                                                          // "MRN VERIFICATION - CIVIL",
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .reqOrdNo
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .projectName
                                                              .toString(),
                                                          context);
                                                },
                                              )),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },

                                                  // onTap: () async {
                                                  //   pendingListController.checkColor = 1;
                                                  //
                                                  //   // Call deleteAlert and assign to a variable
                                                  //   bool shouldDelete = await deleteAlert(context, index) ?? false;
                                                  //   if (!shouldDelete) return; // Exit if delete is canceled or if result is null
                                                  //
                                                  //   // Continue with delete operation
                                                  //   await pendingListController.mrn_verification_delete(
                                                  //       context,widget.onclickPendingListData[index].id
                                                  //   );
                                                  //
                                                  //   await pendingListController.getPendingList();
                                                  //   if (pendingListController.mainlist.isEmpty) {
                                                  //     Navigator.pop(context); // Navigate back only if the list is empty
                                                  //   }
                                                  // }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].reqOrdNo.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await mrn_request_controller
                              .Material_EntryList_DeleteApi(
                                  pendingListController
                                      .mainlist.value[index].id);
                          if (result) {
                            pendingListController.mainlist.removeAt(index);
                            pendingListController.getPoAprovalDetList.clear();
                            pendingListController.update();
                            Navigator.pop(context);
                            if (pendingListController.mainlist.isEmpty) {
                              Navigator.pop(context);
                            }
                            await pendingListController.getPendingList();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete",
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
//
// class MrnApproval extends StatefulWidget {
//   MrnApproval(
//       {Key? key, required this.onclickPendingListData, required this.heading})
//       : super(key: key);
//   List<OnClickListResult> onclickPendingListData;
//   String heading;
//
//   @override
//   State<MrnApproval> createState() => _MrnApprovalState();
// }
//
// class _MrnApprovalState extends State<MrnApproval> {
//   TextEditingController editingController = TextEditingController();
//   PendingListController pendingListController =
//       Get.put(PendingListController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         backgroundColor: Setmybackground,
//         body: GestureDetector(
//           onTap: () {
//             FocusScopeNode currentFocus = FocusScope.of(context);
//             if (!currentFocus.hasPrimaryFocus &&
//                 currentFocus.focusedChild != null) {
//               FocusManager.instance.primaryFocus?.unfocus();
//             }
//           },
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 50),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       widget.heading.toString(),
//                       style: TextStyle(
//                           fontSize: RequestConstant.Heading_Font_SIZE,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: BaseUtitiles.getWidthtofPercentage(context, 40),
//                         margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
//                         child: TextField(
//                           cursorColor: Theme.of(context).primaryColor,
//                           controller: editingController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide.none,
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               color: Colors.black,
//                             ),
//                             hintText: "search..",
//                             hintStyle: TextStyle(color: Colors.black),
//                             isDense: true,
//                             fillColor: Setmybackground,
//                           ),
//                           onEditingComplete: () {
//                             FocusScope.of(context).unfocus();
//                             // if (onSearch != null) onSearch!(searchcontroller.text);
//                           },
//                           textInputAction: TextInputAction.search,
//                           onChanged: (value) {
//                             setState(() {
//                               pendingListController.mainlist.value =
//                                   BaseUtitiles.filterSearchResults_PendingList(
//                                       value,
//                                       pendingListController.pendingmainlist);
//                             });
//                           },
//                         ),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             "Back",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ))
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 6, right: 6),
//                   height: BaseUtitiles.getheightofPercentage(context, 80),
//                   child: Obx(() => ListView.builder(
//                       padding: EdgeInsets.zero,
//                       physics: BouncingScrollPhysics(),
//                       itemCount: widget.onclickPendingListData.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             BaseUtitiles.showToast("Access only in web");
//                           },
//                           child: Container(
//                             // height: BaseUtitiles.getheightofPercentage(context, 16),
//                             margin: EdgeInsets.only(left: 3, right: 3),
//                             child: Card(
//                               elevation: 5,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                               child: Container(
//                                 margin: EdgeInsets.all(3),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Container(
//                                           child: Text(
//                                             widget.onclickPendingListData[index]
//                                                 .no
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: <Widget>[
//                                         Container(
//                                           margin:
//                                               EdgeInsets.only(top: 8, left: 10),
//                                           child: Text(""),
//                                         ),
//                                         Expanded(
//                                             flex: 3,
//                                             child: Text(
//                                               "Date",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                         Expanded(
//                                             flex: 8,
//                                             child: Text(
//                                               widget
//                                                   .onclickPendingListData[index]
//                                                   .date
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                     SizedBox(height: 10),
//                                     Row(
//                                       children: <Widget>[
//                                         Container(
//                                           margin:
//                                               EdgeInsets.only(top: 5, left: 10),
//                                           child: Text(""),
//                                         ),
//                                         Expanded(
//                                             flex: 3,
//                                             child: Text(
//                                               "Due Date",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                         Expanded(
//                                             flex: 8,
//                                             child: Text(
//                                               widget
//                                                   .onclickPendingListData[index]
//                                                   .dueDate
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                     SizedBox(height: 10),
//                                     Row(
//                                       children: <Widget>[
//                                         Container(
//                                           margin:
//                                               EdgeInsets.only(top: 5, left: 10),
//                                           child: Text(""),
//                                         ),
//                                         Expanded(
//                                             flex: 3,
//                                             child: Text(
//                                               "Project Name",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                         Expanded(
//                                             flex: 8,
//                                             child: Text(
//                                               widget
//                                                   .onclickPendingListData[index]
//                                                   .projectName
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                     Divider(thickness: 1),
//                                     Row(
//                                       children: <Widget>[
//                                         Container(
//                                           margin:
//                                               EdgeInsets.only(top: 5, left: 10),
//                                           child: Text(""),
//                                         ),
//                                         Text(
//                                           "Prepared By       ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         Expanded(
//                                             flex: 7,
//                                             child: Text(
//                                               widget
//                                                   .onclickPendingListData[index]
//                                                   .preparedBy
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             )),
//                                         Expanded(
//                                             flex: 5,
//                                             child: InkWell(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Container(
//                                                       margin: EdgeInsets.only(
//                                                           left: 15),
//                                                       child: Text(
//                                                         "More",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Theme.of(
//                                                                     context)
//                                                                 .primaryColor),
//                                                       )),
//                                                   CircleAvatar(
//                                                     backgroundColor:
//                                                         Theme.of(context)
//                                                             .primaryColor,
//                                                     radius: 13,
//                                                     child: Icon(
//                                                       Icons.more_vert,
//                                                       color: Setmybackground,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               onTap: () {
//                                                 setState(() {
//                                                   pendingListController
//                                                       .PendingPoDetDetails(
//                                                           "PENDING PO",
//                                                           pendingListController
//                                                               .mainlist
//                                                               .value[index]
//                                                               .id!,
//                                                           pendingListController
//                                                               .mainlist
//                                                               .value[index]
//                                                               .no
//                                                               .toString(),
//                                                           pendingListController
//                                                               .mainlist
//                                                               .value[index]
//                                                               .projectName
//                                                               .toString(),
//                                                           context);
//                                                 });
//                                               },
//                                             )),
//                                         SizedBox(width: 5),
//                                       ],
//                                     ),
//                                     Divider(thickness: 1),
//                                     Container(
//                                       height:
//                                           BaseUtitiles.getheightofPercentage(
//                                               context, 4),
//                                       margin: EdgeInsets.symmetric(
//                                           vertical: 3, horizontal: 5),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           InkWell(
//                                             child: Container(
//                                               margin: EdgeInsets.only(
//                                                   left: 20, right: 20),
//                                               width: BaseUtitiles
//                                                   .getWidthtofPercentage(
//                                                       context, 20),
//                                               height: BaseUtitiles
//                                                   .getheightofPercentage(
//                                                       context, 4),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(10)),
//                                                 color: pendingListController
//                                                             .checkColor ==
//                                                         0
//                                                     ? Theme.of(context)
//                                                         .primaryColor
//                                                     : Colors.white,
//                                               ),
//                                               alignment: Alignment.center,
//                                               child: Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 1),
//                                                 child: Text(
//                                                   RequestConstant.DELETE,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: RequestConstant
//                                                         .Lable_Font_SIZE,
//                                                     color: pendingListController
//                                                                 .checkColor ==
//                                                             0
//                                                         ? Colors.white
//                                                         : Theme.of(context)
//                                                             .primaryColor,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             onTap: () async {
//                                               pendingListController.checkColor =
//                                                   1;
//                                               await deleteAlert(context, index);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       })),
//                 ),
//                 SizedBox(height: 20)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future deleteAlert(BuildContext context, int index) async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Alert!'),
//         content: const Text('Do you want to Delete?'),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20),
//             child: IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Cancel",
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: RequestConstant.Lable_Font_SIZE))),
//                   ),
//                   VerticalDivider(
//                     color: Colors.grey.shade400,
//                     width: 5,
//                     thickness: 2,
//                     indent: 15,
//                     endIndent: 15,
//                   ),
//                   Expanded(
//                     child: TextButton(
//                         onPressed: () async {
//                           await pendingListController.mrn_verification_delete(
//                               context,
//                               pendingListController.mainlist.value[index].id!);
//                           pendingListController.mainlist.removeAt(index);
//                           pendingListController.getPoAprovalDetList.clear();
//                           pendingListController.update();
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Delete",
//                             style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: RequestConstant.Lable_Font_SIZE))),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// ----- MRN PRE APPROVAL-GM -----

class MrnPreApproval extends StatefulWidget {
  MrnPreApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<MrnPreApproval> createState() => _MrnPreApprovalState();
}

class _MrnPreApprovalState extends State<MrnPreApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  MrnPreApprovalController mrnPreApprovalController =
      Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await mrn_request_controller.getCheckApprovalLevel();
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
      pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrnPreApprovalController.reqId =
                                  pendingListController
                                      .mainlist.value[index].id!;
                              pendingListController.mrnPreapprovallist.value
                                  .add(pendingListController
                                      .mainlist.value[index]);
                              await mrnPreApprovalController
                                  .deleteMaterialApprvalTable();
                              mrnPreApprovalController
                                  .MaterialAppr_itemview_GetDbList.value
                                  .clear();
                              mrnPreApprovalController.mrnPreAppDetList.value
                                  .clear();
                              await mrnPreApprovalController
                                  .mrnPreapprovalDetListApi(
                                      widget.heading,
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 3,
                                right: 3,
                              ),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].reqOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 10),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 8, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Req Date",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           pendingListController
                                      //               .mainlist.value[index].date
                                      //               .toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqdueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .requestType
                                                            .toString() ==
                                                        "PO"
                                                    ? "General Items"
                                                    : "Asset Materials",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      if (mrn_request_controller
                                              .checkApprovalLevelData
                                              .isNotEmpty &&
                                          (mrn_request_controller
                                                      .checkApprovalLevelData[0]
                                                  ["isVerification"] ??
                                              false))
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Verified By        ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].verifyName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .GetDetDetails(
                                                          "MRN PRE APPROVAL",
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .reqOrdNo
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .projectName
                                                              .toString(),
                                                          context);
                                                },
                                              )),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].reqOrdNo.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await mrn_request_controller
                              .Material_EntryList_DeleteApi(
                                  pendingListController
                                      .mainlist.value[index].id);
                          if (result) {
                            pendingListController.mainlist.removeAt(index);
                            pendingListController.getPoAprovalDetList.clear();
                            pendingListController.update();
                            Navigator.pop(context);
                            if (pendingListController.mainlist.isEmpty) {
                              Navigator.pop(context);
                            }
                            await pendingListController.getPendingList();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete",
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

/// ----- MRN PRE Approval -Am -----

class MrnPreApproval_AM extends StatefulWidget {
  MrnPreApproval_AM(
      {Key? key, required this.onclickPendingListData, required this.heading});

  List<OnClickListResult> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<MrnPreApproval_AM> createState() => _MrnPreApproval_AMState();
}

class _MrnPreApproval_AMState extends State<MrnPreApproval_AM> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  MrnPreApprovalController mrnPreApprovalController =
      Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
      pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              // BaseUtitiles.showToast("Access only in web");
                              pendingListController.mrnPreapprovallist.value
                                  .clear();
                              mrnPreApprovalController.reqId = 0;
                              mrnPreApprovalController.reqId =
                                  pendingListController
                                      .mainlist.value[index].id!;
                              pendingListController.mrnPreapprovallist.value
                                  .add(pendingListController
                                      .mainlist.value[index]);
                              await pendingListController
                                  .Mrn_PreApproval_AutoYearWise();
                              await mrnPreApprovalController
                                  .deleteMaterialApprvalTable();
                              mrnPreApprovalController
                                  .MaterialAppr_itemview_GetDbList.value
                                  .clear();
                              mrnPreApprovalController.mrnPreAppDetList.value
                                  .clear();
                              await mrnPreApprovalController
                                  .mrnPreapprovalDetListApi(
                                      widget.heading,
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 8, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Req Date",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           pendingListController
                                      //               .mainlist.value[index].date
                                      //               .toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].purchaseType
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      //Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Verified By         ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .GetDetDetails(
                                                          "MRN PRE APPROVAL-AM",
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .no
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .projectName
                                                              .toString(),
                                                          context);
                                                },
                                              )),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    // decoration: BoxDecoration(
                                                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    //   // Change the background color to red
                                                    //   color: pendingListController.checkColor == 0
                                                    //       ? Colors.red
                                                    //       : Colors.white,
                                                    // ),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].no.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await pendingListController.mrn_preapprovial_delete(
                              context,
                              pendingListController.mainlist.value[index].id!);
                          pendingListController.mainlist.removeAt(index);
                          pendingListController.getPoAprovalDetList.clear();
                          pendingListController.update();
                          Navigator.pop(context);
                          if (pendingListController.mainlist.isEmpty) {
                            Navigator.pop(context);
                          }
                          await pendingListController.getPendingList();
                        },
                        child: const Text("Delete",
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

class MrnFinalApproval extends StatefulWidget {
  MrnFinalApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<MrnFinalApproval> createState() => _MrnFinalApprovalState();
}

class _MrnFinalApprovalState extends State<MrnFinalApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  MrnFinalApprovalController mrnFinalApprovalController =
      Get.put(MrnFinalApprovalController());
  MrnPreApprovalController mrnPreApprovalController =
      Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await mrn_request_controller.getCheckApprovalLevel();
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
      pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: const TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrnFinalApprovalController.reqId =
                                  pendingListController
                                      .mainlist.value[index].id!;
                              pendingListController.mrnfinalapprovallist.value
                                  .add(pendingListController
                                      .mainlist.value[index]);
                              await mrnFinalApprovalController
                                  .deleteMaterial_FinalApprvalTable();
                              mrnFinalApprovalController
                                  .MaterialFinalAppr_itemview_GetDbList.value
                                  .clear();
                              await mrnFinalApprovalController
                                  .mrnFinalapprovalDetListApi(
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].reqOrdNo,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(height: 10),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:const EdgeInsets.only(top: 8, left: 10),
                                      //       child:const Text(" "),
                                      //     ),
                                      //     const Expanded(
                                      //         flex: 5,
                                      //         child: Text(
                                      //           "Req Date    ",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 10,
                                      //         child: Text(
                                      //           pendingListController
                                      //               .mainlist.value[index].date
                                      //               .toString(),
                                      //           style:const TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(" "),
                                          ),
                                          const Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Due Date    ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 10,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqdueDate
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(" "),
                                          ),
                                          const Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 10,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(" "),
                                          ),
                                          const Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Req Type ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 10,
                                              child: Text(
                                                pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .requestType ==
                                                        "PO"
                                                    ? "General Items"
                                                    : "Asset Materials"
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // const Divider(thickness: 1),
                                      if (mrn_request_controller
                                              .checkApprovalLevelData
                                              .isNotEmpty &&
                                          (mrn_request_controller
                                                      .checkApprovalLevelData[0]
                                                  ["isPreApproval"] ??
                                              false))
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: const Text(""),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: const Text(
                                                " PreApprovedBy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 10,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .preApprovedName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      "More details",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )),
                                              ],
                                            ),
                                            onTap: () {
                                              pendingListController
                                                  .GetDetDetails(
                                                      "MRN FINAL APPROVAL",
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .id!,
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .reqOrdNo
                                                          .toString(),
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .projectName
                                                          .toString(),
                                                      context);
                                            },
                                          ),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].reqOrdNo.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await mrn_request_controller
                              .Material_EntryList_DeleteApi(
                                  pendingListController
                                      .mainlist.value[index].id);
                          if (result) {
                            pendingListController.mainlist.removeAt(index);
                            pendingListController.getPoAprovalDetList.clear();
                            pendingListController.update();
                            Navigator.pop(context);
                            if (pendingListController.mainlist.isEmpty) {
                              Navigator.pop(context);
                            }
                            await pendingListController.getPendingList();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete",
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

class SiteRequestVerification extends StatefulWidget {
  SiteRequestVerification(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<SiteRequestVerification> createState() =>
      _SiteRequestVerificationState();
}

class _SiteRequestVerificationState extends State<SiteRequestVerification> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller =
      Get.put(MRNRequest_PreIndent_Controller());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only( left: 10, right: 10 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 70),
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrnRequest_PreIndent_Controller
                                  .delete_MaterialIntent_itemlist_Table();
                              mrnRequest_PreIndent_Controller
                                  .Material_itemview_GetDbList.value
                                  .clear();
                              await mrnRequest_PreIndent_Controller
                                  .getPendingList_Alldatas(
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context,
                                      widget.heading ==
                                              "SITE REQUEST VERIFICATION"
                                          ? "Verify"
                                          : "Approve");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].reqOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqOrdDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqdueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Purchase \nType",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .requestType ==
                                                        "PO"
                                                    ? "General Items"
                                                    : "Asset Materials"
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "Prepared by",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].createdName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                      widget.heading ==
                                                              "SITE REQUEST VERIFICATION"
                                                          ? "SITE REQUEST VERIFICATION"
                                                          : "SITE REQUEST APPROVAL",
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .id!,
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .reqOrdNo
                                                          .toString(),
                                                      pendingListController
                                                          .mainlist
                                                          .value[index]
                                                          .projectName,
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// STORE TRANSFER PENDING

class StoreTransferPending extends StatefulWidget {
  StoreTransferPending({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<StoreTransferPending> createState() => _StoreTransferPendingState();
}

class _StoreTransferPendingState extends State<StoreTransferPending> {

  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  TransferBt_Site_Controller transferBt_Site_Controller = Get.put(TransferBt_Site_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.samplemainlist.value =
          widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: BaseUtitiles.getWidthtofPercentage(context, 40),
                      margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: editingController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search..",
                          hintStyle: TextStyle(color: Colors.black),
                          isDense: true,
                          fillColor: Setmybackground,
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          // if (onSearch != null) onSearch!(searchcontroller.text);
                        },
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          setState(() {
                            pendingListController.mainlist.value =
                                BaseUtitiles.filterSearchResults_PendingList(
                                    value,
                                    pendingListController.pendingmainlist);
                          });
                        },
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
              ),
              Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                height: BaseUtitiles.getheightofPercentage(context, 88),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: pendingListController.mainlist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          transferBt_Site_Controller.ItemGetTableListdata.clear();
                          transferBt_Site_Controller.itemlistTable_Delete();
                          print("SSSSSSSSSSSSSS");
                          transferBt_Site_Controller.getStoreTransPendingView(pendingListController.mainlist[index].ReqOrdMasId,0, context);
                        },
                        child: Container(
                          // height: BaseUtitiles.getheightofPercentage(context, 16),
                          margin: EdgeInsets.only(left: 3, right: 3),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Text(
                                          pendingListController.mainlist[index].ReqOrdNo.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 8, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            pendingListController.mainlist[index].ReqOrdDate
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Due Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            pendingListController.mainlist[index]
                                                .ReqDueDate
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Project Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            pendingListController.mainlist[index]
                                                .ProjectName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Site Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            pendingListController.mainlist[index]
                                                .SiteName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Divider(thickness: 1),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Text(
                                        "Prepared By       ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 7,
                                          child: Text(
                                            pendingListController.mainlist[index]
                                                .CreatedName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 5,
                                          child: InkWell(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      "More",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColor),
                                                    )),
                                                CircleAvatar(
                                                  backgroundColor:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  radius: 13,
                                                  child: Icon(
                                                    Icons.more_vert,
                                                    color: Setmybackground,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {
                                                pendingListController.PendingPoDetDetails(
                                                    "STORE TRANSFER PENDING",
                                                    pendingListController.mainlist.value[index].ReqOrdMasId!,
                                                    pendingListController.mainlist.value[index].ReqOrdNo.toString(),
                                                    pendingListController.mainlist.value[index].ProjectName.toString(),
                                                    context);
                                              });
                                            },
                                          )),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

///----------Direct Transfer Verify And Approve-----------

class DirectTransferVerifyApprove extends StatefulWidget {
  DirectTransferVerifyApprove(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<DirectTransferVerifyApprove> createState() =>
      _DirectTransferVerifyApproveState();
}

class _DirectTransferVerifyApproveState
    extends State<DirectTransferVerifyApprove> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  MaterialTransferReqController materialTransferReqController =
      Get.put(MaterialTransferReqController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });

    // pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    // _isChecked = List<bool>.filled(pendingListController.mainlist.value.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: const TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              materialTransferReqController
                                  .itemlistTable_Delete();
                              materialTransferReqController
                                  .ItemGetTableListdata.value = [];
                              materialTransferReqController
                                  .saveButton.value = widget.heading ==
                                      "TRANSFER REQUEST VERIFICATION PENDING"
                                  ? RequestConstant.VERIFY
                                  : RequestConstant.APPROVAL;
                              await materialTransferReqController
                                  .matTransReqEdit(
                                      pendingListController
                                          .mainlist.value[index].id,
                                      context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .transEntryDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].TransferNo,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .fromProjectName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].ToProjectName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Visibility(
                                        visible: widget.heading ==
                                            "TRANSFER REQUEST APPROVAL PENDING",
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: const Text(""),
                                            ),
                                            const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "VerifiedBy",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].verifiedBy
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible: widget.heading ==
                                              "TRANSFER REQUEST APPROVAL PENDING",
                                          child: SizedBox(height: 10)),
                                      // const Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Text(
                                            "PreparedBy       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].createdName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .GetDirectTransVerifyApproveDet(
                                                          widget.heading
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .TransferNo
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .fromProjectName
                                                              .toString(),
                                                          context);
                                                },
                                              )),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    alignment: Alignment.center,
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].TransferNo
                    .toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await pendingListController
                              .TransferReq_Verify_DeleteApi(
                                  widget.heading,
                                  pendingListController
                                      .mainlist.value[index].id!);
                          pendingListController.mainlist.removeAt(index);
                          pendingListController.getPoAprovalDetList.clear();
                          pendingListController.update();
                          Navigator.pop(context);
                          if (pendingListController.mainlist.isEmpty) {
                            Navigator.pop(context);
                          }
                          await pendingListController.getPendingList();
                        },
                        child: const Text("Delete",
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

class PendingPO extends StatefulWidget {
  PendingPO(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<PendingPO> createState() => _PendingPOState();
}

class _PendingPOState extends State<PendingPO> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());

  @override
  void initState() {
    setState(() {
      widget.pendingListController.pendingmainlist.value.clear();
      widget.pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      widget.pendingListController.mainlist.value =
          widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await widget.pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.ALERT_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 40),
                          margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              BaseUtitiles.showToast(
                                  "PO Generation Only in Website");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              widget
                                                  .pendingListController
                                                  .mainlist
                                                  .value[index]
                                                  .ReqOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .ReqOrdDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .ReqDueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .ProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "ApprovedBy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .approveName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .CreatedName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController
                                                        .PendingPoDetDetails(
                                                            "PENDING PO",
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .id!,
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .ReqOrdNo
                                                                .toString(),
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .ProjectName
                                                                .toString(),
                                                            context);
                                                  });
                                                  // pendingListController.GetDetDetails("MRN VERIFICATION",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InwardPending extends StatefulWidget {
  InwardPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<InwardPending> createState() => _InwardPendingState();
}

class _InwardPendingState extends State<InwardPending> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  InwardPending_Controller inwardPending_Controller =
      Get.put(InwardPending_Controller());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only( left: 10, right: 10 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 70),
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              inwardPending_Controller.itemlistTable_Delete();
                              inwardPending_Controller
                                  .ItemGetTableListdata.value
                                  .clear();
                              await inwardPending_Controller.getInward_Alldatas(
                                  pendingListController
                                      .mainlist.value[index].id!,
                                  context);
                              await inwardPending_Controller
                                  .inwardpending_itemlist_SaveTable();
                              await inwardPending_Controller
                                  .getItemlistTablesDatas();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].purchaseOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .PurchaseOrdDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].ProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].SiteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "PreparedBy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedby
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "Delay Days",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].delaydays
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            // margin: EdgeInsets.only(top: 15, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Inward_PoAmendment(
                                                            heading:
                                                                "INWARD PENDING",
                                                            ReqNo: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .purchaseOrdNo
                                                                .toString(),
                                                            PoDate: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .PurchaseOrdDate
                                                                .toString(),
                                                            ProjectName: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .ProjectName
                                                                .toString(),
                                                            SiteName: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .SiteName
                                                                .toString(),
                                                            SupplierName: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .supplierName
                                                                .toString(),
                                                            purOrdMasId:
                                                                pendingListController.mainlist.value[index].id,
                                                            projectId: pendingListController.mainlist.value[index].ProjectID!,
                                                            siteId: pendingListController.mainlist.value[index].SiteID!,
                                                            inwdType: pendingListController.mainlist.value[index].inwType!)));
                                                await inwardPending_Controller
                                                    .getPo_AmendmentList(
                                                        context,
                                                        pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .id);
                                              },
                                              child: Container(
                                                  width: BaseUtitiles
                                                      .getWidthtofPercentage(
                                                          context, 13),
                                                  child: const Text(
                                                    "PO AMD",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            RequestConstant
                                                                .App_Font_SIZE),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .PendingPoDetDetails(
                                                          "INWARD PENDING",
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .PurchaseOrdNo
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .ProjectName,
                                                          context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubContractorAttandance extends StatefulWidget {
  SubContractorAttandance(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<SubContractorAttandance> createState() =>
      _SubContractorAttandanceState();
}

class _SubContractorAttandanceState extends State<SubContractorAttandance> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    pendingListController.mainlist.value = widget.onclickPendingListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 10),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                isDense: true,
                                fillColor: Setmybackground,
                                // fillColor: Colors.white,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              dailyEntriesController.saveButton.value =
                                  RequestConstant.APPROVAL;
                              dailyEntriesController
                                  .getAttendanceDetailsDto()
                                  .clear();
                              dailyEntriesController
                                  .deleteSubcontDetTableDatas();
                              dailyEntriesController.readListdata.value = [];
                              dailyEntriesController.subContEntryList_EditApi(
                                  pendingListController.mainlist[index].id!,
                                  context,
                                  1);
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .labourAttendanceDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist
                                                  .value[index]
                                                  .labourAttendanceNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].ProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 2, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site Name ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].SiteName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 2, left: 10),
                                            child: const Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "SubCont ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .subcontractName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Labours",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                "${pendingListController.mainlist.value[index].totNos} Nos",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "₹ ${pendingListController.mainlist.value[index].totAmt}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      // const SizedBox(height: 5),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       margin: const EdgeInsets.only(top: 2, left: 10),
                                      //       child: const Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Shift Type",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           pendingListController.mainlist.value[index].workshift.toString(),
                                      //           style: const TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 2, left: 10),
                                            child: const Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Work Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                // pendingListController.mainlist.value[index].type.toString() == 'NMR'
                                                //   ? 'Claimable NMR'
                                                //   : pendingListController.mainlist.value[index].type.toString() == 'NO-WORK'
                                                //   ? 'No Work'
                                                //   : pendingListController.mainlist.value[index].type.toString()=='RATE'?'Daily attendance':
                                                pendingListController
                                                    .mainlist.value[index].type
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Prepared By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].prepareby
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            child: Icon(
                                              Icons.arrow_circle_right_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubContDPRApproval extends StatefulWidget {
  SubContDPRApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<SubContDPRApproval> createState() => _SubContDPRApprovalState();
}

class _SubContDPRApprovalState extends State<SubContDPRApproval> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller =
      Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
      Get.put(DailyWrkDone_DPRNEW_Controller());
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          // "Subcontractor DPR Approval",
                          widget.heading.toString(),
                          style: TextStyle(
                              // fontSize: RequestConstant.Heading_Font_SIZE,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 10),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                isDense: true,
                                fillColor: Setmybackground,
                                // fillColor: Colors.white,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (pendingListController
                                      .mainlist.value[index].DprType ==
                                  1) {
                                dailyWrkDone_DPR_Controller
                                    .dpr_EditListApiValue.value
                                    .clear();
                                dailyWrkDone_DPR_Controller.screenchek.value =
                                    1;
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPR_Controller
                                    .DprEntryList_EditApi(
                                        pendingListController
                                            .mainlist.value[index].id!,
                                        context,
                                        1);
                              } else if (pendingListController
                                      .mainlist.value[index].DprType ==
                                  2) {
                                dailyWrkDone_DPRNEW_Controller
                                    .dprNew_EditApiList.value
                                    .clear();
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPRNEW_Controller
                                    .Dpr_New_EntryList_EditApi(
                                        pendingListController
                                            .mainlist.value[index].id!,
                                        context,
                                        1);
                              } else if (pendingListController
                                      .mainlist.value[index].DprType ==
                                  3) {
                                dailyWrkDone_DPRLabour_Controller
                                    .dpr_EditListApiValue.value
                                    .clear();
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPRLabour_Controller
                                    .DprLabourEntryList_EditApi(
                                        pendingListController
                                            .mainlist.value[index].id!,
                                        context,
                                        1);
                              } else {}
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Subcontractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .subContractorName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Work Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].type
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Prepared By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SubContNMRBillApproval extends StatefulWidget {
//   SubContNMRBillApproval({Key? key,required this.onclickPendingListData, required this.heading}) : super(key: key);
//   List<OnClickListResult> onclickPendingListData;
//   PendingListController pendingListController=Get.put(PendingListController());
//   String heading;
//   @override
//   State<SubContNMRBillApproval> createState() => _SubContNMRBillApprovalState();
// }
//
// class _SubContNMRBillApprovalState extends State<SubContNMRBillApproval> {
//   PendingListController pendingListController=Get.put(PendingListController());
//
//   late List<bool> _isChecked;
//   TextEditingController editingController = TextEditingController();
//   @override
//   void initState() {
//     pendingListController.addSubcontNmrListvalue.value.clear();
//     _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         pendingListController.getPendingList();
//         return true ;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text(widget.heading.toString()),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.all(6),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: 10),
//                   height: BaseUtitiles.getheightofPercentage(context, 5),
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {});
//                     },
//                     controller: editingController,
//                     decoration: InputDecoration(
//                         labelText: RequestConstant.SEARCH,
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                   ),
//                 ),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,70),
//                   child: ListView.builder(
//                       itemCount: widget.onclickPendingListData.length,
//                       itemBuilder: (context, index) {
//                         if(editingController.text.isEmpty){
//                           return InkWell(
//                             onTap: () {
//
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Card(
//                                 child: Container(
//                                   margin: EdgeInsets.all(5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children:<Widget> [
//                                           Text(widget.onclickPendingListData[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].date.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Project Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].projectName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Subcontractor Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].subContractorName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("From Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].fromDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("To Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].toDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Manual BillNo")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].billno.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Net Amount")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),style: TextStyle(color: Colors.red))),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 5,
//                                               child: Text("Verified By")),
//                                           Expanded(
//                                               flex: 6,
//                                               child: Text(widget.onclickPendingListData[index].preparedBy.toString(),style: TextStyle(color: Colors.blue),)),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Checkbox(
//                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                               value: _isChecked[index],
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   if(val==true){
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.add(widget.onclickPendingListData[index]);
//                                                   }
//                                                   else{
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.remove(widget.onclickPendingListData[index]);
//                                                   }
//                                                 },
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         else if(widget.onclickPendingListData[index].projectName.toString().toLowerCase().contains(editingController.text)||widget.onclickPendingListData[index].projectName.toString().toUpperCase().contains(editingController.text)){
//                           return InkWell(
//                             onTap: () {
//
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Card(
//                                 child: Container(
//                                   margin: EdgeInsets.all(5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children:<Widget> [
//                                           Text(widget.onclickPendingListData[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                           //Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].date.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Project Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].projectName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Subcontractor Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].subContractorName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("From Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].fromDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("To Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].toDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Manual BillNo")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].billno.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Net Amount")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),style: TextStyle(color: Colors.red))),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 5,
//                                               child: Text("Verified By")),
//                                           Expanded(
//                                               flex: 6,
//                                               child: Text(widget.onclickPendingListData[index].preparedBy.toString(),style: TextStyle(color: Colors.blue),)),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Checkbox(
//                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                               value: _isChecked[index],
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   if(val==true){
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.add(widget.onclickPendingListData[index]);
//                                                   }
//                                                   else{
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.remove(widget.onclickPendingListData[index]);
//                                                   }
//                                                 },
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         else{
//                           return Container();
//                         }
//
//                       }),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top:15),
//                   height: BaseUtitiles.getheightofPercentage(context, 5),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       side: BorderSide(width: 3, color: Colors.brown),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),),
//                     child: Text("Approval"),
//                     onPressed: () async{
//                       pendingListController.getNMRAprovalDetList.value.clear();
//                       pendingListController.subcontNmrAproval_buttonApi(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PoVerification extends StatefulWidget {
  PoVerification(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<PoVerification> createState() => _PoVerificationState();
}

class _PoVerificationState extends State<PoVerification> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: BaseUtitiles.getWidthtofPercentage(context, 20),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      RequestConstant.VERIFY,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  if (pendingListController
                          .add_PoaprovalListvalue.value.length !=
                      0) {
                    pendingListController.checkColor = 1;
                    pendingListController.getPoAprovalDetList.value = [];
                    await pendingListController.poAproval_buttonApi(
                        context, widget.heading.toString());
                    Navigator.pop(context);
                    await pendingListController.getPendingList();
                  } else {
                    BaseUtitiles.showToast("Please select checkbox");
                  }
                },
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .purchaseOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .ProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .SiteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .supplier
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant
                                                        .CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                            index]
                                                        .netAmount
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedByName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),

                                          // SizedBox(width: 5),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .PoVerification_ApproveDetDetails(
                                                          "PO VERIFICATION",
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .PoId!,
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .purchaseOrdNo
                                                              .toString(),
                                                          context,
                                                          purchaseType: widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .purchaseType
                                                              .toString());
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 60),
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    // decoration: BoxDecoration(
                                                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    //   // Change the background color to red
                                                    //   color: pendingListController.checkColor == 0
                                                    //       ? Colors.red
                                                    //       : Colors.white,
                                                    // ),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].purchaseOrdNo
                    .toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await pendingListController.PO_Approval_DeleteApi(
                              pendingListController
                                  .mainlist.value[index].PoId!);
                          pendingListController.mainlist.removeAt(index);
                          pendingListController.getPoAprovalDetList.clear();
                          pendingListController.update();
                          await pendingListController.getPendingList();
                          Navigator.pop(context);
                          // if (pendingListController.mainlist.isEmpty) {
                          Navigator.pop(context);
                          // }
                        },
                        child: const Text("Delete",
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

/// ----- PO Preapproval -----

class PoPreApproval extends StatefulWidget {
  PoPreApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;
  @override
  State<PoPreApproval> createState() => _PoPreApprovalState();
}

class _PoPreApprovalState extends State<PoPreApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant
                                                        .CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                            index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .PendingPoPreApprovalDetDetails(
                                                          "PO PREAPPROVAL PENDING",
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .id!,
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .no
                                                              .toString(),
                                                          context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 25),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              RequestConstant.PREAPPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value
                              .clear();
                          await pendingListController.poAproval_buttonApi(
                              context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///---------------PO APPROVAL--------------

class PoApprovalDesign extends StatefulWidget {
  PoApprovalDesign(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<PoApprovalDesign> createState() => _PoApprovalDesignState();
}

class _PoApprovalDesignState extends State<PoApprovalDesign> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: BaseUtitiles.getWidthtofPercentage(context, 20),
                  height: BaseUtitiles.getheightofPercentage(context, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: pendingListController.checkColor == 0
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: pendingListController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                onTap: () async {
                  if (pendingListController
                          .add_PoaprovalListvalue.value.length !=
                      0) {
                    pendingListController.checkColor = 1;
                    pendingListController.getPoAprovalDetList.value.clear();
                    await pendingListController.poAproval_buttonApi(
                        context, widget.heading.toString());
                    Navigator.pop(context);
                    await pendingListController.getPendingList();
                  } else {
                    BaseUtitiles.showToast("Please select checkbox");
                  }
                },
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .purchaseOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .PurchaseOrdNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .suppliername
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant
                                                        .CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                            index]
                                                        .netAmount
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      //Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .createdName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 7,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController
                                                      .PoVerification_ApproveDetDetails(
                                                          "PO APPROVAL",
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .PoId!,
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .PurchaseOrdNo
                                                              .toString(),
                                                          context,
                                                          purchaseType: widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .PurchaseType
                                                              .toString());
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 60),
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                    context, 4),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    width: BaseUtitiles
                                                        .getWidthtofPercentage(
                                                            context, 20),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 4),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1),
                                                      child: Text(
                                                        RequestConstant.DELETE,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    pendingListController
                                                        .checkColor = 1;
                                                    await deleteAlert(
                                                        context, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future deleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alert!'),
            Container(
              child: Text(
                pendingListController.mainlist.value[index].PurchaseOrdNo
                    .toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        content: const Text('Do you want to Delete?'),
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
                          Navigator.pop(context);
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
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          pendingListController.PO_Approval_DeleteApi(
                              pendingListController
                                  .mainlist.value[index].PoId!);
                          pendingListController.mainlist.removeAt(index);
                          pendingListController.getPoAprovalDetList.value = [];
                          await pendingListController.getPendingList();

                          Navigator.pop(context);
                          if (pendingListController.mainlist.isEmpty) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Delete",
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

///----------WORK ORDER VERIFICATION & APPROVAL-----------

class WorkOrder extends StatefulWidget {
  WorkOrder(
      {super.key, required this.onclickPendingListData, required this.heading});
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<WorkOrder> createState() => _WorkOrderState();
}

class _WorkOrderState extends State<WorkOrder> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.workorderListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 75),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "SubContractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .subContractorName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Work Order",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .worktype
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .workorderListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .workorderListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.WorkOrderDetList(
                                                      widget.heading.toString(),
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .id!,
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .no
                                                          .toString(),
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .workordertype
                                                          .toString(),
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 20),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              widget.heading.toString() ==
                                          "WORK ORDER VERIFICATION - DIRECT" ||
                                      widget.heading.toString() ==
                                          "WORK ORDER VERIFICATION - BOQ"
                                  ? RequestConstant.VERIFY
                                  : RequestConstant.APPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (pendingListController
                              .workorderListvalue.value.isNotEmpty) {
                            pendingListController.getWorkOrderDetList.value =
                                [];
                            await pendingListController.WorkOrder_buttonApi(
                                context, widget.heading.toString());
                            await pendingListController.getPendingList();
                          } else {
                            BaseUtitiles.showToast("Please select item");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///-----------------------Transfer Pending-------------------
class TransferPending extends StatefulWidget {
  TransferPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<TransferPending> createState() => _TransferPendingState();
}

class _TransferPendingState extends State<TransferPending> {
  TransferBW_project_Controller transferBW_project_Controller =
      Get.put(TransferBW_project_Controller());
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: const TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              transferBW_project_Controller
                                  .itemlistTable_Delete();
                              transferBW_project_Controller
                                  .ItemGetTableListdata.value = [];

                              if (widget.heading.toString() ==
                                  "TRANSFER REQUEST PENDING VIEW") {
                                transferBW_project_Controller.type.value =
                                    "Against Transfer Request";
                                transferBW_project_Controller
                                    .getTransPendingView(
                                        pendingListController
                                            .mainlist.value[index].id!,
                                        context);
                              } else {
                                transferBW_project_Controller.type.value =
                                    "Against Mrn Approval";
                                transferBW_project_Controller
                                    .getTransferProject_Alldatas(
                                        pendingListController
                                            .mainlist.value[index].reqMasId!,
                                        context);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget.heading.toString() ==
                                                      "TRANSFER REQUEST PENDING VIEW"
                                                  ? pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .transferNo
                                                      .toString()
                                                  : pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .ReqOrdNo
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.heading.toString() ==
                                                        "TRANSFER REQUEST PENDING VIEW"
                                                    ? pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .transferEntryDate
                                                        .toString()
                                                    : pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .ReqOrdDate
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Visibility(
                                          visible: widget.heading.toString() ==
                                                  "TRANSFER REQUEST PENDING VIEW"
                                              ? true
                                              : false,
                                          child: SizedBox(height: 5)),
                                      Visibility(
                                        visible: widget.heading.toString() ==
                                                "TRANSFER REQUEST PENDING VIEW"
                                            ? true
                                            : false,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "From Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist
                                                      .value[index]
                                                      .FromProjectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible: widget.heading.toString() ==
                                                  "TRANSFER REQUEST PENDING VIEW"
                                              ? true
                                              : false,
                                          child: SizedBox(height: 5)),
                                      Visibility(
                                        visible: widget.heading.toString() ==
                                                "TRANSFER REQUEST PENDING VIEW"
                                            ? true
                                            : false,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "From Site",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].fromSiteName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.heading.toString() ==
                                                        "TRANSFER REQUEST PENDING VIEW"
                                                    ? pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .toProjectName
                                                        .toString()
                                                    : pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .ProjectName
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Approved By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.heading.toString() ==
                                                        "TRANSFER REQUEST PENDING VIEW"
                                                    ? pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .approvedbyname
                                                        .toString()
                                                    : pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .approveByName
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget.heading.toString() ==
                                                        "TRANSFER REQUEST PENDING VIEW"
                                                    ? pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .Preparedbyname
                                                        .toString()
                                                    : pendingListController
                                                        .mainlist
                                                        .value[index]
                                                        .createdByName
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    print(
                                                        "HeadingURL :: ${widget.heading.toString()}");
                                                    if (widget.heading ==
                                                        "TRANSFER PENDING") {
                                                      pendingListController.againstMRNApprovalPendingDetDetails(
                                                          widget.heading
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .reqMasId!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .ReqOrdNo
                                                              .toString(),
                                                          widget.heading
                                                                      .toString() ==
                                                                  "TRANSFER REQUEST PENDING VIEW"
                                                              ? pendingListController
                                                                  .mainlist
                                                                  .value[index]
                                                                  .FromProjectName
                                                                  .toString()
                                                              : pendingListController
                                                                  .mainlist
                                                                  .value[index]
                                                                  .ProjectName
                                                                  .toString(),
                                                          context);
                                                    } else {
                                                      pendingListController.PendingTransferPendingDetDetails(
                                                          widget.heading
                                                              .toString(),
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .id!,
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .transferNo
                                                              .toString(),
                                                          widget.heading
                                                                      .toString() ==
                                                                  "TRANSFER REQUEST PENDING VIEW"
                                                              ? pendingListController
                                                                  .mainlist
                                                                  .value[index]
                                                                  .FromProjectName
                                                                  .toString()
                                                              : pendingListController
                                                                  .mainlist
                                                                  .value[index]
                                                                  .ProjectName
                                                                  .toString(),
                                                          context);
                                                    }
                                                  });
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///---Direct TransferVerification--------------

class TransferVerification extends StatefulWidget {
  TransferVerification(
      {super.key, required this.onclickPendingListData, required this.heading});
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<TransferVerification> createState() => _TransferVerificationState();
}

class _TransferVerificationState extends State<TransferVerification> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.getPoAprovalDetList.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        // child: Container(
                        //   margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                        //   child: TextField(
                        //     cursorColor: Theme.of(context).primaryColor,
                        //     controller: editingController,
                        //     decoration: InputDecoration(
                        //       filled: true,
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       prefixIcon: const Icon(
                        //         Icons.search,
                        //         color: Colors.black,
                        //       ),
                        //       hintText: "search..",
                        //       hintStyle: TextStyle(color: Colors.black),
                        //       isDense: true,
                        //       fillColor: Setmybackground,
                        //     ),
                        //     onEditingComplete: () {
                        //       FocusScope.of(context).unfocus();
                        //       // if (onSearch != null) onSearch!(searchcontroller.text);
                        //     },
                        //     textInputAction: TextInputAction.search,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        //
                        //       });
                        //     },
                        //   ),
                        // ),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 15,
                            bottom: 10,
                          ),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              isDense: true,
                              fillColor: Setmybackground,
                              // fillColor: Colors.white,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(editingController.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .frProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .toProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "DC No",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .dcno
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .type
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  // pendingListController.DirectTransfer(
                                                  //     "DIRECT TRANSFER VERIFICATION PENDING",
                                                  //     widget.onclickPendingListData[index].id!,
                                                  //     widget.onclickPendingListData[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 25),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              RequestConstant.VERIFY,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value
                              .clear();
                          await pendingListController.poAproval_buttonApi(
                              context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///--------Direct TransferApproval-----------

class DirectTransferApprovarl extends StatefulWidget {
  DirectTransferApprovarl(
      {super.key, required this.onclickPendingListData, required this.heading});
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<DirectTransferApprovarl> createState() =>
      _DirectTransferApprovarlState();
}

class _DirectTransferApprovarlState extends State<DirectTransferApprovarl> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        // child: Container(
                        //   margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                        //   child: TextField(
                        //     cursorColor: Theme.of(context).primaryColor,
                        //     controller: editingController,
                        //     decoration: InputDecoration(
                        //       filled: true,
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       prefixIcon: const Icon(
                        //         Icons.search,
                        //         color: Colors.black,
                        //       ),
                        //       hintText: "search..",
                        //       hintStyle: TextStyle(color: Colors.black),
                        //       isDense: true,
                        //       fillColor: Setmybackground,
                        //     ),
                        //     onEditingComplete: () {
                        //       FocusScope.of(context).unfocus();
                        //       // if (onSearch != null) onSearch!(searchcontroller.text);
                        //     },
                        //     textInputAction: TextInputAction.search,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        //
                        //       });
                        //     },
                        //   ),
                        // ),
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              isDense: true,
                              fillColor: Setmybackground,
                              // fillColor: Colors.white,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(editingController.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .frProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .toProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "DC No",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .dcno
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .type
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  // pendingListController.DirectTransfer(
                                                  //     "DIRECT TRANSFER APPROVAL PENDING",
                                                  //     widget.onclickPendingListData[index].id!,
                                                  //     widget.onclickPendingListData[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 25),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              RequestConstant.APPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value
                              .clear();
                          await pendingListController.poAproval_buttonApi(
                              context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///----TransferACKPending----------

class TransferACKPending extends StatefulWidget {
  TransferACKPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<TransferACKPending> createState() => _TransferACKPendingState();
}

class _TransferACKPendingState extends State<TransferACKPending> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TransferAcknowledgmentPendingController
      transferAcknowledgmentPendingController =
      Get.put(TransferAcknowledgmentPendingController());

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading == "TRANSFER ACKNOWLEDGMENT PENDING"
                            ? "TRANSFER ACK PENDING"
                            : "",
                        style: const TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 40),
                          margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              transferAcknowledgmentPendingController
                                  .deleteDetTableDatas();
                              transferAcknowledgmentPendingController
                                  .readListdata.value
                                  .clear();
                              transferAcknowledgmentPendingController
                                  .tranAckAlldatasApi(
                                      pendingListController
                                          .mainlist.value[index].id!,
                                      context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController.mainlist
                                                      .value[index].entryDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              pendingListController.mainlist
                                                  .value[index].TransferNo
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .fromProjectName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].ToProjectName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "DC No",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dcNo
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Vehicle No",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].vehicleName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          const Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Type       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].entryName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController
                                                        .PendingTransferACKDetails(
                                                            "TRANSFER ACKNOWLEDGMENT PENDING",
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .id!,
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .no
                                                                .toString(),
                                                            context);
                                                  });
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyLbrAtendance extends StatefulWidget {
  CompanyLbrAtendance(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<CompanyLbrAtendance> createState() => _CompanyLbrAtendanceState();
}

class _CompanyLbrAtendanceState extends State<CompanyLbrAtendance> {
  CompanyNmrAttendanceController companyNmrAttendanceController =
      Get.put(CompanyNmrAttendanceController());
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 40),
                          margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              });
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              companyNmrAttendanceController.entrycheck = 3;
                              companyNmrAttendanceController
                                  .delete_cmpNmrdetTable();
                              companyNmrAttendanceController.cmpNmr_getDbDetList
                                  .clear();
                              companyNmrAttendanceController
                                  .getPendingList_Alldatas(
                                      widget.onclickPendingListData[index].id!,
                                      context);
                            },
                            child: Container(
                              // height: BaseUtitiles.getheightofPercentage(context, 16),
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController
                                                        .PendingPoDetDetails(
                                                            "PENDING PO",
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .id!,
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .no
                                                                .toString(),
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .projectName
                                                                .toString(),
                                                            context);
                                                  });
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubContNMRBillApproval extends StatefulWidget {
  SubContNMRBillApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<SubContNMRBillApproval> createState() => _SubContNMRBillApprovalState();
}

class _SubContNMRBillApprovalState extends State<SubContNMRBillApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addSubcontNmrListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    pendingListController.getNMRAprovalDetList.value.clear();
                    await pendingListController
                        .subcontNmrAproval_buttonApi(context);
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.onclickPendingListData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                // height: BaseUtitiles.getheightofPercentage(context, 16),
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2, child: Container()),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .no
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Subcontractor",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .subContractorName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Net Amount",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  RequestConstant
                                                          .CURRENCY_SYMBOL +
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .netAmt
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),

                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "From Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .fromDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "To Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .toDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        // SizedBox(height: 5),
                                        // Row(
                                        //   children: <Widget>[
                                        //     Container(
                                        //       margin:
                                        //       EdgeInsets.only(top: 5, left: 10),
                                        //       child: Text(""),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "To Date",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //     Expanded(
                                        //         flex: 8,
                                        //         child: Text(
                                        //           widget.onclickPendingListData[index].toDate.toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 5),
                                        // Row(
                                        //   children: <Widget>[
                                        //     Container(
                                        //       margin:
                                        //       EdgeInsets.only(top: 5, left: 10),
                                        //       child: Text(""),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "Manual BillNo",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //     Expanded(
                                        //         flex: 8,
                                        //         child: Text(
                                        //           widget.onclickPendingListData[index].billno.toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),

                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Verified By       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .preparedBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                // Rounded Checkbox
                                                value: _isChecked[index],
                                                onChanged: (val) {
                                                  setState(
                                                    () {
                                                      if (val == true) {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addSubcontNmrListvalue
                                                            .value
                                                            .add(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      } else {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addSubcontNmrListvalue
                                                            .value
                                                            .remove(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            // Expanded(
                                            //     flex: 5,
                                            //     child: InkWell(
                                            //       child: Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .spaceBetween,
                                            //         children: [
                                            //           Container(
                                            //               margin: EdgeInsets.only(
                                            //                   left: 15),
                                            //               child: Text(
                                            //                 "More",
                                            //                 style: TextStyle(
                                            //                     fontWeight:
                                            //                         FontWeight.bold,
                                            //                     color: Theme.of(
                                            //                             context)
                                            //                         .primaryColor),
                                            //               )),
                                            //           CircleAvatar(
                                            //             backgroundColor:
                                            //                 Theme.of(context)
                                            //                     .primaryColor,
                                            //             radius: 13,
                                            //             child: Icon(
                                            //               Icons.more_vert,
                                            //               color: Setmybackground,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //       onTap: () {
                                            //         setState(() {
                                            //           pendingListController
                                            //               .PendingPoDetDetails(
                                            //                   "PENDING PO",
                                            //                   pendingListController
                                            //                       .mainlist
                                            //                       .value[index]
                                            //                       .id!,
                                            //                   pendingListController
                                            //                       .mainlist
                                            //                       .value[index]
                                            //                       .no
                                            //                       .toString(),
                                            //                   context);
                                            //         });
                                            //       },
                                            //     )),
                                            // SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillGenBOQAproval extends StatefulWidget {
  BillGenBOQAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<BillGenBOQAproval> createState() => _BillGenBOQAprovalState();
}

class _BillGenBOQAprovalState extends State<BillGenBOQAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addBillGenBOQListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    bottomNavigationBar:
                    Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 25),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).primaryColor),
                              alignment: Alignment.center,
                              child: Text(
                                RequestConstant.APPROVAL,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: Colors.white),
                              ),
                            ),
                            onTap: () async {
                              pendingListController
                                  .getbillBOQAprovalDetList.value
                                  .clear();
                              await pendingListController
                                  .billGenBOQAproval_buttonApi(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.onclickPendingListData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2, child: Container()),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .no
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Subcontractor",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .subContractorName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Net Amount",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  RequestConstant
                                                          .CURRENCY_SYMBOL +
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .netAmt
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "From Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .fromDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "To Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .toDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Prepared By       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .preparedBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                // Rounded Checkbox
                                                value: _isChecked[index],
                                                onChanged: (val) {
                                                  setState(
                                                    () {
                                                      if (val == true) {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addBillGenBOQListvalue
                                                            .value
                                                            .add(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      } else {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addBillGenBOQListvalue
                                                            .value
                                                            .remove(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillGenDirectAproval extends StatefulWidget {
  BillGenDirectAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<BillGenDirectAproval> createState() => _BillGenDirectAprovalState();
}

class _BillGenDirectAprovalState extends State<BillGenDirectAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addBillGenDirectListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    pendingListController.getbillDirectAprovalDetList.value
                        .clear();
                    await pendingListController
                        .billGenDirectAproval_buttonApi(context);
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.onclickPendingListData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // BaseUtitiles.showToast("Only proccess in Website");
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .no
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Subcontractor",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .subContractorName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Net Amount",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  RequestConstant
                                                          .CURRENCY_SYMBOL +
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .netAmt
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "From Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .fromDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "To Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .toDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        // SizedBox(height: 5),
                                        // Row(
                                        //   children: <Widget>[
                                        //     Container(
                                        //       margin:
                                        //       EdgeInsets.only(top: 5, left: 10),
                                        //       child: Text(""),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "To Date",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //     Expanded(
                                        //         flex: 4,
                                        //         child: Text(
                                        //           widget
                                        //               .onclickPendingListData[index]
                                        //               .toDate
                                        //               .toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 5),
                                        // Row(
                                        //   children: <Widget>[
                                        //     Container(
                                        //       margin:
                                        //       EdgeInsets.only(top: 5, left: 10),
                                        //       child: Text(""),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "Manual BillNo",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //     Expanded(
                                        //         flex: 8,
                                        //         child: Text(
                                        //           widget
                                        //               .onclickPendingListData[index]
                                        //               .billno
                                        //               .toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),

                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Verified By       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .preparedBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                // Rounded Checkbox
                                                value: _isChecked[index],
                                                onChanged: (val) {
                                                  setState(
                                                    () {
                                                      if (val == true) {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addBillGenDirectListvalue
                                                            .value
                                                            .add(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      } else {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .addBillGenDirectListvalue
                                                            .value
                                                            .remove(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdvanceReqAproval extends StatefulWidget {
  AdvanceReqAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<AdvanceReqAproval> createState() => _AdvanceReqAprovalState();
}

class _AdvanceReqAprovalState extends State<AdvanceReqAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;
  AdvanceReqVoucherController_new advanceReqVoucherController_new =
      Get.put(AdvanceReqVoucherController_new());
  var selectedValues;
  @override
  void initState() {
    pendingListController.add_AdvanceReqListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    pendingListController.getAdvanceReqAprovalDetList.value
                        .clear();
                    await pendingListController.advanceAproval_buttonApi(
                        widget.heading.toString(), context);
                  },
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    // await advanceReqVoucherController_new.DeleteAlert(context, index);
                    if (pendingListController.add_AdvanceReqListvalue.length !=
                        0) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Alert!'),
                          content: Text('Do you want to Delete?'),
                          actions: [
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  fontSize: RequestConstant
                                                      .Lable_Font_SIZE))),
                                    ),
                                    VerticalDivider(
                                      color: Colors
                                          .grey.shade400, //color of divider
                                      width: 5, //width space of divider
                                      thickness: 2, //thickness of divier line
                                      indent:
                                          15, //Spacing at the top of divider.
                                      endIndent:
                                          15, //Spacing at the bottom of divider.
                                    ),
                                    Expanded(
                                      child: TextButton(
                                          onPressed: () async {
                                            List<int> IdList = [];
                                            List<String> NoList = [];
                                            for (int i = 0;
                                                i <
                                                    pendingListController
                                                        .add_AdvanceReqListvalue
                                                        .length;
                                                i++) {
                                              IdList.add(pendingListController
                                                      .add_AdvanceReqListvalue[
                                                          i]
                                                      .id ??
                                                  0);
                                              NoList.add(pendingListController
                                                      .add_AdvanceReqListvalue[
                                                          i]
                                                      .no ??
                                                  '');
                                            }

                                            if (mounted) {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            }
                                            pendingListController
                                                .getAdvanceReqAprovalDetList
                                                .value
                                                .clear();
                                            await advanceReqVoucherController_new
                                                .EntryList_DeleteApi(
                                                    IdList, NoList);
                                            await pendingListController
                                                .getPendingList();
                                            if (mounted) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: RequestConstant
                                                      .Lable_Font_SIZE))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      BaseUtitiles.showToast("Please select a list");
                    }
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                              value,
                                              pendingListController
                                                  .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.onclickPendingListData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[
                                                        index]
                                                    .no
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Acc Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .accName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Acc Type",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .accType
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Type",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .type
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Req Amount",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  RequestConstant
                                                          .CURRENCY_SYMBOL +
                                                      widget
                                                          .onclickPendingListData[
                                                              index]
                                                          .reqAmt
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Prepared By       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  widget
                                                      .onclickPendingListData[
                                                          index]
                                                      .preparedBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Checkbox(
                                            //     shape: const RoundedRectangleBorder(
                                            //         borderRadius: BorderRadius.all(
                                            //             Radius.circular(5.0))),
                                            //     // Rounded Checkbox
                                            //     value: _isChecked[index],
                                            //     onChanged: (val) {
                                            //       setState(
                                            //         () {
                                            //           if (val == true) {
                                            //             _isChecked[index] = val!;
                                            //             pendingListController.add_AdvanceReqListvalue.value.add(widget.onclickPendingListData[index]);
                                            //           } else {
                                            //             _isChecked[index] = val!;
                                            //             pendingListController.add_AdvanceReqListvalue.value.remove(widget.onclickPendingListData[index]);
                                            //           }
                                            //         },
                                            //       );
                                            //     },
                                            //   ),
                                            // ),

                                            Expanded(
                                              flex: 1,
                                              child: Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => BorderSide(
                                                    width: 1.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                checkColor: Colors.white,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                // Rounded Checkbox
                                                value: _isChecked[index],
                                                onChanged: (val) {
                                                  setState(
                                                    () {
                                                      if (val == true) {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .add_AdvanceReqListvalue
                                                            .value
                                                            .add(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      } else {
                                                        _isChecked[index] =
                                                            val!;
                                                        pendingListController
                                                            .add_AdvanceReqListvalue
                                                            .value
                                                            .remove(widget
                                                                    .onclickPendingListData[
                                                                index]);
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StaffRequisitionVerify extends StatefulWidget {
  StaffRequisitionVerify(
      {super.key, required this.onclickPendingListData, required this.heading});

  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<StaffRequisitionVerify> createState() => _StaffRequisitionVerifyState();
}

class _StaffRequisitionVerifyState extends State<StaffRequisitionVerify> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  RequisitionSlipController requisitionSlipController =
      Get.put(RequisitionSlipController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    requisitionSlipController.verifyRemarks.text = "";
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    pendingListController.mainlist.value = widget.onclickPendingListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        widget.heading.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: editingController,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "search..",
                            hintStyle: const TextStyle(color: Colors.black),
                            isDense: true,
                            fillColor: Setmybackground,
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            // if (onSearch != null) onSearch!(searchcontroller.text);
                          },
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() {
                              pendingListController.mainlist.value =
                                  BaseUtitiles.filterSearchStaffRequisiton(
                                      value,
                                      pendingListController.pendingmainlist);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              requisitionSlipController.verifyRemarks.text = "";
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus &&
                                          currentFocus.focusedChild != null) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                    },
                                    child: Form(
                                      key: formKey,
                                      child: AlertDialog(
                                        title: Text(
                                            '${pendingListController.mainlist.value[index].type}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        content: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8, // Set max height
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8, // Set max width
                                          ),
                                          child: IntrinsicHeight(
                                            child: Container(
                                              // height: widget.heading.toString() == "STAFF REQUISITION VERIFICATION" ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.33,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          pendingListController
                                                              .mainlist
                                                              .value[index]
                                                              .staffName
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        const Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "Project: ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    RequestConstant
                                                                        .Lable_Font_SIZE,
                                                              ),
                                                            )),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .projectName
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  RequestConstant
                                                                      .Lable_Font_SIZE,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        const Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "Entry No: ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    RequestConstant
                                                                        .Lable_Font_SIZE,
                                                              ),
                                                            )),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .no
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  RequestConstant
                                                                      .Lable_Font_SIZE,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),

                                                  Visibility(
                                                    visible: pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .type ==
                                                                "LEAVE" ||
                                                            widget
                                                                    .onclickPendingListData[
                                                                        index]
                                                                    .type ==
                                                                "COMP OF LEAVE"
                                                        ? true
                                                        : false,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "Reason: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          RequestConstant
                                                                              .Lable_Font_SIZE,
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  pendingListController
                                                                      .mainlist
                                                                      .value[
                                                                          index]
                                                                      .leaveReason
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "From Date: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          RequestConstant
                                                                              .Lable_Font_SIZE,
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  pendingListController
                                                                      .mainlist
                                                                      .value[
                                                                          index]
                                                                      .lFrdate
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "To Date: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          RequestConstant
                                                                              .Lable_Font_SIZE,
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  pendingListController
                                                                      .mainlist
                                                                      .value[
                                                                          index]
                                                                      .lTodate
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    "Total Days: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          RequestConstant
                                                                              .Lable_Font_SIZE,
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  pendingListController
                                                                      .mainlist
                                                                      .value[
                                                                          index]
                                                                      .totalLeave
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Visibility(
                                                    visible: pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .type ==
                                                            "ON DUTY"
                                                        ? true
                                                        : pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .type ==
                                                                "PERMISSION"
                                                            ? true
                                                            : false,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "Reason: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .perReason
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      RequestConstant
                                                                          .Lable_Font_SIZE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "Date: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .pFrdate
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      RequestConstant
                                                                          .Lable_Font_SIZE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "From Time: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .pFrTime
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      RequestConstant
                                                                          .Lable_Font_SIZE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "To Time: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .pToTime
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      RequestConstant
                                                                          .Lable_Font_SIZE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: <Widget>[
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "Total Hours: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        RequestConstant
                                                                            .Lable_Font_SIZE,
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                pendingListController
                                                                    .mainlist
                                                                    .value[
                                                                        index]
                                                                    .totalPerHrs
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      RequestConstant
                                                                          .Lable_Font_SIZE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  const SizedBox(height: 15),

                                                  Container(
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      cursorColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      readOnly: false,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      controller:
                                                          requisitionSlipController
                                                              .verifyRemarks,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxHeight: 70,
                                                                minHeight: 35),
                                                        // contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 18),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                5.0,
                                                                0.0,
                                                                5.0,
                                                                0.0),
                                                        // isDense: false,
                                                        labelText: widget
                                                                    .heading
                                                                    .toString() ==
                                                                "STAFF REQUISITION VERIFICATION"
                                                            ? "Remarks"
                                                            : widget.heading
                                                                        .toString() ==
                                                                    "STAFF REQUISITION APPROVAL"
                                                                ? "Remarks"
                                                                : "",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              width: 1.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              width: 1.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return '\u26A0 Please enter Remarks';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),

                                                  // Container(
                                                  //   margin: EdgeInsets.all(5.0),
                                                  //   child: Padding(
                                                  //     padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                                  //     child: TextFormField(
                                                  //       autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  //       controller: requisitionSlipController.verifyRemarks,
                                                  //       cursorColor: Colors.black,
                                                  //       style: TextStyle(color: Colors.black),
                                                  //       decoration: InputDecoration(
                                                  //         contentPadding: EdgeInsets.zero,
                                                  //         focusedBorder:
                                                  //         OutlineInputBorder(
                                                  //           borderSide: BorderSide(
                                                  //               color: Theme.of(context).primaryColor,
                                                  //               width: 1.0),
                                                  //         ),
                                                  //         enabledBorder:
                                                  //         OutlineInputBorder(
                                                  //           borderSide: BorderSide(
                                                  //               color: Theme.of(context)
                                                  //                   .primaryColor,
                                                  //               width: 1.0),
                                                  //         ),
                                                  //         border: OutlineInputBorder(),
                                                  //         labelText: widget.heading.toString() == "STAFF REQUISITION VERIFICATION"
                                                  //             ? "Verify Remarks"
                                                  //             : widget.heading.toString() == "STAFF REQUISITION APPROVAL"
                                                  //             ? "Approval Remarks"
                                                  //             : "",
                                                  //         labelStyle: TextStyle(color: Colors.black),
                                                  //         prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                  //         prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                  //             child: ConstIcons.remarks),
                                                  //       ),
                                                  //       onChanged: (value) {
                                                  //
                                                  //       },
                                                  //       validator: (value) {
                                                  //         if (value!.isEmpty) {
                                                  //           return '\u26A0 Please enter Remarks.';
                                                  //         }
                                                  //         return null;
                                                  //       },
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      height: BaseUtitiles
                                                          .getheightofPercentage(
                                                              context, 4),
                                                      width: BaseUtitiles
                                                          .getWidthtofPercentage(
                                                              context, 20),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        widget.heading
                                                                    .toString() ==
                                                                "STAFF REQUISITION VERIFICATION"
                                                            ? RequestConstant
                                                                .VERIFY
                                                            : widget.heading
                                                                        .toString() ==
                                                                    "STAFF REQUISITION APPROVAL"
                                                                ? RequestConstant
                                                                    .APPROVAL
                                                                : "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      await requisitionSlipController
                                                          .reqSlipApproveApi(
                                                        context,
                                                        widget.heading
                                                                    .toString() ==
                                                                "STAFF REQUISITION VERIFICATION"
                                                            ? widget.heading
                                                                .toString()
                                                            : widget.heading
                                                                        .toString() ==
                                                                    "STAFF REQUISITION APPROVAL"
                                                                ? widget.heading
                                                                    .toString()
                                                                : "",
                                                        widget
                                                            .onclickPendingListData[
                                                                index]
                                                            .id!,
                                                        widget
                                                            .onclickPendingListData[
                                                                index]
                                                            .no
                                                            .toString(),
                                                      );
                                                    },
                                                  ),

                                                  VerticalDivider(
                                                    color: Colors.grey.shade400,
                                                    width: 5,
                                                    thickness: 2,
                                                    indent: 2,
                                                    endIndent: 2,
                                                  ),

                                                  InkWell(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      height: BaseUtitiles
                                                          .getheightofPercentage(
                                                              context, 4),
                                                      width: BaseUtitiles
                                                          .getWidthtofPercentage(
                                                              context, 20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: Colors.red,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        "Reject",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      // Check if the form is valid before making the API call
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        formKey.currentState!
                                                            .save();
                                                        await requisitionSlipController
                                                            .reqSlipApproveApi(
                                                          context,
                                                          "STAFF REQUISITION REJECTION",
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .id!,
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .no
                                                              .toString(),
                                                        );
                                                      }
                                                    },
                                                  ),

                                                  // InkWell(
                                                  //   child: Container(
                                                  //     margin: EdgeInsets.only(left: 20, right: 20),
                                                  //     height: BaseUtitiles.getheightofPercentage(context, 4),
                                                  //     width: BaseUtitiles.getWidthtofPercentage(context, 20),
                                                  //     decoration: BoxDecoration(
                                                  //       borderRadius:
                                                  //           BorderRadius.all(
                                                  //               Radius.circular(
                                                  //                   10)),
                                                  //       color: Colors.red,
                                                  //     ),
                                                  //     alignment: Alignment.center,
                                                  //     child: const Text(
                                                  //       "Reject",
                                                  //       style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight.bold,
                                                  //           fontSize: RequestConstant
                                                  //               .Lable_Font_SIZE,
                                                  //           color: Colors.white),
                                                  //     ),
                                                  //   ),
                                                  //   onTap: () async {
                                                  //     if(formKey.currentState!.validate()){
                                                  //       formKey.currentState!.save();
                                                  //       await requisitionSlipController.reqSlipApproveApi(context,
                                                  //         "STAFF REQUISITION REJECTION",
                                                  //         widget.onclickPendingListData[index].id!, widget.onclickPendingListData[index].no.toString(),
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "${pendingListController.mainlist.value[index].no.toString()}  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Location",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Staff Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].staffName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Type",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                " ${pendingListController.mainlist.value[index].type}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfficeVoucherApproval extends StatelessWidget {
  OfficeVoucherApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;

  String heading;

  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width:
                                BaseUtitiles.getWidthtofPercentage(context, 30),
                            margin:
                                EdgeInsets.only(top: 10, left: 5, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              // textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                pendingListController.mainlist.value =
                                    BaseUtitiles
                                        .filterSearchResults_PendingList(
                                            value,
                                            pendingListController
                                                .pendingmainlist);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        // itemCount: onclickPendingListData.length,
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BaseUtitiles.showToast(
                                  "PO Verification Only in Website");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                RequestConstant
                                                        .CURRENCY_SYMBOL +
                                                    onclickPendingListData[
                                                            index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Po Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .potype
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PunchInApproval extends StatefulWidget {
  PunchInApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnClickListResult> onclickPendingListData;
  String heading;

  @override
  State<PunchInApproval> createState() => _PunchInApprovalState();
}

class _PunchInApprovalState extends State<PunchInApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PunchInAppListvalue.value = [];
    setState(() {
      pendingListController.pendingmainlist.value = [];
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: RequestConstant.ALERT_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              fillColor: Setmybackground,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              setState(() {
                                pendingListController.mainlist.value =
                                    BaseUtitiles.filterSearchOndutyPunchIn(
                                        value,
                                        pendingListController.pendingmainlist);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 78),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin: EdgeInsets.only(right: 10),
                                      //       child: Text(
                                      //         widget.onclickPendingListData[index].no.toString(),
                                      //         style: TextStyle(fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "StaffName",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                            .mainlist[index]
                                                            .staffName
                                                            .toString() ==
                                                        "null"
                                                    ? "-"
                                                    : pendingListController
                                                        .mainlist[index]
                                                        .staffName
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "PunchIn Time",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                DateFormat("hh:mm a").format(
                                                    DateFormat("HH:mm:ss").parse(
                                                        pendingListController
                                                            .mainlist[index]
                                                            .Time
                                                            .toString())),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Address",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist[index].Address
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Designation",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist[index].Designation
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Remarks           ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                    .mainlist[index].Remarks
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PunchInAppListvalue
                                                          .value
                                                          .add(
                                                              pendingListController
                                                                      .mainlist[
                                                                  index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PunchInAppListvalue
                                                          .value
                                                          .remove(
                                                              pendingListController
                                                                      .mainlist[
                                                                  index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 20),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              RequestConstant.APPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.getPunchinAprovalDetList.value =
                              [];
                          await pendingListController.punchInAproval_buttonApi(
                              context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuotePending extends StatefulWidget {
  QuotePending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List onclickPendingListData;
  String heading;

  @override
  State<QuotePending> createState() => _QuotePendingState();
}

class _QuotePendingState extends State<QuotePending> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    pendingListController.pendingmainlist.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: RefreshIndicator(
            onRefresh: () => pendingListController.getSubcontractor_ExpensesList("PENDING QUOTE", context,isRoute: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResultsPendingList(value,
                                              widget.onclickPendingListData);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6, bottom: 16),
                      height: BaseUtitiles.getheightofPercentage(context, 84),
                      child: Obx(() => ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: pendingListController.mainlist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 3, child: Container()),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].reqOrdNo
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Due Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqDueDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Site",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].siteName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Quote Count",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].qCount
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Prepared By     ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index]
                                                      .createdByName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: InkWell(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                          child: Text(
                                                            "More",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          )),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        radius: 13,
                                                        child: Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Setmybackground,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    pendingListController
                                                        .GetDetDetails(
                                                            widget.heading
                                                                .toString(),
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .materialReqOrdMasId!,
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .reqOrdNo
                                                                .toString(),
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .projectName
                                                                .toString(),
                                                            context);
                                                  },
                                                )),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: TextButton(
                                                    onPressed: () {
                                                        launch(
                                                            "${ApiConfig.WebURL}pending-quote-list-comparison?reqMasId=${pendingListController.mainlist[index].materialReqOrdMasId}&access_token=${loginController.user.value.accessToken}");
                                                        print(
                                                            "${ApiConfig.WebURL}pending-quote-list-comparison?reqMasId=${pendingListController.mainlist[index].materialReqOrdMasId}&access_token=${loginController.user.value.accessToken}");
                                                    },
                                                    child: Text("Comparison",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                              ),
                                              VerticalDivider(
                                                color: Colors.grey.shade400,
                                                width: 5,
                                                thickness: 2,
                                                indent: 15,
                                                endIndent: 15,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: InkWell(
                                                  onTap: () async {
                                                    int count = int.tryParse(
                                                            pendingListController
                                                                .mainlist
                                                                .value[index]
                                                                .qCount
                                                                .toString()) ??
                                                        0;
                                                    if (count <= 0) {
                                                      BaseUtitiles.showToast(
                                                          "Quote Not Submitted, Due to Insufficent No of Quotations");
                                                    } else {
                                                      verifyAndApproveAlert(
                                                          context, index);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Submit",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: RequestConstant
                                                          .Lable_Font_SIZE,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))),
                  SizedBox(height: 25)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///----verify-----
  Future verifyAndApproveAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Submit?'),
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
                          if (await BaseUtitiles.checkNetworkAndShowLoader(
                              context)) {
                            await pendingListController
                                .quotVerifyAprovalbuttonApi(
                                    context,
                                    pendingListController
                                        .mainlist[index].materialReqOrdMasId,"Submit");
                          }
                        },
                        child: Text("Submit",
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

class QuoteVerifyandApproval extends StatefulWidget {
  QuoteVerifyandApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List onclickPendingListData;
  String heading;

  @override
  State<QuoteVerifyandApproval> createState() => _QuoteVerifyandApprovalState();
}

class _QuoteVerifyandApprovalState extends State<QuoteVerifyandApproval> {

  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    pendingListController.pendingmainlist.clear();
      pendingListController.verifyRemarks.text = "-";
      pendingListController.revertRemarks.text = "-";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: RefreshIndicator(
            onRefresh: () => widget.heading=="QUOTE VERIFICATION PENDING"?pendingListController.getSubcontractor_ExpensesList("QUOTE VERIFICATION PENDING", context,isRoute: false):pendingListController.getSubcontractor_ExpensesList("QUOTE APPROVAL PENDING", context,isRoute: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value = BaseUtitiles.filterSearchResultsPendingList(value, widget.onclickPendingListData);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6, bottom: 16),
                      height: BaseUtitiles.getheightofPercentage(context, 84),
                      child: Obx(() => ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: pendingListController.mainlist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 3,
                                                child: Container()),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                pendingListController.mainlist.value[index].reqOrdNo.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqOrdDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Due Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].reqdueDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist.value[index].projectName.toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Site",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist.value[index].siteName.toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Quote Count",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist.value[index].qCount.toString(),
                                                  style: TextStyle(color: Colors.black,),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Text(
                                              "Prepared By     ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                    widget.heading == "QUOTE VERIFICATION PENDING"?pendingListController.mainlist[index].createdByName:pendingListController.mainlist[index].createdBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),

                                            Expanded(
                                                flex: 5,
                                                child: InkWell(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets.only(left: 15),
                                                          child: Text(
                                                            "More",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Theme.of(context).primaryColor),
                                                          )),
                                                      CircleAvatar(
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        radius: 13,
                                                        child: Icon(
                                                          Icons.more_vert,
                                                          color: Setmybackground,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    pendingListController
                                                        .GetDetDetails(
                                                        widget.heading
                                                            .toString(),
                                                        pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .id!,
                                                        pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .reqOrdNo
                                                            .toString(),
                                                        pendingListController
                                                            .mainlist
                                                            .value[index]
                                                            .projectName
                                                            .toString(),
                                                        context);
                                                  },
                                                )),
                                            SizedBox(width: 5),
                                          ],
                                        ),

                                        Divider(thickness: 1),

                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Expanded(
                                                flex: 4,
                                                child: TextButton(
                                                    onPressed: () {
                                                      launch("${ApiConfig.WebURL}${widget.heading == "QUOTE VERIFICATION PENDING"?"pending-quote-verification-comparison":"pending-quote-approval-comparison"}?reqMasId=${pendingListController.mainlist[index].id}&access_token=${loginController.user.value.accessToken}");
                                                      print("${ApiConfig.WebURL}${widget.heading == "QUOTE VERIFICATION PENDING"?"pending-quote-verification-comparison":"pending-quote-approval-comparison"}?reqMasId=${pendingListController.mainlist[index].id}&access_token=${loginController.user.value.accessToken}");
                                                    },
                                                    child: Text(
                                                        "Comparison",
                                                        style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
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
                                                flex: 4,
                                                child: InkWell(
                                                  onTap: () async {

                                                    if (widget.heading == "QUOTE VERIFICATION PENDING") {
                                                      verifyAndApproveAlert(context, index);
                                                    } else {
                                                      await pendingListController.getQuoteSupplierlist(pendingListController.mainlist[index].id!);
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return QuoteApproveAlert(
                                                            heading: widget.heading.toString(),
                                                            id: pendingListController.mainlist[index].id!,
                                                            no: pendingListController.mainlist[index].reqOrdNo,
                                                            pId: pendingListController.mainlist[index].ProjectID,
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    widget.heading == "QUOTE VERIFICATION PENDING"
                                                        ? RequestConstant.VERIFY
                                                        :  RequestConstant.APPROVAL,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Theme.of(context).primaryColor,
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
                                                endIndent: 15,
                                              ),

                                              Expanded(
                                                flex: 4,
                                                child: TextButton(
                                                    onPressed: () {
                                                        revertAlert(context, index,  pendingListController.mainlist[index].reqOrdNo.toString());
                                                    },
                                                    child: Text("Revert",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: RequestConstant
                                                                .Lable_Font_SIZE))),
                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      )),

                  SizedBox(height: 25)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///----verify-----
  Future verifyAndApproveAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Alert!'),
            content: Text(
                widget.heading.toString() == "QUOTE VERIFICATION PENDING"
                    ? 'Are you sure to Verify?' : 'Are you sure to Approval?'),
            actions: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: IntrinsicHeight(

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(context, 6),
                              child: TextFormField(
                                maxLines: 2,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: pendingListController.verifyRemarks,
                                decoration: InputDecoration(
                                  labelText: "Verify Remarks",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme
                                          .of(context)
                                          .primaryColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                ),
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {

                                },
                                onTap: () {
                                  pendingListController.verifyRemarks.text == "-" ? pendingListController.verifyRemarks.text = "" : pendingListController.verifyRemarks.text;
                                },

                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
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
                                        fontSize: RequestConstant
                                            .Lable_Font_SIZE))),
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
                                  await pendingListController
                                      .quotVerifyAprovalbuttonApi(
                                      context,
                                      pendingListController
                                          .mainlist[index].id,"Verify");
                                },
                                child: Text(
                                    widget.heading.toString() == "QUOTE VERIFICATION PENDING" ? RequestConstant.VERIFY : RequestConstant.APPROVAL,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: RequestConstant.Lable_Font_SIZE))),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }

  ///----revert----
  Future revertAlert(BuildContext context, int index, reqno) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('Alert!')),
                Expanded(
                  child: Text(reqno, style: TextStyle(
                      fontSize: RequestConstant.Lable_Font_SIZE,
                      color: Theme.of(context).primaryColor),),
                )
              ],
            ),
            content: Text('Are you sure to Revert?'),
            actions: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(context, 6),
                              child: TextFormField(
                                maxLines: 2,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: pendingListController.revertRemarks,
                                decoration: InputDecoration(
                                  labelText: "Revert Remarks",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme
                                          .of(context)
                                          .primaryColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                ),
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {

                                },
                                onTap: () {
                                  pendingListController.revertRemarks.text == "-" ? pendingListController.revertRemarks.text = "" : pendingListController.revertRemarks.text;
                                },

                              ),
                            ),
                          ),
                        ],
                      ),


                      Row(
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
                                        fontSize: RequestConstant
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
                                onPressed: () async {
                                  await pendingListController.quotVerifyAprovalbuttonApi(context, pendingListController.mainlist[index].id!,"Revert");
                                },
                                child: Text("REVERT",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: RequestConstant.Lable_Font_SIZE))),
                          )
                        ],
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


