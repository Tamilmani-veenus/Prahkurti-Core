import '../controller/boqrevised_controller.dart';
import '../controller/consumption_controller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/sitecontroller.dart';
import '../controller/stocksite_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteShowPopup extends StatefulWidget {
  const SiteShowPopup({Key? key, required this.list,required this.value}) : super(key: key);
  final List list;
  final int value;

  @override
  State<SiteShowPopup> createState() => _SiteShowPopupState();
}

class _SiteShowPopupState extends State<SiteShowPopup> {


  var id=0;
  TextEditingController editingController = TextEditingController();
  SiteController siteController = Get.put(SiteController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());
  Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
  StockSiteController stockSiteController=Get.put(StockSiteController());


  @override
  void initState() {
    siteController.mainlist.value.clear();
    siteController.mainlist.value=widget.list;
    super.initState();
  }

  @override
  Widget  build(BuildContext context)  {
    return  AlertDialog(
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
                      siteController.mainlist.value=BaseUtitiles.sitePopupAlert(value,widget.list);
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
                    itemCount: siteController.mainlist.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async{
                          if(widget.value==1 && siteController.selectedsiteId!=0){
                            await showDialog(
                              context: context,
                              builder: (BuildContext context)  {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text('Do you want change the Site?'),
                                  actions: [
                                    ElevatedButton(
                                      // textColor: Colors.black,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'),
                                    ),
                                    ElevatedButton(
                                      // textColor: Colors.black,
                                      onPressed: () {
                                        id=1;
                                        boq_revised_controller.Boqitem_itemview_GetDbList.value.clear();
                                        boq_revised_controller.delete_BoqRevised_itemlist_Table();
                                        stockSiteController.projectShowList.clear();
                                        consumption_controller.Consum_itemview_GetDbList.value.clear();
                                        consumption_controller.delete_Consum_itemlist_Table();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if(id==1){
                              dailyEntriesController.deleteSubcontDetTableDatas();
                              dailyEntriesController.readListdata.clear();
                              Navigator.pop(context);
                            }
                            else{
                              Navigator.pop(context);
                            }
                          }
                          else{
                            Navigator.pop(context);
                          }

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
                                    child: Text(siteController.mainlist.value[index].siteName
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
