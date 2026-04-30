import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/fromproject_ccontroller.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';

class MrnPreapprovalItemlist extends StatefulWidget {
  const MrnPreapprovalItemlist({Key? key}) : super(key: key);

  @override
  State<MrnPreapprovalItemlist> createState() => _MrnPreapprovalItemlistState();
}

class _MrnPreapprovalItemlistState extends State<MrnPreapprovalItemlist> {

  PendingListController pendingListController = Get.put(PendingListController());
  MrnPreApprovalController mrnPreApprovalController = Get.put(MrnPreApprovalController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  LoginController loginController = Get.put(LoginController());
  FromProjectController fromprojectController = Get.put(FromProjectController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // always dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Item List",
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
                            ),),
                      ],
                    ),
                  ),
                  Text(
                    projectController.projectname.text,
                    style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  ListDetails(),

                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: BaseUtitiles.getWidthtofPercentage(context, 30),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: mrnPreApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text( "Pre Approve",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: mrnPreApprovalController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      mrnPreApprovalController.checkColor = 0;
                      if (check()) {
                        BaseUtitiles.showToast("Please select FromProject Name");
                      } else {
                        SubmitAlert(context);
                      }
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  bool check(){
    int i=0;
    var data=false;
    mrnPreApprovalController.mrnPreAppDetList.forEach((element) {
      mrnPreApprovalController.itemlist_textControllersInitiate();
      if(mrnPreApprovalController.mrnpre_Approval_ListController[i].text=="T" && double.parse(mrnPreApprovalController.mrnpre_projectId[i].text)==0){
        data=true;
      }
      i++;
    });
    return data;
  }

  Widget ListDetails() {
    return Container(
            height: BaseUtitiles.getheightofPercentage(context,75),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    margin: EdgeInsets.only(top: 10),
                    height: BaseUtitiles.getheightofPercentage(context,80),
                    child: Obx(() => Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 6, // reduce the thickness to make thumb smaller
                      radius: Radius.circular(5),
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: mrnPreApprovalController.MaterialAppr_itemview_GetDbList.length,
                        itemBuilder: (BuildContext context, int index) {
                          mrnPreApprovalController.itemlist_textControllersInitiate();
                          return Padding(
                            padding: EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
                                            child: Text(mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString()+" - "+mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: BaseUtitiles.getheightofPercentage(context, 3),
                                              width: BaseUtitiles.getWidthtofPercentage(context, 4),
                                              margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                              child: Icon(Icons.search_off, color: white,),
                                            ),
                                            onTap: (){
                                              mrnPreApprovalController.getStock_MaterialWise(
                                                  mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialid,
                                                  mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString(),
                                                  mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),
                                                  context);
                                            },
                                          ),
                                        ),

                                      ],
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Text("Bal Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 11),
                                              height: BaseUtitiles.getheightofPercentage(context, 4),
                                              //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                              child:
                                              TextField(
                                                readOnly: true,
                                                cursorColor:Theme.of(context).primaryColor,
                                                textAlign: TextAlign.center,
                                               controller: mrnPreApprovalController.mrnpre_BalQty_ListController[index],
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                ),
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                                onChanged: (value) {

                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text("Req Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 11),
                                              height: BaseUtitiles.getheightofPercentage(context, 4),
                                              child:
                                              TextField(
                                                readOnly: true,
                                                cursorColor:Theme.of(context).primaryColor,
                                                textAlign: TextAlign.center,
                                               controller: mrnPreApprovalController.mrnpre_ReqQty_ListController[index],
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                ),
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                                onChanged: (value) {

                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text("App Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 11),
                                              height: BaseUtitiles.getheightofPercentage(context, 4),
                                              child:
                                              TextField(
                                                cursorColor:Theme.of(context).primaryColor,
                                                textAlign: TextAlign.center,
                                                controller: mrnPreApprovalController.mrnpre_ApprQty_ListController[index],
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                                ),
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                                onChanged: (value) {
                                                  setState(() {
                                                    mrnPreApprovalController.Approval_updateConsumTables();
                                                  });
                                                  // mrnPreApprovalController.Approval_MaterialItemlist_clickEdit();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                              flex: 3,
                                              child: Text("App Type",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                          Expanded(
                                            flex: 4,
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 4,right: 11),
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      border: Border.all(color: Theme.of(context).primaryColor)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8, right: 16),
                                                    child: Obx(()=>
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton2<String>(
                                                            isExpanded: true,
                                                            hint: Align(
                                                              alignment: Alignment.center,
                                                              child: Text(
                                                                mrn_request_controller.appTypeList.isNotEmpty
                                                                    ? mrn_request_controller.appTypeList[0]["approvalName"].toString()
                                                                    : "--SELECT--",
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            value: mrnPreApprovalController
                                                                .mrnpre_Approval_ListController[index].text.isEmpty
                                                                ? null
                                                                :mrnPreApprovalController
                                                                .mrnpre_Approval_ListController[index].text,

                                                            // ✅ ITEMS
                                                            items: mrn_request_controller.appTypeList
                                                                .map<DropdownMenuItem<String>>((item) {
                                                              return DropdownMenuItem<String>(
                                                                value: item["approvalType"].toString(),
                                                                child: Align(
                                                                  alignment: Alignment.center, // better UX than center
                                                                  child: Text(
                                                                    item["approvalName"].toString(),
                                                                    maxLines: 1, // ✅ restrict to single line
                                                                    overflow: TextOverflow.ellipsis, // ✅ add ...
                                                                    softWrap: false, // ✅ prevent wrapping
                                                                    style: const TextStyle(
                                                                      fontSize: 14.0,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),

                                                            // ✅ ON CHANGE
                                                            onChanged: (value) async {
                                                              if (value == null) return;

                                                              setState(() {
                                                                mrnPreApprovalController
                                                                    .mrnpre_Approval_ListController[index].text = value;

                                                                if (value != "T") {
                                                                  mrnPreApprovalController.mrnpre_TransfrProject_ListController[index].text = "--SELECT--";
                                                                  mrnPreApprovalController.mrnpre_projectId[index].text="0";
                                                                }
                                                              });

                                                              await mrnPreApprovalController
                                                                  .Approval_updateConsumTables();
                                                            },

                                                            // ✅ BUTTON STYLE (NO BORDER HERE ❗)
                                                            buttonStyleData: ButtonStyleData(
                                                              height: 35, // match container
                                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),

                                                            // ✅ ICON
                                                            iconStyleData: IconStyleData(
                                                              icon: Icon(
                                                                Icons.arrow_drop_down,
                                                                color: Theme.of(context).primaryColor,
                                                              ),
                                                              iconSize: 22,
                                                            ),

                                                            // ✅ DROPDOWN STYLE
                                                            dropdownStyleData: DropdownStyleData(
                                                              maxHeight: 300,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              elevation: 4,
                                                            ),

                                                            // ✅ MENU ITEM STYLE
                                                            menuItemStyleData: const MenuItemStyleData(
                                                              height: 40,
                                                            ),
                                                          ),
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible:  mrnPreApprovalController.mrnpre_Approval_ListController[index].text != "T" ? false : true,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                                flex: 3,
                                                child: Text("Transfer From Project",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin: EdgeInsets.only(right: 11),
                                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                                child:
                                                TextField(
                                                  readOnly: true,
                                                  cursorColor:Theme.of(context).primaryColor,
                                                  textAlign: TextAlign.center,
                                                  controller: mrnPreApprovalController.mrnpre_TransfrProject_ListController[index],
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                  ),
                                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),
                                                    onTap: () async {
                                                      var result = mrnPreApprovalController.mrnPreAppDetList.value.first;

                                                      if (result.mMatReqMasLink != null && result.mMatReqMasLink!.isNotEmpty) {

                                                        var currentItem = result.mMatReqMasLink![index];
                                                          await mrnPreApprovalController.gettingProjectName(
                                                            currentItem.reqMasDetId!,
                                                            projectController.selectedProjectId.value,
                                                            context,
                                                          );
                                                      }
                                                    }
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          );

  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
        'Are you sure to Pre Approve?' ),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if(mrnPreApprovalController.mrnpre_TransfrProject_ListController == "--SELECT--"){
                           BaseUtitiles.showToast("Please select transfer from project");
                          }
                          else{
                          if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                            await mrnPreApprovalController.getMaterialsItemlist_TableDatas();
                            await mrnPreApprovalController.ApproveAPI(context);
                          }
                        }
                        },
                        child: Text( "Pre Approve",
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
