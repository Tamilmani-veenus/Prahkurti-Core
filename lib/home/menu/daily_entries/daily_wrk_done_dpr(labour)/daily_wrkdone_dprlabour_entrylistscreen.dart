import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DailyWork_done_DPRLabour_EntryListScreen extends StatefulWidget {
  const DailyWork_done_DPRLabour_EntryListScreen({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPRLabour_EntryListScreen> createState() => _DailyWork_done_DPRLabour_EntryListScreenState();
}

class _DailyWork_done_DPRLabour_EntryListScreenState extends State<DailyWork_done_DPRLabour_EntryListScreen> {
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  TextEditingController editingController = TextEditingController();
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {

    if(dailyWrkDone_DPRLabour_Controller.screencheck==2){
      dailyWrkDone_DPRLabour_Controller.screencheck=0;
    }
    else if(dailyWrkDone_DPRLabour_Controller.screencheck==0){

    }
    else{
      dailyWrkDone_DPRLabour_Controller.screencheck=1;
    }
    setState(() {
      dailyWrkDone_DPRLabour_Controller.main_EntryList.value.clear();
      dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value.clear();
    });

    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
    dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_todateController.text = BaseUtitiles.initiateCurrentDateFormat();
    dailyWrkDone_DPRLabour_Controller.dprLabour_getEntryList();
    dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value = dailyWrkDone_DPRLabour_Controller.main_EntryList.value;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context,40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      readOnly: true,
                      controller: dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_frdateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                      //  dailyWrkDone_DPRNEW_Controller.dpr_New_entryList.clear();
                        var Frdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_frdateController.text =
                            Frdate.toString().substring(0, 10);
                        dailyWrkDone_DPRLabour_Controller.dprLabour_getEntryList();
                      },
                    ),
                  ),
                  Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context,40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      readOnly: true,
                      controller: dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_todateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                        dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.clear();
                        var Frdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        dailyWrkDone_DPRLabour_Controller.dprlabor_entryList_todateController.text =
                            Frdate.toString().substring(0, 10);
                        dailyWrkDone_DPRLabour_Controller.dprLabour_getEntryList();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:10,top: 10,right: 10),
              height: BaseUtitiles.getheightofPercentage(context, 5),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value=BaseUtitiles.filterSearchResults(value, dailyWrkDone_DPRLabour_Controller.main_EntryList);
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: RequestConstant.SEARCH,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Divider(
              color: Colors.red,
            ),
            ListDetails(),
          ],
        ),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 3,left: 3,right: 3),
      height: BaseUtitiles.getheightofPercentage(context, 70),
      width: BaseUtitiles.getWidthtofPercentage(context, 100),
      child: Obx(
            () => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Visibility(
                        visible: commanController.deleteMode == 1 ? true : false,
                        child: IconSlideAction(
                            icon: Icons.delete,
                            color: Colors.white10,
                            foregroundColor: Colors.red,
                            caption: RequestConstant.DELETE,
                            onTap: () {
                              setState(() {
                                dailyWrkDone_DPRLabour_Controller.DeleteAlert(context,index);
                              });
                            }),
                      ),
                      Visibility(
                        visible:
                        commanController.editMode == 1 ? true : false,
                        child: IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.white10,
                            foregroundColor: Colors.green,
                            caption: RequestConstant.EDIT,
                            onTap: () async{
                              dailyWrkDone_DPRLabour_Controller.screencheck=1;
                              dailyWrkDone_DPRLabour_Controller.dprLabour_DetTable_Delete();
                              dailyWrkDone_DPRLabour_Controller.dprlabour_EntryDetlist.value.clear();
                              dailyWrkDone_DPRLabour_Controller.getLablist.value.clear();
                              dailyWrkDone_DPRLabour_Controller.getDetList.value.clear();
                              dailyWrkDone_DPRLabour_Controller.dprLabour_Labourtable_Delete();
                              dailyWrkDone_DPRLabour_Controller.dprLabourlist.value.clear();
                              dailyWrkDone_DPRLabour_Controller.dpr_EditListApiValue.value.clear();
                              FocusScope.of(context).unfocus();
                              dailyWrkDone_DPRLabour_Controller.DprLabourEntryList_EditApi(dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].workId,context,0);
                            }),
                      ),
                    ],
                  )
                ],

                child: Container(
                  margin: EdgeInsets.only(left: 3,right: 3),
                  height: BaseUtitiles.getheightofPercentage(context, 15),
                  width: BaseUtitiles.getWidthtofPercentage(context, 200),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.indigo.shade800,
                    child: Container(
                      margin: EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].workNo.toString(),
                                style: TextStyle(color: Colors.yellow),
                              ),
                              Text(
                                dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].workDate.toString(),
                                style: TextStyle(color: Colors.yellow),
                              ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text(RequestConstant.PROJECT_NAME,style: TextStyle(color: Colors.white),)),
                              Expanded(
                                  flex: 3,
                                  child: Text(dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].project.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text(RequestConstant.SITE_NAME,style: TextStyle(color: Colors.white),)),
                              Expanded(
                                  flex: 3,
                                  child: Text(dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].siteName.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 2, child: Text(RequestConstant.PREPARED_BY,style: TextStyle(color: Colors.white),)),
                              Expanded(
                                  flex: 3,
                                  child: Text(dailyWrkDone_DPRLabour_Controller.dprLabour_EntryList.value[index].preparedbyName.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
