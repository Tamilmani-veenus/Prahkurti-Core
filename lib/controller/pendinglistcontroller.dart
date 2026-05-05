import '../commonpopup/pendinglistdet_alert.dart';
import '../commonpopup/po_suppliernamelist_alert.dart';
import '../commonpopup/transferackmateriallist_alert.dart';
import '../controller/logincontroller.dart';
import '../home/pending_list/onclickpending_list.dart';
import '../models/advanceapproval_reqapi_model.dart';
import '../models/onclick_pendinglist_model.dart';
import '../models/onclickpendingdet_model.dart';
import '../models/pendinglist_model.dart';
import '../models/pendingpo_aprovalapi_resmodel.dart';
import '../models/poapprovalsupplierlist_model.dart';
import '../models/punchIn_approvalApiResmodel.dart';
import '../models/quoteapproval_model.dart';
import '../models/quoteverifysave_model.dart';
import '../models/subcont_nmrbillaproval_pendinglistres_model.dart';
import '../models/transferackmateriallist_model.dart';
import '../provider/mrnfinalapproval_provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/requestconstant.dart';

class PendingListController extends GetxController {
  List<OnClickListResult> onclickPendingListData = [];
  RxList mainlist = [].obs;
  RxList samplemainlist = [].obs;
  RxList mrnfinalapprovallist = [].obs;
  RxList matTransReqVerifyApprovelist = [].obs;
  RxList mrnPreapprovallist = [].obs;
  RxList pendingmainlist = [].obs;
  List onclickPendingListDet = [];
  List<GetPendingListResponse> datas = [];
  LoginController loginController = Get.put(LoginController());
  RxList pendingList_datas = [].obs;
  RxList<QuoteDet> getQuoteDetList = <QuoteDet>[].obs;
  final revertRemarks = TextEditingController();
  final verifyRemarks = TextEditingController();

  List poapprovalSupplierList = [];
  RxList Searchpoapproval_supplierList = [].obs;

  List<TransferAckMatList> transAckMaterialList = [];
  RxList Search_transAckMaterialList = [].obs;

  int checkColor = 0;

  RxString mrn_preapproval_autoYrsWise = "".obs;

  RxList<OnClickListResult> addSubcontNmrListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> addBillGenBOQListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> addBillGenDirectListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> add_AdvanceReqListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> add_PoaprovalListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> add_MrnFinalaprovalListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> workorderListvalue =
      <OnClickListResult>[].obs;
  RxList<OnClickListResult> add_PunchInAppListvalue =
      <OnClickListResult>[].obs;

  RxList<NmrApprovalDet> getNMRAprovalDetList = <NmrApprovalDet>[].obs;
  RxList<DirectApprovalDet> getbillBOQAprovalDetList =
      <DirectApprovalDet>[].obs;
  RxList<DirectApprovalDet> getbillDirectAprovalDetList =
      <DirectApprovalDet>[].obs;
  RxList<ApprovalDet> getAdvanceReqAprovalDetList = <ApprovalDet>[].obs;
  RxList<ApprovalDet> getPoAprovalDetList = <ApprovalDet>[].obs;
  RxList<ApprovalDet> getMrnFinalAprovalDetList = <ApprovalDet>[].obs;
  RxList<ApprovalDet> getWorkOrderDetList = <ApprovalDet>[].obs;
  RxList<ApprovalPunchInDet> getPunchinAprovalDetList = <ApprovalPunchInDet>[].obs;

  Future getPendingList() async {
    pendingList_datas.value=[];
    var response = await PendingListProvider.getPendingListProvider();
    if (response != null) {
      if(response.success==true) {
        List<PendingListResult>? materialList = response.result;
        if (materialList!.isNotEmpty) {
          pendingList_datas.assignAll(materialList);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future Mrn_PreApproval_AutoYearWise() async {
    mrn_preapproval_autoYrsWise.value = "";
    await PendingListProvider.preapproval_getAutoYearWise().then((value) {
      if (value != null) {
        mrn_preapproval_autoYrsWise.value = value;
        return mrn_preapproval_autoYrsWise.value;
      }
    });
  }


  ///--------------------TRANSFER REQUEST verifily----------------------------


  Future<String?> TransferReq_Verify_DeleteApi(Url,int reqId) async {
    return MrnFinalApprovalProvider.TransferReq_Verify_deleteAPI(Url,reqId);
  }


  ///------------------------------mrlpreapproveapi-------------------------
  Future mrn_preapprovial_delete(BuildContext context, id) async {
    String body =
    pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
      urlName: "MRN VERIFICATION DELETE",
      userId: loginController.user.value.userId.toString(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getPoAprovalDetList.value.isEmpty
          ? getmrnpreapproalDet(id)
          : getPoAprovalDetList.value,
    ));
    if (mainlist.isNotEmpty) {
      // await MrnFinalApprovalProvider.mrlpreapproveapi(body);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<ApprovalDet> getmrnpreapproalDet(int id) {
    getPoAprovalDetList.value.clear();
    mainlist.forEach((element) {
      if (id == element.id) {
        var list =
        ApprovalDet(id: element.id, no: element.no.toString(), poWoType: '-');
        getPoAprovalDetList.add(list);
      }
    });
    return getPoAprovalDetList.value;
  }




  Future punchInAproval_buttonApi(BuildContext context, String Urlname) async {
    String body = punchInapprovalApiResmodelToJson(PunchInapprovalApiResmodel(
      urlName: Urlname.toString(),
      userId: loginController.EmpId(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getPunchinAprovalDetList.value.length == 0
          ? getPunchInApprovalDet()
          : getPunchinAprovalDetList.value,
    ));
    if (add_PunchInAppListvalue.isNotEmpty) {
      await PendingListProvider.PunchInAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<ApprovalPunchInDet>? getPunchInApprovalDet() {
    add_PunchInAppListvalue.value.forEach((element) {
      var list = new ApprovalPunchInDet(
        id: element.id,
        no: element.no.toString(),
      );
      getPunchinAprovalDetList.value.add(list);
    });
    return getPunchinAprovalDetList.value;
  }


  List<ApprovalDet> poverifideletedet(int id) {
    getPoAprovalDetList.value.clear();
    mainlist.forEach((element) {
      if (id == element.id) {
        var list = ApprovalDet(
          id: element.id,
          no: element.no.toString(),
          poWoType: element.type,
        );
        getPoAprovalDetList.add(list);
      }
    });
    return getPoAprovalDetList.value;
  }


  Future PO_Approval_DeleteApi(int reqId) async {
    await PendingListProvider.PO_Approval_deleteAPI(reqId)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  ///---------------------------mrnfinal_approval_delete----------------------------------------
  Future mrnfinal_approvil_delete(BuildContext context, id) async {
    String body =
    pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
      urlName: "MRN FINAL APPROVAL DELETE",
      userId: loginController.user.value.userId.toString(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getPoAprovalDetList.value.isEmpty
          ? getmrnfinalDet(id)
          : getPoAprovalDetList.value,
    ));
    if (mainlist.isNotEmpty) {
      await MrnFinalApprovalProvider.mrnfinaldeleteApi(body);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<ApprovalDet> getmrnfinalDet(int id) {
    getPoAprovalDetList.value.clear();
    mainlist.forEach((element) {
      if (id == element.id) {
        var list =
        ApprovalDet(id: element.id, no: element.no.toString(), poWoType: '-');
        getPoAprovalDetList.add(list);
      }
    });
    return getPoAprovalDetList.value;
  }


  Future poAproval_buttonApi(BuildContext context, String Urlname) async {

    List body = [];

    List<ApprovalDet>? finalList = getPoAprovalDetList.value.length == 0
        ? getPoApprovalDet()
        : getPoAprovalDetList.value;

    if (finalList != null) {
      body = finalList.map((e) => e.toJson()).toList();
    }
    if (add_PoaprovalListvalue.isNotEmpty) {
      if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
        var response = await PendingListProvider.PoAprovalAPI(Urlname, body, context);
        if (response != null) {
          BaseUtitiles.showToast(response.message=="PO/WO verified successfully"?"PO verified successfully":response.message=="PO/WO Approved successfully"?"PO Approved successfully":response.message ?? 'Something went wrong..');
          Navigator.pop(context);
        }
        else{
          Navigator.pop(context);
          BaseUtitiles.showToast('Something went wrong..');
        }
      }
    }
  }

  ///-------------Po Approval && Direct Transfer (Verify & Approval)




  List<ApprovalDet>? getPoApprovalDet() {
    add_PoaprovalListvalue.value.forEach((element) {
      var list = new ApprovalDet(
        id: element.PoId,
        poWoType: "PO",
      );
      getPoAprovalDetList.value.add(list);
    });
    return getPoAprovalDetList.value;
  }

  ///--------------WorkOrder Verify & Approval Button------
  Future WorkOrder_buttonApi(BuildContext context, String Urlname) async {
    String body =
    pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
      urlName: Urlname.toString(),
      userId: loginController.EmpId(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getWorkOrderDetList.value.length == 0
          ? getApprovalDet()
          : getWorkOrderDetList.value,
    ));
    if (workorderListvalue.isNotEmpty) {
      await PendingListProvider.AprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
    }
  }

  List<ApprovalDet>? getApprovalDet() {
    getWorkOrderDetList.value.clear();
    int i = 0;
    workorderListvalue.value.forEach((element) {
      var list = ApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getWorkOrderDetList.value.add(list);
      i++;
    });
    return getWorkOrderDetList.value;
  }

  // Future directTrans_buttonApi(BuildContext context, String Urlname) async {
  //   String body = pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
  //     urlName: Urlname.toString(),
  //     userId: loginController.EmpId(),
  //     deviceName: BaseUtitiles.deviceName,
  //     approvalDet: getPoAprovalDetList.value.length == 0
  //         ? getPoApprovalDet()
  //         : getPoAprovalDetList.value,
  //   ));
  //   if (add_PoaprovalListvalue.isNotEmpty) {
  //     await PendingListProvider.PoAprovalAPI(body, context);
  //   } else {
  //     BaseUtitiles.showToast("Please select a list");
  //   }
  // }
  //
  // List<ApprovalDet>? getPoApprovalDet() {
  //   add_PoaprovalListvalue.value.forEach((element) {
  //     var list = new ApprovalDet(
  //       id: element.id,
  //       no: element.no.toString(),
  //     );
  //     getPoAprovalDetList.value.add(list);
  //   });
  //   return getPoAprovalDetList.value;
  // }

  Future subcontNmrAproval_buttonApi(BuildContext context) async {
    String body = subContNmrBillAprovalPendinglistResToJson(
        SubContNmrBillAprovalPendinglistRes(
          urlName: loginController.EmpId(),
          userId: loginController.UserId(),
          deviceName: BaseUtitiles.deviceName,
          nmrApprovalDet: getNMRAprovalDetList.value.length == 0
              ? getnmrApprovalDet()
              : getNMRAprovalDetList.value,
        ));
    if (addSubcontNmrListvalue.isNotEmpty) {
      await PendingListProvider.subcontNMR_BillAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<NmrApprovalDet>? getnmrApprovalDet() {
    addSubcontNmrListvalue.value.forEach((element) {
      var list = new NmrApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getNMRAprovalDetList.value.add(list);
    });
    return getNMRAprovalDetList.value;
  }

  Future billGenBOQAproval_buttonApi(BuildContext context) async {
    String body = billGenBoqApprovalReqToJson(BillGenBoqApprovalReq(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      directApprovalDet: getbillBOQAprovalDetList.value.length == 0
          ? getBillBOQApprovalDet()
          : getbillBOQAprovalDetList.value,
    ));
    if (addBillGenBOQListvalue.isNotEmpty) {
      await PendingListProvider.BillGenAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<DirectApprovalDet>? getBillBOQApprovalDet() {
    addBillGenBOQListvalue.value.forEach((element) {
      var list = new DirectApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getbillBOQAprovalDetList.value.add(list);
    });
    return getbillBOQAprovalDetList.value;
  }

  Future billGenDirectAproval_buttonApi(BuildContext context) async {
    String body = billGenBoqApprovalReqToJson(BillGenBoqApprovalReq(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      directApprovalDet: getbillDirectAprovalDetList.value.length == 0
          ? getBillDirectApprovalDet()
          : getbillDirectAprovalDetList.value,
    ));
    if (addBillGenDirectListvalue.isNotEmpty) {
      await PendingListProvider.BillGenAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<DirectApprovalDet>? getBillDirectApprovalDet() {
    addBillGenDirectListvalue.value.forEach((element) {
      var list = DirectApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getbillDirectAprovalDetList.value.add(list);
    });
    return getbillDirectAprovalDetList.value;
  }

  Future advanceAproval_buttonApi(String Url, BuildContext context) async {
    String body =
    pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
      urlName: Url.toString(),
      userId: loginController.EmpId(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getAdvanceReqAprovalDetList.value.length == 0
          ? getAdvanceApprovalDet()
          : getAdvanceReqAprovalDetList.value,
    ));
    if (add_AdvanceReqListvalue.isNotEmpty) {
      await PendingListProvider.AdvanceRequesAprovalAPI(body, context);
      await getPendingList();
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<ApprovalDet>? getAdvanceApprovalDet() {
    int i = 0;
    add_AdvanceReqListvalue.value.forEach((element) {
      var list = ApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getAdvanceReqAprovalDetList.value.add(list);
      i++;
    });
    return getAdvanceReqAprovalDetList.value;
  }

  Future GetDetDetails(String Url, int RID, String Reqno, String Projectname,
      BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null) {
      if (response.success == true) {
        onclickPendingListDet = Url == "PENDING QUOTE"|| Url =="QUOTE VERIFICATION PENDING" || Url =="QUOTE APPROVAL PENDING"?response.result!:response.result!.mMatReqMasLink!;
        print(onclickPendingListDet.toString());
        return Url == "MRN VERIFICATION" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingListDet_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    ))) :
        Url == "MRN PRE APPROVAL" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingListDet_PreApproval(
                      heading: Url,
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    ))) :
        Url == "MRN FINAL APPROVAL" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingListDet_MRNFinalApproval_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    ))) :
        Url == "SITE REQUEST VERIFICATION" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingList_SiteVerifyPopup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname, heading: Url,
                    ))):
        Url == "SITE REQUEST APPROVAL" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingList_SiteVerifyPopup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname, heading: Url,
                    ))) :

        Url == "PENDING QUOTE" || Url == "QUOTE VERIFICATION PENDING" || Url == "QUOTE APPROVAL PENDING" ?
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => QuoteDetPopup(
              heading: Url,
              list: onclickPendingListDet,
              ReqNo: Reqno,
              ProjectName: Projectname,
            ))) : SizedBox();
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future PendingPoDetDetails(String Url, int RID, String Reqno,
      String Projectname, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true)
      {
        var result = response!.result;

        if (result is List<MMatReqMasLink>) {
          onclickPendingListDet = result;

        } else if (result is OnclickPendingDetResult) {
          onclickPendingListDet = result.mMatReqMasLink ?? [];

        } else {
          onclickPendingListDet = [];
        }
        print(onclickPendingListDet.toString());
        return Url == "PENDING PO" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_PoPopup(
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                  ProjectName: Projectname,
                ))) :
        Url == "INWARD PENDING" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_InwardPopup(
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                ))) :  Url == "STORE TRANSFER PENDING" ?
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StoreTeansferPending(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname, URL: Url,
                    ))) : SizedBox();
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future PoVerification_ApproveDetDetails(
      String Url, int RID, String Reqno,BuildContext context,{String? purchaseType}) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID, purchaseType:purchaseType);
    if (response != null ) {
      if(response.success==true){
        onclickPendingListDet = response.result!.mMatPurOrdLink!;
        print(onclickPendingListDet.toString());
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingPo_Approvel_Popup(
                    heading: Url, list: onclickPendingListDet, ReqNo: Reqno)));
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  Future GetDirectTransVerifyApproveDet(String Url, int RID, String Reqno,
      String frProjectName, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true) {
        onclickPendingListDet = response.result!.materialTransferRequestDets!;
        print(onclickPendingListDet.toString());
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DirectTransVerifyApprovalDet(
                  heading: Url,
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                  frProjectName: frProjectName,
                )));
      }
      else
      {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  //----------PO PREAPPROVAL------------------

  Future PendingPoPreApprovalDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true) {
        onclickPendingListDet = response.result!.mMatReqMasLink!;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingPo_Approvel_Popup(
                  heading: Url,
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                )));
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }



  ///--------------WORK ORDER VERIFY & APPROVAL-------------------
  Future WorkOrderDetList(String Url, int RID, String Reqno, String WOType,
      BuildContext context) async {
    onclickPendingListDet.clear();
    var response =  await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true){
        onclickPendingListDet = response.result!.mMatReqMasLink!;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOrderDet(
                  heading: Url,
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                  WOType: WOType,
                )));
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future poapprovalSupplierlist(
      BuildContext context, matId, String materialname, String scale) async {
    poapprovalSupplierList.clear();
    Searchpoapproval_supplierList.clear();
    var response = await PendingListProvider.getPoapproval_SupplierbuildList_Provider(matId);
    if (response != null) {
      if(response.success == true ){
        if(response.result!.isNotEmpty){
          poapprovalSupplierList = response.result!;
          Searchpoapproval_supplierList.value = poapprovalSupplierList;
          print(poapprovalSupplierList.toString());
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return PoApproval_supplierList_Alert(
                    MaterialId: matId, MaterialName: materialname, Scale: scale);
              });
        }
        else{
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something Went Wrong..");
      }
    }
    else
    {
      BaseUtitiles.showToast("Something Went Wrong..");
    }
  }


  // Future quoteDetDetails(String Url, int RID, String Reqno, String ProjectName, BuildContext context) async {
  //   onclickPendingListDet.clear();
  //   await PendingListProvider.getOnclickDetProvider(Url, RID).then((value) async {
  //     if (value != null && value.length > 0) {
  //       onclickPendingListDet = value;
  //       print(onclickPendingListDet);
  //       Navigator.push(
  //           context, MaterialPageRoute(
  //           builder: (context) => QuoteDetPopup(
  //             heading: Url,
  //             list: onclickPendingListDet,
  //             ReqNo: Reqno,
  //             ProjectName: ProjectName,
  //           )));
  //     }
  //   });
  // }

  RxList supplierList = [].obs;
  bool checkboxval = false;
  bool refreshdata = false;
  late List<bool> isChecked;

  RxInt quoteid = 0.obs;

  setCheck(int id,bool value){
    quoteid.value = 0;
    supplierList.forEach((element) {
      if(element.id == id){
        quoteid.value = element.id;
        element.isChecked = value;
      }
    });
  }

  Future getQuoteSupplierlist(int id) async {
    supplierList.value=[];
    var response = await PendingListProvider.getsupplierlistApi(id);
    if (response != null) {
      if (response.success == true) {
        if (response.result.isNotEmpty) {
          supplierList.value = response.result;
        } else {
          BaseUtitiles.showToast('No Data Found');
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future quotVerifyAprovalbuttonApi(context,int id,type,{quoteMasId}) async {
    final response = await PendingListProvider.quoteVerifyApprovalApi(id,type,verifyRemarks.text,revertRemarks.text,quoteMasId);
    print("Quote Approve :: $response");
    if(response!=null){
      if(response["success"]==true){
        BaseUtitiles.showToast(response["message"]);
        await getPendingList();
        BaseUtitiles.popMultiple(context, count: 3);
      }else {
        BaseUtitiles.showToast(response["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 3);
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 3);
    }
  }

  Future PendingTransferPendingDetDetails(String Url, int RID, String Reqno,
      String ProjectName, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true){
        var result = response!.result;

        if (result is List<MMatReqMasLink>) {
          onclickPendingListDet = result;

        } else if (result is OnclickPendingDetResult) {
          onclickPendingListDet = result.mMatReqMasLink ?? [];

        } else {
          onclickPendingListDet = [];
        }
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_TransferPending_Popup(
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                  ProjectName: ProjectName,
                  heading: Url,
                )));
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future againstMRNApprovalPendingDetDetails(String Url, int RID, String Reqno,
      String ProjectName, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true) {
        var result = response!.result;
        if (result is List<MMatReqMasLink>) {
          onclickPendingListDet = result;
        } else if (result is OnclickPendingDetResult) {
          onclickPendingListDet = result.mMatReqMasLink ?? [];
        } else {
          onclickPendingListDet = [];
        }
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PendingList_TransferPending_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: ProjectName,
                      heading: Url,
                    )));
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }




  Future PendingTransferACKDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    var response = await PendingListProvider.getOnclickDetProvider(Url, RID);
    if (response != null ) {
      if(response.success==true){
        var result = response!.result;

        if (result is List<MMatReqMasLink>) {
          onclickPendingListDet = result;

        } else if (result is OnclickPendingDetResult) {
          onclickPendingListDet = result.mMatReqMasLink ?? [];

        } else {
          onclickPendingListDet = [];
        }
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransferAckMaterialList(
                  list: onclickPendingListDet,
                  ReqNo: Reqno,
                )));
      }else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  Future getSubcontractor_ExpensesList(String name, BuildContext context, {bool? isRoute}) async {
    onclickPendingListData.clear();
    mainlist.value=[];
    var response = await PendingListProvider.getOnclickPendingListProvider(name);
    if (response != null) {
      if(response.success==true ){
        if(response.result!.isNotEmpty) {
          onclickPendingListData = response.result!;
          mainlist.value = onclickPendingListData;
          if (isRoute != false) {
            name == "MRN VERIFICATION"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnVerfication(
                          onclickPendingListData: onclickPendingListData,
                          heading: name)),
            )
                : name == "MRN PRE APPROVAL-GM"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnPreApproval(
                          onclickPendingListData: onclickPendingListData,
                          heading: name)),
            )
                : name == "MRN PRE APPROVAL-AM"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnPreApproval_AM(
                          onclickPendingListData: onclickPendingListData,
                          heading: name)),
            )
            //     : name == "MRN APPROVAL"
            //     ? Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MrnApproval(
            //           onclickPendingListData:
            //           onclickPendingListData,
            //           heading: name)),
            // )
                : name == "MRN PRE APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnPreApproval(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name == "PENDING PO"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PendingPO(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name == "MRN DECISION PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OnclickPendingList(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name == "WORK PRE APPROVAL PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WorkPreApproval(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name == "MRN FINAL APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnFinalApproval(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name == "SITE REQUEST VERIFICATION"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SiteRequestVerification(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            ) : name == "SITE REQUEST APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SiteRequestVerification(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            ) : name == "STORE TRANSFER PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StoreTransferPending(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name ==
                "TRANSFER REQUEST VERIFICATION PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DirectTransferVerifyApprove(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading: name)),
            )
                : name ==
                "TRANSFER REQUEST APPROVAL PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DirectTransferVerifyApprove(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading:
                          name)),
            )
                : name == "PO VERIFICATION"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PoVerification(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading:
                          name)),
            )
                : name ==
                "PO PREAPPROVAL PENDING"
                ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PoPreApproval(
                            onclickPendingListData:
                            onclickPendingListData,
                            heading:
                            name)))
                : name ==
                "PO APPROVAL"
                ? Navigator
                .push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PoApprovalDesign(
                          onclickPendingListData:
                          onclickPendingListData,
                          heading:
                          name)),
            )
                : name == "WORK ORDER VERIFICATION - DIRECT" ||
                name ==
                    "WORK ORDER VERIFICATION - BOQ"
                ? Navigator
                .push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WorkOrder(onclickPendingListData: onclickPendingListData,
                          heading: name)),
            )
                : name ==
                "WORK ORDER APPROVAL"
                ? Navigator
                .push(
              context,
              MaterialPageRoute(builder: (context) => WorkOrder(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name ==
                "INWARD PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InwardPending(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "TRANSFER PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  TransferPending(
                      onclickPendingListData: onclickPendingListData,
                      heading: name)),
            )
                : name == "TRANSFER REQUEST PENDING VIEW"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  TransferPending(
                      onclickPendingListData: onclickPendingListData,
                      heading: name)),
            )
                : name == "DIRECT TRANSFER VERIFICATION PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  TransferVerification(
                      onclickPendingListData: onclickPendingListData,
                      heading: name)),
            )
                : name == "DIRECT TRANSFER APPROVAL PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DirectTransferApprovarl(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "TRANSFER ACKNOWLEDGMENT PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransferACKPending(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "SUBCONTRACTOR ATTENDANCE APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubContractorAttandance(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "COMPANY LABOUR ATTENDANCE APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompanyLbrAtendance(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "SUBCONTRACTOR DPR APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SubContDPRApproval(
                        onclickPendingListData: onclickPendingListData,
                        heading: name,
                      )),
            )
                : name == "SUBCONTRACTOR NMR Bill APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubContNMRBillApproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "BILL GENERATION-BOQ APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BillGenBOQAproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "BILL GENERATION-DIRECT APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BillGenDirectAproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "ADVANCE REQUISITION APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdvanceReqAproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "STAFF REQUISITION APPROVAL" ||
                name == "STAFF REQUISITION VERIFICATION"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaffRequisitionVerify(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name == "STAFF ONDUTY PUNCHIN APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PunchInApproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            ) : name ==
                "PENDING QUOTE"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuotePending(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            ) : name ==
                "QUOTE VERIFICATION PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuoteVerifyandApproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : name ==
                "QUOTE PRE APPROVAL"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuoteVerifyandApproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            ) : name ==
                "QUOTE APPROVAL PENDING"
                ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuoteVerifyandApproval(
                  onclickPendingListData: onclickPendingListData,
                  heading: name)),
            )
                : Navigator.push(context, MaterialPageRoute(
                builder: (context) => OfficeVoucherApproval(
                    onclickPendingListData: onclickPendingListData,
                    heading: name)));
          }
        }
        else{
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }
      else{
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong..");
    }
  }
}
