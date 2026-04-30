import '../../../../commonpopup/entry_type_alert.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprlabour_controller.dart';

import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyWork_done_DPRLabour_EntryScreen extends StatefulWidget {
  const DailyWork_done_DPRLabour_EntryScreen({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPRLabour_EntryScreen> createState() => _DailyWork_done_DPRLabour_EntryScreenState();
}

class _DailyWork_done_DPRLabour_EntryScreenState extends State<DailyWork_done_DPRLabour_EntryScreen> {
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());


  @override
  void initState() {
    dailyWrkDone_DPRLabour_Controller.dprlabor_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
    dailyWrkDone_DPRLabour_Controller.dprlabor_autoYearWiseNoController.text=autoYearWiseNoController.DPR_Labour_autoYrsWise.value;

    if(dailyWrkDone_DPRLabour_Controller.editCheck==1){
      dailyWrkDone_DPRLabour_Controller.dpr_EditListApiValue.value.forEach((element) {
        dailyWrkDone_DPRLabour_Controller.workid=element.workId!;
        dailyWrkDone_DPRLabour_Controller.dprlabor_autoYearWiseNoController.text=element.workNo;
        dailyWrkDone_DPRLabour_Controller.dprlabor_dateController.text=element.workDate;
        projectController.projectname.text=element.projectName;
        projectController.selectedProjectId.value=element.projectId;
        siteController.Sitename.text= element.siteName;
        siteController.selectedsiteId.value=element.siteId;
        dailyWrkDone_DPRLabour_Controller.dprlabor_referenceController.text=element.refNo;
        dailyWrkDone_DPR_Controller.entryTypeController.text=element.entryTypeName;
        dailyWrkDone_DPR_Controller.entryType=element.entryType;
        dailyWrkDone_DPRLabour_Controller.dprlabor_remarksController.text=element.remarks;
      });
    }
    if(dailyWrkDone_DPRLabour_Controller.screencheck==0){
      dailyWrkDone_DPRLabour_Controller.workid=0;
      dailyWrkDone_DPRLabour_Controller.dprLabour_DetTable_Delete();
      dailyWrkDone_DPRLabour_Controller.dprlabour_EntryDetlist.clear();
      dailyWrkDone_DPRLabour_Controller.dprLabour_Labourtable_Delete();
      dailyWrkDone_DPRLabour_Controller.dprLabourlist.value.clear();
      projectController.projectname.text=RequestConstant.SELECT;
      dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
      siteController.Sitename.text=RequestConstant.SELECT;
      dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";
      dailyWrkDone_DPRLabour_Controller.dprlabor_referenceController.text="";
      dailyWrkDone_DPRLabour_Controller.dprlabor_remarksController.text="";
      dailyWrkDone_DPRLabour_Controller.dprlabor_preparedbyController.text=loginController.UserName();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        child: TextField(
                          style: TextStyle(color: Theme.of(context).primaryColor,fontSize:12,fontWeight: FontWeight.bold
                          ),
                          controller: dailyWrkDone_DPRLabour_Controller.dprlabor_autoYearWiseNoController,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .primaryColor, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .primaryColor, width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        margin: EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(),
                        child: TextField(
                          style: TextStyle(fontSize: 12),
                          readOnly: true,
                          controller: dailyWrkDone_DPRLabour_Controller.dprlabor_dateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .primaryColor, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme
                                  .of(context)
                                  .primaryColor, width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.date_range_sharp,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            dailyWrkDone_DPRLabour_Controller.dprlabor_dateController.text =
                                BaseUtitiles.selectDateFormat(Entrydate!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: BaseUtitiles.getheightofPercentage(context, 5),
                width: BaseUtitiles.getWidthtofPercentage(context, 90),
                child: TextField(
                  style: TextStyle(
                      fontSize: RequestConstant.Dropdown_Font_SIZE),
                  readOnly: true,
                  controller: projectController.projectname,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    labelText: RequestConstant.PROJECT_NAME,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme
                          .of(context)
                          .primaryColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme
                          .of(context)
                          .primaryColor, width: 1.0),
                    ),
                  ),
                  onTap: () {
                    projectController.getProjectList();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: BaseUtitiles.getheightofPercentage(context, 5),
                width: BaseUtitiles.getWidthtofPercentage(context, 90),
                child: TextField(
                  style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                  readOnly: true,
                  controller: siteController.Sitename,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    labelText:RequestConstant.SITE_NAME,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                  ),
                  onTap: () {
                    siteController.subcontEntry_siteDropdowntList(context,0);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: BaseUtitiles.getheightofPercentage(context, 5),
                width: BaseUtitiles.getWidthtofPercentage(context, 90),
                child: TextField(
                  controller: dailyWrkDone_DPR_Controller.entryTypeController,
                  style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                  readOnly: true,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    labelText:RequestConstant.TYPE,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return  EntryTypeAlert();
                        });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,top: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        child: Text("Ref no"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        margin: EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: dailyWrkDone_DPRLabour_Controller.dprlabor_referenceController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            ),
                          ),
                          onChanged: (value){
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,top: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        child: Text("Prepared By"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        margin: EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(),
                        child: TextField(
                          style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                          readOnly: true,
                          controller: dailyWrkDone_DPRLabour_Controller.dprlabor_preparedbyController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            ),
                          ),
                          onChanged: (value){
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,top: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        child: Text("Remarks"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        margin: EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: dailyWrkDone_DPRLabour_Controller.dprlabor_remarksController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            ),
                          ),
                          onChanged: (value){
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: BaseUtitiles.getheightofPercentage(context,5),

                margin: EdgeInsets.only(top: 5,bottom: 5),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      //background color of button
                      side: BorderSide(width: 3, color: Colors.brown),
                      //border width and color
                      elevation: 3,
                      //elevation of button
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),),
                    child: Text("ADD BOQ DETAILS"),
                    onPressed: () {
                      if(dailyWrkDone_DPR_Controller.entryTypeController.text=="TYPE" ||projectController.projectname.text==RequestConstant.SELECT||siteController.Sitename.text==RequestConstant.SELECT){

                      }
                      else{
                        dailyWrkDone_DPRLabour_Controller.getAddBoqDetails(context);
                      }
                    }
                ),
              ),
              Obx(()=> Visibility(
                visible:  dailyWrkDone_DPRLabour_Controller.dprlabour_EntryDetlist.value.isEmpty?false:true,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 3,right: 3),
                        height: BaseUtitiles.getheightofPercentage(context, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: Text("BOQ DETAILS",style: TextStyle(fontSize: 10),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,top: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        child: Text("Item Description"),
                      ),
                      Container(
                        height: BaseUtitiles.getheightofPercentage(context,7),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(),
                        child: TextField(
                          style: TextStyle(fontSize:11,fontWeight: FontWeight.bold),
                          readOnly:true,
                          controller: dailyWrkDone_DPRLabour_Controller.dpr_lab_descripionController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            ),
                          ),
                          onChanged: (value){
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                child: Text("Rate",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                child: Text("Units",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                child: Text("Bal-BOQ qty",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                child: Text("Current Qty",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2,bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  readOnly:true,
                                  keyboardType: TextInputType.number,
                                  controller: dailyWrkDone_DPRLabour_Controller.dpr_lab_rateController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value){

                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  readOnly:true,
                                  keyboardType: TextInputType.number,
                                  controller:dailyWrkDone_DPRLabour_Controller.dpr_lab_unitsController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value){
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  readOnly:true,
                                  keyboardType: TextInputType.number,
                                  controller:dailyWrkDone_DPRLabour_Controller.dpr_lab_boqQtyController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value){
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:dailyWrkDone_DPRLabour_Controller.dpr_lab_currQtyController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value){
                                    dailyWrkDone_DPRLabour_Controller.currQtyclickEdit(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
