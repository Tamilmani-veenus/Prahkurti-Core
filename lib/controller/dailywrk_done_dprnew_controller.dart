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
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyWrkDone_DPRNEW_Controller extends GetxController {


  int editcheck=0;
  int entrycheck=0;
  RxInt selectedMatId=0.obs;
  RxString selectedMatName="".obs;
  RxList materialNameList=[].obs;
  RxString selectedMatUnit="".obs;
  RxList dprNew_EditApiList = [].obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  int aprovedButton=0;
  int saveId=0;
  double curQtyAmt=0.0;
  double AddQty=0.0;

  double currentQty=0.0;

  int check=0;
  int checkColor=0;

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
  List<TextEditingController> dpr_new_Mat_QtylistTextControllers = [];


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
  HeadNameController headNameController=Get.put(HeadNameController());

  double totalNetAmnt=0.0;
  RxList dprNew_BoqDetailsList = [].obs;
  RxList dprNew_mainList = [].obs;
  RxList dprNew_LabourList = [].obs;
  int buttonControl = 0;

  RxList dpr_New_entryList = [].obs;
  RxList main_entryList = [].obs;
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
  RxList MaterialApiLIst = [].obs;
  RxList mainlist=[].obs;
  late List<DprNew_MaterialTable> dprNewMaterialUpdateModelList = <DprNew_MaterialTable>[];
  late List<DprNew_MaterialTable> deletedprNewMaterialModelList = <DprNew_MaterialTable>[];

  var dprNew_MeasurementTable=DprNew_MeasurementTable();
  late List<DprNew_MeasurementTable> DprNewMeasurementModelList = <DprNew_MeasurementTable>[];
  List dprNew_MeasurementReadList = <DprNew_MeasurementTable>[];
  RxList dprNewGetMSRreadListdata = [].obs;
  late List<DprNew_MeasurementTable> dprNewMSRUpdateModelList = <DprNew_MeasurementTable>[];
  late List<DprNew_MeasurementTable> deletedprNewMSRModelList = <DprNew_MeasurementTable>[];

  RxList<DprDet> getDprNewDetList = <DprDet>[].obs;
  RxList<DprLab> getDprNewLabList = <DprLab>[].obs;
  RxList<DprMaterial> getDprNewMatList = <DprMaterial>[].obs;
  RxList<DprMeasurement> getDprNewMSRList = <DprMeasurement>[].obs;

  RxList dummyListData=[].obs;
  RxList list=[].obs;

  Future getAddBoqDetails(BuildContext context) async {
    dprNew_BoqDetailsList.value.clear();
    dprNew_mainList.value.clear();
    await DPR_New_Provider.dprNew_getBoqDetails(
            projectController.selectedProjectId.value,
            siteController.selectedsiteId.value,
            dailyWrkDone_DPR_Controller.TypeSubcontId.value,
            headNameController.selectedHeadId.value,
            dailyWrkDone_DPR_Controller.entryType)
        .then((value) async {
      if (value != null && value.length > 0) {
        dprNew_BoqDetailsList.value = value;
        dprNew_mainList.value = dprNew_BoqDetailsList.value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddBoqPopup(list: dprNew_BoqDetailsList.value);
            });
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  dprNew_DetTable_Delete() async {
    await dprNew_DetService.DprNew_Dettable_delete();
  }

  dprNew_DetTableSave(var element) async {
    dprNewDetModelList.clear();
    dprNewDetmodel = new DprNew_DetTable();
    dprNewDetmodel.headItemId = element.headItemId;
    dprNewDetmodel.subItemId = element.subItemId;
    dprNewDetmodel.level3ItemId = element.level3ItemId;
    dprNewDetmodel.woDetId = element.woDetId;
    dprNewDetmodel.itemDesc = element.itemDesc.toString();
    dprNewDetmodel.rate = element.rate;
    dprNewDetmodel.unit = element.unit;
    dprNewDetmodel.balQty = element.balQty;
    dprNewDetmodel.qty = element.qty;
    dprNewDetmodel.boqCode = element.boqCode.toString();

    dprNewDetModelList.add(dprNewDetmodel);
    var savedatas =
        await dprNew_DetService.DprNew_DetTable_Save(dprNewDetModelList);
    return savedatas;
  }

  Future getDetTablesDatas() async {
    dprNew_EntryDetReadList.clear();
    var datas = await dprNew_DetService.DprNew_DetTable_readAll();
    dprNew_DetReadList = <DprNew_DetTable>[];
    dprNew_DetReadList.clear();
    datas.forEach((value) {
      dprNewDetmodel = new DprNew_DetTable();
      dprNewDetmodel.headItemId = value['headItemId'];
      dprNewDetmodel.subItemId = value['subItemId'];
      dprNewDetmodel.level3ItemId = value['level3ItemId'];
      dprNewDetmodel.woDetId = value['woDetId'];
      dprNewDetmodel.itemDesc = value['itemDesc'];
      dprNewDetmodel.rate = value['rate'];
      dprNewDetmodel.unit = value['units'];
      dprNewDetmodel.balQty = value['balQty'];
      dprNewDetmodel.qty = value['qty'];
      dprNewDetmodel.boqCode = value['boqCode'];
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
    await SubContAttendanceProvider.getShowPopupList(
            dailyWrkDone_DPR_Controller.TypeSubcontId.value,
            projectController.selectedProjectId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        dprNew_LabourList.value = value;
        return dprNew_LabourList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
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
      dprNew_LabourTable.catId = element.categoryId;
      dprNew_LabourTable.catName = element.categoryName;
      dprNew_LabourTable.wages = element.wages;
      dprNew_LabourTable.nos =  "0.0";
      dprNew_LabourTable.otHrs = "0.0";
      dprNew_LabourTable.otAmt =0.0;
      dprNew_LabourTable.netAmt = 0.0;
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
      dprNew_LabourTable.catId=value['catId'];
      dprNew_LabourTable.catName=value['catName'];
      dprNew_LabourTable.wages=value['wages'];
      dprNew_LabourTable.nos=value['nos'];
      dprNew_LabourTable.otHrs=value['otHrs'];
      dprNew_LabourTable.otAmt=value['otAmt'];
      dprNew_LabourTable.netAmt=value['netAmt'];
      dprNew_LabourTable.remarks=value['remarks'];
      dprNew_LabourReadList.add(dprNew_LabourTable);
    });
  }

  updateLabourTable() async {
    int i=0;
     dprNew_UpdateModelListReadList.clear();
    dprNew_LabourReadList.forEach((element) {
      dprNew_LabourTable = DprNew_LabourTable();
      dprNew_LabourTable.catId=element.catId;
      dprNew_LabourTable.catName=element.catName;
      dprNew_LabourTable.wages=element.wages;
      dprNew_LabourTable.nos=NosControllers[i].value.text.toString();
      dprNew_LabourTable.otHrs=OtHrsController[i].value.text.toString();
      dprNew_LabourTable.otAmt= double.parse(OtAmtController[i].value.text.toString());
      dprNew_LabourTable.netAmt=double.parse(NetAmtController[i].value.text.toString());
      dprNew_LabourTable.remarks=RemarksController[i].value.text.toString();
      dprNew_UpdateModelListReadList.add(dprNew_LabourTable);
      i++;
    });
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
      textControllersInitiate();
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
      dprNew_MaterialTable.MatId=selectedMatId.value;
      dprNew_MaterialTable.Name=dpr_new_Mat_NameController.text;
      dprNew_MaterialTable.qty=double.parse(dpr_new_Mat_QtyController.text);
      dprNew_MaterialTable.Scale=dpr_new_Mat_ScaleController.text;
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
      dprNew_MaterialTable.MatId = value['MatId'];
      dprNew_MaterialTable.Name = value['Name'];
      dprNew_MaterialTable.qty = value['Qty'];
      dprNew_MaterialTable.Scale = value['Scale'];
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
      dprNew_MaterialTable.MatId = element.MatId;
      dprNew_MaterialTable.Name = element.Name;
      dprNew_MaterialTable.Scale = element.Scale;
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
    dprNew_MeasurementTable.Name=dpr_new_Measur_DescController.text;
    dprNew_MeasurementTable.nos=dpr_new_Measur_NosController.text;
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
      dprNew_MeasurementTable.Name = element.Name;
      dprNew_MeasurementTable.nos = dpr_new_MeasurListNosController[i].text;
      dprNew_MeasurementTable.breath = double.parse(dpr_new_MeasurListBreathController[i].text != "" ? dpr_new_MeasurListBreathController[i].text : "0");
      dprNew_MeasurementTable.length = double.parse(dpr_new_MeasurListLengthController[i].text != "" ? dpr_new_MeasurListLengthController[i].text : "0");
      dprNew_MeasurementTable.depth = double.parse(dpr_new_MeasurListDepthController[i].text != "" ? dpr_new_MeasurListDepthController[i].text : "0");
      dprNew_MeasurementTable.qty = double.parse(dpr_new_MeasurListQtyController[i].text != "" ? dpr_new_MeasurListQtyController[i].text : "0");
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
    getDprNewDetList.value.clear();
    getDprNewLabList.value.clear();
    getDprNewMSRList.value.clear();
    getDprNewMatList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = dailywrkdonDprNewSaveReqToJson(DailywrkdonDprNewSaveReq(
      workId: id != 0 ? id.toString() : "0",
      workNo: autoYearWiseNoController.text,
      workDate: dateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: dailyWrkDone_DPR_Controller.TypeSubcontId.toString(),
      refNo: dpr_new_referenceController.text,
      entryType: dailyWrkDone_DPR_Controller.entryType,
      remarks: dpr_new_remarksController.text,
      preparedby: loginController.EmpId(),
      approvedby: "0",
      userId: loginController.UserId(),
      empId: loginController.EmpId(),
      entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      deviceName: BaseUtitiles.deviceName,
      dprDet: getDprNewDetList.value.length == 0
          ? getDprNewDet() : getDprNewDetList.value,
      dprLab: getDprNewLabList.value.length == 0
          ? getDprNewLab() : getDprNewLabList.value,
      dprMaterial:  getDprNewMatList.value.length == 0
          ? getDprNewMat() : getDprNewMatList.value,
      dprMeasurement: getDprNewMSRList.value.length == 0
          ? getDprNewMSR() : getDprNewMSRList.value,
    ));
    final list = await DPR_New_Provider.DPR_NEW_SaveAPI(body,id,aprovedButton, context);
    if (list != null) {
      if (id != 0) {
        if (aprovedButton != 0) {
          await pendingListController.getPendingList();
          clearDatas();
          BaseUtitiles.showToast(list);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
        else {
          entrycheck = 2;
          editcheck = 0;
          dprNew_DetTable_Delete();
          dprNew_EntryDetReadList.clear();
          dprNew_LabourTable_Delete();
          dprNew_LabourReadList.clear();
          totalNetAmnt = 0.0;
          dprNew_MaterialTable_Delete();
          dprNewGetMatreadListdata.value.clear();
          dprNew_MSRTable_Delete();
          dprNewGetMSRreadListdata.value.clear();
          clearDatas();
          await dpr_New_getEntryList();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          BaseUtitiles.showToast(list);
        }
      }
      else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list);
        } else {
          entrycheck = 2;
          dprNew_DetTable_Delete();
          dprNew_EntryDetReadList.clear();
          dprNew_LabourTable_Delete();
          dprNew_LabourReadList.clear();
          totalNetAmnt = 0.0;
          dprNew_MaterialTable_Delete();
          dprNewGetMatreadListdata.value.clear();
          dprNew_MSRTable_Delete();
          dprNewGetMSRreadListdata.value.clear();
          clearDatas();
          await dpr_New_getEntryList();
          BaseUtitiles.showToast(list);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    }
  }


  clearDatas(){
     dpr_new_currQtyController.text="0.0";
    headNameController.headName.text="--Select--";
    headNameController.selectedHeadId.value=0;
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
     dpr_new_Mat_ScaleController.text="UNIT";
     dpr_new_Mat_QtyController.text="0.0";
     dpr_new_Mat_NameController.text="";
     dprNew_MaterialTable_Delete();
     dprNewGetMatreadListdata.value.clear();

    //Masurement Screen
     dpr_new_Measur_DescController.text = "";
     dpr_new_Measur_NosController.text = "";
     dpr_new_Measur_LengthController.text = "";
     dpr_new_Measur_BreathController.text = "";
     dpr_new_Measur_DepthController.text = "";
     dprNew_MSRTable_Delete();
     dprNewGetMSRreadListdata.value.clear();
  }

  List<DprDet>? getDprNewDet() {
    dprNew_EntryDetReadList.forEach((element) {
      var list = new DprDet(
        headItemId: element.headItemId.toString(),
        subItemId: element.subItemId.toString(),
        level3ItemId: element.level3ItemId.toString(),
        woDetId: element.woDetId.toString(),
        unit: element.unit.toString(),
        qty: currentQty.toString(),
        rate: element.rate.toString(),
        amount: element.amt.toString(),
      );
      getDprNewDetList.value.add(list);
    });
    return getDprNewDetList.value;
  }

  List<DprLab>? getDprNewLab() {
    dprNew_LabourReadList.forEach((element) {
      var list = new DprLab(
        categoryId: element.catId.toString(),
        nos: element.nos.toString(),
        wages: element.wages.toString(),
        otHrs: element.otHrs.toString(),
        otAmt: element.otAmt.toString(),
        amount: element.netAmt.toString(),
        labRemark: element.remarks.toString(),
      );
      getDprNewLabList.value.add(list);
    });
    return getDprNewLabList.value;
  }


  List<DprMaterial>? getDprNewMat() {
    dprNewGetMatreadListdata.value.forEach((element) {
      var list = new DprMaterial(
        MaterialId: element.MatId.toString(),
        Unit: element.Scale.toString(),
        Qty: element.qty.toString(),
      );
      getDprNewMatList.value.add(list);
    });
    return getDprNewMatList.value;
  }

  List<DprMeasurement>? getDprNewMSR() {
    dprNewGetMSRreadListdata.value.forEach((element) {
      var list = new DprMeasurement(
        WorkDesc: element.Name.toString(),
        N: element.nos.toString(),
        L: element.length.toString(),
        B: element.breath.toString(),
        D: element.depth.toString(),
        Qty: element.qty.toString(),
      );
      getDprNewMSRList.value.add(list);
    });
    return getDprNewMSRList.value;
  }



  filterMaterialPopSearchResults(String value)  async {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      MaterialApiLIst.value.forEach((item) {
        if (item.materialName.toString().toLowerCase().contains(value) ||
            item.materialName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      dummyListData.value.clear();
      return  dummyListData.value=MaterialApiLIst.value;
    }
  }




  //---Material Name--
  Future getMaterialName(BuildContext context) async {
    MaterialApiLIst.value = await DPR_New_Provider.getMaterial();
    MaterialApiLIst.value.forEach((element) {
      return materialNameList.add(element.materialName);
    });
  }

  setSelectedMaterialID(String value) {
    if (MaterialApiLIst.value.length>0) {
      MaterialApiLIst.forEach((element) {
        if(value == element.materialName){
          selectedMatId(element.materialId);
        }
      });
    }
    setSelectedMaterialListName(selectedMatId.value);
  }

  setSelectedMaterialListName(int? id) {
    if (MaterialApiLIst.value != null) {
      MaterialApiLIst.value.forEach((element) {
        if (id == element.materialId) {
          selectedMatName(element.materialName.toString());
          selectedMatUnit(element.Scale.toString());
        }
      });
    }
    dpr_new_Mat_NameController.text=selectedMatName.value;
  }

  Future dpr_New_getEntryList() async {
    main_entryList.value.clear();
    dpr_New_entryList.value.clear();
    await DPR_New_Provider.get_dprNew_EntryList(loginController.user.value.userId, loginController.UserType(), dpr_New_entryList_frdateController.text, dpr_New_entryList_todateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        dpr_New_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
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

  Future Dpr_New_EntryList_EditApi(int workid, BuildContext context, int checkdata) async {
    checkdata != 0 ? aprovedButton = 1 : aprovedButton = 0;
    await DPR_New_Provider.dpr_New_entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        entrycheck=1;
        dprNew_EditApiList.value = value;
        await dprnew_ClearData();
        await dprNew_EditMesurmentTableSave();
        await getMesurmentTablesDatas();
        await dprNew_EditDetTableSave();
        await getDetTablesDatas();
        await dprNew_EditLabourTableSave();
        await getLabourTablesDatas();
        await dprNew_EditMaterialTableSave();
        await getMaterialTablesDatas();
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_Entry_New()),);
      }
    });
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
    dprNew_EditApiList.value.forEach((element) {
      element.dprEditDet.forEach((data) {
        dprNewDetmodel = new DprNew_DetTable();
        dprNewDetmodel.headItemId = data.headItemId;
        dprNewDetmodel.subItemId = data.subItemId;
        dprNewDetmodel.level3ItemId = data.level3ItemId;
        dprNewDetmodel.woDetId = data.woDetId;
        dprNewDetmodel.itemDesc = data.itemDesc.toString();
        dprNewDetmodel.rate = data.rate;
        dprNewDetmodel.unit = data.unit;
        dprNewDetmodel.balQty = data.balQty;
        dprNewDetmodel.qty = curQtyTotalAmount();
        dprNewDetmodel.boqCode = data.boqCode.toString();
        dprNewDetModelList.add(dprNewDetmodel);
      });
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
      element.dprEditLab.forEach((data) {
        dprNew_LabourTable = new DprNew_LabourTable();
        textControllersInitiate();
        dprNew_LabourTable.catId = data.categoryId;
        dprNew_LabourTable.catName = data.categoryName;
        dprNew_LabourTable.wages = data.wages;
        dprNew_LabourTable.nos =  data.nos.toString();
        dprNew_LabourTable.otHrs = data.otHrs.toString();
        dprNew_LabourTable.otAmt =data.otAmt;
        dprNew_LabourTable.netAmt = data.amount;
        dprNew_LabourTable.remarks = RemarksController[i].value.text.toString();
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
      element.dprEditMaterial.forEach((data) {
        dprNew_MaterialTable = new DprNew_MaterialTable();
        dprNew_MaterialTable.MatId=data.materialId;
        dprNew_MaterialTable.Name=data.materialName;
        dprNew_MaterialTable.qty=data.qty;
        dprNew_MaterialTable.Scale=data.unit;
        dprNewMaterialModelList.add(dprNew_MaterialTable);
      });
    });
    var savedatas = await dprNew_MaterialService.DprNew_MaterialTable_Save(dprNewMaterialModelList);
    return savedatas;
  }

  dprNew_EditMesurmentTableSave() async {
    DprNewMeasurementModelList.clear();
    dprNew_EditApiList.value.forEach((element) {
      element.dprEditMeasurement.forEach((data) {
        dprNew_MeasurementTable=new DprNew_MeasurementTable();
        dprNew_MeasurementTable.Name=data.workDesc;
        dprNew_MeasurementTable.nos=data.n.toString();
        dprNew_MeasurementTable.length=data.l;
        dprNew_MeasurementTable.breath=data.b;
        dprNew_MeasurementTable.depth=data.d;
        dprNew_MeasurementTable.qty=data.qty;
        DprNewMeasurementModelList.add(dprNew_MeasurementTable);
      });
    });
    var savedatas = await dprNew_MeasurementService.DprNew_MeasurementTable_Save(DprNewMeasurementModelList);
    return savedatas;
  }

  String ButtonChanges(int id,int aproval){
    saveId=id;
    if(id!=0){
      if(aproval!=0)
        return saveButton.value=RequestConstant.APPROVAL;
      else
        return saveButton.value=RequestConstant.RESUBMIT;
    }
    else
      return saveButton.value=RequestConstant.SUBMIT;
  }
  Future DprNew_EntryList_DeleteApi(int WorkId, String WorkNo) async {
    await DPR_New_Provider.dprNew_entryList_deleteAPI(WorkId,WorkNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }






  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to delete?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child:Text('No'),
          ),
          ElevatedButton(
            onPressed: () async{
              entrycheck=0;
              editcheck=0;
              dprNew_EntryDetReadList.clear();
              dprNew_LabourReadList.clear();
              totalNetAmnt=0.0;
              dprNewGetMatreadListdata.value.clear();
              dprNewGetMSRreadListdata.value.clear();
             await DprNew_EntryList_DeleteApi(dpr_New_entryList.value[index].workId, dpr_New_entryList.value[index].workNo);
              dpr_New_entryList.value.removeAt(index);
              Navigator.of(context).pop();
            },
            child:Text('Yes'),
          ),
        ],
      ),
    );
  }

}
