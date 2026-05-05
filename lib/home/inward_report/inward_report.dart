import 'package:url_launcher/url_launcher.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/reports_controller.dart';
import '../../controller/stocksite_controller.dart';
import '../../controller/suppliercontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/sitecontroller.dart';
import '../../controller/subcontcontroller.dart';
import '../../utilities/apiconstant.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pdf_generate/pdf_model/pdfmodel.dart';

class InwardReport extends StatefulWidget {
  const InwardReport({Key? key}) : super(key: key);

  @override
  State<InwardReport> createState() => _InwardReportState();
}

class _InwardReportState extends State<InwardReport> {
  final ProjectController projectController=Get.put(ProjectController());
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  final AttendanceController attendanceController=Get.put(AttendanceController());
  final SiteController siteController=Get.put(SiteController());
  final SupplierController suppliercontroller=Get.put(SupplierController());
  LoginController loginController=Get.put(LoginController());
  CommanController commanController = Get.put(CommanController());
  SupplierController supplierController = Get.put(SupplierController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ReportsController reportsController = Get.put(ReportsController());
  StockSiteController stockSiteController = Get.put(StockSiteController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {

      suppliercontroller.FromdateController.clear();
      suppliercontroller.TodateController.clear();
      DateTime currentDate = DateTime. now();
      suppliercontroller.FromdateController.text=currentDate.toString().substring(0,10);
      suppliercontroller.TodateController.text=currentDate.toString().substring(0,10);
      suppliercontroller.getSupplierListData.value=[];
      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";
      reportsController.suppliername.text = "--ALL--";
      reportsController.selectedsuppliertId.value = 0;
      reportsController.Subheadername.text = "--ALL--";
      reportsController.materialDropdowntId.value = 0;
      await reportsController.getReportProjectList();
      await reportsController.getReportMaterialList();
      await reportsController.getSupplierReportList();

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
                      const Text(
                        "Inward Report",
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
                                controller: suppliercontroller.FromdateController,
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
                                  suppliercontroller.FromdateController.text = Frdate.toString().substring(0, 10);
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
                        child: Container(
                          width: BaseUtitiles.getWidthtofPercentage(context, 38),
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
                                controller: suppliercontroller.TodateController,
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
                                  var Todate = await showDatePicker(
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
                                  suppliercontroller.TodateController.text = Todate.toString().substring(0, 10);
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
                        controller: reportsController.sitename,
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
                              child: ConstIcons.siteName
      
                          ),
                        ),
                        onTap: () async {
                          await siteController.subcontEntry_siteDropdowntList(context, 0,type: "InwardReport");
                              if (mounted) {
                            bottomsheetControllers.siteNameReport(context, siteController.getSiteDropdownvalue.value);
                              }},
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
                        controller: reportsController.suppliername,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Supplier Name",
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
                          setState(() {
                            bottomsheetControllers.supplierNameReport(context, reportsController.supplierListDropdown.value);
                          });
      
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select supplier name.';
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
                              child: ConstIcons.projectName

                          ),
                        ),
                        onTap: () {
                          setState(() {
                            bottomsheetControllers.MRNMaterialName(context, reportsController.getMaterialdropDownvalue.value);
                          });

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select Material Name.';
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
                              color: suppliercontroller.checkColor == 0
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
                                    color: suppliercontroller.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              suppliercontroller.getSupplierListData.value=[];
                              await suppliercontroller.getInwardtList();
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
                              color: suppliercontroller.checkColor == 0
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
                                    color: suppliercontroller.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              download(loginController.user.value.userId!, loginController.user.value.userType!,reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,reportsController.projectname.text,reportsController.sitename.text, reportsController.selectedsuppliertId.value,reportsController.suppliername.text,suppliercontroller.FromdateController.text, suppliercontroller.TodateController.text,reportsController.materialDropdowntId.value);
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


  download(int uid,String uType,int pId,int sId,String pName, String sName,int supId, String supName,String fdate,String todate,mId){
    launch("${ApiConfig.WebURL}mobile-inward-report?fromDate=2020-04-01&toDate=2026-04-06&projectId=$pId&siteId=$sId&supplierId=$supId&materialId=$mId&access_token=${loginController.user.value.accessToken}");
    print("${ApiConfig.WebURL}mobile-inward-report?fromDate=2020-04-01&toDate=2026-04-06&projectId=$pId&siteId=$sId&supplierId=$supId&materialId=$mId&access_token=${loginController.user.value.accessToken}");
  }

  List<PdfListModel> getInwardReportList() {
    suppliercontroller.getSupplierList_Pdf.clear();
    suppliercontroller.getSupplierListData.forEach((element) async {
      var list = PdfListModel(
        inwardNo: element.inwardNo,
        inwardDate: element.inwardDate,
        supplierName: element.supplierName,
        projectName: element.projectName,
      );
      suppliercontroller.getSupplierList_Pdf.add(list);
    });
    return suppliercontroller.getSupplierList_Pdf;
  }

  Widget ListDetails(){
    return Container(
      height:BaseUtitiles.getheightofPercentage(context,50),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height:BaseUtitiles.getheightofPercentage(context,48),
              width: BaseUtitiles.getWidthtofPercentage(context,100),
              child: Obx(()=>ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: suppliercontroller.getSupplierListData.value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        suppliercontroller.OnItemsSelected(suppliercontroller.getSupplierListData.value[index].inwardId,suppliercontroller.getSupplierListData.value[index].inwardNo, context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
                        child: Card(
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
                                              suppliercontroller.getSupplierListData.value[index].inwardDate.toString(),
                                            style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text(suppliercontroller.getSupplierListData.value[index].inwardNo.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text("Project Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        suppliercontroller.getSupplierListData.value[index].projectName.toString(),style: TextStyle(color: Colors.black),
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
                                        suppliercontroller.getSupplierListData.value[index].siteName.toString(),style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text("Supplier Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        suppliercontroller.getSupplierListData.value[index].supplierName.toString(),style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3,),

                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceBetween,
                                //   children: <Widget>[
                                //     Text(suppliercontroller.getSupplierListData.value[index].inwardNo.toString(),style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
                                //     Text(
                                //       (suppliercontroller.getSupplierListData.value[index].inwardDate.toString()),style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
                                //     ),
                                //   ],
                                // ),
                                // Container(
                                //   margin: EdgeInsets.only(top: 10),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       Text(
                                //         ("Project Name "),style: TextStyle(color: Colors.white),
                                //       ),
                                //       Container(
                                //         width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                //         child: Text(
                                //           (suppliercontroller.getSupplierListData.value[index].projectName.toString()),style: TextStyle(color: Colors.white),
                                //         ),
                                //       ),
                                //
                                //     ],
                                //   ),
                                // ),
                                // Container(
                                //   margin: EdgeInsets.only(top: 10),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         ("Site Name " ),style: TextStyle(color: Colors.white),
                                //       ),
                                //       Container(
                                //         width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                //         child: Text(
                                //           (suppliercontroller.getSupplierListData.value[index].siteName.toString()),style: TextStyle(color: Colors.white),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Container(
                                //   margin: EdgeInsets.only(top: 10),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         ("Supplier Name" ),style: TextStyle(color:Colors.white),
                                //       ),
                                //       Container(
                                //         width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                //         child: Text(
                                //           (
                                //              suppliercontroller.getSupplierListData.value[index].supplierName.toString()),style: TextStyle(color:Colors.white),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              ),
            ),
          ),
        ],
      ),
    );

  }

}
