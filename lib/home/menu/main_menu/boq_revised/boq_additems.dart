import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/boqrevised_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Boq_AddItems extends StatefulWidget {
  const Boq_AddItems({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<Boq_AddItems> createState() => _Boq_AddItemsState();
}

class _Boq_AddItemsState extends State<Boq_AddItems> {

  TextEditingController editingController = TextEditingController();
  final Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
  String datas="";

  @override
  void initState() {

    int i=0;
    boq_revised_controller.Boq_ItemList.forEach((element) {
      boq_revised_controller.Item_itemlist_textControllersInitiate();
      boq_revised_controller.Itemlist_qtyControllers[i].text="1";
      boq_revised_controller.Itemlist_AmountControllers[i].text="1";
      i++;
    });

    boq_revised_controller.isChecked=List<bool>.filled(widget.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await boq_revised_controller.boqitemlist_Save_DB(context);
          await boq_revised_controller.getItemTablesDatas();
        },
        label: Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
        icon: Icon(Icons.library_add_check_outlined, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
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
                        boq_revised_controller.Boq_MainItemList.value = BaseUtitiles.filterSearchResults_BOQRevised(value,boq_revised_controller.Boq_ItemList);
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            listDetails(),

          ],
        ),
      ),
    );
  }

  Widget listDetails(){
    if(datas.isEmpty){
      return Container(
      height: BaseUtitiles.getheightofPercentage(context, 100),
        child: ListView.builder(
          padding: EdgeInsets.zero,
            itemCount: boq_revised_controller.Boq_MainItemList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 2),

                  child:
                    Column(
                      children: [
                        Row(
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
                                      boq_revised_controller.setCheck(boq_revised_controller.Boq_MainItemList.value[index].level3ItemId,value!);
                                      boq_revised_controller.Boq_MainItemList.value[index].isCheck=value;
                                    });
                                  },
                                  value:  boq_revised_controller.Boq_MainItemList.value[index].isCheck
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 3),
                                  width: BaseUtitiles.getWidthtofPercentage(context,83),
                                  child: Text(
                                    boq_revised_controller.Boq_MainItemList.value[index].itemDesc.toString()+"  ("+ boq_revised_controller.Boq_MainItemList.value[index].unit.toString()+")",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize:
                                        RequestConstant.App_Font_SIZE,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(thickness: 1, color:Theme.of(context).primaryColor)
                      ],
                    ),

              );
            }),
      );
    }
    else if(boq_revised_controller.list.isNotEmpty){
      return Container(
        // color: Colors.lightGreenAccent,
        height: BaseUtitiles.getheightofPercentage(context, 100),
        child: ListView.builder(
            itemCount: boq_revised_controller.list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 2),
                child:
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                                  boq_revised_controller.serachsetCheck(boq_revised_controller.list.value[index].level3ItemId,value!);
                                  boq_revised_controller.list.value[index].isCheck=value;
                                });
                              },
                              value:  boq_revised_controller.list[index].isCheck
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              width: BaseUtitiles.getWidthtofPercentage(context,60),
                              child: Text(
                                boq_revised_controller.list.value[index].itemDesc.toString()+"  ("+ boq_revised_controller.list.value[index].unit.toString()+")",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                    RequestConstant.App_Font_SIZE,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),

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


  // Widget listDetails(){
  //   if(editingController.text.isEmpty){
  //     return Container(
  //       margin: EdgeInsets.only(top: 10,),
  //       height: BaseUtitiles.getheightofPercentage(context, 100),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 physics: BouncingScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: consumption_controller.Stock_List.value.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return Container(
  //                     color: Setmybackground,
  //                     margin: EdgeInsets.only(bottom: 2),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Row(
  //                           children: <Widget>[
  //                             Container(
  //                               child:  Checkbox(
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(2.0),
  //                                   ),
  //                                   side: MaterialStateBorderSide.resolveWith(
  //                                         (states) => BorderSide(width: 1.0,
  //                                       // color: Colors.white
  //                                       color: Theme.of(context).primaryColor,
  //                                     ),
  //                                   ),
  //                                   checkColor: Colors.white,
  //                                   activeColor: Theme.of(context).primaryColor,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       consumption_controller.setCheck(consumption_controller.Stock_List[index].materialId,value!);
  //                                       consumption_controller.Stock_List[index].check=value;
  //                                     });
  //                                   },
  //                                   value:  consumption_controller.Stock_List[index].check
  //                               ),
  //                             ),
  //
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Container(
  //                                     margin: EdgeInsets.only(left: 3),
  //                                     width: BaseUtitiles.getWidthtofPercentage(context,85),
  //                                     child: Text(  consumption_controller.Stock_List.value[index].material.toString()+"  ( "+ consumption_controller.Stock_List.value[index].scale.toString()+" )  ",
  //                                       style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)
  //                                 ),
  //                                 Container(
  //                                     margin: EdgeInsets.only(top: 5,left: 3),
  //                                     child: Text("Stock Qty :   "+consumption_controller.Stock_List.value[index].stockQty.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),)),
  //                               ],
  //                             ),
  //
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   else if(consumption_controller.mainlist.value.isNotEmpty){
  //     return Container(
  //       margin: EdgeInsets.only(top: 10,),
  //       height: BaseUtitiles.getheightofPercentage(context, 100),
  //       child: Expanded(
  //         child: ListView.builder(
  //             itemCount: consumption_controller.mainlist.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               // mrn_request_controller.Material_itemlist_textControllersInitiate();
  //               return Container(
  //                 color: Setmybackground,
  //                 margin: EdgeInsets.only(bottom: 2),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Row(
  //                       children: <Widget>[
  //                         Container(
  //                           child:  Checkbox(
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(2.0),
  //                               ),
  //                               side: MaterialStateBorderSide.resolveWith(
  //                                     (states) => BorderSide(width: 1.0,
  //                                   color: Theme.of(context).primaryColor,
  //                                   // color: Colors.white
  //                                 ),
  //                               ),
  //                               checkColor: Colors.white,
  //                               activeColor: Theme.of(context).primaryColor,
  //
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   consumption_controller.serachsetCheck(consumption_controller.mainlist[index].materialId,value!);
  //                                   consumption_controller.mainlist[index].check=value;
  //                                 });
  //
  //                               },
  //                               value:  consumption_controller.mainlist[index].check
  //                           ),
  //                         ),
  //
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                                 margin: EdgeInsets.only(left: 3),
  //                                 width: BaseUtitiles.getWidthtofPercentage(context,85),
  //                                 child: Text(consumption_controller.mainlist.value[index].material.toString()+" (  "+ consumption_controller.mainlist.value[index].scale.toString()+"  ) ",
  //                                   style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)
  //                             ),
  //                             Container(
  //                                 margin: EdgeInsets.only(top: 5,left: 3),
  //                                 child: Text("Stock Qty : "+consumption_controller.mainlist.value[index].stockQty.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),)),
  //                           ],
  //                         ),
  //
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }),
  //       ),
  //     );
  //   }
  //   else{
  //     return Container();
  //   }
  //
  // }

}
