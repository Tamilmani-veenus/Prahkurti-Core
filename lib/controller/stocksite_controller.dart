
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prahkurticore/controller/logincontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';
import 'package:prahkurticore/models/getstockprojwise_model.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../home/stock_site/project_details_popup.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';


// class HomeState{
//   GetstockprojwiseModel? _getstockprojwiseModel;
//   GetstockprojwiseModel? get stockRepDetails => _getstockprojwiseModel;
//
//   // var _getStockReport = <GetStockReport>[];
//   //
//   // // Getter for _getStockReport
//   // List<GetStockReport>? get getStockReport => _getStockReport;
//   //
//   // // Setter for _getStockReport
//   // set getStockReport(List<GetStockReport>? value) {
//   //   _getStockReport = value!;
//   // }
//
//   HomeState();
// }


class StockSiteController extends GetxController{

  final Materialsubname = TextEditingController();
  final materialHeadName = TextEditingController();
  final Subheadername = TextEditingController();
  RxList projectShowList=[].obs;
  RxList projectDetailsList=[].obs;

  RxList materialWiseShowList=[].obs;


  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  ReportsController reportsController = Get.put(ReportsController());
  LoginController loginController = Get.put(LoginController());

  RxList getmaterialSubdropDownvalue = [].obs;
  RxList getmaterialHeadDropDownvalue = [].obs;
  RxList mainlist = [].obs;
  RxList submaterialDropdownName = [].obs;
  RxList headMaterialDropdownName = [].obs;
  RxInt matDropdowntId = 0.obs;
  RxInt matHeadDropdowntId = 0.obs;
  RxString matdropdownName = "".obs;

  RxList getSubHeaddropDownvalue = [].obs;
  RxList HeadDropdownName = [].obs;
  RxInt subHeadDropdowntId = 0.obs;
  RxString subHeadDropdownName = "".obs;

  RxList getMaterialdropDownvalue = [].obs;
  RxList MaterialNamemainlist = [].obs;
  RxList getMaterialDropdownName = [].obs;
  RxInt materialDropdowntId = 0.obs;
  RxString materiaDropdownName = "".obs;

  int reportScreen = 0;




  /// ----- ProjectWise -----

    Future getProjectWiseSubmatList(headId) async {
      getmaterialSubdropDownvalue.value.clear();
      final value = await CommonProvider.materialWise_sub_HeadDropdown(headId);
      if (value != null ) {
        if(value.success == true) {
          getmaterialSubdropDownvalue.value = value.result!;
        }else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      }
      else{
        BaseUtitiles.showToast('Something went wrong..');
      }
    }

  // Future getProjectWiseSubmatList(BuildContext context,mhId, reportScreen) async {
  //   getmaterialSubdropDownvalue.value= await CommonProvider.getmaterialsubDropdown(mhId, reportScreen);
  //   getmaterialSubdropDownvalue.value.forEach((element) {
  //     return submaterialDropdownName.value.add(element.materialSubname);
  //   });
  // }

  Future getMaterialHeadReportList() async {
    getmaterialHeadDropDownvalue.value.clear();
    final value = await CommonProvider.materialWise_HeadDropdown();
    if (value != null)
    {
      if(value.success == true)
        {
      getmaterialHeadDropDownvalue.value = value.result!;
        }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  setSelectedHeadMatID(String value) {
    if (getmaterialHeadDropDownvalue.value.length>0) {
      getmaterialHeadDropDownvalue.forEach((element) {
        if(value == element.materialHeadName){
          matDropdowntId(element.id);
        }
      });
    }
    setSelectedHeadMatListName(matDropdowntId.value);
  }

  setSelectedHeadMatListName(int? id) {
    if (getmaterialHeadDropDownvalue.value != null) {
      getmaterialHeadDropDownvalue.value.forEach((element) {
        if (id == element.id) {
          matdropdownName(element.materialHeadName);
        }
      });
    }
    Materialsubname.text=matdropdownName.value;
  }




  setSelectedSubMatID(String value) {
    if (getmaterialSubdropDownvalue.value.length>0) {
      getmaterialSubdropDownvalue.forEach((element) {
        if(value == element.materialSubname){
          matDropdowntId(element.materialSubId);
        }
      });
    }
    setSelectedSubMatListName(matDropdowntId.value);
  }

  setSelectedSubMatListName(int? id) {
    if (getmaterialSubdropDownvalue.value != null) {
      getmaterialSubdropDownvalue.value.forEach((element) {
        if (id == element.materialSubId) {
          matdropdownName(element.materialSubname);
        }
      });
    }
    Materialsubname.text=matdropdownName.value;
  }

  var groupedlist;

  // Future getProjectShow() async {
  //   projectShowList.clear();
  //       await ReportsProvider.getProject_Show_List(
  //       loginController.user.value.userId!,
  //       loginController.user.value.userType!,
  //       reportsController.selectedProjectId.value,
  //       reportsController.selectedsiteId.value,
  //       matDropdowntId.value,
  //       matHeadDropdowntId.value).then((value)async{
  //     print("Project id :: ${reportsController.selectedProjectId.value}");
  //     print("Site id :: ${reportsController.selectedsiteId.value}");
  //     print("Mat id :: ${matDropdowntId.value}");
  //     if(value != null){
  //       projectShowList.value=value;
  //       // projectShowList.forEach((element) {
  //       //   // if(groupedlist['$group']){
  //       //   //
  //       //   // }
  //       //
  //       // });
  //       return projectShowList.value;
  //     } else {
  //       Fluttertoast.showToast(msg: "No details found");
  //     }
  //   });
  // }
  // StockRepDetails? _stockRepDetails;
  // // StockRepDetails? get stockRepDetails => _stockRepDetails;

  RxList stockReportList = [].obs;
  GetstockprojwiseModel? _getstockprojwiseModel;
  GetstockprojwiseModel? get getStockReport => _getstockprojwiseModel;

  StockRepDetails? _getStockReport;
  StockRepDetails? get stockRepDetails => _getStockReport;

  List<GetStockReport>?  getStockReportList = [];
  List<StockRepDetails>?  getStockReportDetList = [];
  RxList<GetStockReport> getStockList = <GetStockReport>[].obs;
  RxList<StockRepDetails> getStockDetList = <StockRepDetails>[].obs;

  clearlistData(){
   getStockReportList!.clear();
   getStockReportDetList!.clear();
   getStockList.clear();
   getStockDetList.clear();
  }


  Future getProjectwiseshow() async {
    getStockReportList!.clear();
    getStockReportDetList!.clear();
    getStockList.clear();
    getStockDetList.clear();
    try {
      // Assuming ReportsProvider().stockReportProvider(...) returns a List<StockReport>
      GetstockprojwiseModel getstockprojwiseModel = await ReportsProvider().stockReportProvider(
        loginController.user.value.userId!,
        loginController.user.value.userType!,
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        matDropdowntId.value,
        matHeadDropdowntId.value,
      );
      _getstockprojwiseModel = getstockprojwiseModel;

      if (getstockprojwiseModel.getStockReport != null && getstockprojwiseModel.getStockReport!.isNotEmpty) {
        getStockReportList = getstockprojwiseModel.getStockReport;
        getStockList.value = getStockReportList!;
        for (var report in getStockList.value!) {
          if (report.stockRepDetails != null) {
            getStockReportDetList!.addAll(report.stockRepDetails!);
            getStockDetList.value = getStockReportDetList!;
            // return getStockReportDetList;
          }
        }
        print('REPORT DATAS1 :: $getStockReportDetList');
        // for (var report in getStockReportList!) {
        //   if (report.stockRepDetails != null) {
        //     getStockReportDetList!.addAll(report.stockRepDetails!);
        //
        //     print('REPORT DATAS1 :: $getStockReportDetList');
        //     return getStockReportDetList;
        //   }
        // }
      }
      else {
        BaseUtitiles.showToast("No record found...");
      }
      // return getStockReportList;
    } catch (e) {
      // Handle exceptions or errors here
      print('Error fetching data: $e');
      rethrow; // Optionally rethrow the exception
    }
  }



  /// ----Try this function
  Future getProjectShowData() async {
    // HomeState homeState = state!;
    // GetStockReport getStockReport = await ReportsProvider().stockReportProvider(
        await ReportsProvider().stockReportProvider(
        loginController.user.value.userId!,
        loginController.user.value.userType!,
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        matDropdowntId.value,
        matHeadDropdowntId.value).then((value)async{
          if(value != null){
            stockReportList.value = value as List;
          }else{
            BaseUtitiles.showToast("No record found...");
          }
          return stockReportList.value;
    });

    // if(getStockReport == null ? getStockReport.stockRepDetails.isNotEmpty){
    //
    // }

      // getStockReport.stockRepDetails = getStockReport as List<StockRepDetail>;
      // if(getStockReport.stockRepDetails.isNotEmpty){
      //   stockRepDetailsList = getStockReport.stockRepDetails;
      // }else{
      //   BaseUtitiles.showToast("No record found...");
      // }
      // return stockRepDetailsList;
    // stockRepDetailsList = getStockReport.stockRepDetails;



    // homeState._punchFilterResponse = punchFilterResponse;
    // if (punchFilterResponse.employeeTiming!.isNotEmpty) {
    //   punchFilterList = punchFilterResponse.employeeTiming;
    // } else {
    //   BaseUtitiles.showToast("No record found...");
    // }
    // return punchFilterList;
  }



  Future getProjectDetailisList(BuildContext context, String pName) async {
    projectDetailsList.value.clear();
    await ReportsProvider.getProject_Details_List(reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,matDropdowntId.value,matHeadDropdowntId.value).then((value)async{
      if(value.isNotEmpty){
        projectDetailsList.value=value;
        return  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetailsPopup(list:projectDetailsList.value,ProjectName: pName)));
      } else {
        Fluttertoast.showToast(msg: "No details found");
      }
    });
  }


  Future getmaterialDropdowntList(mId) async {
    getMaterialdropDownvalue.value.clear();
    final value = await CommonProvider.materialWise_Based_HeadDropdown(mId);
    if (value != null ) {
      if(value.success == true) {
        getMaterialdropDownvalue.value = value.result!;
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  // Future getmaterialDropdowntList(BuildContext context,subId,mhId,reportScreen) async {
  //   getMaterialdropDownvalue.value = await CommonProvider.getMaterialDropdown(subId,mhId, reportScreen);
  //   // getMaterialdropDownvalue.value = await CommonProvider.getMaterialDropdown(matDropdowntId.value,mhId, reportScreen);
  //   getMaterialdropDownvalue.value.forEach((element) {
  //     return getMaterialDropdownName.add(element.materialName);
  //   });
  // }

  selectedMaterialID(String value) {
    if (getMaterialdropDownvalue.value.length>0) {
      getMaterialdropDownvalue.forEach((element) {
        if(value == element.materialName){
          materialDropdowntId(element.materialId);
        }
      });
    }
    selectedMaterialName(materialDropdowntId.value);
  }

  selectedMaterialName(int? id) {
    if (getMaterialdropDownvalue.value != null) {
      getMaterialdropDownvalue.value.forEach((element) {
        if (id == element.materialId) {
          materiaDropdownName(element.materialName);
        }
      });
    }
    Subheadername.text=materiaDropdownName.value;
  }

  Future getMaterialShowList() async {
    materialWiseShowList.value.clear();
    await ReportsProvider.getMaterialWise_Show_List(
        loginController.user.value.userId!,
        loginController.user.value.userType!,
        matDropdowntId.value,
        materialDropdowntId.value,matHeadDropdowntId.value
    ).then((value)async{
      if(value.isNotEmpty){
        materialWiseShowList.value=value;
        return materialWiseShowList.value;
      } else {
        Fluttertoast.showToast(msg: "No details found");
      }
    });
  }

}