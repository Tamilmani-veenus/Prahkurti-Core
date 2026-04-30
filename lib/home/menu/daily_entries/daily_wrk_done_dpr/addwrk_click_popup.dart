import '../../../../app_theme/app_colors.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddwrkClickPopup extends StatefulWidget {
  const AddwrkClickPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<AddwrkClickPopup> createState() => _AddwrkClickPopupState();
}

class _AddwrkClickPopupState extends State<AddwrkClickPopup> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
  Get.put(DailyWrkDone_DPR_Controller());
  String datas="";

  @override
  void initState() {
    // dailyWrkDone_DPR_Controller.dpr_mainitemList.value = dailyWrkDone_DPR_Controller.dpr_itemList.value;
    // dailyWrkDone_DPR_Controller.currQtyAndAmntZerovalueset(widget.list);
    dailyWrkDone_DPR_Controller.list.value.clear();
    int i=0;
    dailyWrkDone_DPR_Controller.dpr_mainitemList.value.forEach((element) {
      dailyWrkDone_DPR_Controller.dpr_itemlist_textControllersInitiate();
      dailyWrkDone_DPR_Controller.Addwrk_CurrentQtyControllers[i].text="1";
      i++;
    });
    dailyWrkDone_DPR_Controller.isChecked=List<bool>.filled(widget.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return
    //
    //   GestureDetector(
    //   onTap: (){
    //     FocusScopeNode currentFocus = FocusScope.of(context);
    //     if (!currentFocus.hasPrimaryFocus &&
    //         currentFocus.focusedChild != null) {
    //       FocusManager.instance.primaryFocus?.unfocus();
    //     }
    //   },
    //     child:

    return Scaffold(
            backgroundColor: Setmybackground,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await dailyWrkDone_DPR_Controller.dpr_itemlist_Save_DB(context);
                dailyWrkDone_DPR_Controller.getDprTablesDatas();
                dailyWrkDone_DPR_Controller.addwrkCheck=1;
              },
              label: Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
              icon: Icon(Icons.library_add_check_outlined, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(

                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Items",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),

                        Container(
                          height: BaseUtitiles.getheightofPercentage(context, 5),
                          width: BaseUtitiles.getWidthtofPercentage(context, 50),
                          margin: EdgeInsets.only(left: 15),
                          child: TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "Search..",
                              hintStyle: TextStyle(color: Colors.black),
                              isDense: true,
                              // fillColor: Setmybackground,
                              fillColor: Colors.white,
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              // if (onSearch != null) onSearch!(searchcontroller.text);
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              dailyWrkDone_DPR_Controller.dpr_mainitemList.value = BaseUtitiles.itemDescPopupAlert(value, dailyWrkDone_DPR_Controller.dpr_itemList.value);
                            },
                          ),
                        ),


                      ],
                    ),
                  ),
                  listDetails(),
                ],
              ),
            )
        );

      // child: AlertDialog(
      //   contentPadding: EdgeInsets.all(5.0),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //   ),
      //   content: Stack(children: <Widget>[
      //     SingleChildScrollView(
      //       child: Container(
      //         //height: BaseUtitiles.getheightofPercentage(context, 60),
      //         child: Column(
      //           children: <Widget>[
      //             Container(
      //               margin: EdgeInsets.only(top: 10),
      //               height: BaseUtitiles.getheightofPercentage(context, 4),
      //               child: TextField(
      //                 onChanged: (value) {
      //                   setState(() {
      //                     datas=value;
      //                     dailyWrkDone_DPR_Controller.list.value=BaseUtitiles.itemDescPopupAlert(value,dailyWrkDone_DPR_Controller.dpr_mainitemList.value);
      //                   });
      //                 },
      //                 controller: editingController,
      //                 decoration: InputDecoration(
      //                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      //                     labelText: "Search",
      //                     labelStyle: TextStyle(
      //                         color: Theme.of(context).primaryColor,
      //                         fontStyle: FontStyle.italic,
      //                         fontSize: RequestConstant.App_Font_SIZE),
      //                     prefixIcon: Icon(
      //                       Icons.search,
      //                       color: Theme.of(context).primaryColor,
      //                     ),
      //                     border: OutlineInputBorder(
      //                         borderRadius:
      //                         BorderRadius.all(Radius.circular(25.0)))),
      //               ),
      //             ),
      //             Container(
      //               margin: const EdgeInsets.only(top: 20),
      //               width: BaseUtitiles.getWidthtofPercentage(context, 80),
      //               height: BaseUtitiles.getheightofPercentage(context, 55),
      //               child: Column(
      //                 children:<Widget> [
      //                   Container(
      //                     width: BaseUtitiles.getWidthtofPercentage(context, 80),
      //                     height: BaseUtitiles.getheightofPercentage(context,48),
      //                     child: listDetails(),
      //                   ),
      //                   Container(
      //                     margin: EdgeInsets.only(top: 15),
      //                     height: BaseUtitiles.getheightofPercentage(context, 4),
      //                     width: BaseUtitiles.getWidthtofPercentage(context, 24),
      //                     child: ElevatedButton(
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Theme.of(context).primaryColor,
      //                         //background color of button
      //                         side: BorderSide(width: 3, color: Colors.black),
      //                         //border width and color
      //                         elevation: 3,
      //                         //elevation of button
      //                         shape: RoundedRectangleBorder(
      //                           //to set border radius to button
      //                             borderRadius: BorderRadius.circular(30)),),
      //                       child: Text(RequestConstant.OK),
      //                       onPressed: () async{
      //                         await dailyWrkDone_DPR_Controller.dpr_itemlist_Save_DB(context);
      //                         dailyWrkDone_DPR_Controller.getDprTablesDatas();
      //                         dailyWrkDone_DPR_Controller.addwrkCheck=1;
      //                       },
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ]),
      // ),
    // );
  }


  Widget listDetails(){
    if(datas.isEmpty){
      return Container(
        height: BaseUtitiles.getheightofPercentage(context, 90),
        child: Column(
          children: [
            Container(
              height: BaseUtitiles.getheightofPercentage(context, 90),
              child: ListView.builder(
                  itemCount: dailyWrkDone_DPR_Controller.dpr_mainitemList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    dailyWrkDone_DPR_Controller.dpr_itemlist_textControllersInitiate();
                    return Container(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      margin: EdgeInsets.only(bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child:  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    side: MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
                                    ),
                                    checkColor: Colors.white,
                                    activeColor: Theme.of(context).primaryColor,

                                    onChanged: (value) {
                                      setState(() {
                                        dailyWrkDone_DPR_Controller.setCheck(dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].level3ItemId,value!);
                                        dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].isCheck=value;
                                      });

                                    },
                                    value: dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].isCheck
                                ),
                              ),
                              Expanded(
                                flex:13,
                                child: Container(
                                    // margin: EdgeInsets.only(left: 3, right: 10),
                                    width: BaseUtitiles.getWidthtofPercentage(context,80),
                                    child: Text(
                                      dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].itemDesc.toString()+"  ("+ dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].unit.toString()+")",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize:
                                          RequestConstant.App_Font_SIZE,
                                          color: Colors.black),
                                    )),
                              ),
                              Expanded(
                                  child: Container()),

                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //         margin: EdgeInsets.only(left: 3),
                              //         width: BaseUtitiles.getWidthtofPercentage(context,60),
                              //         child: Text(
                              //           dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].itemDesc.toString()+"  ("+ dailyWrkDone_DPR_Controller.dpr_mainitemList.value[index].unit.toString()+")",
                              //           textAlign: TextAlign.justify,
                              //           style: TextStyle(
                              //               fontSize:
                              //               RequestConstant.App_Font_SIZE,
                              //               color: Colors.black),
                              //         )),
                              //     ],
                              // ),3
                            ],
                          ),
                          Divider(thickness: 1,color: Theme.of(context).primaryColor)
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    }
    else if(dailyWrkDone_DPR_Controller.list.isNotEmpty){
      return Container(
        height: BaseUtitiles.getheightofPercentage(context, 90),
        child: ListView.builder(
            itemCount: dailyWrkDone_DPR_Controller.list.value.length,
            itemBuilder: (BuildContext context, int index) {
              dailyWrkDone_DPR_Controller.dpr_itemlist_textControllersInitiate();
              return Container(
                color: Color.fromRGBO(240, 240, 240, 1),
                margin: EdgeInsets.only(bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child:  Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(width: 1.0, color: Theme.of(context).primaryColor),
                              ),
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,

                              onChanged: (value) {
                                setState(() {
                                  dailyWrkDone_DPR_Controller.serachsetCheck(dailyWrkDone_DPR_Controller.list.value[index].level3ItemId,value!);
                                  dailyWrkDone_DPR_Controller.list.value[index].isCheck=value;
                                });

                              },
                              value: dailyWrkDone_DPR_Controller.list.value[index].isCheck
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 3),
                            width: BaseUtitiles.getWidthtofPercentage(context,60),
                            child: Text(
                              dailyWrkDone_DPR_Controller.list.value[index].itemDesc.toString()+"  ("+ dailyWrkDone_DPR_Controller.list.value[index].unit.toString()+")",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize:
                                  RequestConstant.App_Font_SIZE,
                                  color: Colors.black),
                            )),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //
                        //   ],
                        // ),
                      ],
                    ),
                    Divider(thickness: 1,color: Theme.of(context).primaryColor)
                  ],
                ),
              );
            }),
      );
    }
    else{
      return Container();
    }




  }
}
