import 'package:prahkurticore/controller/punch_in_controller.dart';
import 'package:prahkurticore/controller/requisitionslip_controller_new.dart';
import 'package:prahkurticore/controller/site_location_controller.dart';
import '../controller/preapproval_controller.dart';
import '../controller/billgenerationdirect_controller.dart';
import '../controller/cashbook_site_controller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/dailywrk_done_dprlabour_controller.dart';
import '../controller/dailywrk_done_dprnew_controller.dart';
import '../controller/inward_pending_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/sitevoucher_controller.dart';
import '../controller/staffvoucher_controller.dart';
import '../controller/transferbw_project_controller.dart';
import '../controller/transferbw_site_controller.dart';
import '../home/menu/accounts/cash_book_site/casebook_site_new.dart';
import '../home/menu/accounts/cash_book_staff/case_book_staff.dart';
import '../home/menu/accounts/site_voucher/site_voucher_new/site_voucher_entrylist_new.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_entrylist.dart';
import '../home/menu/daily_entries/advancereques_voucher_new/advance_req_entrylist_new.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generation_entrylist.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_main.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/daily_wrkdone_dpr_labour.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_wrkdone_dpr_entrylistnew.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entrylist.dart';
import '../home/menu/daily_entries/pre_approval/preapproval_main.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subattendance_site_entry_list.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entrylist.dart';
import '../home/menu/materials/consumption/consumption_list.dart';
import '../home/menu/materials/inward/inward_list.dart';
import '../home/menu/materials/materialTransferRequest/materialTransReq_list.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/menu/materials/mrn_request(preIndent)/mrnreq_preindent_list.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_list.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_list.dart';
import '../home/menu/payroll/requisitionslip/list_requisitionslip.dart';
import '../models/home_menulistres_model.dart';
import '../models/report_list_model.dart';
import '../provider/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';
import 'advance_reqvoucher_new_controller.dart';
import 'boqrevised_controller.dart';
import 'company_nmr_controller.dart';
import 'consumption_controller.dart';
import 'mrn_request_indent_controller.dart';
import 'mrnrequest_preIndent_controller.dart';
import 'nmrweeklybill_controller.dart';


class Menu_Controller extends GetxController {
  LoginController loginController = Get.put(LoginController());
  DailyEntriesController dailyEntriesController=Get.put(DailyEntriesController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());
  TransferBW_project_Controller transferBW_project_Controller=Get.put(TransferBW_project_Controller());
  TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());
  // AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  AdvanceReqVoucherController_new advanceReqVoucherController_new =Get.put(AdvanceReqVoucherController_new());
  SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
  StaffVoucher_Controller staffVoucher_Controller=Get.put(StaffVoucher_Controller());
  MRN_Request_Controller mrn_request_controller=Get.put(MRN_Request_Controller());
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());
  Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
  InwardPending_Controller inward_controller = Get.put(InwardPending_Controller());
  CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  // PreApprovalController preApprovalController=Get.put(PreApprovalController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  RequisitionSlipControllerNew requisitionSlipController = Get.put(RequisitionSlipControllerNew());
  PunchInController punchInController = Get.put(PunchInController());
  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());

  RxList menuListDatas = [].obs;
  RxList reportListDatas = [].obs;

  RxString formName = "".obs;
  RxInt formMenuId = 0.obs;
  RxString commonMenuId = "0".obs;
  // List<SubMenuReports> subMenusReportList = [];
  // RxList<SubMenuReports> subMenusList = <SubMenuReports>[].obs;

  List<Menu> subMatList = [];
  List<Menu> subMainmenuList = [];
  List<Menu> dailyEntryList = [];
  List<Menu> accountsList = [];
  List<Menu> payrollList = [];


  Future getMenuList(BuildContext context) async {
    menuListDatas.value =[];
    print("User Id :: ${loginController.user.value.userId}");

    await MenuProvider.getMenuListProvider().then((value)  {
      if ( value != null ) {
        if (value.success == true) {
          if(value.result!.isNotEmpty) {
            menuListDatas.value = value.result!;
            value.result!.forEach((element) {
              if (element.moduleName == "Materials") {
                subMatList.clear();
                subMatList.addAll(element.menu!);
              }
              if (element.moduleName == "Main Menu") {
                subMainmenuList.clear();
                subMainmenuList.addAll(element.menu!);
              }
              if (element.moduleName == "Daily Entries") {
                dailyEntryList.clear();
                dailyEntryList.addAll(element.menu!);
              }
              if (element.moduleName == "Accounts") {
                accountsList.clear();
                accountsList.addAll(element.menu!);
              }
              if (element.moduleName == "Payroll") {
                payrollList.clear();
                payrollList.addAll(element.menu!);
              }
            });
          }else {
            BaseUtitiles.showToast("No Data Found");
          }
        }
        else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      }
      else {
        BaseUtitiles.showToast("Something went wrong..");
      }
    });
  }


  // Future getReportsList() async {
  //   print("User Id :: ${loginController.user.value.userId}");
  //   await MenuProvider.getReportsListProvider(loginController.user.value.userId!).then((value)  {
  //     if (value != null && value.length > 0) {
  //       reportListDatas.value = value;
  //       subMenusList.clear();
  //       for (var menu in reportListDatas.value) {
  //         subMenusList.addAll(menu.subMenu);
  //       }
  //       return reportListDatas.value;
  //     }
  //     update();
  //     return reportListDatas.value;
  //   });
  // }

  Future getReportsList() async {
    reportListDatas.value.clear();
    var response = await MenuProvider.getReportsListProvider();
    if (response != null) {
      if (response.success == true) {
        List<ReportResult> materialList = response.result!;
        if (materialList!.isNotEmpty) {
          reportListDatas.assignAll(materialList);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      }
      else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


 MaterialScreen(String value, BuildContext context) {
    if (value == "MRN Request (Indent)") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MRN_RequestIndent_Entrylist()));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MRN_Request_Indent(0)),
      // );

    }
    else if (value == "Site Request (Issue Slip)") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MRNRequest_PreIndent_List()),);
    }
    else if (value == "Inward") {
      inward_controller.inwardAllDatasList.value.clear();
      inward_controller.itemlistTable_Delete();
      inward_controller.ItemGetTableListdata.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Inward_ListScreen()),);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Material_Inward(2)),
      // );

    } else if (value == "Transfer Between Projects") {
      transferBW_project_Controller.type.value="Direct";
      transferBW_project_Controller.itemlistTable_Delete();
      transferBW_project_Controller.ItemGetTableListdata.value.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  TransferBtweenProjects_Entrylist()),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Transfer_Between_Projects(0)),
      // );
    } else if (value == "Transfer Between Sites") {
      transferBt_Site_Controller.itemlistTable_Delete();
      transferBt_Site_Controller.ItemGetTableListdata.value.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransferBetweenSites_Entrylist()),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Transfer_Between_Sites(0)),
      // );
    }else if(value == "Material Transfer Request"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MatTransReqList()),);
    }
    else if (value == "Consumption") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Consumption_List()),);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Material_Consumption(0)),
      // );

    }
  }

  NavigateScreen(String value, BuildContext context) async {
    if (value == "SubContractor Attendance") {
      dailyEntriesController.deleteSubcontDetTableDatas();
      dailyEntriesController.readListdata.value=[];
      Navigator.push(context, MaterialPageRoute(builder: (context) => SubAttendanceSiteEntryList()));

    }
    else if(value=="Company NMR Attendance"){
      companyNmrAttendanceController.entrycheck=0;
      companyNmrAttendanceController.edicheck=0;
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  CompanyNmrMain(0)),);
    }

    else if (value == "SubCont NMR Wkly Bill - Generation") {
      nmrWklyController.editCheck = 0;
      nmrWklyController.submitCheck = 0;
      nmrWklyController.NmritemList.value.clear();
      Navigator.push(
        context, MaterialPageRoute(
            builder: (context) => Subcont_NMR_EntryListScreen_Site()),
      );
    } else if (value == "Daily Work Done (DPR)") {
      dailyWrkDone_DPR_Controller.editCheck = 0;
      dailyWrkDone_DPR_Controller.entrycheck = 0;
      dailyWrkDone_DPR_Controller.addwrkCheck = 0;
      dailyWrkDone_DPR_Controller.screenchek.value=0;
      dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyWork_done_DPR_EntryList()),
      );
    } else if (value == "Daily Work Done (DPR New)") {
        dailyWrkDone_DPRNEW_Controller. entrycheck=0;
        dailyWrkDone_DPRNEW_Controller.editcheck=0;
        dailyWrkDone_DPRNEW_Controller.check=0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyWork_done_DPR_EntryListNew()),
      );
    }

    else if (value == "Daily Work Done (DPR Labour)") {
      dailyWrkDone_DPRLabour_Controller.screencheck=0;
      dailyWrkDone_DPRLabour_Controller.editCheck=0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyWrk_Done_DPR_Labour(0)),
      );
    }


    else if (value == "Bill Generation - Direct") {
      billGenerationDirectController.entrycheck=0;
      billGenerationDirectController.editCheck=0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bill_Generation_direct_Entrylist()),
      );

    } else if (value == "Advance Requisition Voucher") {
      advanceReqVoucherController_new.itemlistTable_Delete();
      advanceReqVoucherController_new.ItemGetTableListdata.value.clear();
      advanceReqVoucherController_new.delete_ListTable();
      advanceReqVoucherController_new. GetTableList.value.clear();
      advanceReqVoucherController_new.entrycheck=0;
      advanceReqVoucherController_new.editcheck=0;
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdvReq_Voucher_EntryList_new()),
      );
    }
  }

  AccountsScreen(String value, BuildContext context) {
    if (value == "Site Voucher") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SiteVoucher_EntryListNew()),
      );
    } else if (value == "Staff Voucher") {
      staffVoucher_Controller.TotalAmount.text="0.00";
      staffVoucher_Controller.editcheck=0;
      staffVoucher_Controller.itemcheck=0;
      staffVoucher_Controller.Active=0;
      staffVoucher_Controller.type.value="SiteWise Payment";
      staffVoucher_Controller.delete_Sitevoucher_itemlist_Table();
      staffVoucher_Controller.Sitevoucher_itemview_GetDbList.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Staff_Voucher_EntryListScreen()),
      );
    } else if (value == "Cash Book/Staff") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Case_Book_Staff()),
      );
    }
    else if (value == "Cash Book/Site") {
      cashBookSiteController.cashsiteDatas.value.clear();
      Navigator.push(
        // context, MaterialPageRoute(builder: (context) => Case_Book_Site()),
        context, MaterialPageRoute(builder: (context) => CashBook_Site()),
      );
    }
  }

  MainmenuScreen(String value, BuildContext context) {
    boq_revised_controller.editCheck=0;
    boq_revised_controller.itemCheck=0;
    if (value == "BOQ - Revised") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Boq_Revised_EntryList()),
      );
    }
  }
  PayrollScreen(String value, BuildContext context) {
    if (value == "Staff Requisition Slip") {
      requisitionSlipController.reqSlip = 0;
      requisitionSlipController.entryCheck = 0;
      requisitionSlipController.editCheck = 0;
      requisitionSlipController.buttonControl = 0;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Requisitionslip_EntryList()));
    }
  }
}
