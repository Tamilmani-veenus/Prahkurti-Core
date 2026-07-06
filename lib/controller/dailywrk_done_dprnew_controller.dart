import 'dart:convert';
import 'dart:io';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/headname_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../db_model/dpr_new_detTable_model.dart';
import '../db_model/dpr_new_labourTable_model.dart';
import '../db_model/dpr_new_massTable_model.dart';
import '../db_model/dpr_new_materialTable_model.dart';
import '../db_model/dpr_new_measurementTable_model.dart';
import '../db_services/dpr_new_det_service.dart';
import '../db_services/dpr_new_labour_service.dart';
import '../db_services/dpr_new_mass_service.dart';
import '../db_services/dpr_new_material_service.dart';
import '../db_services/dpr_new_measurement_service.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/addBoqdetails_popup.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_work_done_dprnew.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_wrkdone_dpr_entrylistnew.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_wrkdone_dpr_entrynew.dart';
import '../models/dailywrk_done_dpr_new_save_api_model.dart';
import '../provider/daily_wrkdone_dprNew_provider.dart';
import '../provider/inward_pending_provider.dart';
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyWrkDone_DPRNEW_Controller extends GetxController {

  RxInt selectedMatId=0.obs;
  RxString selectedMatName="".obs;
  RxList materialNameList=[].obs;
  RxList dprNew_EditApiList = [].obs;
  RxList dprNew_EditDetApiList = [].obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  double curQtyAmt=0.0;
  double AddQty=0.0;
  RxList dprNew_mainList = [].obs;
  var imageFiles = <File>[].obs;
  var gettingNetworkImages = <String>[].obs;
  List<int> imageIds = [];
  RxInt pickedImageCount = 0.obs;
  double currentQty=0.0;
  RxInt matScaleId = 0.obs;

  final autoYearWiseNoController = TextEditingController();
  final dateController = TextEditingController();
  final dpr_new_preparedbyController = TextEditingController();
  final dpr_new_referenceController = TextEditingController();
  final dpr_new_remarksController = TextEditingController();
  final dpr_new_descripionController = TextEditingController();
  final dpr_new_rateController = TextEditingController();
  final dpr_new_unitsController = TextEditingController();
  final dpr_new_boqQtyController = TextEditingController();
  final dpr_new_currQtyController = TextEditingController();

  final dpr_new_Mat_NameController = TextEditingController();
  final dpr_new_Mat_QtyController = TextEditingController();
  final dpr_new_Mat_ScaleController = TextEditingController();


  final dpr_new_Measur_DescController = TextEditingController();
  final dpr_new_Measur_NosController = TextEditingController();
  final dpr_new_Measur_LengthController = TextEditingController();
  final dpr_new_Measur_BreathController = TextEditingController();
  final dpr_new_Measur_DepthController = TextEditingController();
  List<TextEditingController> dpr_new_MeasurListDescController = [];
  List<TextEditingController> dpr_new_MeasurListNosController = [];
  List<TextEditingController> dpr_new_MeasurListLengthController = [];
  List<TextEditingController> dpr_new_MeasurListBreathController = [];
  List<TextEditingController> dpr_new_MeasurListDepthController = [];
  List<TextEditingController> dpr_new_MeasurListQtyController = [];
  List<TextEditingController> dpr_new_Mat_QtylistTextControllers = [];


  List<TextEditingController> NosControllers = [];
  List<TextEditingController> OtHrsController = [];
  List<TextEditingController> OtAmtController = [];
  List<TextEditingController> NetAmtController = [];
  List<TextEditingController> RemarksController = [];

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  LoginController loginController=Get.put(LoginController());
  PendingListController pendingListController=Get.put(PendingListController());

  double totalNetAmnt=0.0;
  RxList dprNew_BoqDetailsList = [].obs;
  RxList dprNew_LabourList = [].obs;
  RxInt level3ItemIdValue=0.obs;
  RxList dpr_New_entryList = [].obs;
  final dpr_New_entryList_frdateController = TextEditingController();
  final dpr_New_entryList_todateController = TextEditingController();

  var dprNew_MassService = DprNew_MassService();
  var dprNew_DetService = DprNew_DetService();
  var dprNew_LabourService = DprNew_LabourService();
  var dprNew_MaterialService = DprNew_MaterialService();
  var dprNew_MeasurementService = DprNew_MeasurementService();

  var dprNewMassmodel = DprNew_MassModel();
  late List<DprNew_MassModel> dprNewMassModelList = <DprNew_MassModel>[];

  var dprNewDetmodel = DprNew_DetTable();
  late List<DprNew_DetTable> dprNewDetModelList = <DprNew_DetTable>[];
  List dprNew_DetReadList = <DprNew_DetTable>[];
  RxList dprNew_EntryDetReadList =[].obs;

  var dprNew_LabourTable = DprNew_LabourTable();
  late List<DprNew_LabourTable> dprNewLabourModelList = <DprNew_LabourTable>[];
  List dprNew_LabourReadList = <DprNew_LabourTable>[];
  late List<DprNew_LabourTable> dprNew_UpdateModelListReadList = <DprNew_LabourTable>[];


  var dprNew_MaterialTable = DprNew_MaterialTable();
  late List<DprNew_MaterialTable> dprNewMaterialModelList = <DprNew_MaterialTable>[];
  List dprNew_MatReadList = <DprNew_MaterialTable>[];
  RxList dprNewGetMatreadListdata = [].obs;
  RxList MaterialApiList = [].obs;
  RxList mainlist=[].obs;
  late List<DprNew_MaterialTable> dprNewMaterialUpdateModelList = <DprNew_MaterialTable>[];
  late List<DprNew_MaterialTable> deletedprNewMaterialModelList = <DprNew_MaterialTable>[];

  var dprNew_MeasurementTable=DprNew_MeasurementTable();
  late List<DprNew_MeasurementTable> DprNewMeasurementModelList = <DprNew_MeasurementTable>[];
  List dprNew_MeasurementReadList = <DprNew_MeasurementTable>[];
  RxList dprNewGetMSRreadListdata = [].obs;
  late List<DprNew_MeasurementTable> dprNewMSRUpdateModelList = <DprNew_MeasurementTable>[];
  late List<DprNew_MeasurementTable> deletedprNewMSRModelList = <DprNew_MeasurementTable>[];

  RxList<SubContractDailyWorkDet> getDprNewDetList = <SubContractDailyWorkDet>[].obs;
  RxList<SubcontractDailyWorkLabour> getDprNewLabList = <SubcontractDailyWorkLabour>[].obs;
  RxList<SubcontractDailyWorkCement> getDprNewMatList = <SubcontractDailyWorkCement>[].obs;
  RxList<SubcontractDailyWorkMeasurement> getDprNewMSRList = <SubcontractDailyWorkMeasurement>[].obs;

  RxList dummyListData=[].obs;
  RxList list=[].obs;

  Future getAddBoqDetails(BuildContext context) async {
    dprNew_BoqDetailsList.value=[];
    var response = await DPR_New_Provider.dprNew_getBoqDetails(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        dailyWrkDone_DPR_Controller.TypeSubcontId.value,
        siteController.selectedHeadId.value,
        dailyWrkDone_DPR_Controller.entryType);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          dprNew_BoqDetailsList.value = response.result!;
          dprNew_mainList.value = dprNew_BoqDetailsList.value;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddBoqPopup(list: dprNew_BoqDetailsList.value);
              });
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  dprNew_DetTable_Delete() async {
    await dprNew_DetService.DprNew_Dettable_delete();
  }

  dprNew_DetTableSave(var element) async {
    dprNewDetModelList.clear();
    dprNewDetmodel = new DprNew_DetTable();
    dprNewDetmodel.reqDetId = 0;
    dprNewDetmodel.headItemId = element.headItemIdd;
    dprNewDetmodel.subItemId = element.subItemId;
    dprNewDetmodel.level3ItemId = element.measureLevel3ItemId;
    dprNewDetmodel.woDetId = element.workdetid;
    dprNewDetmodel.itemDesc = element.itemdesc.toString();
    dprNewDetmodel.rate = element.rate;
    dprNewDetmodel.unit = element.scaleName;
    dprNewDetmodel.unitId = element.unit;
    dprNewDetmodel.balQty = element.balQty;
    dprNewDetmodel.qty = element.qty;
    dprNewDetmodel.boqCode = element.boqcode;
    dprNewDetmodel.cement = element.cement;
    dprNewDetmodel.workremarks = element.workremarks;
    dprNewDetmodel.workdetid = element.workdetid;
    dprNewDetmodel.siteid = element.siteid;
    dprNewDetmodel.amt = element.amt;
    dprNewDetModelList.add(dprNewDetmodel);
    var savedatas = await dprNew_DetService.DprNew_DetTable_Save(dprNewDetModelList);
    return savedatas;
  }

  Future getDetTablesDatas() async {
    dprNew_EntryDetReadList.clear();
    var datas = await dprNew_DetService.DprNew_DetTable_readAll();
    dprNew_DetReadList = <DprNew_DetTable>[];
    dprNew_DetReadList.clear();
    datas.forEach((value) {
      dprNewDetmodel = new DprNew_DetTable();
      dprNewDetmodel.reqDetId = value['reqDetId'];
      dprNewDetmodel.headItemId = value['headItemId'];
      dprNewDetmodel.subItemId = value['subItemId'];
      dprNewDetmodel.level3ItemId = value['level3ItemId'];
      dprNewDetmodel.woDetId = value['woDetId'];
      dprNewDetmodel.itemDesc = value['itemDesc'];
      dprNewDetmodel.rate = value['rate'];
      dprNewDetmodel.unit = value['units'];
      dprNewDetmodel.unitId = value['unitId'];
      dprNewDetmodel.balQty = value['balQty'];
      dprNewDetmodel.qty = value['qty'];
      dprNewDetmodel.boqCode = value['boqCode'];
      dprNewDetmodel.cement = value['cement'];
      dprNewDetmodel.workremarks = value['workremarks'];
      dprNewDetmodel.workdetid = value['workdetid'];
      dprNewDetmodel.siteid = value['siteid'];
      dprNewDetmodel.amt = value['amt'];
      dprNew_DetReadList.add(dprNewDetmodel);
      dprNew_EntryDetReadList.value=dprNew_DetReadList;
    });
    setTextValue(dprNew_EntryDetReadList);
  }

  setTextValue(vale) {
    vale.forEach((datas) {
      dpr_new_rateController.text = datas.rate.toString();
      dpr_new_unitsController.text = datas.unit.toString();
      dpr_new_boqQtyController.text = datas.balQty.toString();
      dpr_new_currQtyController.text = datas.qty.toString();
      dpr_new_descripionController.text = datas.itemDesc.toString();
    });
  }

  Future getLabourList() async {
    await dprNew_LabourTable_Delete();
    dprNew_LabourList.value=[];
    var response = await SubContAttendanceProvider.getShowPopupList(dailyWrkDone_DPR_Controller.TypeSubcontId.value);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          dprNew_LabourList.assignAll(response.result!);
          await dprNew_LabourTableSave();
          await getLabourTablesDatas();
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  dprNew_LabourTable_Delete() async {
    await dprNew_LabourService.DprNew_LabTable_delete();
  }

  dprNew_LabourTableSave() async {
    int i = 0;
    dprNewLabourModelList.clear();
    dprNew_LabourList.value.forEach((element) {
      dprNew_LabourTable = new DprNew_LabourTable();
      textControllersInitiate();
      dprNew_LabourTable.reqDetId = 0;
      dprNew_LabourTable.catId = element.labCategoryId;
      dprNew_LabourTable.catName = element.dprcategoryName;
      dprNew_LabourTable.wages = element.dprWages;
      dprNew_LabourTable.nos =  0.0;
      dprNew_LabourTable.otHrs = 0.0;
      dprNew_LabourTable.otAmt = 0.0;
      dprNew_LabourTable.netAmt = 0.0;
      dprNew_LabourTable.labourId = element.labourId;
      dprNew_LabourTable.remarks = RemarksController[i].value.text.toString();
      dprNewLabourModelList.add(dprNew_LabourTable);
      i++;
    });
    var savedatas = await dprNew_LabourService.DprNew_LabTable_Save(dprNewLabourModelList);
    return savedatas;
  }

  Future getLabourTablesDatas() async {
    var datas = await dprNew_LabourService.DprNew_LabTable_readAll();
    dprNew_LabourReadList = <DprNew_LabourTable>[];
    dprNew_LabourReadList.clear();
    datas.forEach((value) {
      dprNew_LabourTable = DprNew_LabourTable();
      dprNew_LabourTable.reqDetId=value['reqDetId'];
      dprNew_LabourTable.catId=value['catId'];
      dprNew_LabourTable.catName=value['catName'];
      dprNew_LabourTable.wages=value['wages'];
      dprNew_LabourTable.nos=value['nos'];
      dprNew_LabourTable.otHrs=value['otHrs'];
      dprNew_LabourTable.otAmt=value['otAmt'];
      dprNew_LabourTable.netAmt=value['netAmt'];
      dprNew_LabourTable.remarks=value['remarks'];
      dprNew_LabourTable.labourId=value['labourId'];
      dprNew_LabourReadList.add(dprNew_LabourTable);
    });
  }

  updateLabourTable() async {
    int i=0;
    dprNew_UpdateModelListReadList.clear();
    for (var element in dprNew_LabourReadList){
      dprNew_LabourTable = DprNew_LabourTable();
      dprNew_LabourTable.reqDetId=element.reqDetId;
      dprNew_LabourTable.catId=element.catId;
      dprNew_LabourTable.catName=element.catName;
      dprNew_LabourTable.wages=element.wages;
      dprNew_LabourTable.nos=double.tryParse(NosControllers[i].value.text);
      dprNew_LabourTable.otHrs=double.tryParse(OtHrsController[i].value.text);
      dprNew_LabourTable.otAmt= double.tryParse(OtAmtController[i].value.text);
      dprNew_LabourTable.netAmt=double.tryParse(NetAmtController[i].value.text);
      dprNew_LabourTable.remarks=RemarksController[i].value.text;
      dprNew_LabourTable.labourId=element.labourId;
      dprNew_UpdateModelListReadList.add(dprNew_LabourTable);
      i++;
    }
    await dprNew_LabourService.DprNew_LabTable_Update(dprNew_UpdateModelListReadList);
  }

  clickEdit() async {
    for (var index = 0; index < dprNew_LabourReadList.length; index++) {
      OtAmtController[index].text = ((dprNew_LabourReadList[index].wages / 8) * double.parse(OtHrsController[index].value.text != "" ? OtHrsController[index].value.text : "0")).toString();
      NetAmtController[index].text = ((dprNew_LabourReadList[index].wages * double.parse(NosControllers[index].value.text != "" ? NosControllers[index].value.text : "0")) + ((dprNew_LabourReadList[index].wages / 8) * double.parse(OtHrsController[index].value.text != "" ? OtHrsController[index].value.text : "0"))).toString();
    }
    await updateLabourTable();
    totalNetAmnt = 0.0;
    dprNew_UpdateModelListReadList.forEach((element) {
      totalNetAmnt= totalNetAmnt + element.netAmt!;
    });
  }

  textControllersInitiate() {
    OtAmtController.add(TextEditingController());
    NetAmtController.add(TextEditingController());
    NosControllers.add(TextEditingController());
    OtHrsController.add(TextEditingController());
    RemarksController.add(TextEditingController());
  }

  nosAndothrsZerovalueset(){
    int index=0;
    dprNew_LabourReadList.forEach((element) {
      NosControllers[index].text=element.nos.toString()==""?"0.0":element.nos.toString();
      OtHrsController[index].text=element.otHrs.toString()==""?"0.0":element.otHrs.toString();
      OtAmtController[index].text=element.otAmt.toString();
      NetAmtController[index].text=element.netAmt.toString();
      RemarksController[index].text="-";
      index++;
    });
  }

  dprNew_MaterialTable_Delete() async {
    await dprNew_MaterialService.DprNew_MaterialTable_delete();
  }

  Future deleteParticularList(DprNew_MaterialTable data) async {
    deletedprNewMaterialModelList.clear();
    dprNew_MaterialTable = new DprNew_MaterialTable();
    dprNew_MaterialTable.MatId = data.MatId;
    dprNew_MaterialTable.Name = data.Name;
    dprNew_MaterialTable.qty = data.qty;
    deletedprNewMaterialModelList.add(dprNew_MaterialTable);
    await dprNew_MaterialService.DprNew_MaterialTable_deleteById(deletedprNewMaterialModelList);
  }

  dprNew_MaterialTableSave() async {
    int j=0;
    dprNewMaterialModelList.clear();
    dprNew_MaterialTable = new DprNew_MaterialTable();
    dprNew_MaterialTable.reqDetId=0;
    dprNew_MaterialTable.MatId=selectedMatId.value;
    dprNew_MaterialTable.Name=dpr_new_Mat_NameController.text;
    dprNew_MaterialTable.qty=double.parse(dpr_new_Mat_QtyController.text);
    dprNew_MaterialTable.Scale=dpr_new_Mat_ScaleController.text;
    dprNew_MaterialTable.scaleId=matScaleId.value;
    dprNewGetMatreadListdata.value.forEach((element) {
      if (element.MatId == dprNew_MaterialTable.MatId) {
        j = 1;
        BaseUtitiles.showToast("This record already exists.Please update the record.");
      }
    });
    if (j == 0) {
      dprNewMaterialModelList.add(dprNew_MaterialTable);
    }
    else{
      j=0;
    }
    var savedatas = await dprNew_MaterialService.DprNew_MaterialTable_Save(dprNewMaterialModelList);
    return savedatas;
  }

  Future getMaterialTablesDatas() async {
    dprNewGetMatreadListdata.value.clear();
    var datas = await dprNew_MaterialService.DprNew_MaterialTable_readAll();
    dprNew_MatReadList = <DprNew_MaterialTable>[];
    dprNew_MatReadList.clear();
    datas.forEach((value) {
      dprNew_MaterialTable = DprNew_MaterialTable();
      textMatInitiate();
      dprNew_MaterialTable.reqDetId = value['reqDetId'];
      dprNew_MaterialTable.MatId = value['MatId'];
      dprNew_MaterialTable.Name = value['Name'];
      dprNew_MaterialTable.qty = value['Qty'];
      dprNew_MaterialTable.Scale = value['Scale'];
      dprNew_MaterialTable.scaleId = value['scaleId'];
      dprNew_MatReadList.add(dprNew_MaterialTable);
      dprNewGetMatreadListdata.value=dprNew_MatReadList;

    });
    setMaterialListTextValue(dprNewGetMatreadListdata.value);
  }

  updateMaterialTable() async {
    int i=0;
    dprNewMaterialUpdateModelList.clear();
    dprNewGetMatreadListdata.forEach((element) {
      dprNew_MaterialTable = DprNew_MaterialTable();
      dprNew_MaterialTable.reqDetId = element.reqDetId;
      dprNew_MaterialTable.MatId = element.MatId;
      dprNew_MaterialTable.Name = element.Name;
      dprNew_MaterialTable.Scale = element.Scale;
      dprNew_MaterialTable.scaleId = element.scaleId;
      dprNew_MaterialTable.qty = double.parse(dpr_new_Mat_QtylistTextControllers[i].text != "" ? dpr_new_Mat_QtylistTextControllers[i].text : "0");
      dprNewMaterialUpdateModelList.add(dprNew_MaterialTable);
      i++;
    });
    await dprNew_MaterialService.DprNew_MaterialTable_Update(dprNewMaterialUpdateModelList);
  }

  MatclickEdit() async {
    await updateMaterialTable();
  }

  setMaterialListTextValue(vale) {
    int i=0;
    vale.forEach((datas) {
      textMatInitiate();
      dpr_new_Mat_QtylistTextControllers[i].text = datas.qty.toString();
      i++;
    });
  }

  textMatInitiate(){
    dpr_new_Mat_QtylistTextControllers.add(new TextEditingController());
  }


  dprNew_MesurmentTableSave() async {
    DprNewMeasurementModelList.clear();
    dprNew_MeasurementTable=new DprNew_MeasurementTable();
    dprNew_MeasurementTable.reqDetId=0;
    dprNew_MeasurementTable.Name=dpr_new_Measur_DescController.text;
    dprNew_MeasurementTable.nos=double.tryParse(dpr_new_Measur_NosController.text);
    dprNew_MeasurementTable.length=double.parse(dpr_new_Measur_LengthController.text);
    dprNew_MeasurementTable.breath=double.parse(dpr_new_Measur_BreathController.text);
    dprNew_MeasurementTable.depth=double.parse(dpr_new_Measur_DepthController.text);
    dprNew_MeasurementTable.qty=double.parse(dpr_new_Measur_NosController.text)*double.parse(dpr_new_Measur_LengthController.text)*double.parse(dpr_new_Measur_BreathController.text)*double.parse(dpr_new_Measur_DepthController.text);
    DprNewMeasurementModelList.add(dprNew_MeasurementTable);
    var savedatas = await dprNew_MeasurementService.DprNew_MeasurementTable_Save(DprNewMeasurementModelList);
    return savedatas;
  }

  Future getMesurmentTablesDatas() async {
    dprNewGetMSRreadListdata.value.clear();
    var datas = await dprNew_MeasurementService.DprNew_MeasurementTable_readAll();
    dprNew_MeasurementReadList = <DprNew_MeasurementTable>[];
    dprNew_MeasurementReadList.clear();
    currentQty=0.0;
    datas.forEach((value) {
      dprNew_MeasurementTable=new DprNew_MeasurementTable();
      textMSRTextInitiate();
      dprNew_MeasurementTable.id = value['id'];
      dprNew_MeasurementTable.reqDetId = value['reqDetId'];
      dprNew_MeasurementTable.Name = value['Name'];
      dprNew_MeasurementTable.nos = value['nos'];
      dprNew_MeasurementTable.length = value['length'];
      dprNew_MeasurementTable.breath = value['breath'];
      dprNew_MeasurementTable.depth = value['depth'];
      dprNew_MeasurementTable.qty = value['qty'];
      currentQty = (currentQty + dprNew_MeasurementTable.qty!).toPrecision(2);
      dprNew_MeasurementReadList.add(dprNew_MeasurementTable);
      dprNewGetMSRreadListdata.value=dprNew_MeasurementReadList;
    });

    setMSRlListTextValue(dprNewGetMSRreadListdata.value);
  }

  textMSRTextInitiate(){
    dpr_new_MeasurListDescController.add(TextEditingController());
    dpr_new_MeasurListNosController.add(TextEditingController());
    dpr_new_MeasurListBreathController.add(TextEditingController());
    dpr_new_MeasurListDepthController.add(TextEditingController());
    dpr_new_MeasurListQtyController.add(TextEditingController());
    dpr_new_MeasurListLengthController.add(TextEditingController());
  }

  addMessListQty(){
    AddQty=0.0;
    dprNewGetMSRreadListdata.value.forEach((element) {
      AddQty=AddQty+element.qty!;
    });
  }


  setMSRlListTextValue(vale) {
    int i=0;
    vale.forEach((datas) {
      textMSRTextInitiate();
      dpr_new_MeasurListDescController[i].text = datas.Name.toString();
      dpr_new_MeasurListNosController[i].text = datas.nos.toString();
      dpr_new_MeasurListBreathController[i].text = datas.breath.toString();
      dpr_new_MeasurListDepthController[i].text = datas.depth.toString();
      dpr_new_MeasurListQtyController[i].text = datas.qty.toString();
      dpr_new_MeasurListLengthController[i].text = datas.length.toString();
      i++;
    });
  }

  MSRclickChanged() {
    int i=0;
    dprNewGetMSRreadListdata.value.forEach((element) {
      textMSRTextInitiate();
      dpr_new_MeasurListQtyController[i].text = ((double.parse(dpr_new_MeasurListNosController[i].text != "" ? dpr_new_MeasurListNosController[i].text : "0")*(double.parse(dpr_new_MeasurListLengthController[i].text != "" ? dpr_new_MeasurListLengthController[i].text : "0"))*(double.parse(dpr_new_MeasurListBreathController[i].text != "" ? dpr_new_MeasurListBreathController[i].text : "0"))*(double.parse(dpr_new_MeasurListDepthController[i].text != "" ? dpr_new_MeasurListDepthController[i].text : "0")))).toString();
      i++;
    });
    updateMSRTable();
  }

  updateMSRTable() async {
    int i=0;
    currentQty=0.0;
    dprNewMSRUpdateModelList.clear();
    dprNewGetMSRreadListdata.forEach((element) {
      dprNew_MeasurementTable = DprNew_MeasurementTable();
      dprNew_MeasurementTable.id = element.id;
      dprNew_MeasurementTable.reqDetId = element.reqDetId;
      dprNew_MeasurementTable.Name = element.Name;
      dprNew_MeasurementTable.nos = double.tryParse(dpr_new_MeasurListNosController[i].text) ?? 0;
      dprNew_MeasurementTable.breath = double.tryParse(dpr_new_MeasurListBreathController[i].text)?? 0;
      dprNew_MeasurementTable.length = double.tryParse(dpr_new_MeasurListLengthController[i].text)?? 0;
      dprNew_MeasurementTable.depth = double.tryParse(dpr_new_MeasurListDepthController[i].text)?? 0;
      dprNew_MeasurementTable.qty = double.tryParse(dpr_new_MeasurListQtyController[i].text)?? 0;
      currentQty = currentQty + dprNew_MeasurementTable.qty!;
      dprNewMSRUpdateModelList.add(dprNew_MeasurementTable);
      i++;
    });
    await dprNew_MeasurementService.DprNew_MeasurementTable_Update(dprNewMSRUpdateModelList);
  }

  Future deleteByIdMSRTable(DprNew_MeasurementTable data) async {
    deletedprNewMSRModelList.clear();
    dprNew_MeasurementTable = DprNew_MeasurementTable();
    dprNew_MeasurementTable.id = data.id;
    dprNew_MeasurementTable.reqDetId = data.reqDetId;
    dprNew_MeasurementTable.Name = data.Name;
    dprNew_MeasurementTable.nos = data.nos;
    dprNew_MeasurementTable.length = data.length;
    dprNew_MeasurementTable.breath = data.breath;
    dprNew_MeasurementTable.depth = data.depth;
    dprNew_MeasurementTable.qty = data.qty;
    deletedprNewMSRModelList.add(dprNew_MeasurementTable);
    await dprNew_MeasurementService.DprNew_MeasurementTable_deleteById(deletedprNewMSRModelList);
  }

  dprNew_MSRTable_Delete() async {
    await dprNew_MeasurementService.DprNew_MeasurementTable_delete();
  }


  Future SaveButton_dprNew_MSR_SaveAPI(BuildContext context, int id) async {
    getDprNewDetList.value=[];
    getDprNewLabList.value=[];
    getDprNewMSRList.value=[];
    getDprNewMatList.value=[];
    await Future.delayed(const Duration(seconds:0));
    DprNewSaveReq formdata = DprNewSaveReq(
      id: id,
      workNo: autoYearWiseNoController.text,
      workDate: dateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContractorId: dailyWrkDone_DPR_Controller.TypeSubcontId.value,
      entryType: dailyWrkDone_DPR_Controller.entryType,
      dprType: 2,
      billStatus: "N",
      totalAmount: totalNetAmnt,
      refNo: "-",
      remarks: dpr_new_remarksController.text.isEmpty ? "-" : dpr_new_remarksController.text,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(dateController.text),
      approveStatus: saveButton.value==RequestConstant.APPROVAL?"Y":"N",
      verifyStatus: saveButton.value==RequestConstant.APPROVAL?"Y":"N",
      subContractDailyWorkDets: getDprNewDet(id),
      subcontractDailyWorkLabours: getDprNewLab(id),
      subcontractDailyWorkCements: getDprNewMat(id),
      subcontractDailyWorkMeasurements: getDprNewMSR(id),
    );

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(formdata.toJson());
    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await DPR_New_Provider.DPR_NEW_SaveAPI(formdata, imageFiles, saveButton.value, id);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        clearDatas();
        if(saveButton.value==RequestConstant.APPROVAL) {
          await pendingListController.getPendingList();
        }
        else{
          await dpr_New_getEntryList();
        }
        BaseUtitiles.popMultiple(context, count: 6);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }else{
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }


  clearDatas(){
    dpr_new_currQtyController.text="0.0";
    projectController.projectname.text=RequestConstant.SELECT;
    projectController.selectedProjectId.value=0;
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId.value=0;
    dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";
    dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
    dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
    dpr_new_preparedbyController.text=loginController.UserName();
    dateController.text=BaseUtitiles.initiateCurrentDateFormat();
    dpr_new_remarksController.text="";
    dpr_new_referenceController.text="";
    dprNew_DetTable_Delete();
    dprNew_EntryDetReadList.clear();


    //Labour Screen
    dprNew_LabourTable_Delete();
    dprNew_LabourReadList.clear();
    totalNetAmnt=0.0;

    //Material Screen
    dpr_new_Mat_NameController.text="--SELECT--";
    dpr_new_Mat_ScaleController.text="UNIT";
    dpr_new_Mat_QtyController.text="0.0";
    matScaleId.value=0;
    selectedMatId.value=0;
    dprNew_MaterialTable_Delete();
    dprNewGetMatreadListdata.clear();

    //Masurement Screen
    dpr_new_Measur_DescController.text = "";
    dpr_new_Measur_NosController.text = "";
    dpr_new_Measur_LengthController.text = "";
    dpr_new_Measur_BreathController.text = "";
    dpr_new_Measur_DepthController.text = "";
    dprNew_MSRTable_Delete();
    dprNewGetMSRreadListdata.clear();

  }

  List<SubContractDailyWorkDet>? getDprNewDet(masId) {
    dprNew_EntryDetReadList.forEach((element) {
      var list = SubContractDailyWorkDet(
          id: saveButton.value==RequestConstant.SUBMIT? 0: element.reqDetId,
          subContractDailyWorkMasId: masId,
          subContarctWorkdetid: element.woDetId,
          cement: double.tryParse(element.cement==""?"0.0":element.cement),
          rate: element.rate,
          workRemarks: element.workremarks,
          siteId: element.siteid,
          scaleId: element.unitId,
          itemDescription: element.itemDesc,
          workType: "RAT",
          headItemId: element.headItemId,
          subItemId: element.subItemId,
          boqCode: element.boqCode,
          qty: currentQty,
          amount: element.amt,
          billStatus: "N",
          avgLabRate: 0,
          level3ItemId: element.level3ItemId
      );
      getDprNewDetList.add(list);
    });
    return getDprNewDetList;
  }

  List<SubcontractDailyWorkLabour>? getDprNewLab(masId) {
    dprNew_LabourReadList.forEach((element) {
      var list = SubcontractDailyWorkLabour(
          id: saveButton.value==RequestConstant.SUBMIT? 0:element.reqDetId,
          subContractDailyWorkMasId: masId,
          otHrs: element.otHrs,
          wages: element.wages,
          subContractorId: element.labourId,
          nos: element.nos,
          amount: element.netAmt,
          categoryId: element.catId,
          otAmount: element.otAmt
      );
      getDprNewLabList.add(list);
    });
    return getDprNewLabList;
  }

  List<SubcontractDailyWorkCement>? getDprNewMat(masId) {
    dprNewGetMatreadListdata.forEach((element) {
      var list = SubcontractDailyWorkCement(
        id: saveButton.value==RequestConstant.SUBMIT? 0:element.reqDetId,
        subContractDailyWorkMasId: masId,
        materialId: element.MatId,
        scaleId: element.scaleId,
        qty: element.qty,
      );
      getDprNewMatList.add(list);
    });
    return getDprNewMatList;
  }

  List<SubcontractDailyWorkMeasurement>? getDprNewMSR(masId) {
    dprNewGetMSRreadListdata.forEach((element) {
      var list = SubcontractDailyWorkMeasurement(
        id: saveButton.value==RequestConstant.SUBMIT? 0:element.reqDetId,
        subContractDailyWorkMasId: masId,
        descriptionWork: element.Name,
        no: element.nos,
        length: element.length,
        breadth: element.breath,
        depth: element.depth,
        qty: element.qty,
      );
      getDprNewMSRList.add(list);
    });
    return getDprNewMSRList;
  }


  //---Material Name--
  Future getMaterialName() async {
    MaterialApiList.value=[];
    var response = await DPR_New_Provider.getMaterial(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        level3ItemIdValue.value
    );
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"].isNotEmpty) {
          MaterialApiList.assignAll(response["result"]!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future dpr_New_getEntryList() async {
    dpr_New_entryList.value=[];
    var response = await DPR_New_Provider.get_dprNew_EntryList(dpr_New_entryList_frdateController.text, dpr_New_entryList_todateController.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          dpr_New_entryList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  dprnew_ClearData(){
    DprNewMeasurementModelList.clear();
    dprNewDetModelList.clear();
    dprNewLabourModelList.clear();
    dprNewMaterialModelList.clear();
    dprNewMaterialModelList.clear();

    dprNew_DetTable_Delete();
    dprNew_EntryDetReadList.clear();

    dprNew_LabourTable_Delete();
    dprNew_LabourReadList.clear();

    dprNew_MaterialTable_Delete();
    dprNewGetMatreadListdata.value.clear();

    dprNew_MSRTable_Delete();
    dprNewGetMSRreadListdata.value.clear();
  }

  Future Dpr_New_EntryList_EditApi(int workid,String MenuName,BuildContext context) async {
    dprNew_EditApiList.value=[];
    var response = await DPR_New_Provider.dpr_New_entryList_editAPI(workid);
    if (response != null) {
      if (response.success == true) {
        dprNew_EditApiList.value = [response.result];
        if (dprNew_EditApiList.isNotEmpty) {
          await dprnew_ClearData();
          await Dpr_New_EntryList_DetEditApi(workid);
          await dprNew_EditMaterialTableSave();
          await getMaterialTablesDatas();
          await dprNew_EditLabourTableSave();
          await getLabourTablesDatas();
          await dprNew_EditMesurmentTableSave();
          await getMesurmentTablesDatas();
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_Entry_New(heading: MenuName,)),);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future Dpr_New_EntryList_DetEditApi(int workid) async {
    dprNew_EditDetApiList.value=[];
    var response = await DPR_New_Provider.dpr_New_entryList_detEditAPI(workid);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          dprNew_EditDetApiList.value = response.result!;
          await dprNew_EditDetTableSave();
          await getDetTablesDatas();
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  double curQtyTotalAmount(){
    curQtyAmt=0.0;
    dprNewGetMSRreadListdata.value.forEach((element) {
      curQtyAmt=curQtyAmt + element.qty;
    });
    return curQtyAmt;
  }

  dprNew_EditDetTableSave() async {
    dprNewDetModelList.clear();
    dprNew_EditDetApiList.value.forEach((data) {
      dprNewDetmodel = new DprNew_DetTable();
      dprNewDetmodel.reqDetId = data.id;
      dprNewDetmodel.cement = data.cement.toString();
      dprNewDetmodel.workremarks = data.workRemarks;
      dprNewDetmodel.siteid = data.siteId;
      dprNewDetmodel.headItemId = data.measureheadItemId;
      dprNewDetmodel.subItemId = data.measuresubItemId;
      dprNewDetmodel.level3ItemId = data.measureLevel3ItemId;
      dprNewDetmodel.woDetId = data.subContarctWorkdetid;
      dprNewDetmodel.itemDesc = data.fulldescription;
      dprNewDetmodel.rate = data.rate;
      dprNewDetmodel.unitId = data.unit;
      dprNewDetmodel.balQty = data.balQty;
      dprNewDetmodel.qty = data.qty;
      dprNewDetmodel.amt = data.amount;
      dprNewDetmodel.unit = data.scaleName;
      dprNewDetmodel.boqCode = data.boqcode;
      level3ItemIdValue.value = data.measureLevel3ItemId;
      dprNewDetModelList.add(dprNewDetmodel);
    });
    var savedatas =
    await dprNew_DetService.DprNew_DetTable_Save(dprNewDetModelList);
    return savedatas;
  }

  dprNew_EditLabourTableSave() async {
    int i = 0;
    totalNetAmnt=0.0;
    dprNewLabourModelList.clear();
    dprNew_EditApiList.value.forEach((element) {
      element.subcontractDailyWorkLabours.forEach((data) {
        dprNew_LabourTable = new DprNew_LabourTable();
        textControllersInitiate();
        dprNew_LabourTable.reqDetId = data.id;
        dprNew_LabourTable.catId = data.categoryId;
        dprNew_LabourTable.wages = data.wages;
        dprNew_LabourTable.nos =  data.nos;
        dprNew_LabourTable.otHrs = data.otHrs;
        dprNew_LabourTable.otAmt =data.otAmount;
        dprNew_LabourTable.netAmt = data.amount;
        dprNew_LabourTable.catName = data.categoryName;
        dprNew_LabourTable.labourId = data.subContractorId;
        dprNew_LabourTable.remarks = RemarksController[i].value.text;
        totalNetAmnt= totalNetAmnt + data.amount!;
        dprNewLabourModelList.add(dprNew_LabourTable);
        i++;
      });

    });
    var savedatas = await dprNew_LabourService.DprNew_LabTable_Save(dprNewLabourModelList);
    return savedatas;
  }

  dprNew_EditMaterialTableSave() async {
    dprNewMaterialModelList.clear();
    dprNew_EditApiList.value.forEach((element) {
      element.subcontractDailyWorkCements.forEach((data) {
        dprNew_MaterialTable = new DprNew_MaterialTable();
        dprNew_MaterialTable.reqDetId=data.id;
        dprNew_MaterialTable.MatId=data.materialId;
        dprNew_MaterialTable.qty=data.qty;
        dprNew_MaterialTable.scaleId=data.scaleId;
        dprNew_MaterialTable.Scale=data.scaleName;
        dprNew_MaterialTable.Name=data.materialName;
        dprNewMaterialModelList.add(dprNew_MaterialTable);
      });
    });
    var savedatas = await dprNew_MaterialService.DprNew_MaterialTable_Save(dprNewMaterialModelList);
    return savedatas;
  }

  dprNew_EditMesurmentTableSave() async {
    DprNewMeasurementModelList.clear();
    dprNew_EditApiList.value.forEach((element) {
      element.subcontractDailyWorkMeasurements.forEach((data) {
        dprNew_MeasurementTable=new DprNew_MeasurementTable();
        dprNew_MeasurementTable.reqDetId=data.id;
        dprNew_MeasurementTable.Name=data.descriptionWork;
        dprNew_MeasurementTable.nos=data.no;
        dprNew_MeasurementTable.length=data.length;
        dprNew_MeasurementTable.breath=data.breadth;
        dprNew_MeasurementTable.depth=data.depth;
        dprNew_MeasurementTable.qty=data.qty;
        DprNewMeasurementModelList.add(dprNew_MeasurementTable);
      });
    });
    var savedatas = await dprNew_MeasurementService.DprNew_MeasurementTable_Save(DprNewMeasurementModelList);
    return savedatas;
  }

  Future<bool> DprNew_EntryList_DeleteApi(int WorkId) async {
    return DPR_New_Provider.dprNew_entryList_deleteAPI(WorkId);
  }

  Future<void> gettingImage() async {
    gettingNetworkImages.clear();
    imageIds.clear();
    imageFiles.clear();
    final value =
    await Inward_Pending_provider.gettingImageProvider(WorkId!, "DPR");
    if (value != null) {
      for (int i = 0; i < value!.length; i++) {
        gettingNetworkImages.add(value[i].url.toString());
        imageIds.add(value[i].id);
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future<bool> deletingImage(int imageId) async {
    return await Inward_Pending_provider.deleteImageProvider(imageId,"DPR");
  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
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
                        onPressed: () async {
                          dprNew_EntryDetReadList.clear();
                          dprNew_LabourReadList.clear();
                          totalNetAmnt=0.0;
                          dprNewGetMatreadListdata.value.clear();
                          dprNewGetMSRreadListdata.value.clear();
                          bool result = await DprNew_EntryList_DeleteApi(dpr_New_entryList.value[index].id);
                          if (result) {
                            dpr_New_entryList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
