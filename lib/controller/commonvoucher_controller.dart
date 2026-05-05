
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commonpopup/accountname_alert.dart';
import '../commonpopup/accounttype_alert.dart';
import '../commonpopup/payfor_alert.dart';
import '../commonpopup/paymode_alert.dart';

import '../models/accountname_model.dart';
import '../models/addaccountnamerequest_model.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'bottomsheet_Controllers.dart';

class CommonVoucherController extends GetxController{


  final VoucherTypeController =new TextEditingController();
  final voucherPaidForm=new TextEditingController();
  final detVoucherTypeController =new TextEditingController();
  final AccountTypename=new TextEditingController();
  final AddAccountname=new TextEditingController();
  final payforController=new TextEditingController();
  RxList getdropDownvalue=[].obs;
  RxList acountmainlist=[].obs;
  RxList AccounttypeDropdownName=[].obs;
  RxInt selectedAccTypeId = 0.obs;
  RxString selectedAccName = "".obs;
  RxString VocType = "P".obs;
  String detVocType = "A";
  RxString payfor = "AD".obs;

  int vocPaidformId = 0;
  int active=0;
  RxString SaveButton=RequestConstant.SAVE.obs;

  bool check=false;

  final Accountname=new TextEditingController();
  final namethrough=new TextEditingController();
  RxList getaccdropDownvalue=[].obs;
  RxList mainlist=[].obs;
  RxInt selectedAccnameId = 0.obs;
  RxString selectedAccountName = "".obs;

  final AccPayforname=new TextEditingController();

  RxList getPayfordropDownvalue=[].obs;
  RxList payforNamelist=[].obs;
  RxList AccPayforDropdownName=[].obs;
  RxString selectedAccPayId = "AD".obs;
  RxString selectedAccpayName = "".obs;

  final Paymodename=new TextEditingController();
  RxList getpaymodedropDownvalue=[].obs;
  RxList paymodeList=[].obs;
  RxList paymentTypeList=[].obs;
  RxList PaymodeDropdownName=[].obs;
  RxInt selectedPaymodeId = 0.obs;
  RxString selectedPaymodeName = "".obs;

  Future getAccountTypeList() async {
    getdropDownvalue.value.clear();
    final value = await CommonProvider.getAccountType();
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getdropDownvalue.value = value.result!;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  setSelectedAccountTypeID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if(value == element.accType){
          selectedAccTypeId(element.accTypeid);
        }
      });
    }
    setSelectedAccountTypeListName(selectedAccTypeId.value);
  }


  setSelectedAccountTypeListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.accTypeid) {
          selectedAccName(element.accType.toString());
        }
      });
    }
    AccountTypename.text=selectedAccName.value;
  }
  //---Account Name--

  Future getAccountName() async {
    getaccdropDownvalue.value.clear();
    final value = await CommonProvider.getAccountnameDropdown(selectedAccTypeId.value);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getaccdropDownvalue.value = value.result!;
          getaccdropDownvalue.value.insert(
            0,
            Result(accNameid: 0, accName: "--SELECT--"),
          );
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  checkDuplicateAccountName(String value,BuildContext context){
    check=false;
    getaccdropDownvalue.value.forEach((element) {
      if(value.toUpperCase()==element.accName){
        check=true;
        return;
      }
    });
    if(check==true){
      BaseUtitiles.showToast("already exist");
    }
    else{
      SaveButton_AccountnameScreen(context,selectedAccnameId.value=SaveButton.value == RequestConstant.UPDATE?selectedAccnameId.value:0,selectedAccTypeId.value);
    }
  }


  setSelectedAccountnameID(String value) {
    if (getaccdropDownvalue.value.length>0) {
      getaccdropDownvalue.forEach((element) {
        if(value == element.accName){
          selectedAccnameId(element.accNameid);
        }
      });
    }
    setSelectedaccountName(selectedAccnameId.value);
  }

  setSelectedaccountName(int? id) {
    if (getaccdropDownvalue.value != null) {
      getaccdropDownvalue.value.forEach((element) {
        if (id == element.accNameid) {
          selectedAccountName(element.accName.toString());
        }
      });
    }
    Accountname.text=selectedAccountName.value;
    namethrough.text=Accountname.text;
  }

  //---Payfor alert

  Future getPayforList() async {
    getPayfordropDownvalue.value.clear();
    final value = await CommonProvider.getPayforType();
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getPayfordropDownvalue.value = value.result!;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  setSelectedacPayForID(String value) {
    if (getPayfordropDownvalue.value.length>0) {
      getPayfordropDownvalue.forEach((element) {
        if(value == element.acPayForName){
          selectedAccPayId(element.acPayForId.toString());
        }
      });
    }
    setSelectedAccPayForListName(selectedAccPayId.value);
  }


  setSelectedAccPayForListName(String id) {
    if (getPayfordropDownvalue.value != null) {
      getPayfordropDownvalue.value.forEach((element) {
        if (id == element.acPayForId.toString()) {
          selectedAccpayName(element.acPayForName.toString());
        }
      });
    }
    AccPayforname.text=selectedAccpayName.value;
  }


  Future getPaymodeList() async {
    getpaymodedropDownvalue.value.clear();
    final value = await CommonProvider.getPaymodetype();
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getpaymodedropDownvalue.value = value.result!;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future getPaymentTypeList() async {
    paymentTypeList.value.clear();
    final value = await CommonProvider.getPaymentTypeListAPI();
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          paymentTypeList.value = value.result!;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  setSelectedPaymodeID(String value) {
    if (getpaymodedropDownvalue.value.length>0) {
      getpaymodedropDownvalue.forEach((element) {
        if(value == element.paymode){
          selectedPaymodeId(element.paymodeid);
        }
      });
    }
    setSelectedPaymodeListName(selectedPaymodeId.value);
  }


  setSelectedPaymodeListName(int? id) {
    if (getpaymodedropDownvalue.value != null) {
      getpaymodedropDownvalue.value.forEach((element) {
        if (id == element.paymodeid) {
          selectedPaymodeName(element.paymode.toString());
        }
      });
    }
    Paymodename.text=selectedPaymodeName.value;
  }

  Future SaveButton_AccountnameScreen(BuildContext context, int accNameId,accTypeId) async {
    String body = accountnamesaveRequestToJson(AccountnamesaveRequest(
      id: accNameId,
      accountTypeId: accTypeId!=0?accTypeId:0,
      accountHeadId: 0,
      accountMainGroupId: 0,
      accountName: AddAccountname.text,
      active: "Y",
    ));
    final list = await CommonProvider.SaveAccountnameScreenEntryAPI(body, accNameId, SaveButton.value);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        BaseUtitiles.popMultiple(context, count: 1);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 1);
      }
    }else{
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 1);
    }
  }

  // ----------Delete call API --------------

  Future<bool> Accountname_DeleteApi(int AccNameId) async {
    return CommonProvider.Accountname_deleteAPI(AccNameId);
  }

  Future DeleteAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await Accountname_DeleteApi(selectedAccnameId.value);
                          await getAccountName();
                          selectedAccnameId.value = 0;
                          Accountname.text = "--SELECT--";
                          namethrough.text = "--SELECT--";
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
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