import 'package:prahkurticore/controller/pendinglistcontroller.dart';

import '../controller/logincontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jiffy/jiffy.dart';

import '../home/requistionslip/requistionslipactivity.dart';
import '../models/reqslipapproval_model.dart';
import '../models/requisitionslipsave_model.dart';
import '../provider/reuisitionslip_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class  RequisitionSlipController extends GetxController{
  final ReqAutoyearwise=TextEditingController();
  final Reqdate=TextEditingController();
  final Staffname=TextEditingController();
  final Location=TextEditingController();
  final Reason=TextEditingController();
  final PerReason=TextEditingController();
  final OndutyReason=TextEditingController();
  final Fromdate=TextEditingController();
  final Todate=TextEditingController();
  final Totaldays=TextEditingController();
  final ondutyDate=TextEditingController();
  final perDate=TextEditingController();
  final pFromtime=TextEditingController();
  final onFromtime=TextEditingController();
  final pTotime=TextEditingController();
  final onTotime=TextEditingController();
  final TotalHrs=TextEditingController();
  final EntrylistFromdate=TextEditingController();
  final EntrylistTodate=TextEditingController();
  final reqtype=TextEditingController();


  RxString type="Leave".obs;
  final verifyRemarks=TextEditingController();


  int reqId=0;
  int editCheck = 0;
  RxString saveButton=RequestConstant.SAVE.obs;
  RxList ReqSlipEtyList = [].obs;
  RxList mainentrylist = [].obs;
  RxList ReqSlipEditList = [].obs;
  LoginController loginController=Get.put(LoginController());
  PendingListController pendingListController = Get.put(PendingListController());



  Future getRequisitionslip_EntryList() async {
    mainentrylist.value.clear();
    ReqSlipEtyList.value.clear();
    await RequisitionslipProvider.getReqSlipEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        EntrylistFromdate.text,
        EntrylistTodate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainentrylist.value = value;
        ReqSlipEtyList.value = mainentrylist.value;
        return mainentrylist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }


  // Future SaveButton_MaterialIntentScreen(BuildContext context, int id) async {
  //   if(type.value=="Leave"){
  //       reqtype.text="L";
  //   }
  //   else if(type.value=="OnDuty"){
  //     reqtype.text="O";
  //   }
  //   else{
  //     reqtype.text="P";
  //   }
  //   String body = requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest(
  //     reqId: id != 0 ? id.toString() : "0",
  //     reqNo: ReqAutoyearwise.text,
  //     reqDate: Reqdate.text,
  //     staffId: loginController.user.value.empId.toString(),
  //     projectid: "0",
  //     reqType: reqtype.text,
  //     leaveReason: Reason.text,
  //     lFrdate: Fromdate.text,
  //     lTodate: Todate.text,
  //     totalLeave: Totaldays.text,
  //     perReason: PerReason.text,
  //     pFrdate: perDate.text,
  //     pTodate: perDate.text,
  //     pFrTime: pFromtime.text,
  //     pToTime: pTotime.text,
  //     totalPerHrs: TotalHrs.text,
  //     userId: loginController.UserId(),
  //     deviceName: BaseUtitiles.deviceName,
  //     entryMode:saveButton.value=="Save"?"ADD":saveButton.value=="Update"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
  //
  //   ));
  //   final list = await RequisitionslipProvider.SaveReqslipScreenEntryAPI(body, id,context);
  //   if (list != null && id != 0) {
  //     BaseUtitiles.showToast(list);
  //     editCheck=0;
  //     return Navigator.pushReplacement(
  //         context,
  //         new MaterialPageRoute(
  //             builder: (BuildContext context) =>
  //             new requistion_Activity(1)));
  //   } else {
  //     if (list == RequestConstant.DUPLICATE_OCCURED) {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       return BaseUtitiles.showToast(list);
  //     } else {
  //
  //       BaseUtitiles.showToast(list);
  //       editCheck=0;
  //       return Navigator.pushReplacement(
  //           context,
  //           new MaterialPageRoute(
  //               builder: (BuildContext context) =>
  //               new requistion_Activity(1)));
  //     }
  //   }
  // }


  // Future Requisitionslip_EditApi(int reqId, BuildContext context) async {
  //
  //   await RequisitionslipProvider.Requisitionslip_editAPI(reqId).then((value) async {
  //     if (value != null && value.length > 0) {
  //
  //       editCheck = 1;
  //       ReqSlipEditList.value = value;
  //
  //       return Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => requistion_Activity(0)),
  //       );
  //     }
  //   });
  // }


  //--Entrylist Delete--
  Future Requisition_DeleteApi(int reqId, String ReqNo) async {
    await RequisitionslipProvider.Requisitionslip_entryList_deleteAPI(reqId,ReqNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future<void> reqSlipApproveApi(BuildContext context, String urlName, int? reqId, String reqNo,) async {
    String body = reqSlipApprovalToJson(ReqSlipApproval(
      urlName: urlName,
      reqId: reqId.toString(),
      reqNo: reqNo,
      deviceName: BaseUtitiles.deviceName,
      userId: loginController.user.value.userId.toString(),
      approvedBy: loginController.user.value.empId.toString(),
      appRemarks: verifyRemarks.text,
    ));
    final returnRes = await RequisitionslipProvider.RequisitionSlipAPI(body, context);
    if (returnRes != null) {
      print('RequisitionVerify :: $returnRes');
      BaseUtitiles.showToast(returnRes);
      await pendingListController.getPendingList();
      Navigator.pop(context);
      return Navigator.pop(context);
    } else {
      BaseUtitiles.showToast( RequestConstant.NORECORD_FOUND);
    }
  }


  vehicleAge(DateTime Fromdate, DateTime Todate) {
    var dt1 = Jiffy(Fromdate);
    var dt2 = Jiffy(Todate);

    int years = int.parse("${dt2.diff(dt1, Units.YEAR)}");
    dt1.add(years: years);

    int month = int.parse("${dt2.diff(dt1, Units.MONTH)}");
    dt1.add(months: month);

    var days = dt2.diff(dt1, Units.DAY)+1;

    Totaldays.text=days.toString();
    // return "$years Years $month Month $days Days";

  }
}