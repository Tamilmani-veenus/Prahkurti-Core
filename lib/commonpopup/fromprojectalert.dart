import '../controller/fromproject_ccontroller.dart';
import '../controller/fromsite_controller.dart';
import '../controller/projectcontroller.dart';
import '../controller/transferbw_project_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrProjectShowPopup extends StatefulWidget {
  const FrProjectShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<FrProjectShowPopup> createState() => _FrProjectShowPopupState();
}

class _FrProjectShowPopupState extends State<FrProjectShowPopup> {
  TextEditingController editingController = TextEditingController();
  TransferBW_project_Controller transferBW_project_Controller=Get.put(TransferBW_project_Controller());

  final ProjectController projectController=Get.put(ProjectController());
  final FromProjectController fromprojectController=Get.put(FromProjectController());
  final FromSiteController fromsiteController=Get.put(FromSiteController());
  var id;


  @override
  void initState() {
    fromprojectController.mainlist.value.clear();
    fromprojectController.mainlist.value=widget.list;
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
                      fromprojectController.mainlist.value=BaseUtitiles.projectPopupAlert(value,widget.list);
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
                    itemCount: fromprojectController.mainlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()async{
                          if(fromprojectController.selectedProjectId!=0){
                            await showDialog(
                              context: context,
                              builder: (BuildContext context)  {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text('Do you want change the Project?'),
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
                                        if(transferBW_project_Controller.type.value=="Direct"){
                                          transferBW_project_Controller.ItemGetTableListdata.value.clear();
                                        }
                                        fromsiteController.setSelectedMRNListName(0);
                                        fromprojectController.setSelectedProjectID(fromprojectController.mainlist.value[index].project!);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if(id==1){
                              // fromsiteController.setSelectedMRNListName(0);
                              // fromprojectController.setSelectedProjectID(widget.list[index].project!);
                              Navigator.pop(context);
                            }
                            else{
                              Navigator.pop(context);
                            }

                          }
                          else{
                            fromsiteController.setSelectedMRNListName(0);
                            fromprojectController.setSelectedProjectID(fromprojectController.mainlist.value[index].project!);
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
                                    child: Text(fromprojectController.mainlist.value[index].project
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
