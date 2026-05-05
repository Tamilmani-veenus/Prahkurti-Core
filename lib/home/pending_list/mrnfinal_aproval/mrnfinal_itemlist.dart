import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../../commonpopup/mrnfinal_aproval_detalert.dart';
import '../../../controller/mrn_finalapproval_controller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';
import '../onclickpending_list.dart';

class MrnfinalItemList extends StatefulWidget {
  const MrnfinalItemList({Key? key}) : super(key: key);

  @override
  State<MrnfinalItemList> createState() => _MrnfinalItemListState();
}

class _MrnfinalItemListState extends State<MrnfinalItemList> {
  PendingListController pendingListController =
  Get.put(PendingListController());
  MrnFinalApprovalController mrnFinalApprovalController =
  Get.put(MrnFinalApprovalController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  MRN_Request_Controller mrn_request_controller =
  Get.put(MRN_Request_Controller());
  MrnPreApprovalController mrnPreApprovalController =
  Get.put(MrnPreApprovalController());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // always dispose the controller
    super.dispose();
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
                const SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item List",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
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
                Text(
                  projectController.projectname.text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                ListDetails(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: mrnFinalApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: mrnFinalApprovalController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    mrnFinalApprovalController.checkColor = 0;
                    if (check()) {
                      BaseUtitiles.showToast("Please select FromProject Name");
                    } else {
                      SubmitAlert(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool check() {
    int i = 0;
    var data = false;
    mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
      mrnFinalApprovalController.itemlist_textControllersInitiate();
      if (mrnFinalApprovalController.Approval_ListController[i].text == "T" &&
          double.parse(mrnFinalApprovalController.projectId[i].text) == 0) {
        data = true;
      }
      i++;
    });
    return data;
  }

  Widget ListDetails() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: BaseUtitiles.getheightofPercentage(context, 75),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5),
              height: BaseUtitiles.getheightofPercentage(context, 85),
              child: Obx(
                    () => Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 6, // reduce the thickness to make thumb smaller
                  radius: Radius.circular(5),
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: mrnFinalApprovalController
                        .MaterialFinalAppr_itemview_GetDbList.length,
                    itemBuilder: (BuildContext context, int index) {
                      mrnFinalApprovalController
                          .itemlist_textControllersInitiate();
                      return Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 3, bottom: 3, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: Text(
                                            mrnFinalApprovalController
                                                .MaterialFinalAppr_itemview_GetDbList[
                                            index]
                                                .materialname
                                                .toString() +
                                                " - " +
                                                mrnFinalApprovalController
                                                    .MaterialFinalAppr_itemview_GetDbList[
                                                index]
                                                    .scale
                                                    .toString(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                context, 3),
                                            width: BaseUtitiles
                                                .getWidthtofPercentage(
                                                context, 4),
                                            margin: const EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                bottom: 3,
                                                top: 5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                              BorderRadius.circular(3),
                                            ),
                                            child: Icon(
                                              Icons.search_off,
                                              color: white,
                                            ),
                                          ),
                                          onTap: () {
                                            mrnPreApprovalController.getStock_MaterialWise(
                                                mrnFinalApprovalController
                                                    .MaterialFinalAppr_itemview_GetDbList[
                                                index]
                                                    .materialid,
                                                mrnFinalApprovalController
                                                    .MaterialFinalAppr_itemview_GetDbList[
                                                index]
                                                    .materialname
                                                    .toString(),
                                                mrnFinalApprovalController
                                                    .MaterialFinalAppr_itemview_GetDbList[
                                                index]
                                                    .scale
                                                    .toString(),
                                                context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 3, top: 3, bottom: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx((){
                                        return mrn_request_controller.activeType.value ?
                                        Expanded(
                                            flex: 3,
                                            child: Text("Bal Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)) : SizedBox();
                                      }
                                      ),
                                      Obx((){
                                        return mrn_request_controller.activeType.value ?
                                         Expanded(
                                          flex: 4,
                                          child: Container(
                                            margin:
                                            const EdgeInsets.only(right: 11),
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                context, 4),
                                            //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                            child: TextField(
                                              readOnly: true,
                                              cursorColor:
                                              Theme.of(context).primaryColor,
                                              textAlign: TextAlign.center,
                                              controller:
                                              mrnFinalApprovalController
                                                  .BalQty_ListController[
                                              index],
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 8.0, 0.0),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10))),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10))),
                                              ),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ) : SizedBox();
                                        },
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Req Qty",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          margin:
                                          const EdgeInsets.only(right: 11),
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                              context, 4),
                                          // width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                          child: TextField(
                                            readOnly: true,
                                            cursorColor:
                                            Theme.of(context).primaryColor,
                                            textAlign: TextAlign.center,
                                            controller:
                                            mrnFinalApprovalController
                                                .ReqQty_ListController[
                                            index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 8.0, 0.0),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, right: 3, top: 3, bottom: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                            "App Qty",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 11),
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                              context, 4),
                                          //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                          child: TextField(
                                            cursorColor:
                                            Theme.of(context).primaryColor,
                                            textAlign: TextAlign.center,
                                            controller:
                                            mrnFinalApprovalController
                                                .ApprQty_ListController[
                                            index],
                                            keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 8.0, 0.0),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(10))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(10))),
                                            ),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                            onChanged: (value) {
                                              if(mrn_request_controller.activeType.value)
                                                {
                                                  mrnFinalApprovalController.MaterialItemlistBal_clickEdit(index);
                                                }
                                              else {
                                                mrnFinalApprovalController
                                                    .finalApproval_updateConsumTables();
                                              } },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 3, right: 3, top: 3, bottom: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          flex: 3,
                                          child: Text(
                                            "App Type",
                                            style:
                                            TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, right: 11),
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Obx(
                                                    () =>
                                                    DropdownButtonHideUnderline(
                                                      child:
                                                      DropdownButton2<String>(
                                                        isExpanded: true,

                                                        // ✅ HINT
                                                        hint: const Align(
                                                          alignment:
                                                          Alignment.center,
                                                          child: Text(
                                                            "--SELECT--",
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),

                                                        // ✅ VALUE
                                                        value: mrnFinalApprovalController
                                                            .Approval_ListController[
                                                        index]
                                                            .text
                                                            .isEmpty
                                                            ? null
                                                            : mrnFinalApprovalController
                                                            .Approval_ListController[
                                                        index]
                                                            .text,

                                                        // ✅ ITEMS
                                                        items: mrn_request_controller
                                                            .appTypeList
                                                            .map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value:
                                                            item["approvalType"]
                                                                .toString(),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .center, // better UX than center
                                                              child: Text(
                                                                item["approvalName"]
                                                                    .toString(),
                                                                maxLines:
                                                                1, // ✅ restrict to single line
                                                                overflow: TextOverflow
                                                                    .ellipsis, // ✅ add ...
                                                                softWrap:
                                                                false, // ✅ prevent wrapping
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 14.0,
                                                                  color:
                                                                  Colors.black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),

                                                        // ✅ ON CHANGE
                                                        onChanged: (value) async {
                                                          if (value == null) return;

                                                          setState(() {
                                                            mrnFinalApprovalController
                                                                .Approval_ListController[
                                                            index]
                                                                .text = value;

                                                            if (value != "T") {
                                                              mrnFinalApprovalController.TransfrProject_ListController[index].text = "--SELECT--";
                                                              mrnFinalApprovalController.projectId[index].text="0";
                                                            }
                                                          });

                                                          await mrnFinalApprovalController
                                                              .finalApproval_updateConsumTables();
                                                        },

                                                        // ✅ BUTTON STYLE (NO BORDER HERE ❗)
                                                        buttonStyleData:
                                                        ButtonStyleData(
                                                          height:
                                                          35, // match container
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                          ),
                                                        ),

                                                        // ✅ ICON
                                                        iconStyleData:
                                                        IconStyleData(
                                                          icon: Icon(
                                                            Icons.arrow_drop_down,
                                                            color: Theme.of(context)
                                                                .primaryColor,
                                                          ),
                                                          iconSize: 22,
                                                        ),

                                                        // ✅ DROPDOWN STYLE
                                                        dropdownStyleData:
                                                        DropdownStyleData(
                                                          maxHeight: 300,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                          ),
                                                          elevation: 4,
                                                        ),

                                                        // ✅ MENU ITEM STYLE
                                                        menuItemStyleData:
                                                        const MenuItemStyleData(
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: mrnFinalApprovalController
                                      .Approval_ListController[index]
                                      .text !=
                                      "T"
                                      ? false
                                      : true,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 3, right: 3, top: 3, bottom: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Transfer From Project",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0),
                                            )),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 11),
                                            height: BaseUtitiles
                                                .getheightofPercentage(
                                                context, 4),
                                            child: TextField(
                                                readOnly: true,
                                                cursorColor: Theme.of(context)
                                                    .primaryColor,
                                                textAlign: TextAlign.center,
                                                controller:
                                                mrnFinalApprovalController
                                                    .TransfrProject_ListController[
                                                index],
                                                keyboardType:
                                                TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColor),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius
                                                              .circular(
                                                              10))),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColor),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius
                                                              .circular(
                                                              10))),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                                onTap: () async {
                                                  var result =
                                                      mrnFinalApprovalController
                                                          .mrnfinalAppDetList
                                                          .value
                                                          .first;

                                                  if (result.mMatReqMasLink !=
                                                      null &&
                                                      result.mMatReqMasLink!
                                                          .isNotEmpty) {
                                                    var currentItem = result
                                                        .mMatReqMasLink![index];

                                                    await mrnFinalApprovalController
                                                        .gettingProjectName(
                                                      currentItem.reqMasDetId!,
                                                      currentItem.materialid!,
                                                      projectController
                                                          .selectedProjectId
                                                          .value,
                                                      context,
                                                    );
                                                  }
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Approval?'),
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (mrnFinalApprovalController
                              .TransfrProject_ListController ==
                              "--SELECT--") {
                            BaseUtitiles.showToast(
                                "Please select transfer from project");
                          } else {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(
                                context)) {
                              await mrnFinalApprovalController
                                  .getFinalApp_MaterialsItemlist_TableDatas();
                              await mrnFinalApprovalController.ApproveAPI(
                                  context);
                            }
                          }
                        },
                        child: Text(RequestConstant.APPROVAL,
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
