import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/mrn_finalapproval_controller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';
import 'mrnfinal_itemlist.dart';

class MrnfinalEntryScreen extends StatefulWidget {
  const MrnfinalEntryScreen({Key? key}) : super(key: key);

  @override
  State<MrnfinalEntryScreen> createState() => _MrnfinalEntryScreenState();
}

class _MrnfinalEntryScreenState extends State<MrnfinalEntryScreen> {

  MrnFinalApprovalController mrnFinalApprovalController = Get.put(MrnFinalApprovalController());
  MrnPreApprovalController mrnPreApprovalController = Get.put(MrnPreApprovalController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  PendingListController pendingListController = Get.put(PendingListController());
  LoginController loginController = Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await mrn_request_controller.getAppTypeList();
    mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
      mrnFinalApprovalController.RequestNoText.text = element.no.toString();
      mrnFinalApprovalController.RequestDateText.text =
          element.date.toString();
      mrnFinalApprovalController.DueDateText.text =
          element.dueDate.toString();
      projectController.projectname.text = element.projectName.toString();
      projectController.selectedProjectId.value = element.ProjectId!;
      siteController.selectedsiteId.value = element.SiteId!;
      siteController.Sitename.text = element.siteName.toString();
      mrn_request_controller.ReqType.value = element.requestType;
      mrnFinalApprovalController.PreparedbyText.text =
          element.preparedBy.toString();
      mrnFinalApprovalController.preparedById = element.preparedByid;
      mrnFinalApprovalController.ApprovalDateText.text =
          BaseUtitiles.initiateCurrentDateFormat();
      mrnFinalApprovalController.ApprovedbyText.text =
          element.PreapprovedBy.toString();
      mrnFinalApprovalController.VerifiedbyText.text =
          element.VerifiedBy.toString();
      mrnFinalApprovalController.ReqremarksText.text =
          element.req_remarks.toString();
      mrnFinalApprovalController.ApprovalremarksText.text =
      element.app_remarks.toString()=="null" ?"-":element.app_remarks.toString();
    });
    int i = 0;
    mrnFinalApprovalController.MaterialFinalAppr_itemview_GetDbList.forEach((
        element) {
      mrnFinalApprovalController.itemlist_textControllersInitiate();
      mrnFinalApprovalController.BalQty_ListController[i].text =
          element.balqty.toString();
      mrnFinalApprovalController.ReqQty_ListController[i].text =
          element.reqqty.toString();
      mrnFinalApprovalController.ApprQty_ListController[i].text =
          element.appqty.toString();
      mrnFinalApprovalController.Approval_ListController[i].text =
          element.apptype;
      mrnFinalApprovalController.TransfrProject_ListController[i].text =
      element.tranfromprjname.toString() == "null" ? "--SELECT--" : element
          .tranfromprjname.toString();
      mrnFinalApprovalController.projectId[i].text =
          element.tranfromprjid.toString();
      mrnFinalApprovalController.Description_ListController[i].text =
          element.desc.toString();
      mrnFinalApprovalController.Remarks_ListController[i].text =
          element.remarks.toString();
      i++;
    });
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "MRN Final Approval",
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
                            ),),
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
                          padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.RequestNoText,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Request No",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.requestNo),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: mrnFinalApprovalController.RequestDateText,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Request Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: mrnFinalApprovalController.DueDateText,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Due Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),

                                  onTap: () async {
                                    if (mrn_request_controller.saveButton == RequestConstant.RESUBMIT) {
                                    } else {
                                      var Entrydate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  // header background color
                                                  onPrimary: Colors.white,
                                                  // header text color
                                                  onSurface: Colors
                                                      .black, // body text color
                                                ),
                                                textButtonTheme:
                                                TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors
                                                        .black, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          });
                                      mrn_request_controller
                                          .DuedateController.text =
                                          BaseUtitiles.selectDateFormat(Entrydate!);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Container(
                    //   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //       side: BorderSide(color: Colors.white70, width: 1),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     elevation: 3,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    //       child: TextFormField(
                    //         readOnly: true,
                    //         controller: mrnFinalApprovalController.ApprovalNoText,
                    //         cursorColor: Colors.black,
                    //         style: TextStyle(color: Colors.black),
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.zero,
                    //           border: InputBorder.none,
                    //           labelText: "Approval No",
                    //           labelStyle: TextStyle(
                    //               color: Colors.grey,
                    //               fontSize: RequestConstant.Lable_Font_SIZE),
                    //           prefixIconConstraints:
                    //           BoxConstraints(minWidth: 0, minHeight: 0),
                    //           prefixIcon: Padding(
                    //               padding: EdgeInsets.symmetric(
                    //                   vertical: 8, horizontal: 8),
                    //               child: ConstIcons.projectName
                    //
                    //           ),
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty || value == "--Select--") {
                    //             return '\u26A0 Please select project name.';
                    //           }
                    //           return null;
                    //         },
                    //
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.ApprovalDateText,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText:  "Approval Date",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.projectName

                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select project name.';
                              }
                              return null;
                            },

                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: projectController.projectname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Project Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.projectName

                              ),
                            ),
                            onTap: () {
                              // await projectController.getProjectList(context, 0);


                              // if(mrnFinalApprovalController.screenCheck == "PendingScreen"){
                              //
                              // }
                              // else{
                              //   setState(() {
                              //     bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
                              //   });
                              // }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select project name.';
                              }
                              return null;
                            },

                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: siteController.Sitename,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Site Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child:  ConstIcons.siteName
                              ),
                            ),
                            onTap: () {
                              // setState(() {
                              //   bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value);
                              // });
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select site name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.ReqremarksText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Request Remarks",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.preparedBy
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: false,
                            controller: mrnFinalApprovalController.ApprovalremarksText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Approval Remarks",
                              labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), child: ConstIcons.preparedBy
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '\u26A0 ${RequestConstant.VALIDATE}';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),

                    if (mrn_request_controller.checkApprovalLevelData.isNotEmpty && (mrn_request_controller.checkApprovalLevelData[0]["isPreApproval"] ?? false)) Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.ApprovedbyText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText:"Pre Approved By",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.preparedBy
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '\u26A0 Enter user name';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),

                    if (mrn_request_controller.checkApprovalLevelData.isNotEmpty && (mrn_request_controller.checkApprovalLevelData[0]["isVerification"] ?? false)) Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.VerifiedbyText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Verified By",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.remarks
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '\u26A0 Enter user name';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: mrnFinalApprovalController.PreparedbyText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Prepared By",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.remarks
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '\u26A0 Enter user name';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 5),

                    // Row  (
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           primary: Setmybackground,
                    //         ),
                    //         onPressed: () {
                    //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MrnfinalItemList()));
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Icon(
                    //               Icons.add,
                    //               color: Theme.of(context).primaryColor,
                    //             ),
                    //             SizedBox(width: 5),
                    //             Text(
                    //               "Items List",
                    //               style: TextStyle(
                    //                   color: Theme.of(context).primaryColor),
                    //             ),
                    //           ],
                    //         )),
                    //   ],
                    // ),

                  ],
                ),
              ),


            ],
          ),

          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),

            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // Expanded(
                //   child: InkWell(
                //     child: Container(
                //       margin: EdgeInsets.only(left: 20, right: 20),
                //       height: BaseUtitiles.getheightofPercentage(context, 4),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         color: mrnFinalApprovalController.checkColor == 0
                //             ? Colors.white
                //             : Theme.of(context).primaryColor,
                //       ),
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Reset",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: RequestConstant.Lable_Font_SIZE,
                //             color: mrnFinalApprovalController.checkColor == 0
                //                 ? Theme.of(context).primaryColor
                //                 : Colors.white),
                //       ),
                //     ),
                //     onTap: () {
                //       setState(() {
                //         mrnFinalApprovalController.checkColor = 1;
                //         ResetAlert(context);
                //       });
                //     },
                //   ),
                // ),

                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getheightofPercentage(context, 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: mrnFinalApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text( "Next",
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
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MrnfinalItemList()));
                    // if(mrn_request_controller.Material_itemview_GetDbList.value.length < 1){
                    //   BaseUtitiles.showToast("Plese select item list");
                    // }
                    // else if (_formKey.currentState!.validate()) {
                    //   SubmitAlert(context);
                    // }
                    // else {
                    //
                    // }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: ()  {
                          mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
                            mrnFinalApprovalController.RequestNoText.text=element.no.toString();
                            mrnFinalApprovalController.RequestDateText.text=element.date.toString();
                            mrnFinalApprovalController.DueDateText.text=element.dueDate.toString();
                            projectController.projectname.text=element.projectName.toString();
                            projectController.selectedProjectId.value=element.ProjectId!;
                            siteController.selectedsiteId.value=element.SiteId!;
                            siteController.Sitename.text=element.siteName.toString();
                            mrnFinalApprovalController.PreparedbyText.text=element.preparedBy.toString();
                            mrnFinalApprovalController.ApprovalDateText.text=BaseUtitiles.initiateCurrentDateFormat();
                            mrnFinalApprovalController.ApprovedbyText.text=element.PreapprovedBy.toString();
                            mrnFinalApprovalController.VerifiedbyText.text=element.VerifiedBy.toString();
                          });
                          int i=0;
                          mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
                            mrnFinalApprovalController.itemlist_textControllersInitiate();
                            mrnFinalApprovalController.BalQty_ListController[i].text=element.balQty.toString();
                            mrnFinalApprovalController.ReqQty_ListController[i].text=element.reqQty.toString();
                            mrnFinalApprovalController.ApprQty_ListController[i].text=element.qty.toString();
                            mrnFinalApprovalController.Approval_ListController[i].text="P";
                            mrnFinalApprovalController.TransfrProject_ListController[i].text="--SELECT--";
                            mrnFinalApprovalController.projectId[i].text="0";
                            i++;
                          });
                          mrnFinalApprovalController.entrycheck=1;
                          Navigator.pop(context);
                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
