import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';
import 'mrnpreapr_itemlist.dart';

class MrnPreApprovalEntryScreen extends StatefulWidget {
  const MrnPreApprovalEntryScreen({Key? key, required this.heading }) : super(key: key);
  final String heading;
  @override
  State<MrnPreApprovalEntryScreen> createState() => _MrnPreApprovalEntryScreenState();
}


class _MrnPreApprovalEntryScreenState extends State<MrnPreApprovalEntryScreen> {
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  PendingListController pendingListController=Get.put(PendingListController());
  MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    super.initState();
    _initializeData(); // call separate async function
  }

  Future<void> _initializeData() async {
    await mrn_request_controller.getAppTypeList();

    // 🔹 Header Data
    for (var element in mrnPreApprovalController.mrnPreAppDetList) {
      mrnPreApprovalController.mrnpre_RequestNoText.text =
          element.no.toString();
      mrnPreApprovalController.mrnpre_RequestDateText.text =
          element.date.toString();
      mrnPreApprovalController.mrnpre_DueDateText.text =
          element.dueDate.toString();

      projectController.projectname.text = element.projectName.toString();
      projectController.selectedProjectId.value = element.ProjectId!;
      siteController.selectedsiteId.value = element.SiteId!;
      siteController.Sitename.text = element.siteName.toString();

      mrnPreApprovalController.mrnpre_PreparedbyText.text =
          element.preparedBy.toString();
      mrnPreApprovalController.preparedById = element.preparedByid;

      mrn_request_controller.ReqType.value = element.requestType;

      mrnPreApprovalController.mrnpre_ApprovalDateText.text =
          BaseUtitiles.initiateCurrentDateFormat();

      mrnPreApprovalController.mrnpre_ApprovedbyText.text =
          loginController.EmpName();

      mrnPreApprovalController.mrnpre_VerifiedbyText.text =
          element.VerifiedBy.toString();

      mrnPreApprovalController.mrnpre_ReqremarksText.text =
      element.req_remarks == "" ? "-" : element.req_remarks;

      mrnPreApprovalController.mrnpre_ApprovalremarksText.text = "";
    }

    // 🔹 Item List
    int i = 0;
    for (var element in mrnPreApprovalController.MaterialAppr_itemview_GetDbList) {
      mrnPreApprovalController.itemlist_textControllersInitiate();

      mrnPreApprovalController.mrnpre_BalQty_ListController[i].text =
          element.balqty.toString();

      mrnPreApprovalController.mrnpre_ReqQty_ListController[i].text =
          element.reqqty.toString();

      mrnPreApprovalController.mrnpre_ApprQty_ListController[i].text =
          element.appqty.toString();

      // ✅ Default approvalType
      mrnPreApprovalController.mrnpre_Approval_ListController[i].text = "P";

      mrnPreApprovalController
          .mrnpre_TransfrProject_ListController[i].text = "--SELECT--";

      mrnPreApprovalController.mrnpre_projectId[i].text = "0";

      mrnPreApprovalController.mrnpre_Description_ListController[i].text =
          element.desc.toString();

      mrnPreApprovalController.mrnpre_Remarks_ListController[i].text =
          element.remarks.toString();

      i++;
    }

    // 🔥 IMPORTANT (if UI depends on this)
    setState(() {});
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
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and button
                    children: [
                      Text(
                        widget.heading, // Display the heading passed to the widget
                        style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back", // Text on the button
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
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
                        controller: mrnPreApprovalController.mrnpre_RequestNoText,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
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
                              controller: mrnPreApprovalController.mrnpre_RequestDateText,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                              controller:mrnPreApprovalController.mrnpre_DueDateText,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                              // onTap: () async {
                              //   if (mrn_request_controller.editCheck == 1) {
                              //   } else {
                              //     var Entrydate = await showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.now(),
                              //         firstDate: DateTime(2000),
                              //         lastDate: DateTime(2100),
                              //         builder: (context, child) {
                              //           return Theme(
                              //             data: Theme.of(context).copyWith(
                              //               colorScheme: ColorScheme.light(
                              //                 primary: Theme.of(context)
                              //                     .primaryColor,
                              //                 // header background color
                              //                 onPrimary: Colors.white,
                              //                 // header text color
                              //                 onSurface: Colors
                              //                     .black, // body text color
                              //               ),
                              //               textButtonTheme:
                              //               TextButtonThemeData(
                              //                 style: TextButton.styleFrom(
                              //                   primary: Colors
                              //                       .black, // button text color
                              //                 ),
                              //               ),
                              //             ),
                              //             child: child!,
                              //           );
                              //         });
                              //     mrn_request_controller
                              //         .DuedateController.text =
                              //         BaseUtitiles.selectDateFormat(Entrydate!);
                              //   }
                              // },
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
                //         controller: mrnPreApprovalController.mrnpre_ApprovalNoText,
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
                        controller: mrnPreApprovalController.mrnpre_ApprovalDateText,
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
                          // // await projectController.getProjectList(context, 0);
                          // setState(() {
                          //   bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
                          // });
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
                        // onTap: () {
                        //   setState(() {
                        //     bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value);
                        //   });
                        // },
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
                        controller: mrnPreApprovalController.mrnpre_ReqremarksText,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
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
                    child: Padding(padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        readOnly: false,
                        controller: mrnPreApprovalController.mrnpre_ApprovalremarksText,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Pre Approval Remarks",
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 ${RequestConstant.VALIDATE}';
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
                        controller: mrnPreApprovalController.mrnpre_ApprovedbyText,
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
                        controller: mrnPreApprovalController.mrnpre_VerifiedbyText,
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
                        controller: mrnPreApprovalController.mrnpre_PreparedbyText,
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


              ],
            ),
          ),



          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: mrnPreApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text( "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: mrnPreApprovalController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    mrnPreApprovalController.checkColor = 0;
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MrnPreapprovalItemlist()));
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
                          pendingListController.mrnPreapprovallist.forEach((element) {
                            mrnPreApprovalController.mrnpre_RequestNoText.text=element.no.toString();
                            mrnPreApprovalController.mrnpre_RequestDateText.text=element.date.toString();
                            mrnPreApprovalController.mrnpre_DueDateText.text=element.dueDate.toString();
                            projectController.projectname.text=element.projectName.toString();
                            projectController.selectedProjectId.value=element.ProjectId!;
                            siteController.selectedsiteId.value=element.SiteId!;
                            siteController.Sitename.text=element.siteName.toString();
                            mrnPreApprovalController.mrnpre_PreparedbyText.text=element.preparedBy.toString();
                            mrnPreApprovalController.mrnpre_ApprovalDateText.text=BaseUtitiles.initiateCurrentDateFormat();
                            mrnPreApprovalController.mrnpre_ApprovedbyText.text=loginController.EmpName();
                            mrnPreApprovalController.mrnpre_VerifiedbyText.text=element.VerifiedBy.toString();
                          });
                          int i=0;
                          mrnPreApprovalController.mrnPreAppDetList.forEach((element) {
                            mrnPreApprovalController.itemlist_textControllersInitiate();
                            mrnPreApprovalController.mrnpre_BalQty_ListController[i].text=element.balQty.toString();
                            mrnPreApprovalController.mrnpre_ReqQty_ListController[i].text=element.reqQty.toString();
                            mrnPreApprovalController.mrnpre_ApprQty_ListController[i].text=element.qty.toString();
                            mrnPreApprovalController.mrnpre_Approval_ListController[i].text="PO";
                            mrnPreApprovalController.mrnpre_TransfrProject_ListController[i].text="--SELECT--";
                            mrnPreApprovalController.mrnpre_projectId[i].text="0";
                            i++;
                          });
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
