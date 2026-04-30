import '../controller/commonvoucher_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountTypeShowPopup extends StatefulWidget {
  const AccountTypeShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<AccountTypeShowPopup> createState() => _AccountTypeShowPopupState();
}

class _AccountTypeShowPopupState extends State<AccountTypeShowPopup> {
  TextEditingController editingController = TextEditingController();

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());


  @override
  void initState() {
    commonVoucherController.acountmainlist.value.clear();
    commonVoucherController.acountmainlist.value=widget.list;
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
          //height: BaseUtitiles.getheightofPercentage(context, 60),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: BaseUtitiles.getheightofPercentage(context, 4),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      commonVoucherController.acountmainlist.value=BaseUtitiles.accTypePopupAlert(value,widget.list);
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      labelText: "Search",
                      labelStyle: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
                      prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: commonVoucherController.acountmainlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          commonVoucherController.setSelectedaccountName(0);
                          commonVoucherController.setSelectedAccountTypeID(commonVoucherController.acountmainlist.value[index].accType!);
                          commonVoucherController.Accountname.text="--SELECT--";

                          Navigator.pop(context);

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(commonVoucherController.acountmainlist.value[index].accType
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
