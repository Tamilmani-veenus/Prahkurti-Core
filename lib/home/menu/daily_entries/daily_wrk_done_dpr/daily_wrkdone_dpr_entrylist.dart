import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'daily_wrkdone_dpr_entry.dart';

// class DailyWork_done_DPR_EntryList extends StatefulWidget {
//   const DailyWork_done_DPR_EntryList({Key? key}) : super(key: key);
//
//   @override
//   State<DailyWork_done_DPR_EntryList> createState() => _DailyWork_done_DPR_EntryListState();
// }
//
// class _DailyWork_done_DPR_EntryListState extends State<DailyWork_done_DPR_EntryList> {
//   TextEditingController editingController = TextEditingController();
//   DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
//   CommanController commanController = Get.put(CommanController());
//
//   @override
//   void initState() {
//     if(dailyWrkDone_DPR_Controller.entrycheck==2){
//       dailyWrkDone_DPR_Controller.entrycheck=0;
//     }
//     else if(dailyWrkDone_DPR_Controller.entrycheck==0){
//
//     }
//     else{
//       dailyWrkDone_DPR_Controller.entrycheck=1;
//     }
//     dailyWrkDone_DPR_Controller.addwrkCheck=0;
//     dailyWrkDone_DPR_Controller.editCheck=0;
//
//
//     setState(() {
//       dailyWrkDone_DPR_Controller.dpr_entryList.value.clear();
//       dailyWrkDone_DPR_Controller.searchentryList.value.clear();
//     });
//     DateTime currentDate = DateTime.now();
//     DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//     dailyWrkDone_DPR_Controller.entryList_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
//     dailyWrkDone_DPR_Controller.entryList_todateController.text = BaseUtitiles.initiateCurrentDateFormat();
//     dailyWrkDone_DPR_Controller.dpr_getEntryList();
//     dailyWrkDone_DPR_Controller.searchentryList.value=dailyWrkDone_DPR_Controller.dpr_entryList.value;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Container(
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     decoration: BoxDecoration(
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: dailyWrkDone_DPR_Controller.entryList_frdateController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         dailyWrkDone_DPR_Controller.searchentryList.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             });
//                         dailyWrkDone_DPR_Controller.entryList_frdateController.text =
//                             Frdate.toString().substring(0, 10);
//                         dailyWrkDone_DPR_Controller.dpr_getEntryList();
//                       },
//                     ),
//                   ),
//                   Container(
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: dailyWrkDone_DPR_Controller.entryList_todateController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         dailyWrkDone_DPR_Controller.searchentryList.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             });
//                         dailyWrkDone_DPR_Controller.entryList_todateController.text =
//                             Frdate.toString().substring(0, 10);
//                         dailyWrkDone_DPR_Controller.dpr_getEntryList();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left:10,top: 10,right: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     dailyWrkDone_DPR_Controller.searchentryList.value= BaseUtitiles.filterSearchResults(value,dailyWrkDone_DPR_Controller.dpr_entryList);
//                   });
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.SEARCH,
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Divider(
//               color: Colors.red,
//             ),
//             ListDetails(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 3,left: 3,right: 3),
//       height: BaseUtitiles.getheightofPercentage(context, 70),
//       width: BaseUtitiles.getWidthtofPercentage(context, 100),
//       child: Obx(
//             () => ListView.builder(
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemCount: dailyWrkDone_DPR_Controller.searchentryList.value.length,
//             itemBuilder: (context, index) {
//
//               return Slidable(
//                 actionPane: SlidableDrawerActionPane(),
//                 secondaryActions: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Visibility(
//                         visible: commanController.deleteMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.delete,
//                             color: Colors.white10,
//                             foregroundColor: Colors.red,
//                             caption: RequestConstant.DELETE,
//                             onTap: () {
//                               setState(() {
//                                 dailyWrkDone_DPR_Controller.DeleteAlert(context,index);
//                               });
//                             }),
//                       ),
//                       Visibility(
//                         visible:  commanController.editMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.edit,
//                             color: Colors.white10,
//                             foregroundColor: Colors.green,
//                             caption: RequestConstant.EDIT,
//                             onTap: () async{
//                               dailyWrkDone_DPR_Controller.entrycheck=1;
//                               dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
//                               dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
//                               dailyWrkDone_DPR_Controller.getDprDetList.value.clear();
//                               FocusScope.of(context).unfocus();
//                               dailyWrkDone_DPR_Controller.DprEntryList_EditApi(dailyWrkDone_DPR_Controller.searchentryList.value[index].workId,context,0);
//                             }),
//                       ),
//                     ],
//                   )
//                 ],
//
//                 child: Container(
//                   margin: EdgeInsets.only(left: 3,right: 3),
//                   height: BaseUtitiles.getheightofPercentage(context, 17),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 200),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     color: Colors.indigo.shade800,
//                     child: Container(
//                       margin: EdgeInsets.all(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 dailyWrkDone_DPR_Controller.searchentryList.value[index].workNo.toString(),
//                                 style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 dailyWrkDone_DPR_Controller.searchentryList.value[index].workDate.toString(),
//                                 style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                               ),
//                               // Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,)
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.PROJECT_NAME,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyWrkDone_DPR_Controller.searchentryList.value[index].project.toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.SITE_NAME,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyWrkDone_DPR_Controller.searchentryList.value[index].siteName.toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Subcont Name",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyWrkDone_DPR_Controller.searchentryList.value[index].subconName.toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.PREPARED_BY,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyWrkDone_DPR_Controller.searchentryList.value[index].preparedbyName.toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//               //
//             }),
//       ),
//     );
//   }
// }


class DailyWork_done_DPR_EntryList extends StatefulWidget {
  const DailyWork_done_DPR_EntryList({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_EntryList> createState() => _DailyWork_done_DPR_EntryListState();
}

class _DailyWork_done_DPR_EntryListState extends State<DailyWork_done_DPR_EntryList> {
  TextEditingController editingController = TextEditingController();
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {

    var duration = Duration(seconds: 0);

    Future.delayed(duration,() async {

      if(dailyWrkDone_DPR_Controller.entrycheck==2){
        dailyWrkDone_DPR_Controller.entrycheck=0;
      }
      else if(dailyWrkDone_DPR_Controller.entrycheck==0){

      }
      else{
        dailyWrkDone_DPR_Controller.entrycheck=1;
      }
      dailyWrkDone_DPR_Controller.addwrkCheck=0;
      dailyWrkDone_DPR_Controller.editCheck=0;

      setState(() {
        dailyWrkDone_DPR_Controller.dpr_entryList.value.clear();
        dailyWrkDone_DPR_Controller.searchentryList.value.clear();
      });
      DateTime currentDate = DateTime.now();
      DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
      dailyWrkDone_DPR_Controller.entryList_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
      dailyWrkDone_DPR_Controller.entryList_todateController.text = BaseUtitiles.initiateCurrentDateFormat();
      dailyWrkDone_DPR_Controller.dpr_getEntryList();
      dailyWrkDone_DPR_Controller.searchentryList.value=dailyWrkDone_DPR_Controller.dpr_entryList.value;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            setState(() {
              dailyWrkDone_DPR_Controller.entrycheck =0;
              dailyWrkDone_DPR_Controller.editCheck =0;
              dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
              dailyWrkDone_DPR_Controller.gettingNetworkImages.value = [];
              dailyWrkDone_DPR_Controller.imageFiles.clear();
              Navigator.push(context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_Entry()));
            });
            },
          label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
          icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
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
                      "Daily Work Done DPR",
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
                margin: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: dailyWrkDone_DPR_Controller.entryList_frdateController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "From Date",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date),
                            ),
                            onTap: () async {
                              var Frdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          onPrimary: Colors.white,
                                          onSurface:
                                          Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                            Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              dailyWrkDone_DPR_Controller.entryList_frdateController.text = Frdate.toString().substring(0, 10);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: dailyWrkDone_DPR_Controller.entryList_todateController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "ToDate",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date),
                            ),
                            onTap: () async {
                              var Todate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          // header background color
                                          onPrimary: Colors.white,
                                          // header text color
                                          onSurface:
                                          Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                            Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              dailyWrkDone_DPR_Controller.entryList_todateController.text =
                                  Todate.toString().substring(0, 10);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () async {
                            setState(() {
                              dailyWrkDone_DPR_Controller.dpr_getEntryList();
                            });
                          },
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 13, bottom: 13),
                                child: Text("SHOW",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: RequestConstant.App_Font_SIZE,
                                        fontWeight: FontWeight.bold)),
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 80),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: editingController,
                          decoration: const InputDecoration(
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
                              dailyWrkDone_DPR_Controller.dpr_entryList.value= BaseUtitiles.filterSearchResults_dprlist(value,dailyWrkDone_DPR_Controller.searchentryList);
                            });
                          },
                        ),
                      ),
                      ListDetails(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 69),
      child: Column(
        children: [
          Container(
            height: BaseUtitiles.getheightofPercentage(context, 68),
            child: Obx(
                  () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: dailyWrkDone_DPR_Controller.dpr_entryList.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 3, right: 3),
                      // height: BaseUtitiles.getheightofPercentage(context, 17),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                      Container(
                                        width: BaseUtitiles.getWidthtofPercentage(context, 50),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(left: 10, right: 3),
                                                child: ConstIcons.list_date),
                                            Text(
                                              dailyWrkDone_DPR_Controller.dpr_entryList.value[index].workDate.toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      dailyWrkDone_DPR_Controller
                                          .dpr_entryList.value[index].workNo
                                          .toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(height: 10),

                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Project",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller.dpr_entryList.value[index].project.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Site Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].siteName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,),
                                      )),
                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Contractor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].subconName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,),
                                      )),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2, left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller.dpr_entryList.value[index].AppStatusName.toString(),
                                        style: TextStyle(color:  dailyWrkDone_DPR_Controller.dpr_entryList.value[index].AppStatusName.toString() == "Approved" ? Colors.green : Colors.black),
                                      )),
                                ],
                              ),

                              Divider(thickness: 1),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(""),
                                  ),
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Prepared By :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        dailyWrkDone_DPR_Controller
                                            .dpr_entryList.value[index].preparedbyName
                                            .toString(),
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            if( dailyWrkDone_DPR_Controller.dpr_entryList.value[index].appStatus.toString() == "Y"){
                                              BaseUtitiles.showToast("${ dailyWrkDone_DPR_Controller.dpr_entryList.value[index].AppStatusName.toString()} list can not be edit or delete");
                                            }else{
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    // <-- SEE HERE
                                                    borderRadius: BorderRadius.vertical(
                                                        top: Radius.circular(25.0)),
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        left: 15,
                                                      ),
                                                      height: BaseUtitiles
                                                          .getheightofPercentage(
                                                          context, 25),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(right: 10),
                                                                child: Text(
                                                                  dailyWrkDone_DPR_Controller.dpr_entryList.value[index].workNo.toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      color: Theme.of(context).primaryColor),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon: ConstIcons.cancle)
                                                            ],
                                                          ),
                                                          InkWell(
                                                              child: const Row(
                                                                children: [
                                                                  Card(
                                                                    color: Colors.lightGreen,
                                                                    child: Padding(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .all(8),
                                                                      child: Icon(
                                                                        Icons.edit,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5),
                                                                  Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 15),
                                                                  )
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                dailyWrkDone_DPR_Controller.entrycheck=1;
                                                                dailyWrkDone_DPR_Controller.editCheck=0;
                                                                dailyWrkDone_DPR_Controller.screenchek.value=2;
                                                                dailyWrkDone_DPR_Controller.delete_dpr_itemlist_Table();
                                                                dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
                                                                dailyWrkDone_DPR_Controller.getDprDetList.value.clear();
                                                                dailyWrkDone_DPR_Controller.DprEntryList_EditApi(dailyWrkDone_DPR_Controller.searchentryList.value[index].workId,context,0);
                                                                FocusScope.of(context).unfocus();
                                                                Navigator.pop(context);
                                                              }),
                                                          Container(
                                                              margin: EdgeInsets.only(right: 20),
                                                              child: Divider(thickness: 1)),
                                                          InkWell(
                                                              child: const Row(
                                                                children: [
                                                                  Card(
                                                                    color: Colors.red,
                                                                    child: Padding(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .all(8),
                                                                      child: Icon(
                                                                        Icons
                                                                            .delete_forever,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5),
                                                                  Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 15),
                                                                  )
                                                                ],
                                                              ),
                                                              onTap: ()  {
                                                                setState(() {
                                                                  Navigator.pop(context);
                                                                  dailyWrkDone_DPR_Controller.DeleteAlert(context, index);

                                                                });
                                                              }),
                                                          SizedBox(height: 20)
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle_outlined,
                                            color: Theme.of(context).primaryColor,
                                          )))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}