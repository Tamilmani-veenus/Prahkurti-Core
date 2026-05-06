import 'package:url_launcher/url_launcher.dart';
import '../../../../controller/attendancecontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/reports_controller.dart';
import '../../utilities/apiconstant.dart';
import '../pdf_generate/pdf_model/pdfmodel.dart';

class MRNReport extends StatefulWidget {
  const MRNReport({Key? key}) : super(key: key);

  @override
  State<MRNReport> createState() => _MRNReportState();
}

class _MRNReportState extends State<MRNReport> {
  final ProjectController projectController=Get.put(ProjectController());
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  final AttendanceController attendanceController=Get.put(AttendanceController());
  final SiteController siteController =Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  ReportsController reportsController = Get.put(ReportsController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      siteController.FromdateController.clear();
      siteController.TodateController.clear();
      siteController.mrnListValue.value=[];
      DateTime currentDate = DateTime. now();
      siteController.FromdateController.text=currentDate.toString().substring(0,10);
      siteController.TodateController.text=currentDate.toString().substring(0,10);

      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;

      await reportsController.getReportProjectList();
      await reportsController.getReportMaterialList();
      // await reportsController.getSiteReportList(context,0);

      reportsController.selectedsiteId.value=0;
      reportsController.Subheadername.text = "--ALL--";
      reportsController.siteDropdownName.clear();

    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
      
                SizedBox(height: 40),
      
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MRN Report",
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
      
                Container(
                  margin: EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: siteController.FromdateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "From Date",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.date,
                                  ),
                                ),
                                onTap: () async {
                                  var Frdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context).primaryColor, // header background color
                                            onPrimary: Colors.white, // header text color
                                            onSurface: Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.black, // button text color
                                            ),
                                          ),
                                        ),
                                          child: child!,
                                        );
                                      });
                                  siteController.FromdateController.text = Frdate.toString().substring(0, 10);
                                },
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: siteController.TodateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "To Date",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.calendar_month,
                                          color: Theme.of(context).primaryColor)),
                                ),
                                onTap: () async {
                                  var Frdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context).primaryColor, // header background color
                                            onPrimary: Colors.white, // header text color
                                            onSurface: Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.black, // button text color
                                            ),
                                          ),
                                        ),
                                          child: child!,
                                        );
                                      });
                                  siteController.TodateController.text =
                                      Frdate.toString().substring(0, 10);
                                },
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
                      ),
                      // Container(
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //           primary: Theme.of(context).primaryColor),
                      //       onPressed: () async {
                      //         setState(() {
                      //           mrn_request_controller.getMrn_Req_EntryList();
                      //         });
                      //       },
                      //       child: Center(
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(top: 13, bottom: 13),
                      //             child: Text("SHOW",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: RequestConstant.App_Font_SIZE,
                      //                     fontWeight: FontWeight.bold)),
                      //           ))),
                      // ),
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
                        controller: reportsController.projectname,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
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
                          setState(() {
                            bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                          });
      
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
      
                // Container(
                //   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(color: Colors.white70, width: 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     elevation: 3,
                //     child: Padding(
                //       padding:
                //       const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                //       child: TextFormField(
                //         readOnly: true,
                //         controller: reportsController.sitename,
                //         cursorColor: Colors.black,
                //         style: TextStyle(color: Colors.black),
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.zero,
                //           border: InputBorder.none,
                //           labelText: "Site Name",
                //           labelStyle: TextStyle(
                //               color: Colors.grey,
                //               fontSize: RequestConstant.Lable_Font_SIZE),
                //           prefixIconConstraints:
                //           BoxConstraints(minWidth: 0, minHeight: 0),
                //           prefixIcon: Padding(
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 8, horizontal: 8),
                //               child: ConstIcons.siteName
                //
                //           ),
                //         ),
                //         onTap: () {
                //           setState(() {
                //             bottomsheetControllers.siteNameReport(context, reportsController.getSiteDropdownvalue.value );
                //           });
                //         },
                //         validator: (value) {
                //           if (value!.isEmpty) {
                //             return '\u26A0 Please select site name.';
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
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsController.Subheadername,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Material Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.siteName

                          ),
                        ),
                        onTap: () {
                          setState(() {
                            bottomsheetControllers.MRNMaterialName(context, reportsController.getMaterialdropDownvalue.value);

                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select site name.';
                          }
                          return null;
                        },

                      ),
                    ),
                  ),
                ),
      
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
      
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: siteController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("List View",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: siteController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              siteController.mrnListValue.value=[];
                              await siteController.getMrnReporttList();
                            }
                            },
                        ),
      
                        VerticalDivider(
                          color: Colors.grey.shade400,
                          width: 5,
                          thickness: 2,
                          indent: 15,
                          endIndent: 8, //Spacing at the bottom of divider.
                        ),
      
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: siteController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("PDF Download",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: siteController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              await download(reportsController.selectedProjectId.value,reportsController.materialDropdowntId.value,siteController.FromdateController.text,siteController.TodateController.text);
                            }
                          },
                        ),
      
                      ],
                    ),
                  ),
                ),
      
      
                SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2),),
      
                ListDetails(),
      
      
              ],
            ),
          ),
        ),
      ),
    );
  }

  download(int pId,int mId,String fdate,String todate){
    launch("${ApiConfig.WebURL}mobile-mrn-report?fromDate=$fdate&toDate=$todate&projectId=$pId&materialId=$mId&access_token=${loginController.user.value.accessToken}");
    print("${ApiConfig.WebURL}mobile-mrn-report?fromDate=$fdate&toDate=$todate&projectId=$pId&materialId=$mId&access_token=${loginController.user.value.accessToken}");
  }



  Widget ListDetails(){
    return Container(
      height:BaseUtitiles.getheightofPercentage(context,54),
      width: BaseUtitiles.getWidthtofPercentage(context,100),
      child: Obx(()=>ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: siteController.mrnListValue.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                siteController.OnItemsSelected(siteController.mrnListValue.value[index].id,siteController.mrnListValue.value[index].reqNo,context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 3, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only( right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  ConstIcons.list_date,
                                  Text(
                                    siteController.mrnListValue.value[index].reqDate.toString(),
                                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(siteController.mrnListValue.value[index].reqNo.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Project Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                siteController.mrnListValue.value[index].projectName.toString(),style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                siteController.mrnListValue.value[index].siteName.toString(),style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Request Type",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                siteController.mrnListValue.value[index].requestType=="PO"?"General Items":"Asset Materials",style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Status",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                siteController.mrnListValue.value[index].status.toString().toUpperCase(),
                                style:  siteController.mrnListValue.value[index].status.toString() == "APPROVED" ? TextStyle(color: Colors.green, fontWeight: FontWeight.bold) : TextStyle(color: Colors.red, fontWeight: FontWeight.bold) ,
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
    );

  }



  // void Dropdownclear(){
  //   siteController.siteDropdownName.clear();
  //   siteController.selectedsitedropdownName.value="--Select--";
  //
  // }

}
