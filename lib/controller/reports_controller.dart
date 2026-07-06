import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/models/subcontract_dropdown_model.dart';
import '../models/materialwise_materialdropdown_model.dart';
import '../models/supplierdropwon_model.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import '../models/project_dropdownlist_model.dart';


class ReportsController extends GetxController{


  LoginController loginController=Get.put(LoginController());

  final projectname = TextEditingController();
  final sitename = TextEditingController();
  final Subheadername = TextEditingController();
  final suppliername = TextEditingController();
  final subcontractorname = TextEditingController();
  final companyName = TextEditingController();

  //---Projects--
  RxList getProjectdropDownvalue=[].obs;
  RxInt selectedProjectId = 0.obs;

  //---Sites--
  RxList getSiteDropdownvalue = [].obs;
  RxInt selectedsiteId = 0.obs;

  //---Supplier--
  RxList supplierListDropdown = [].obs;
  RxInt selectedsuppliertId = 0.obs;


  //---Subcontractor--
  RxList getdropDownvalue=[].obs;
  RxInt selectedSubcontId = 0.obs;

  //---Material--
  RxList getMaterialdropDownvalue = [].obs;
  RxInt materialDropdowntId = 0.obs;
  RxBool validateProject = false.obs;

  //---Company--
  RxList getCompanyDropDownvalue=[].obs;
  RxInt selectedCompanyId = 0.obs;


  //-------------Get Projects Reports---------------

  Future getReportProjectList({String? type,String? Url}) async {
    getProjectdropDownvalue.value=[];
    final value = await CommonProvider.getproject(type:type,companyId:selectedCompanyId.value);
    if (value != null ) {
    if(value.success == true) {
      getProjectdropDownvalue.value = value.result!;
      if(Url == "Report" || type=="mrnReqTracker"){
        getProjectdropDownvalue.value.insert(
          0,
          Result(projectId: 0, project: "--ALL--"),
        );
      }

    }
    else {
      BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
    }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future getReportMaterialList({type}) async {
    getMaterialdropDownvalue.value=[];
    final value = await ReportsProvider.getReportMrnMaterial(type);
    if (value != null ) {
      if(value.success == true) {
        getMaterialdropDownvalue.value = value.result!;
        getMaterialdropDownvalue.value.insert(
          0,
          MaterialNameResult(id: 0, materialName: "--ALL--"),
        );
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  //---------------Get Sites Reports-------------

  Future getSiteReportList(BuildContext context,int pId) async {
    getSiteDropdownvalue.value.clear();
    final value = await ReportsProvider.getsiteReports(pId);
    if (value != null ) {
      if(value.success == true)
        {
          getSiteDropdownvalue.value = value.result!;
        }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  //------------Get Supplier Reports----------



  Future getSupplierReportList() async {
    supplierListDropdown.value.clear();
    final value = await ReportsProvider.getsupplierReports();
    if (value != null ) {
      if(value.success == true) {
        supplierListDropdown.value = value.response!;
        supplierListDropdown.value.insert(
          0,
          SupplierResponse(id: 0, supplierName: "--ALL--"),
        );
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


 //------------Get Subcontractor Reports----------

  Future getSubcontactorReportList() async {
    getdropDownvalue.value=[];
    final value = await ReportsProvider.getsubcontactorReports();
    if (value != null ) {
      if(value.success == true) {
        getdropDownvalue.value = value.result!;
        getdropDownvalue.value.insert(
          0,
          SubcontResult(subContId: 0, subContName: "--ALL--"),
        );
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  //------------Get Company Reports----------

  Future getCompanyReportList({type}) async {
    getCompanyDropDownvalue.value=[];
    final value = await ReportsProvider.getCompanyReports();
    if (value != null ) {
      if(value["success"] == true) {
        getCompanyDropDownvalue.value = value["result"];
        if(type=="MRNReqTracker") {
          getCompanyDropDownvalue.insert(0, {
            "id": 0,
            "companyName": "--ALL--",
          });
        }
        else{
          getCompanyDropDownvalue.insert(0, {
            "id": 0,
            "companyName": "--SELECT--",
          });
        }
      }else {
        BaseUtitiles.showToast(value["message"] ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }
}