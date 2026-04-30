import '../db_helper/db_manager.dart';
import '../db_model/advReqVoc_SitewisePayTable_model.dart';


class AdvReqVoucher_SiteWisePayment_Service {
  late DBManager _dbManager;

  AdvReqVoucher_SiteWisePayment_Service() {
    _dbManager = DBManager();
  }

  AdvreqVoucher_SiteWisePaymentTable_Save(
      List<AdvReqVoucher_SiteWisePayment_TableModel> advReqVoucher_SiteWisePayment_TableModel) async {
    advReqVoucher_SiteWisePayment_TableModel.forEach((element) async {
      return await _dbManager.insertData('advReqVoucherSitewisePayTable', element.AdvReqVoucher_SiteWisePayment_TableMap());
    });
  }

  AdvreqVoucher_SiteWisePaymentTable_readAll() async {
    return _dbManager.readData('advReqVoucherSitewisePayTable');
  }


  AdvreqVoucher_SiteWisePaymentTable_Update(
      List<AdvReqVoucher_SiteWisePayment_TableModel> advReqVoucher_SiteWisePayment_TableModel) async {
    advReqVoucher_SiteWisePayment_TableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise_AdvReqVou('advReqVoucherSitewisePayTable', element.AdvReqVoucher_SiteWisePayment_TableMap());
    });
  }

  AdvreqVoucher_SiteWisePaymentTable_deleteById(
      List<AdvReqVoucher_SiteWisePayment_TableModel> advReqVoucher_SiteWisePayment_TableModel) async {
    advReqVoucher_SiteWisePayment_TableModel.forEach((element) async {
      return await _dbManager.deleteAdvReqVousiteWise(
          'advReqVoucherSitewisePayTable', element.AdvReqVoucher_SiteWisePayment_TableMap());
    });
  }

  AdvreqVoucher_SiteWisePaymentTable_delete() async {
    return await _dbManager.delete('advReqVoucherSitewisePayTable');
  }


}
