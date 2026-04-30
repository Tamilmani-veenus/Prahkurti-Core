import 'package:prahkurticore/controller/reports_controller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../home/inward_report/inward_popup.dart';
import '../home/pdf_generate/pdf_model/pdfmodel.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class SupplierController extends GetxController {
  final Suppliername=new TextEditingController();
  RxList supplierListDropdown = [].obs;
  RxList mainlist=[].obs;
  RxList supplierDropdownName = [].obs;
  RxList getSupplierListData=[].obs;
  List <PdfListModel> getSupplierList_Pdf = <PdfListModel>[];
  RxInt selectedsuppliertId = 0.obs;
  RxString selectedSupplierName = "".obs;
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  ReportsController reportsController = Get.put(ReportsController());
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  RxList selctListDatas = [].obs;
  int checkColor = 0;
  LoginController loginController = Get.put(LoginController());


  Future getSupplierList(BuildContext context) async {
    supplierListDropdown.value = await CommonProvider.getSupplierDropdown();
    supplierListDropdown.value.forEach((element) {
      return supplierDropdownName.value.add(element.supplierName);
    });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return SupplierShowPopup(list:supplierListDropdown.value);
    //     });
  }

  setSelectSupplierID(String value) {
    if (supplierListDropdown.value.length > 0) {
      supplierListDropdown.forEach((element) {
        if (value == element.supplierName) {
          selectedsuppliertId(element.supplierId);
        }
      });
    }
    setSelectSupplierName(selectedsuppliertId.value);
  }

  setSelectSupplierName(int? id) {
    if (supplierListDropdown.value != null) {
      supplierListDropdown.value.forEach((element) {
        if (id == element.supplierId) {
          selectedSupplierName(element.supplierName.toString());
        }
      });
    }
    Suppliername.text=selectedSupplierName.value;
  }

  Future getInwardtList() async {
    getSupplierListData.value.clear();
    await ReportsProvider.getInward_Report_List(reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,reportsController.selectedsuppliertId.value,FromdateController.text,TodateController.text,loginController.user.value.userType.toString(),
        loginController.user.value.userId!).then((value)async{
      if(value!=null&& value.length>0){
        getSupplierListData.value=value;
        return getSupplierListData.value;
      }
      else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future OnItemsSelected(int slectid,String inwardNo,BuildContext context)async{
    await ReportsProvider.onItemSelctInwardList(slectid).then((value)async{
      if(value!=null&&value.length>0){
        selctListDatas.value=value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return inwardPopup(list:selctListDatas.value, inwardNo:inwardNo);
            });
      }
    });
  }
 // @override
  // void onInit() {
  //
  //   super.onInit();
  // }

}