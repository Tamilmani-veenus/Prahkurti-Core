import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../controller/transferbw_site_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Transferbetween_sites_additems extends StatefulWidget {
  const Transferbetween_sites_additems({Key? key}) : super(key: key);

  @override
  State<Transferbetween_sites_additems> createState() => _Transferbetween_sites_additemsState();
}

class _Transferbetween_sites_additemsState extends State<Transferbetween_sites_additems> {

  TextEditingController editingController = TextEditingController();
  TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());

  @override
  void initState() {
    transferBt_Site_Controller.mainlist.value.clear();
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
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
          transferBt_Site_Controller.itemlistPopup_saveLabTableDatas(context);
          transferBt_Site_Controller.getItemlistTablesDatas();
          },
          label: Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
          icon: Icon(Icons.library_add_check_outlined, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
          body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: 50),
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
                               transferBt_Site_Controller.mainlist.value =BaseUtitiles.materialPopupAlert(value,transferBt_Site_Controller.transferItemListdatas);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ListDetails(),

                ],
              ),
          ),

      ),
    );
  }


  Widget ListDetails(){
    if(editingController.text.isEmpty){
      return Container(
        height: BaseUtitiles.getheightofPercentage(context, 80),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: transferBt_Site_Controller.transferItemListdatas.value.length,
                itemBuilder: (BuildContext context, int index) {
                  transferBt_Site_Controller.itemlist_textControllersInitiate();
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [

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
                                  transferBt_Site_Controller.setCheck(transferBt_Site_Controller.transferItemListdatas[index].materialId,value!);
                                  transferBt_Site_Controller.transferItemListdatas[index].check=value;
                                });

                              },
                              value:  transferBt_Site_Controller.transferItemListdatas[index].check
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                              width: BaseUtitiles.getWidthtofPercentage(context,59),
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                transferBt_Site_Controller.transferItemListdatas.value[index].material.toString()+" (  "+ transferBt_Site_Controller.transferItemListdatas.value[index].scale.toString()+"  ) ",
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),
                              ),
                            ),
                            Container(
                              width: BaseUtitiles.getWidthtofPercentage(context,59),
                              child: Text("Stock Qty :    "+transferBt_Site_Controller.transferItemListdatas.value[index].stockQty.toString(),style: TextStyle(fontSize: 13,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    else if(transferBt_Site_Controller.mainlist.value.isNotEmpty){
      return Container(
        height: BaseUtitiles.getheightofPercentage(context, 80),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: transferBt_Site_Controller.mainlist.length,
                itemBuilder: (BuildContext context, int index) {
                  transferBt_Site_Controller.itemlist_textControllersInitiate();
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
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
                                      transferBt_Site_Controller.serachsetCheck(transferBt_Site_Controller.mainlist[index].materialId,value!);
                                      transferBt_Site_Controller.mainlist[index].check=value;
                                    });
                                  },
                                  value:  transferBt_Site_Controller.mainlist[index].check
                              ),
                            ),

                            Column(
                              children: [
                                Container(
                                  width: BaseUtitiles.getWidthtofPercentage(context,59),
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    transferBt_Site_Controller.mainlist.value[index].material.toString()+" (  "+ transferBt_Site_Controller.mainlist.value[index].scale.toString()+"  ) ",
                                    style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),
                                  ),
                                ),
                                Container(
                                  width: BaseUtitiles.getWidthtofPercentage(context,59),
                                  child: Text("Stock Qty :       "+transferBt_Site_Controller.mainlist.value[index].stockQty.toString(),style: TextStyle(fontSize: 13,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }


}
