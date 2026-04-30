import 'dart:io';

class ApiConfig {
  // static const String LIVE_ENDPOINT_CORE = "http://192.168.0.250:8080/";  //local
  static const String LIVE_ENDPOINT_CORE = "http://49.204.233.151:8080/";    //local

  // static const String DEFAULT_BASE_URL_CORE = LIVE_ENDPOINT_CORE + "vrindhavanaAPI/";
  static const String DEFAULT_BASE_URL_CORE = LIVE_ENDPOINT_CORE + "ERPNEW/";
  static late final String APIURL;
  static late final String APIURL_CORE;
  static late final String WebURL;
  static String BASE_URL = APIURL;
  static String BASE_URL_CORE = APIURL_CORE;


  static Future<void> initializeUrl() async {
    final isLive = await _isEndpointLive(Uri.parse(LIVE_ENDPOINT_CORE).host);
    if (isLive) {
      APIURL = "${LIVE_ENDPOINT_CORE}ERPNEW/";
      APIURL_CORE = "${LIVE_ENDPOINT_CORE}ERPNEW/";
      WebURL = "http://49.204.233.151:8080/ERPNEWUI/";
      print("IP_URL $APIURL");
    } else {
      APIURL = DEFAULT_BASE_URL_CORE;
      WebURL = "${LIVE_ENDPOINT_CORE}ERPNEW/";
      print("Using default base URL: $APIURL");
    }
  }

  static Future<bool> _isEndpointLive(String ip) async {
    try {
      final socket = await Socket.connect(ip, 80, timeout: Duration(seconds: 5));
      socket.destroy();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ApiConstant{

  static String BASE_URL = ApiConfig.BASE_URL;
  static String BASE_URL_CORE = ApiConfig.BASE_URL_CORE;
  static String Web_URL = ApiConfig.WebURL;

  /// ---- Get API's ----

  static String DASHBOARD_API = BASE_URL + "api/CommonFile/GetDashboard";
  static String AUTHENTICATION = BASE_URL_CORE + "api/Login/LoginUser";
  static String GETCHECKDEVICE = BASE_URL + "api/CommonFile/GetCheckDevice";
  static String PENDINGLISTAPI = BASE_URL_CORE + "api/Menu/GetMobilePendingList";
  static String GETMRNFINALAPROVALAPI = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetFinalApproveMasById";
  static String GETMRPREAPROVALAPI = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetTobeApprovalByIDS";
  static String GETVERSIONAPI = BASE_URL + "api/CommonFile/GetVersion";
  static String GETPROJECTDROPDOWNLISTALL = BASE_URL + "api/CommonFile/GetProjectAll";
  static String GETPROJECTDROPDOWNLIST = BASE_URL_CORE + "api/GenericMaster/GetProjectBasedOnUserAllocation";
  static String GETFROMPROAGAINSTMRNLIST = BASE_URL_CORE + "api/MaterialTransfer/FromPrject";
  static String GETFROMSITELIST = BASE_URL_CORE + "api/StoreTransferPending/GetSiteDRP";

  static String GETREPORTPROJECTDROPDOWNLIST = BASE_URL_CORE + "api/GenericMaster/GetProjects";
  static String GETREPORTMATERIALDROPDOWNLIST = BASE_URL_CORE + "api/GenericMaster/GetMaterials";

  static String GETPROJECTCOMPANYWISE_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetProjectCompwise";
  static String GET_HEAD_DROPDOWNLIST = BASE_URL + "api/SubContDPRNew/GetHeadname";
  static String GETSUBCONTRACTDROPDOWNLIST = BASE_URL + "api/CommonFile/GetSubContractorAll";
  static String GETSUBCONTRACTLIST = BASE_URL_CORE + "api/GenericMaster/GetSubContractorByProject";
  static String GETSUBCONTRACTLISTRPT = BASE_URL_CORE + "api/GenericMaster/GetSubContract";
  static String GETWRKORDERNOLIST = BASE_URL + "api/SubContDirectBill/GetWorkorderNo";
  static String GETINVOICENOLIST = BASE_URL + "api/SubContDirectBill/GetinvoiceNo";
  static String GETNMRBILLNO = BASE_URL + "api/SubcontNMR/GetProjectCumContractorNo";
  static String GETSUBCONTRACTBILLDIRLIST = BASE_URL + "api/SubContDirectBill/GetSubcontList";
  static String GETNMRREPORT = BASE_URL + "api/Report/GetNmrReportMas";
  static String GETLABOURLIST = BASE_URL + "api/CommonFile/GetLabour";
  static String GETATTENDANCEREPORTLIST = BASE_URL + "api/Report/GetAttendanceReportMas";
  static String ATTENDANCEONITEMSELCT = BASE_URL + "api/Report/GetAttendanceReportDet";
  static String SITEDROPDWONLISTAPI = BASE_URL_CORE + "api/GenericMaster/GetProjectWiseSiteList";
  static String TOSITEDROPDWONLISTAPI = BASE_URL_CORE + "api/GenericMaster/GetToSitesByFrSiteDd";
  static String GETMRNREPORTSLISTAPI = BASE_URL + "api/Report/GetMrnReportMas";
  static String GETINWARDREPORTSLISTAPI = BASE_URL + "api/Report/GetInwardReportMas";
  static String GETSUPPLIERDROPDOWNAPI = BASE_URL + "api/CommonFile/GetSupplier";
  static String GETDPRLISTAPI = BASE_URL + "api/Report/GetDPRReportMas";
  static String GETCOMPANYDROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompany";
  static String GETCOMPANYALL_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompanyAll";
  static String GETPROJECTEXPENSESAPI = BASE_URL + "api/CommonFile/GetProjectExpenses";
  static String GETSUPPLIEROSEXPENSESAPI = BASE_URL + "api/CommonFile/GetSupplierExpenses";
  static String GETSUBCONTRACTOREXPENSESAPI = BASE_URL + "api/CommonFile/GetSubConExpenses";
  static String GETONCLICK_PENDINGLISTAPI = BASE_URL_CORE + "api/CommonFile/GetPendingRecords";
  static String MRNONITEMSELCT = BASE_URL + "api/Report/GetMrnReportDet";
  static String INWARDONITEMSELCT = BASE_URL + "api/Report/GetInwardReportDet";
  static String DPRONITEMSELCT = BASE_URL + "api/Report/GetDPRReportDet";
  static String GETMATERIALSUBDRPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSub";
  static String GETMATERIALSUBMAT_REPORTLIST = BASE_URL + "api/CommonFile/GetMaterialSubReport";
  static String GETMATERIAL_SHOW_LIST = BASE_URL + "api/Report/GetStockReport";
  static String GETMATERIAL_DETAILS_LIST = BASE_URL + "api/Report/GetStockDetail";
  static String GETMATERIAL_SUBHAED_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialHead";
  static String GETMATERIALHEAD_REPORT = BASE_URL_CORE + "api/GenericMaster/GetMaterialHeadItem";
  static String GETMATERIALSUBHEAD_REPORT = BASE_URL_CORE + "api/GenericMaster/GetMaterialSubByHead";
  static String GETMATERIALBASEDSUBHEAD_REPORT = BASE_URL_CORE + "api/GenericMaster/GetMaterialSubItemWiseMaterial";



  static String GETMATERIALWISEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSubAll";
  static String GETMATERIALWISEREPORTLIST = BASE_URL + "api/CommonFile/GetMaterialSubAllReport";
  static String GETMATERIALWISE_SHOW_LIST = BASE_URL + "api/Report/GetStockAbstract";
  static String GETSUBCONT_ENTRY_SHOW_CLICK = BASE_URL + "api/CommonFile/GetSubContCategory";
  static String GETSUBCONTATTEND_CLICK = BASE_URL_CORE + "api/SubContLabourAttendance/SubContLabcatBasedOnSubContDLR";
  static String GETAUTONO_YEAR_WISE = BASE_URL_CORE + "api/GenericMaster/GetAutoNumber";
  static String GETSUBCONT_ATTEN_ENTRY_LIST = BASE_URL_CORE + "api/SubContLabourAttendance/GetAllSubContLabAtt";
  // static String GETSUBCONT_ATTEN_ENTRY_LIST = BASE_URL + "api/SubContLabAttendanceShiftBasis/GetShiftBasisAttendanceEntryList";
  static String GETMENU_LIST_API = BASE_URL_CORE + "api/Menu/GetMobileMenu";
  static String GETREPORT_LIST_API = BASE_URL_CORE + "api/Menu/GetMobileMenuReport";
  static String GETCONTROLL_RIGHTS_ENTRYLIST = BASE_URL_CORE + "api/Admin/GetMenuRightsBasedonMenuIdUserID";
  static String EDIT_SUBCONT_ENTRYLIST_API = BASE_URL_CORE + "api/SubContLabourAttendance/GetSubContLabAttById";
  // static String EDIT_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/GetShiftBasisAttendanceById";
  static String GETSUBCONT_NMR_ENTRY_LIST = BASE_URL + "api/SubcontNMR/GetNMRWklyBillEntryList";
  static String GETSUBCONT_NMR_ITEM_LIST = BASE_URL + "api/SubcontNMR/GETNMRWklyBill";
  static String GETSUBCONT_NMR_CHECKSTATUS = BASE_URL + "api/SubcontNMR/GetNMRDetails";
  static String GETSUBCONT_NMR_COUNT_CHECKSTATUS = BASE_URL + "api/SubcontNMR/GetNMRCount";
  static String GETSUBCONT_NMR_ADVANCE_BALANCE = BASE_URL + "api/SubcontNMR/GetSubContNMRAdvBalance";
  static String EDIT_NMR_DEDUCTION = BASE_URL + "api/SubcontNMR/GetNMRBillId";
  static String GET_DPR_ENTRY_LIST = BASE_URL + "api/SubContDPR/GetDPREntryList";
  static String GET_DPR_SUBCONTRACTOR_LIST = BASE_URL + "api/SubContDPR/GetSubContractorsList";
  static String GET_DPR_ITEM_LIST = BASE_URL + "api/SubContDPR/GetItemsList";
  static String GET_DPR_EDIT_API = BASE_URL + "api/SubContDPR/GetDprById";
  static String GET_DPRNEW_MATERIAL_API = BASE_URL + "api/CommonFile/GetMaterial";
  static String GET_DPR_NEW_ENTRY_LIST = BASE_URL + "api/SubContDPRNew/GetDPREntryList";
  static String GET_DPRNEW_BOQDETAILSLIST = BASE_URL + "api/SubContDPRNew/GetItemsList";
  static String GET_DPRNEW_EDIT_API = BASE_URL + "api/SubContDPRNew/GetDprById";
  static String GET_DPR_LABOUR_ENTRY_LIST = BASE_URL + "api/SubContDPRNewLabour/GetDPREntryList";
  static String GET_DPR_LABOUR_EDIT_API = BASE_URL + "api/SubContDPRNewLabour/GetDprById";
  static String GET_DIRECTBILL_ADVANCE_BALANCE = BASE_URL + "api/SubContDirectBill/GetSubContAdvBalance";
  static String GET_DIRECTBILL_ENTRY_LIST = BASE_URL + "api/SubContDirectBill/GetDirectBillEntryList";
  static String GET_WORKORDER_ENTRY_LIST = BASE_URL + "api/SubContDirectBill/GetWorkOrderList";
  static String EDIT_DIRECTBILL_API = BASE_URL + "api/SubContDirectBill/GetDirectBillById";
  static String EDIT_INWARDPENDING_API = BASE_URL_CORE + "api/MaterialInward/GetInwardDetById";
  static String EDIT_TRANSFERBET_API = BASE_URL_CORE + "api/MaterialTransfer/GetMaterialTransferbtnProById";
  // static String EDIT_TRANSFERBET_SITE_API = BASE_URL_CORE + "api/MaterialSitetosite/GetMaterialTransferById";
  static String EDIT_TRANSFERBET_SITE_API = BASE_URL_CORE + "api/StoreTransferPending/loadTransferBetweensiteDet";

  static String EDIT_ADVANCEREQ_API = BASE_URL + "api/AdvRequisitionVoucher/GetVoucherProjectById";
  static String EDIT_TRANSFER_ACKNOW_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckById";
  static String GETINWARD_ENTRY_LIST = BASE_URL_CORE + "api/MaterialInward/GetAllMaterialInward";
  static String GETMATERIALINWARD_ALLDATAS = BASE_URL_CORE + "api/MaterialInward/GetInwardPendingById";
  static String GETINWARDSTATUSCHECKAPI = BASE_URL_CORE + "api/MaterialInward/InwardMobilecheck";
  static String GETTRANSPROJECT_ENTRY_LIST = BASE_URL_CORE + "api/MaterialTransfer/GetAllTransBetweenProject";
  static String GET_MATTRANSREQ_LIST = BASE_URL_CORE + "api/MaterialTransferRequest/GetAllMaterialTransferRequestMas";
  static String GETFROMPROJECTDROPDOWNLIST = BASE_URL + "api/MaterialTransferProject/GetFromProject";
  static String GETTRANSALLDATASLIST = BASE_URL + "api/MaterialTransferProject/GetReqById";
  static String GETTRANSITEMLIST = BASE_URL + "api/MaterialTransferProject/GetMaterialList";
  static String GETMATTRANSREQ = BASE_URL + "api/MaterialTransferRequest/GetMaterialListbyPRJSIT";
  static String GET_TRANSBETSITE_ENTRYLIST = BASE_URL_CORE + "api/MaterialSitetosite/GetAllSitetoSiteMas";
  static String GETCASHBOOK_SITE = BASE_URL + "api/Report/GetCashBookSite";
  static String GETCASHBOOK_STAFF = BASE_URL + "api/Report/GetCashBookStaff";
  static String GETACCOUNTTYPEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetAccType";
  static String GETACCOUNTTYPEDROPDOWNLISTADVREQ = BASE_URL + "api/CommonFile/GetAccTypeAdvReq";
  static String GetADVREQ_SITEWIEPAYMENTLIST = BASE_URL + "api/AdvRequisitionVoucher/GetAdvreq_sitewisePayment";
  static String GETPAYMODEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetPayMode";
  static String GETPAYFORDROPDOWNLIST = BASE_URL + "api/CommonFile/GetPayFor";
  static String ACCOUNTNAMEDROPDWONLISTAPI = BASE_URL + "api/CommonFile/GetAccName";
  static String STAFFDROPDWONLISTAPI = BASE_URL_CORE + "api/StaffRequisition/GetStaffDd";
  static String GET_ADVREQ_ENTRY_LIST = BASE_URL + "api/AdvRequisitionVoucher/GetVoucherProjectEntryList";
  static String GETSITEVOC_ENTRY_LIST = BASE_URL_CORE + "api/SiteVoucher/GetAllAccountSiteVoucher";
  static String GETSTAFFVOC_ENTRY_LIST = BASE_URL + "api/VoucherStaff/GetVoucherStaffEntryList";
  static String GET_SITEVOUCHER_EDIT_API = BASE_URL + "api/VoucherProject/GetVoucherProjectById";
  static String GET_STAFFVOUCHERSITE_EDIT_API = BASE_URL + "api/VoucherStaff/GetVoucherStaffById";
  static String GET_STAFFVOUCHER_BankNAMELIST_API = BASE_URL + "api/commonfile/GetBankName";
  static String GETMRNREQUEST_ENTRY_LIST = BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllReqOrdMas";
  static String GET_MATERIAL_EDIT_API = BASE_URL_CORE + "api/MaterialReqOrdMas/GetReqOrdMasById";
  static String GET_MATTRANSREQ_EDIT_API = BASE_URL_CORE + "api/MaterialTransferRequest/GetByIdMTR";
  static String GET_COMPANY_NMRALLLISTAPI = BASE_URL + "api/CommonFile/GetLabourById";
  static String GET_CHECKAPPROVALLEVELAPI = BASE_URL_CORE + "api/MaterialReqOrdMas/CheckApprovalLevel";
  static String GET_APPTYPE_API = BASE_URL_CORE + "api/MaterialReqOrdMas/ApprovalType";
  // static String GETMATERIALREQUESTTYPE = BASE_URL + "api/commonfile/Get_Material_Item_ReqType";
  static String GETMATERIALLIST = BASE_URL_CORE + "api/MaterialReqOrdMas/GetMRNMatByReqTypeProNdSite";
  static String GETCONSUMPTION_ENTRY_LIST = BASE_URL_CORE + "api/MaterialExpenseMas/GetAllMaterialExpenses";
  static String GETSTOCKMATERIALLIST = BASE_URL_CORE + "api/MaterialExpenseMas/GetMaterialBasedOnProjAndSite";
  static String GETCONSTYPELIST = BASE_URL_CORE + "api/MaterialExpenseMas/GetExpenseTypeAll";
  static String GETSTOCKLISTMATERIALWISE = BASE_URL_CORE + "api/MaterialReqOrdMas/MrnApprovalStockList";
  static String GET_MRNREQ_ADD_QTY = BASE_URL + "api/CommonFile/GetScale";
  static String GET_CONSUM_EDIT_API = BASE_URL_CORE + "api/MaterialExpenseMas/GetMaterialExpensesById";
  static String GET_BOQ_ENTRY_LIST = BASE_URL + "api/BOQRevised/GetBOQRevisedEntryList";
  static String GETREVISEDITEMLIST = BASE_URL + "api/BOQRevised/GetItemsList";
  static String GET_BOQREVISED_EDIT_API = BASE_URL + "api/BOQRevised/GetBOQRevisedById";
  static String GETREQUISITIONSLIP_ENTRY_LIST = BASE_URL + "api/HR/GetRequisitionEntryList";
  static String GET_REQUISITION_EDIT_API = BASE_URL + "api/HR/GetRequisitionById";
  static String GET_TRAACK_PENDING_ALLDATAS_API = BASE_URL_CORE + "api/MaterialAckMas/getByIdAckTransferPending";
  static String GET_TRAACK_ENTYLIST_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckEntryList";
  static String GETONCLICK_PENDINGLISTDetAPI = BASE_URL + "api/CommonFile/GetPendingRecordsItemsList";
  static String GETONCLICK_AgainstMRNApprovalDetAPI = BASE_URL + "api/MaterialTransferProject/GetPendingRecordsItemsList";
  static String GET_COMPANY_NMRENTRYLISTAPI = BASE_URL + "api/CompanyLabAttendance/GetAttendanceEntryList";
  static String GET_COMPANY_NMRLISTEDIT_API = BASE_URL + "api/CompanyLabAttendance/GetAttendanceById";
  static String GET_PREAPPROVALENTRYLIST_API = BASE_URL + "api/PreApproval/GetPreApprovalEntryList";
  static String GET_PREAPPROVALTYPELIST_API = BASE_URL + "api/CommonFile/GetPreApprovalType";
  static String GET_PREAPPROVAL_EDIT_API = BASE_URL + "api/PreApproval/GetPreApprovalById";
  static String GET_POAPPROVAL_SUPPLIERBUILDLIST_API = BASE_URL_CORE + "api/MaterialPurOrdMas/GetSupplierListByMatId";
  static String GET_TRANSFERACKPENDING_LIST = BASE_URL + "api/MaterialTransferAck/GetMatTransAckMaterialList";
  static String GET_PUNCHIN_STATUS = BASE_URL_CORE + "api/PunchInandOut/GetPunchStatus";
  // static const String GET_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandoutStatus";
  static String TODAY_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutTodayWiseReports";
  static String OLDTODAY_PUNCHIN_STATUS = BASE_URL_CORE + "api/PunchInandOut/GetAllPunInAndOut";

  static String PUNCH_FILTER_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutReports";
  static String GET_INVOICEANDDCNOCHECK = BASE_URL + "api/MaterialInward/GetCheckNo";
  static String GET_MRNVERIFICATION_PENDINGLIST = BASE_URL_CORE + "api/MaterialReqOrdMas/GetAllReqordVerifyPending";
  static String GET_MRNPREAPPROVAL_PENDINGLIST = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetAllTobePreApproval";
  static String GET_MRNAPPROVAL_PENDINGLIST = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetAllFinalApprovalMas";
  static String GET_PO_PENDINGLIST = BASE_URL_CORE + "api/MaterialPurOrdMas/GetAllPendingPO";
  static String GET_POVERIFICATION_PENDINGLIST = BASE_URL_CORE + "api/MaterialPurOrdMas/GetPurOrdVerificationList";
  static String GET_POAPPROVAL_PENDINGLIST = BASE_URL_CORE + "api/MaterialPurOrdMas/GetAllPoAppPending";
  static String GET_INWARD_PENDINGLIST = BASE_URL_CORE + "api/MaterialInward/GetAllInwardPending";
  static String GET_TRANSFER_PENDINGLIST = BASE_URL_CORE + "api/MaterialTransfer/GetAllTransferPendingView";
  static String GET_TRANSFERREQUEST_PENDINGLIST = BASE_URL_CORE + "api/MaterialTransferRequest/GetAllTransferRequestPendingViewMTR";
  static String GET_TRANSFER_ACKNOWLEGDEMENT_LIST = BASE_URL_CORE + "api/MaterialAckMas/getAllTranferAckPending";
  static String GET_SUBCON_APPROVAL_LIST = BASE_URL_CORE + "api/SubContLabourAttendance/GetToBeApproved";
  static String GET_TRANSFER_DET_LIST = BASE_URL_CORE + "api/MaterialTransfer/DetLoadBasedOnNo";
  static String GET_TRANSFER_VERIFI_PEND_LIST = BASE_URL_CORE + "api/MaterialTransferRequestVerify/GetMTRVerifyDetails";
  static String GET_TRANSFER_APPROVE_PEND_LIST = BASE_URL_CORE + "api/MaterialTransferRequestApproval/GetAllMTRToBeApproval";
  static String GET_SITEREQ_VERIFY_PEND_LIST = BASE_URL_CORE + "api/SiteRequest/GetAllPreIndentVerifyPendingDetails";
  static String GET_SITEREQ_APPROVAL_PEND_LIST = BASE_URL_CORE + "api/SiteRequest/GetAllTobePreIndentApproval";
  static String GET_SUPPLIER_QUOTE_APPROVAL_LIST = BASE_URL_CORE + "api/MaterialQuote/GetSupplierQuoteApproval";

  static String GET_PENDING_QUOTE_LIST = BASE_URL_CORE + "api/MaterialQuote/GetPendingQuote";
  static String GET_VERIFY_QUOTE_LIST = BASE_URL_CORE + "api/MaterialQuote/GetQuoteVerificationPending";
  static String GET_APPROVE_QUOTE_LIST = BASE_URL_CORE + "api/MaterialQuote/GetQuoteApprovalPending";
  static String GET_STORETRANS_PEND_LIST = BASE_URL_CORE + "api/StoreTransferPending/GetAllStoreTransferPending";
  static String GETSTORETRANSPENDINGVIEWLIST = BASE_URL_CORE + "api/StoreTransferPending/GetReqordDetailsById";



  static String GETMRNREQUEST_PREINDENT_ENTRYLIST = BASE_URL_CORE + "api/SiteRequest/GetAllPreIndent";
  static String GET_MATERIALREQPREINDEDNT_EDIT_API = BASE_URL_CORE + "api/SiteRequest/GetPreIndentByID";
  static String GET_PENDING_QUOTE_MORE_API = BASE_URL_CORE + "api/MaterialQuote/GetQuoteDetView";
  static String GET_STORETRANFER_MORE_API = BASE_URL_CORE + "api/StoreTransferPending/GetStoreTransferPendingView";





  static String MRN_VERIFICATION_MOREDETAILS = BASE_URL_CORE + "api/MaterialReqOrdMas/GetReqOrdMasById";
  static String MRN_PREAPPROVAL_MOREDETAILS = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetTobeApprovalByIDS";
  static String MRN_FINALAPPROVAL_MOREDETAILS = BASE_URL_CORE + "api/MaterialPreApprovalRequest/GetFinalApproveMasById";
  static String PENDING_PO_MOREDETAILS = BASE_URL_CORE + "api/MaterialPurOrdMas/GetPendingPoViewSub";
  static String POVERIFICATION_MOREDETAILS = BASE_URL_CORE + "api/MaterialPurOrdMas/GetPurchaseOrderDetaisloadById";
  static String INWARD_MOREDETAILS = BASE_URL_CORE + "api/MaterialInward/GetInwardPendingById";
  static String TRANSFERPENDING_MOREDETAILS = BASE_URL_CORE + "api/MaterialTransfer/GetTransferDetails";
  static String TRANSFER_REQUESTPENDING_MOREDETAILS = BASE_URL_CORE + "api/MaterialTransferRequest/GetMTRViewAndSearch";
  static String TRANSFERACKPENDING_MOREDETAILS = BASE_URL_CORE + "api/MaterialAckMas/getByIdAckTransferPending";
  static String TRANSFERREQ_PEND_APPROVE_MOREDETAILS = BASE_URL_CORE + "api/MaterialTransferRequest/GetByIdMTR";

















  /// ---Reports---

  static String GETPROJECT_REPORTS = BASE_URL + "api/CommonFile/GetProjectReport";
  static String GETPROJECT_REQUISITIONSLIP = BASE_URL + "api/HR/GetLocation";
  static String GETSITE_REPORTS = BASE_URL + "api/CommonFile/GetSiteReport";
  static String GETSUPPLIER_REPORTS = BASE_URL_CORE + "api/SupplierMas/GetAllSupplierMas";
  // static const String GETSUBCONTACTOR_REPORTS = BASE_URL + "api/CommonFile/GetSubContractor";
  static  String GETSUBCONTACTOR_REPORTS = BASE_URL + "api/CommonFile/GetSubCont_ProjwiseReport";
  // static const String GET_SITE_LOCATION = BASE_URL + "api/CommonFile/GetSite_PinAllocation";
  // static String GET_SITE_LOCATION = BASE_URL + "api/commonfile/GetSite_PinAllocationStatus";
  static String GET_SITE_LOCATION = BASE_URL + "api/PunchInandOut/GetProjectForPinLoc";
  static String GET_INWARD_IMAGE_LIST = BASE_URL_CORE + "api/MaterialInward/GetInwardImageList";
  static String GET_DLR_IMAGE_LIST = BASE_URL_CORE + "api/SubContLabourAttendance/GetDLRImageList";
  static String GET_VOC_IMAGE_LIST = BASE_URL + "api/Image/GetSiteVoucherImageList";
  static String GET_ATTEN_IMAGE_LIST = BASE_URL + "api/Image/GetSubContAttImageList";
  static String GET_DPR_IMAGE_LIST = BASE_URL + "api/image/GetDprImageList";
  static String GET_REQLEAVETYPE_LIST = BASE_URL + "api/Report/GetStaffAttdReportMas";
  static String GETSTAFFLEAVECAL = BASE_URL + "api/CommonFile/GetStaffLeaveDetails";




  /// ----- Put API's -----

  static String PUTCHANGEPASSWORDAPI = BASE_URL_CORE + "api/Admin/UpdatePassword";
  static String PUT_UPPDATE_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceUpdate";
  // static String PUT_UPPDATE_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/PUTShiftBasisAttendanceUpdate";
  static String PUT_APROVAL_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceApprove";
  // static String PUT_APROVAL_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/PUTShiftBasisAttendanceApprove";
  static String PUT_NMR_UPDATE_API = BASE_URL + "api/SubcontNMR/PUTNMRBillUpdate";
  static String PUT_DPR_UPDATE_API = BASE_URL + "api/SubContDPR/PUTDprUpdate";
  static String PUT_DPR_NEW_UPDATE_API = BASE_URL + "api/SubContDPRNew/PUTDprUpdate";
  static String PUT_DPR_APROVE_API = BASE_URL + "api/SubContDPR/PUTDprApprove";
  static String PUT_DPR_NEW_APROVE_API = BASE_URL + "api/SubContDPRNew/PUTDprApprove";
  static String PUT_DPR_LABOUR_APROVE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprApprove";
  static String PUT_DPR_LABOUR_UPDATE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprUpdate";
  static String PUT_DIRECTBILL_UPDATE_API = BASE_URL + "api/SubContDirectBill/PUTDirectBillUpdate";
  static String PUT_SUBCONTNMRBILL_APPROVAL_API = BASE_URL + "api/SubcontNMR/PUTNMRApprove";
  static String PUT_BILLGEN_APPROVAL_API = BASE_URL + "api/SubContDirectBill/PUTDirectBillApprove";
  static String PUT_POAPPROVAL_API = BASE_URL_CORE + "api/MaterialPurOrdMas/ApproveSelectedRowById";
  static String PUT_POVERIFY_API = BASE_URL_CORE + "api/MaterialPurOrdMas/VerifySelectedRowsbyId";

  // static const String PUT_ADVANCEREQ_APPROVAL_API = BASE_URL + "api/AdvRequisitionVoucher/PUTAdvVoucherApprove";
  static String PUT_INWARDPENDING_UPDATE_API = BASE_URL_CORE + "api/MaterialInward/UpdateMaterialInward";
  static String PUT_TRANSFERBET_UPDATE_API = BASE_URL + "api/MaterialTransferProject/PUTTransferUpdate";
  static String PUT_MATTRANSREQ_UPDATE_API = BASE_URL + "api/MaterialTransferRequest/PUTMaterialReqTransferUpdate";
  static String PUT_TRANSFERBET_SITE_UPDATE_API = BASE_URL_CORE + "api/MaterialSitetosite/UpdateMaterialSitetoSiteMas";
  static String PUT_ADVREQ_UPDATE_API = BASE_URL + "api/AdvRequisitionVoucher/PUTVoucherProjectUpdate";
  static String PUT_SITEVOUCHER_UPDATE_API = BASE_URL + "api/VoucherProject/PUTVoucherProjectUpdate";
  static String PUT_STAFFVOUCHER_UPDATE_API = BASE_URL + "api/VoucherStaff/PUTVoucherStaffUpdate";
  static String PUT_MATERIALREQUEST_UPDATE_API = BASE_URL_CORE + "api/MaterialReqOrdMas/UpdateReqOrdMas";
  static String PUT_MATERIALREQUEST_APPROVAL_API = BASE_URL + "api/MaterialRequest/PUTRequestApproval";
  static String PUT_COMPANYNMR_UPDATE_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceUpdate";
  static String PUT_COMPANYNMR_APPROVAL_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceApprove";
  static String PUT_Conum_UPDATE_API = BASE_URL_CORE + "api/MaterialExpenseMas/UpdateMaterialExpenses";
  static String PUT_BOQREVISED_UPDATE_API = BASE_URL + "api/BOQRevised/PUTBOQRevisedUpdate";
  static String PUT_REQUISITIONSLIP_UPDATE_API = BASE_URL + "api/HR/PUTRequisitionUpdate";
  static String PUT_TRANSFERACKNOW_UPDATE_API = BASE_URL + "api/MaterialTransferAck/PUTTransferAckUpdate";
  static String PUT_ACCOUNTNAME_UPDATE_API = BASE_URL + "api/CommonFile/PUTAccountNameUpdate";
  static String PUT_PREAPPROVAL_UPDATE_API = BASE_URL + "api/PreApproval/PUTPreApprovalUpdate";
  static String PUT_PREAPPROVAL_APPROVE_API = BASE_URL + "api/PreApproval/PUTPreApprovalApprove";
  static String PUT_MRNFINALAPPROVAL_APPROVE_API = BASE_URL_CORE + "api/MaterialPreApprovalRequest/UpdateFinalApprovalMas";
  // static String PUNCH_OUT = BASE_URL + "api/StaffPunching/PUTStaffPunchOutUpdate";
  static String PUNCH_OUT = BASE_URL + "api/StaffPunching/PutPunchOutUploadStaffImageSave";
  static String PROJECT_NAME_TRANSFER = BASE_URL_CORE + "api/GenericMaster/ToProDiff";
  static String PUT_MATERIALREQUEST_PREINDENT_UPDATE_API = BASE_URL_CORE + "api/SiteRequest/UpdatePreIndent";
  static String PUT_PENDING_QUOTE_API = BASE_URL_CORE + "api/MaterialQuote/SubmitQuote";
  static String PUT_QUOTE_REVERT_API = BASE_URL_CORE + "api/MaterialQuote/RevertQuote";
  static String PUT_QUOTE_VERIFY_APPROVAL_API = BASE_URL_CORE + "api/MaterialQuote/ApproveOrVerify";


  /// ----- POST API's -----

  static String POST_PREAPPROVAL_SAVE_API = BASE_URL + "api/PreApproval/POSTPreApprovalSave";
  static String SUBCONTLABATTAENDANCE_SAVE_API = BASE_URL + "api/SubContLabourAttendance/AddOrUpdateSubContLabAtt";
  // static String SUBCONTLABATTAENDANCE_SAVE_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/POSTShiftBasisAttendanceSave";
  static String SUBCONTLABATTAENDANCE_SAVE_SITE_API = BASE_URL + "api/SubContLabAttendance/POSTAttendanceSavesite";
  static String NMR_SAVE_DEDUCTION = BASE_URL + "api/SubcontNMR/POSTNMRBillSave";
  static String DPR_SAVE_API = BASE_URL + "api/SubContDPR/POSTDprSave";
  static String DPR_NEW_SAVE_API = BASE_URL + "api/SubContDPRNew/POSTDprSave";
  static String DPR_LABOUR_SAVE_API = BASE_URL + "api/SubContDPRNewLabour/POSTDprSave";
  static String DIRECTBILL_SAVE_API = BASE_URL + "api/SubContDirectBill/POSTDirectBillSave";
  static String INWARDPENDING_SAVE_API = BASE_URL_CORE + "api/MaterialInward/AddMaterialInward";
  static String TRANSFERBET_SAVE_API = BASE_URL_CORE + "api/MaterialTransfer/AddOrUpdateMaterialTransfer";
  static String MatTransReq_SAVE_API = BASE_URL_CORE + "api/MaterialTransferRequest/AddOrUpdateTransferReq";
  static String MATTRANSREQ_VERIFY_API = BASE_URL_CORE + "api/MaterialTransferRequestVerify/ToVerify";
  static String MATTRANSREQ_APPROVE_API = BASE_URL_CORE + "api/MaterialTransferRequestApproval/ToApproval";
  static String TRANSFERBET_SITE_SAVE_API = BASE_URL_CORE + "api/MaterialSitetosite/AddMaterialSitetoSite";
  static String TOKEN_SAVE = BASE_URL_CORE + "api/Login/AddUserTokenMas";
  static String ADVREQ_SAVE = BASE_URL + "api/AdvRequisitionVoucher/POSTVoucherProjectSave";
  static String TRANSFER_ACKNOW_ENTRYSAVE = BASE_URL_CORE + "api/MaterialAckMas/AddOrUpdateAck";
  static String SITEVOUCHER_SAVE = BASE_URL + "api/VoucherProject/POSTVoucherProjectSave";
  static String STAFFVOUCHER_SAVE = BASE_URL + "api/VoucherStaff/POSTVoucherStaffSave";
  static String MATERIALREQUEST_SAVE = BASE_URL_CORE + "api/MaterialReqOrdMas/AddReqOrdMas";
  static String COMPANY_NMR_SAVE_API = BASE_URL + "api/CompanyLabAttendance/POSTAttendanceSave";
  static String CONSUM_SAVE = BASE_URL_CORE + "api/MaterialExpenseMas/AddMaterialExpenses";
  static String BOQREVISED_SAVE = BASE_URL + "api/BOQRevised/POSTBOQRevisedSave";
  static String REQUISITION_SAVE = BASE_URL + "api/HR/POSTRequisitionSave";
  static String ACCOUNTNAME_SAVE = BASE_URL + "api/CommonFile/POSTAccountNameSave";
  static String POSTMATERIALSAVEAPI = BASE_URL + "api/CommonFile/POSTMaterial";
  static String PUT_MRNPREAPPROVAL_APPROVE_API = BASE_URL_CORE + "api/MaterialPreApprovalRequest/UpdatePreApprovalMas";
  static String POAMENDMENT_APPROVAL_SAVEAPI = BASE_URL_CORE + "api/MaterialInward/SaveSelectItemAndPoAmd";
  static String PUNCH_IN = BASE_URL_CORE + "api/PunchInandOut/AddOrUpdatePunchAndOut";
  // static String SET_SITE_LOCATION = BASE_URL + "api/CommonFile/PostSetSiteLocationSave";
  static String SET_SITE_LOCATION = BASE_URL_CORE + "api/PunchInandOut/AddPinLocation";
  // static const String INWARDIMAGE_SAVEAPI = BASE_URL + "api/Image/PostInwardImageSave";
  static String SITEVOCIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSiteVoucherImageSave";
  static String SUBIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSubcontractorAttImageSave";
  static String DeviceModelAPI = BASE_URL + "api/CommonFile/POSTDeviceCheck";
  static String MATERIALREQUEST_PREINDENT_SAVE = BASE_URL_CORE + "api/SiteRequest/AddPreIndentDetails";


  /// ----- Delete API's -----
  static String MRL_VERIFY_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
  static String MRL_PREAPPROVE_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
  static String PO_APPROVE_DELETE = BASE_URL_CORE + "api/MaterialPurOrdMas/DeletePOVerification";
  static String MRL_FINAL_APPROVIAL_DELETE = BASE_URL + "api/CommonFile/Deletelistdata";
  static String TRANSFER_VERIFICATION_DELETE= BASE_URL_CORE + "api/MaterialTransferRequestVerify/DeleteVerify";
  static String TRANSFERREQ_PENDAPPROVAL_DELETE = BASE_URL_CORE + "api/MaterialTransferRequestApproval/DeleteMTRApproval";
  static String DELETE_SUBCONT_ENTRYLIST_API = BASE_URL_CORE + "api/SubContLabourAttendance/DeleteSubContLabAtt";
  // static String DELETE_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendanceShiftBasis/DeleteShiftBasisAttendance";
  static String DELETE_PREAPPROVAL_ENTRYLIST_API = BASE_URL + "api/PreApproval/DeletePreApproval";
  static String DELETE_NMR_ENTRYLIST_API = BASE_URL + "api/SubcontNMR/DeleteNMRBill";
  static String DELETE_DPR_ENTRYLIST_API = BASE_URL + "api/SubContDPR/DeleteDPR";
  static String DELETE_DPRLABOUR_ENTRYLIST_API = BASE_URL + "api/SubContDPRNewLabour/DeleteDPR";
  static String DELETE_DIRECTBILL_API = BASE_URL + "api/SubContDirectBill/DeleteDirectBill";
  static String DELETE_INWARDPENDINGLIST_API = BASE_URL_CORE + "api/MaterialInward/DeleteMaterialInward";
  static String DELETE_TRANSFERBET_API = BASE_URL_CORE + "api/MaterialTransfer/DeleteMaterialTransfer";
  static String DELETE_TRANSFERBET_SITE_API = BASE_URL_CORE + "api/MaterialSitetosite/DeleteMaterialTransfer";
  static String DELETE_ADVREQVOUCHER_API = BASE_URL + "api/AdvRequisitionVoucher/DeleteVoucherProject";
  static String USERTOKENDELETE_API = BASE_URL_CORE + "api/Login/logout";
  static String DELETE_SITEVOUCHER_ENTRYLIST_API = BASE_URL_CORE + "api/SiteVoucher/DeleteAccountSiteVoucher";
  static String DELETE_STAFFVOUCHERSITE_ENTRYLIST_API = BASE_URL + "api/VoucherStaff/DeleteVoucherStaff";
  static String DELETE_MATERIAL_ENTRYLIST_API = BASE_URL_CORE + "api/MaterialReqOrdMas/Delete";
  static String DELETE_MATTRANSREQLIST_API = BASE_URL_CORE + "api/MaterialTransferRequest/DeleteTransferReq";
  static String DELETE_CONSUM_ENTRYLIST_API = BASE_URL_CORE + "api/MaterialExpenseMas/DeleteMaterialExpenses";
  static String DELETE_BOQREVISED_ENTRYLIST_API = BASE_URL + "api/BOQRevised/DeleteBOQ";
  static String DELETE_REQUISITION_ENTRYLIST_API = BASE_URL + "api/HR/DeleteRequisition";
  static String DELETE_TRANSACKENTRYLIST_API = BASE_URL + "api/MaterialTransferAck/DeleteTransferAck";
  static String DELETE_ACCOUNTNAME_API = BASE_URL + "api/CommonFile/DeleteAccountName";
  static String DELETE_COMPANYNMRLIST_API = BASE_URL + "api/CompanyLabAttendance/DeleteAttendance";
  static String DELETE_INWARD_IMAGE_API = BASE_URL_CORE + "api/MaterialInward/DeleteInwardImg";
  static String DELETE_DLR_IMAGE_API = BASE_URL_CORE + "api/SubContLabourAttendance/DeleteDLRImg";
  static String SITE_VOC_IMAGE_DELETE = BASE_URL + "api/Image/DeleteSiteVoucherImage";
  static String LABR_ATTEN_IMAGE_DELETE = BASE_URL + "api/Image/DeleteSubcontAttImage";
  static String DPR_IMAGE_DELETE = BASE_URL + "api/Image/DeleteDprImage";
  static String DELETE_MATERIALREQPREINDENT_ENTRYLIST_API = BASE_URL_CORE + "api/SiteRequest/DeletePreIndent";

}
