
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commonpopup/accountname_alert.dart';
import '../commonpopup/accounttype_alert.dart';
import '../commonpopup/payfor_alert.dart';
import '../commonpopup/paymode_alert.dart';

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
  RxInt selectedAccId = 0.obs;
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
          selectedAccId(element.accTypeid);
        }
      });
    }
    setSelectedAccountTypeListName(selectedAccId.value);
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
    final value = await CommonProvider.getAccountnameDropdown(selectedAccId.value);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getaccdropDownvalue.value = value.result!;
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
      SaveButton_AccountnameScreen(context,selectedAccnameId.value);
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

  //---Paymode--
  Future getPaymodeList(BuildContext context) async {
    getpaymodedropDownvalue.value= await CommonProvider.getPaymodetype();

    getpaymodedropDownvalue.value.forEach((element) {
      return PaymodeDropdownName.value.add(element.paymode);
    });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return PaymodeShowPopup(list:getpaymodedropDownvalue.value);
    //     });
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

  Future SaveButton_AccountnameScreen(BuildContext context, int id) async {

    String body = accountnamesaveRequestToJson(AccountnamesaveRequest(
      accTypeId: selectedAccId.value.toString(),
      accNameId: id != 0 ? id.toString() : "0",
      accName: AddAccountname.text,
    ));
    final list = await CommonProvider.SaveAccountnameScreenEntryAPI(body, id);
    if (list != null && id != 0) {
      BaseUtitiles.showToast(list);
      return Navigator.pop(context);
    } else {
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        Navigator.pop(context);
        Navigator.pop(context);
        return BaseUtitiles.showToast(list);
      } else {

        BaseUtitiles.showToast(list);

        return Navigator.pop(context);
      }
    }
  }

  // ----------Delete call API --------------
  Future Accountname_DeleteApi(int AccTypeId, int AccNameId) async {
    await CommonProvider.Accountname_deleteAPI(AccTypeId,AccNameId)
        .then((value) async {
      if (value != null && value.length > 0) {
        selectedAccnameId.value=0;
        setSelectedaccountName(0);
        BaseUtitiles.showToast("Delete successfully");
        return value;
      }
    });
  }


  Future DeleteAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to delete?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Accountname_DeleteApi(selectedAccId.value, selectedAccnameId.value);
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

}