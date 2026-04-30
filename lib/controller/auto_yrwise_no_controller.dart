import '../provider/common_provider.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';

class AutoYearWiseNoController extends GetxController {
  RxString SubcontAttendance_autoYrsWise = "".obs;
  RxString preapproval_autoYrsWise = "".obs;
  RxString NMR_autoYrsWise = "".obs;
  RxString DPRNEW_autoYrsWise = "".obs;
  RxString DPR_Labour_autoYrsWise = "".obs;
  RxString DPR_autoYrsWise = "".obs;
  RxString DirectBillautoYrsWise = "".obs;
  RxString InwardPendingautoYrsWise = "".obs;
  RxString TransferBetProjectautoYrsWise = "".obs;
  RxString TransferAckNoautoYrsWise = "".obs;
  RxString matTransReqautoYrsWise = "".obs;
  RxString TransferBetSiteautoYrsWise = "".obs;
  RxString AdvReqautoYrsWise = "".obs;
  RxString SiteVoucher_autoYrsWise = "".obs;
  RxString StaffVoucher_autoYrsWise = "".obs;
  RxString MRNIndent_autoYrsWise = "".obs;
  RxString companyNMR_autoYrsWise = "".obs;
  RxString Conum_autoYrsWise = "".obs;
  RxString BOQRevised_autoYrsWise = "".obs;
  RxString RequisitionSlip_autoYrsWise = "".obs;
  RxString MRNIndentPreIndent_autoYrsWise = "".obs;


  Future AutoYearWiseNo(Url) async {
    final value =await CommonProvider.getAutoYearWise(Url);
      if (value != null) {
        if(value["success"]==true) {
        if (Url == "MRN INDENT") {
          MRNIndent_autoYrsWise.value = value["entryAutoNo"];
          return MRNIndent_autoYrsWise.value;
        }
        else if (Url == "MRN PRE INDENT") {
          MRNIndentPreIndent_autoYrsWise.value = value["entryAutoNo"];
          return MRNIndentPreIndent_autoYrsWise.value;
        }
        else if (Url == "CONSUMPTION") {
            Conum_autoYrsWise.value = value["entryAutoNo"];
            return Conum_autoYrsWise.value;
        }
        else if (Url == "TRANSFER BETWEEN SITES") {
            TransferBetSiteautoYrsWise.value = value["entryAutoNo"];
            return TransferBetSiteautoYrsWise.value;
        }
        else if (Url == "TRANSFER BETWEEN PROJECTS") {
            TransferBetProjectautoYrsWise.value = value["entryAutoNo"];
            return TransferBetProjectautoYrsWise.value;
        }
        else if (Url == "INWARD") {
            InwardPendingautoYrsWise.value = value["entryAutoNo"];
            return InwardPendingautoYrsWise.value;
        }
        else if (Url == "MATERIAL TRANSFER REQUEST") {
            matTransReqautoYrsWise.value = value["entryAutoNo"];
            return matTransReqautoYrsWise.value;
        }
        else if (Url == "BOQ REVISED") {
            BOQRevised_autoYrsWise.value = value["entryAutoNo"];
            return BOQRevised_autoYrsWise.value;
        }
        else if (Url == "SUBCONTRACTOR ATTENDANCE") {
            SubcontAttendance_autoYrsWise.value = value["entryAutoNo"];
            return SubcontAttendance_autoYrsWise.value;
        }
        else if (Url == "DPR") {
            DPR_autoYrsWise.value = value["entryAutoNo"];
            return DPR_autoYrsWise.value;
        }
        else if (Url == "DPR NEW") {
            DPRNEW_autoYrsWise.value = value["entryAutoNo"];
            return DPRNEW_autoYrsWise.value;
        }
        else if (Url == "DPR LABOUR") {
            DPR_Labour_autoYrsWise.value = value["entryAutoNo"];
            return DPR_Labour_autoYrsWise.value;
        }
        else if (Url == "DIRECT BILL") {
            DirectBillautoYrsWise.value = value["entryAutoNo"];
            return DirectBillautoYrsWise.value;
        }
        else if (Url == "NMR WEEKLY BILL") {
            NMR_autoYrsWise.value = value["entryAutoNo"];
            return NMR_autoYrsWise.value;
        }
        else if (Url == "ADVANCE REQ VOUCHER") {
            AdvReqautoYrsWise.value = value["entryAutoNo"];
            return AdvReqautoYrsWise.value;
        }
        else if (Url == "SITE VOUCHER") {
            SiteVoucher_autoYrsWise.value = value["entryAutoNo"];
            return SiteVoucher_autoYrsWise.value;
        }
        else if (Url == "STAFF VOUCHER") {
            StaffVoucher_autoYrsWise.value = value["entryAutoNo"];
            return StaffVoucher_autoYrsWise.value;
        }
        else if (Url == "TRANSFER ACK PENDING") {
            TransferAckNoautoYrsWise.value = value["entryAutoNo"];
            return TransferAckNoautoYrsWise.value;
        }
        else if (Url == "COMPANY NMR") {
            companyNMR_autoYrsWise.value = value["entryAutoNo"];
            return companyNMR_autoYrsWise.value;
        }
        else if (Url == "REQ SLIP") {
            RequisitionSlip_autoYrsWise.value = value["entryAutoNo"];
            return RequisitionSlip_autoYrsWise.value;
        }
      }
        else {
          BaseUtitiles.showToast(value?.message ?? 'Something went wrong..');
        }
      }
      else{
        BaseUtitiles.showToast('Something went wrong..');
      }
  }
}
