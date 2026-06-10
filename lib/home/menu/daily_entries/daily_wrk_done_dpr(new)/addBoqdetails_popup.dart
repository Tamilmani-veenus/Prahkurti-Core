
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class AddBoqPopup extends StatefulWidget {
   AddBoqPopup({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<AddBoqPopup> createState() => _AddBoqPopupState();
}

class _AddBoqPopupState extends State<AddBoqPopup> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());

  @override
  void initState() {
    dailyWrkDone_DPRNEW_Controller.dprNew_mainList.value = dailyWrkDone_DPRNEW_Controller.dprNew_BoqDetailsList.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BOQ List",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  controller: editingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 15),
                      child: ConstIcons.list_Search,
                    ),
                    hintText: "Search..",
                    hintStyle: TextStyle(color: Colors.black),
                    isDense: true,
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {
                      dailyWrkDone_DPRNEW_Controller.dprNew_mainList.value=BaseUtitiles.itemDescPopupAlert(value,dailyWrkDone_DPRNEW_Controller.dprNew_BoqDetailsList.value);
                    });
                  },
                ),
              ),

              Container(
                height: BaseUtitiles.getheightofPercentage(context, 80),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: dailyWrkDone_DPRNEW_Controller.dprNew_mainList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          dailyWrkDone_DPRNEW_Controller.level3ItemIdValue.value = dailyWrkDone_DPRNEW_Controller.dprNew_mainList.value[index].measureLevel3ItemId;
                          await dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                          await dailyWrkDone_DPRNEW_Controller.dprNew_DetTableSave(dailyWrkDone_DPRNEW_Controller.dprNew_mainList.value[index]);
                          await dailyWrkDone_DPRNEW_Controller.getDetTablesDatas();
                          await dailyWrkDone_DPRNEW_Controller.getLabourList();
                          dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                                    child: Text(dailyWrkDone_DPRNEW_Controller.dprNew_mainList.value[index].itemdesc
                                        .toString(), textAlign: TextAlign.justify,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
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
