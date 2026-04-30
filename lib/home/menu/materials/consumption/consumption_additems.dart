import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../controller/consumption_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Consumption_AddItems extends StatefulWidget {
  const Consumption_AddItems({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<Consumption_AddItems> createState() => _Consumption_AddItemsState();
}

class _Consumption_AddItemsState extends State<Consumption_AddItems> {

  TextEditingController editingController = TextEditingController();
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());

  @override
  void initState() {
    consumption_controller.currQtyAndAmntZerovalueset(widget.list);
    // consumption_controller.mainlist.value.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await consumption_controller.consum_itemlist_Save_DB(context);
            consumption_controller.getConumTablesDatas();
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
                          setState(() {
                            consumption_controller.mainlist.value = BaseUtitiles.filterSearchResults_Consumptionitemlist(value, consumption_controller.Stock_List);
                          });
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
  }

  Widget listDetails() {
    if (editingController.text.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: consumption_controller.Stock_List.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Setmybackground,
                        margin: EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child:  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(width: 1.0,
                                          // color: Colors.white
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          consumption_controller.setCheck(consumption_controller.Stock_List[index].materialId,value!);
                                          consumption_controller.Stock_List[index].check=value;
                                        });
                                      },
                                      value:  consumption_controller.Stock_List[index].check
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 3),
                                        width: BaseUtitiles.getWidthtofPercentage(context,85),
                                        child: Text(  consumption_controller.Stock_List.value[index].material.toString()+"  ( "+ consumption_controller.Stock_List.value[index].scale.toString()+" )  ",
                                          style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,left: 3),
                                        child: Text("Stock Qty :   "+consumption_controller.Stock_List.value[index].stockQty.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),)),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    }),),
              ),

            ],
          ),
        ),
      );
    }
    else if(consumption_controller.mainlist.value.isNotEmpty){
      return  Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child:  Obx(()=>  ListView.builder(
              padding: EdgeInsets.only(bottom: 50),
    itemCount: consumption_controller.mainlist.length,
    itemBuilder: (BuildContext context, int index) {
    // mrn_request_controller.Material_itemlist_textControllersInitiate();
    return Container(
    color: Setmybackground,
    margin: EdgeInsets.only(bottom: 2),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Row(
    children: <Widget>[
    Container(
    child:  Checkbox(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(2.0),
    ),
    side: MaterialStateBorderSide.resolveWith(
    (states) => BorderSide(width: 1.0,
    color: Theme.of(context).primaryColor,
    // color: Colors.white
    ),
    ),
    checkColor: Colors.white,
    activeColor: Theme.of(context).primaryColor,

    onChanged: (value) {
    setState(() {
    consumption_controller.serachsetCheck(consumption_controller.mainlist[index].materialId,value!);
    consumption_controller.mainlist[index].check=value;
    });

    },
    value:  consumption_controller.mainlist[index].check
    ),
    ),

    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    margin: EdgeInsets.only(left: 3),
    width: BaseUtitiles.getWidthtofPercentage(context,85),
    child: Text(consumption_controller.mainlist.value[index].material.toString()+" (  "+ consumption_controller.mainlist.value[index].scale.toString()+"  ) ",
    style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)
    ),
    Container(
    margin: EdgeInsets.only(top: 5,left: 3),
    child: Text("Stock Qty : "+consumption_controller.mainlist.value[index].stockQty.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),)),
    ],
    ),

    ],
    ),
    ],
    ),
    );
    }),)
        ),
      );
    }
    else{
      return Container();
    }
    // return  mrn_request_controller.list.value.isEmpty?  ListView.builder(
    //     itemCount: mrn_request_controller.getmaterialvalue.value.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       mrn_request_controller.Material_itemlist_textControllersInitiate();
    //       return Container(
    //         color: Colors.blueGrey.shade800,
    //         margin: EdgeInsets.only(bottom: 2),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Row(
    //               mainAxisAlignment:
    //               MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                         margin: EdgeInsets.only(left: 3),
    //                         width: BaseUtitiles.getWidthtofPercentage(context,35),
    //                         child: Text(mrn_request_controller.getmaterialvalue[index].materialName.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,color: Colors.white),)
    //                     ),
    //                     Container(
    //                         margin: EdgeInsets.only(top: 5,left: 3),
    //                         child: Text(mrn_request_controller.getmaterialvalue[index].scale.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,color: Colors.blue),)),
    //                   ],
    //                 ),
    //                 // Container(
    //                 //   height: BaseUtitiles.getheightofPercentage(context,4),
    //                 //   width: BaseUtitiles.getWidthtofPercentage(context,20),
    //                 //   child: TextField(
    //                 //     cursorColor:Theme.of(context).primaryColor,
    //                 //     textAlign: TextAlign.center,
    //                 //     controller: mrn_request_controller.Itemlist_qtyControllers[index],
    //                 //     keyboardType: TextInputType.number,
    //                 //     decoration: InputDecoration(
    //                 //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
    //                 //       focusedBorder: OutlineInputBorder(
    //                 //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //                 //           borderRadius: BorderRadius.all(
    //                 //               Radius.circular(10))),
    //                 //       enabledBorder: OutlineInputBorder(
    //                 //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //                 //           borderRadius: BorderRadius.all(
    //                 //               Radius.circular(10))),
    //                 //     ),
    //                 //     style: TextStyle(color: Colors.white),
    //                 //     onChanged: (value) {
    //                 //
    //                 //     //  mrn_request_controller.typeEntry(mrn_request_controller.getmaterialvalue[index].materialId,value);
    //                 //
    //                 //     },
    //                 //   ),
    //                 // ),
    //                 Container(
    //                   child:  Checkbox(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(2.0),
    //                       ),
    //                       side: MaterialStateBorderSide.resolveWith(
    //                             (states) => BorderSide(width: 1.0, color: Colors.white),
    //                       ),
    //                       checkColor: Colors.white,
    //                       activeColor: Theme.of(context).primaryColor,
    //
    //                       onChanged: (value) {
    //                         setState(() {
    //
    //                           mrn_request_controller.setCheck(mrn_request_controller.getmaterialvalue[index].materialId,value!);
    //                           mrn_request_controller.getmaterialvalue[index].isCheck=value;
    //
    //                           // if(value==true){
    //                           //
    //                           //   mrn_request_controller.list.forEach((element) {
    //                           //     mrn_request_controller.isChecked[index]=value!;
    //                           //   });
    //                           //   // mrn_request_controller.StoreList.value.add(mrn_request_controller.list.value[index]);
    //                           //   // mrn_request_controller.StoreList.value.add(mrn_request_controller.Itemlist_qtyControllers[index].value.toString());
    //                           // }
    //                           // else{
    //                           //   mrn_request_controller.isChecked[index]=value!;
    //                           //  // mrn_request_controller.StoreList.value.remove(mrn_request_controller.list.value[index]);
    //                           // }
    //                         });
    //                         //  mrn_request_controller.setSelectedMaterial(widget.list[index].materialId!);
    //                       },
    //                       value:  mrn_request_controller.getmaterialvalue[index].isCheck
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     }):
    // ListView.builder(
    //     itemCount: mrn_request_controller.list.value.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       mrn_request_controller.Material_itemlist_textControllersInitiate();
    //       return Container(
    //         color: Colors.blueGrey.shade800,
    //         margin: EdgeInsets.only(bottom: 2),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Row(
    //               mainAxisAlignment:
    //               MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                         margin: EdgeInsets.only(left: 3),
    //                         width: BaseUtitiles.getWidthtofPercentage(context,35),
    //                         child: Text(mrn_request_controller.list[index].materialName.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,color: Colors.white),)
    //                     ),
    //                     Container(
    //                         margin: EdgeInsets.only(top: 5,left: 3),
    //                         child: Text(mrn_request_controller.list[index].scale.toString(),style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,color: Colors.blue),)),
    //                   ],
    //                 ),
    //                 // Container(
    //                 //   height: BaseUtitiles.getheightofPercentage(context,4),
    //                 //   width: BaseUtitiles.getWidthtofPercentage(context,20),
    //                 //   child: TextField(
    //                 //     cursorColor:Theme.of(context).primaryColor,
    //                 //     textAlign: TextAlign.center,
    //                 //     controller: mrn_request_controller.Itemlist_qtyControllers[index],
    //                 //     keyboardType: TextInputType.number,
    //                 //     decoration: InputDecoration(
    //                 //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
    //                 //       focusedBorder: OutlineInputBorder(
    //                 //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //                 //           borderRadius: BorderRadius.all(
    //                 //               Radius.circular(10))),
    //                 //       enabledBorder: OutlineInputBorder(
    //                 //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //                 //           borderRadius: BorderRadius.all(
    //                 //               Radius.circular(10))),
    //                 //     ),
    //                 //     style: TextStyle(color: Colors.white),
    //                 //     onChanged: (value) {
    //                 //      // mrn_request_controller.typeEntrySearch(mrn_request_controller.list.value[index].materialId,value);
    //                 //     },
    //                 //   ),
    //                 // ),
    //                 Container(
    //                   child:  Checkbox(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(2.0),
    //                       ),
    //                       side: MaterialStateBorderSide.resolveWith(
    //                             (states) => BorderSide(width: 1.0, color: Colors.white),
    //                       ),
    //                       checkColor: Colors.white,
    //                       activeColor: Theme.of(context).primaryColor,
    //
    //                       onChanged: (value) {
    //                         setState(() {
    //
    //                           mrn_request_controller.serachsetCheck(mrn_request_controller.list.value[index].materialId,value!);
    //                           mrn_request_controller.list.value[index].isCheck=value;
    //
    //                           // if(value==true){
    //                           //
    //                           //   mrn_request_controller.list.forEach((element) {
    //                           //     mrn_request_controller.isChecked[index]=value!;
    //                           //   });
    //                           //   // mrn_request_controller.StoreList.value.add(mrn_request_controller.list.value[index]);
    //                           //   // mrn_request_controller.StoreList.value.add(mrn_request_controller.Itemlist_qtyControllers[index].value.toString());
    //                           // }
    //                           // else{
    //                           //   mrn_request_controller.isChecked[index]=value!;
    //                           //  // mrn_request_controller.StoreList.value.remove(mrn_request_controller.list.value[index]);
    //                           // }
    //                         });
    //                         //  mrn_request_controller.setSelectedMaterial(widget.list[index].materialId!);
    //                       },
    //                       value:  mrn_request_controller.list.value[index].isCheck
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     });

  }

}
