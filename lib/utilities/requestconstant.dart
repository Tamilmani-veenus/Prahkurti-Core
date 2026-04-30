import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/logincontroller.dart';
import '../controller/menu_controller.dart';
import 'baseutitiles.dart';

class RequestConstant{

  static Map<String, String> postHeaders() {
    final loginController = Get.find<LoginController>();
    final menuController = Get.isRegistered<Menu_Controller>()
        ? Get.find<Menu_Controller>()
        : Get.put(Menu_Controller());

    return {
      'Content-Type': 'application/json',
      'MenuID': menuController.formMenuId.value.toString(),
      'Authorization': 'Bearer ${loginController.user.value.accessToken ?? ''}',
      'DeviceId': BaseUtitiles.deviceName,
    };
  }

  static Map<String, String> getHeaders() {
    final loginController = Get.find<LoginController>();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginController.user.value.accessToken ?? ''}',
    };
  }

  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  static const Map<String, String> Multiheaders = {
    'Content-Type': 'multipart/form-data'
  };

  /// ------ Screen ------

  static const String ISPLATFORMIOS = 'IOS';
  static const String ISPLATFORMWEB = 'WEB';
  static const String ISPLATFORMANDROID = 'ANROID';

  static const int SETDISGNWEBORMOBILE = 500;

  static const double DropdownHeight = 55;
  static const String CURRENCY_SYMBOL = "₹ ";

  /// ----- fontsize -----

  static const double App_Font_SIZE = 12;
  static const double Lable_Font_SIZE = 15;
  static const double ALERT_Font_SIZE = 14;
  static const double Heading_Font_SIZE = 20;
  static const double Dropdown_Font_SIZE = 13;


  /// ------ SUBCONTRACTOR_ATTENDANCE_SCREEN Strings Name ------
  static const String VALIDATE = 'Required *';
  static const String SAVE = 'Save';
  static const String APPROVAL = 'Approve';
  static const String PREAPPROVAL = 'PreApprove';
  static const String UPDATE = 'Update';
  static const String RESUBMIT = 'Re-Submit';
  static const String SHOW = 'Show';
  static const String SUBMIT = 'Submit';
  static const String PENDINGLIST ='Pending';
  static const String VERIFY = 'Verify';
  static const String LIST = 'List';
  static const String REVISEDDATE = 'Revised Date';
  static const String ADD = 'Add';

  static const String NORECORD_FOUND = 'No Record Found';
  static const String RECORD_SUCCESSFULLY = 'Record Successfully added..';
  static const String SOMETHINGWENT_WRONG = 'Something went wrong.. ';
  static const String DUPLICATE_OCCURED = 'Duplication Occurred... Please Check again...';
  static const String REQUIERD_FIELD = 'required field';
  static const String DO_YOU_WANT_DELETE = 'Do you want to delete?';

  static const String SELECT = '--SELECT--';
  static const String PROJECT_NAME = 'Project Name';
  static const String FROM_SITE_NAME = 'FromSite Name';
  static const String FROM_PROJECT_NAME = 'FromProject Name';
  static const String TO_PROJECT_NAME = 'ToProject Name';
  static const String COMPANY_NAME = 'Company Name';
  static const String SUBCONTRACTOR_NAME = 'Subcontractor Name';
  static const String SITE_NAME = 'Site Name';
  static const String REMARKS = 'Remarks';
  static const String WORKORDERNO = 'Work Order No';

  static const String TOTAL_LABOURS = 'Total Labours';
  static const String TOTAL_AMT = 'Total Amount';
  static const String WRK_DETAILS = 'Work Details';
  static const String CONTNAME = 'Cont Name';
  static const String PREPARED_BY = 'Prepared By';

  static const String TYPE = 'Entry Type';
  static const String DAY = 'Day';
  static const String Morning = 'Morning';
  static const String NIGHT = 'Night';
  static const String NMR = 'NMR';
  static const String BOQ = 'BOQ';
  static const String RATE = 'Rate';
  static const String D = 'D';
  static const String M = 'M';
  static const String N = 'N';
  static const String W = 'W';
  static const String R = 'R';

  static const String FROMDATE = 'FromDate';
  static const String TODATE = 'ToDate';
  static const String SEARCH = 'Search';
  static const String DELETE = 'Delete';
  static const String EDIT = 'Edit';

  static const String YES = 'Yes';
  static const String NO = 'No';
  static const String OK = 'OK';

  static const String NOS = 'Nos :';
  static const String OTHRS = 'OThrs :';
  static const String OTAMT = 'OTAmt :';
  static const String NETAMT = 'NetAmt :';
  static const String REMARKSES = 'Remarks :';


  static const String CATEGORY = 'Category';
  static const String WAGES = 'Wages';
  static const String HEAD_NOS = 'Nos';
  static const String HEAD_OTHRS = 'OT Hrs';

  static const String VOUCHER_TYPE = 'VoucherType';
  static const String ACCOUNT_TYPE = 'AccountType *';
  static const String ACCOUNT_NAME = 'AccountName *';

  static const String UPLOADIMAGEPATH = 'assets/image.jpg';
  static const String NOINTERNETCONNECTION = 'No Internet connection';
  static const String REQUESTTIMEOUT = 'Request timed out';
  static const String BADRESPONSE = 'Bad response format from server';
  static const String NETWORKERROR = 'Network error occured..';

}