
import '../controller/commonvoucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class AccountnameAddAlert extends StatefulWidget {
  const AccountnameAddAlert({Key? key}) : super(key: key);

  @override
  State<AccountnameAddAlert> createState() => _AccountnameAddAlertState();
}

class _AccountnameAddAlertState extends State<AccountnameAddAlert> {
  CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());
@override
  void initState() {
    if(commonVoucherController.Accountname.text=="--Select--" || commonVoucherController.Accountname.text=="--SELECT--"){
      commonVoucherController.SaveButton.value=RequestConstant.ADD;
      commonVoucherController.AddAccountname.text="";

    }
    else{
      commonVoucherController.SaveButton.value=RequestConstant.UPDATE;
      commonVoucherController.AddAccountname.text=commonVoucherController.Accountname.text;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 20,top: 5),

                      child: Text("Account Name",textAlign: TextAlign.center,),
                    )
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 50,top: 5),
                          height: BaseUtitiles.getheightofPercentage(context, 3),
                          child: Image.asset('assets/cancle.png'),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(),
                child: TextField(
                  style: TextStyle(fontSize: 13),
                  keyboardType: TextInputType.multiline,
                  controller: commonVoucherController.AddAccountname,
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    border: OutlineInputBorder(),

                  ),
                  onChanged: (value){

                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 5),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                width: BaseUtitiles.getWidthtofPercentage(context, 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    side: BorderSide(width: 3, color: Colors.black),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () async {
                    if (commonVoucherController.AddAccountname.text.trim()!="") {
                      await commonVoucherController.checkDuplicateAccountName(
                          commonVoucherController.AddAccountname.text, context);
                      if (commonVoucherController.SaveButton.value ==
                          RequestConstant.UPDATE) {
                        commonVoucherController.getAccountName();
                        commonVoucherController.selectedAccnameId.value = 0;
                        commonVoucherController.Accountname.text = "--Select--";
                        commonVoucherController.namethrough.text = "--Select--";
                      } else {
                        commonVoucherController.getAccountName();
                      }
                    }
                    else{
                      BaseUtitiles.showToast("Please enter account name");
                    }
                  },
                  child: Text(commonVoucherController.SaveButton.value),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
