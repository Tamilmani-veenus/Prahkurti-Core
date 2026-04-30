
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../home/menu/daily_entries/daily_wrk_done_dpr/type_subcont_alert.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyWork_done_DPRLabour_ItemListScreen extends StatefulWidget {
  const DailyWork_done_DPRLabour_ItemListScreen({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPRLabour_ItemListScreen> createState() => _DailyWork_done_DPRLabour_ItemListScreenState();
}

class _DailyWork_done_DPRLabour_ItemListScreenState extends State<DailyWork_done_DPRLabour_ItemListScreen> {


  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());

  @override
  void initState() {
    dailyWrkDone_DPRLabour_Controller.screencheck=1;
    dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
    dailyWrkDone_DPRLabour_Controller.saveButton=RequestConstant.SAVE.obs;

    if(dailyWrkDone_DPRLabour_Controller.editCheck==1){
      dailyWrkDone_DPRLabour_Controller.ButtonChanges(dailyWrkDone_DPRLabour_Controller.dpr_EditListApiValue.value[0].workId, 0);
      dailyWrkDone_DPRLabour_Controller.dpr_EditListApiValue.forEach((element) {
        projectController.selectedProjectId.value=element.projectId;
        siteController.selectedsiteId.value=element.siteId;
        dailyWrkDone_DPR_Controller.entryType=element.entryType;
      });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              height: BaseUtitiles.getheightofPercentage(context, 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 90),
              child: TextField(
                style: TextStyle(
                    fontSize: RequestConstant.Dropdown_Font_SIZE),
                readOnly: true,
                controller: dailyWrkDone_DPR_Controller.TypeSubcontractorname,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  labelText: RequestConstant.SUBCONTRACTOR_NAME,
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
                onTap: ()  {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  TypeSubcontAlert(list: dailyWrkDone_DPR_Controller.dpr_subcontractorList,);
                      });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:15),
              height: BaseUtitiles.getheightofPercentage(context, 4),

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
                child: Text("SHOW"),
                onPressed: () {
                 dailyWrkDone_DPRLabour_Controller.getLab_ShowClickPopList(context);
                },
              ),
            ),
            Obx(() => Container(
              child: Visibility(
                  visible: dailyWrkDone_DPRLabour_Controller.dprLabourlist.value.isEmpty
                      ? false
                      : true,
                  child: ListDetails()),
            )),
           Obx(()=> Visibility(
              visible: dailyWrkDone_DPRLabour_Controller.dprLabourlist.value.isEmpty
                  ? false
                  : true,
              child: Container(
                margin: EdgeInsets.only(top:15),
                height: BaseUtitiles.getheightofPercentage(context, 4),
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
                  child: Text(dailyWrkDone_DPRLabour_Controller.saveButton.value),
                  onPressed: () async{
                   if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                     await dailyWrkDone_DPRLabour_Controller.getDetTablesDatas();
                     await dailyWrkDone_DPRLabour_Controller.getLabourTablesDatas();
                     dailyWrkDone_DPRLabour_Controller.SaveButton_dprLabour_SaveAPI(
                         context, dailyWrkDone_DPRLabour_Controller.workid);
                   }  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
  Widget ListDetails() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            height: BaseUtitiles.getheightofPercentage(context,52),
            child: Column(
              children: <Widget>[
                Container(
                  height: BaseUtitiles.getheightofPercentage(context,50),
                  child: Obx(() => ListView.builder(
                    itemCount: dailyWrkDone_DPRLabour_Controller.dprLabourlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      dailyWrkDone_DPRLabour_Controller.textControllersInitiate();
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: BaseUtitiles.getheightofPercentage(context, 3),
                              width: BaseUtitiles.getheightofPercentage(context, 43),
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(dailyWrkDone_DPRLabour_Controller
                                    .dprLabourlist[index].subName),
                              ),
                            ),

                            Container(
                              color: Colors.black,
                              margin: EdgeInsets.only(top: 10,left: 3,right: 3),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 25,
                                          child: Text(
                                            dailyWrkDone_DPRLabour_Controller
                                                .dprLabourlist[index].catName,
                                            style: TextStyle(
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            RequestConstant.CURRENCY_SYMBOL +
                                                dailyWrkDone_DPRLabour_Controller
                                                    .dprLabourlist[index].wages
                                                    .toString(),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height:
                                            BaseUtitiles.getheightofPercentage(context,2),
                                            width: BaseUtitiles.getWidthtofPercentage(context, 8),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(RequestConstant.DO_YOU_WANT_DELETE),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                              child: Text(RequestConstant.NO),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              }
                                                          ),
                                                          ElevatedButton(
                                                              child: Text(RequestConstant.YES),
                                                              onPressed: () {
                                                                dailyWrkDone_DPRLabour_Controller.deleteParticularLabourList(dailyWrkDone_DPRLabour_Controller.dprLabourlist[index]);
                                                                dailyWrkDone_DPRLabour_Controller. getLabourTablesDatas();
                                                                dailyWrkDone_DPRLabour_Controller.dprLabourlist.remove(dailyWrkDone_DPRLabour_Controller.dprLabourlist[index]);
                                                                Navigator.pop(context);
                                                              }
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              },
                                              child: Image.asset('assets/cancle.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            RequestConstant.NOS,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 11),
                                              height: BaseUtitiles
                                                  .getheightofPercentage(
                                                  context, 4),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  controller: dailyWrkDone_DPRLabour_Controller.ListNosControllers[index],
                                                  cursorColor: Colors.red,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                  ),
                                                  onChanged:(value){
                                                    dailyWrkDone_DPRLabour_Controller.LabourclickEdit(value);
                                                  }
                                              ),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            RequestConstant.OTHRS,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                              margin: EdgeInsets.only(left: 8,right: 3),
                                              height: BaseUtitiles
                                                  .getheightofPercentage(
                                                  context, 4),
                                              child: TextField(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  controller: dailyWrkDone_DPRLabour_Controller.ListOtHrsController[index],
                                                  cursorColor: Colors.white,
                                                  keyboardType: TextInputType
                                                      .number,
                                                  decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                  ),
                                                  onChanged:(value){
                                                    dailyWrkDone_DPRLabour_Controller.LabourclickEdit(value);
                                                  }

                                              )),
                                        )],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            RequestConstant.OTAMT,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 11),
                                              height: BaseUtitiles
                                                  .getheightofPercentage(
                                                  context, 4),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                controller: dailyWrkDone_DPRLabour_Controller
                                                    .ShowOtAmtController[index],
                                                style: TextStyle(
                                                    color: Colors.white),
                                                cursorColor: Colors.red,
                                                keyboardType: TextInputType
                                                    .number,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            RequestConstant.NETAMT,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8,right: 3),
                                              height: BaseUtitiles
                                                  .getheightofPercentage(
                                                  context, 4),
                                              child: TextField(
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: dailyWrkDone_DPRLabour_Controller
                                                    .ShowNetAmtController[index],
                                                style: TextStyle(
                                                    color: Colors.white),
                                                cursorColor: Colors.red,
                                                keyboardType: TextInputType
                                                    .number,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            RequestConstant.REMARKSES,
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 11,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 3),
                                              height: BaseUtitiles
                                                  .getheightofPercentage(
                                                  context, 4),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                //  controller:dailyEntriesController.Remarks_Controller,
                                                cursorColor: Colors.red,
                                                keyboardType: TextInputType
                                                    .name,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
