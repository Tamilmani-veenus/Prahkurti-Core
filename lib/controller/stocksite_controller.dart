
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
  RxInt materialSubDropdowntId = 0.obs;
  RxString materiaDropdownName = "".obs;





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

  RxList<GetStockReport> getStockList = <GetStockReport>[].obs;


  Future getProjectwiseshow(type) async {
    getStockList.clear();

      final value = await ReportsProvider().stockReportProvider(
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        matHeadDropdowntId.value,
        materialSubDropdowntId.value,
          reportsController.materialDropdowntId.value,
        type=="Projectwise"?"1":"2"
      );
    if (value != null) {
      if(value.success == true){
        if(value.getStockReport!.isNotEmpty) {
            getStockList.value = value.getStockReport!;
            print('✅ PROJECT COUNT: ${getStockList.value!.length}');
        }
        else {
          BaseUtitiles.showToast(value.message ?? "No Data Found");
        }
      }
      else{
        BaseUtitiles.showToast(value.message ??"Something went wrong..");
      }
    }else
    {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  Future getProjectDetailisList(BuildContext context, String pName) async {
    projectDetailsList.value.clear();
    final value = await ReportsProvider.getProject_Details_List(
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        matDropdowntId.value,matHeadDropdowntId.value);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
          projectDetailsList.value = value.result!;
          return  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetailsPopup(list:projectDetailsList.value,ProjectName: pName)));

        }
        else {
          BaseUtitiles.showToast(value.message ?? "No Data Found");
        }
      }
      else{
        BaseUtitiles.showToast(value.message ??"Something went wrong..");
      }
    }else
    {
      BaseUtitiles.showToast("Something went wrong..");
    }
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

  selectedMaterialID(String value) {
    if (getMaterialdropDownvalue.value.length>0) {
      getMaterialdropDownvalue.forEach((element) {
        if(value == element.materialName){
          materialSubDropdowntId(element.materialId);
        }
      });
    }
    selectedMaterialName(materialSubDropdowntId.value);
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
        materialSubDropdowntId.value,matHeadDropdowntId.value
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