import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/comman_controller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/requisitionslip_controller.dart';
import '../../../../controller/requisitionslip_controller_new.dart';
import 'entry_requisitionslip.dart';


///----------Requisition Slip Entry List-------------

class Requisitionslip_EntryList extends StatefulWidget {
  const Requisitionslip_EntryList({super.key});

  @override
  State<Requisitionslip_EntryList> createState() => _Requisitionslip_EntryListState();
}

class _Requisitionslip_EntryListState extends State<Requisitionslip_EntryList> {

  RequisitionSlipControllerNew requisitionSlipController=Get.put(RequisitionSlipControllerNew());
  LoginController loginController = Get.put(LoginController());
  TextEditingController editingController = TextEditingController();
  CommanController commanController = Get.put(CommanController());


  @override
  void initState() {
    // TODO: implement initState

    requisitionSlipController.ReqSlipEtyList.clear();
    requisitionSlipController.mainentrylist.value.clear();

    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    requisitionSlipController.EntrylistFromdate.text = lastDayOfMonth.toString().substring(0, 10);
    requisitionSlipController.EntrylistTodate.text = currentDate.toString().substring(0, 10);
    requisitionSlipController.getRequisitionslip_EntryList();
    requisitionSlipController.ReqSlipEtyList.value = requisitionSlipController.mainentrylist.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },

      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          floatingActionButton: Obx(()=> Visibility(
            visible: commanController.addMode.value == 1 ? true : false,
            child: FloatingActionButton.extended(
              onPressed: (){
                requisitionSlipController.entryCheck =0;
                requisitionSlipController.editCheck =0;
                // mrn_request_controller.entrycheck =0;
                // mrn_request_controller.editCheck =0;
                Future.delayed(Duration(seconds: 0), ()async{
                  // await requisitionSlipController.getLeaveInfo_List(loginController.user.value.empId!);
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RequisitionSlip_Entry()));
              },
              label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
              icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),),

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
                        "Requisition Slip",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            },
                          child: Text("Back", style: TextStyle(color: Colors.grey, fontSize: 18),))
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
                            borderRadius: BorderRadius.circular(15),),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller: requisitionSlipController.EntrylistFromdate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
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
                                  child: ConstIcons.date,
                                ),
                              ),
                              onTap: () async {
                                // requisitionSlipController.ReqSlipEtyList.clear();
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
                                              primary: Colors.black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                requisitionSlipController.EntrylistFromdate.text = Frdate.toString().substring(0, 10);
                                // requisitionSlipController.getRequisitionslip_EntryList();
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
                              controller: requisitionSlipController.EntrylistTodate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: Icon(Icons.calendar_month, color: Theme.of(context).primaryColor)),
                              ),
                              onTap: () async {
                                // requisitionSlipController.ReqSlipEtyList.clear();
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
                                requisitionSlipController.EntrylistTodate.text = Todate.toString().substring(0, 10);
                                // requisitionSlipController.getRequisitionslip_EntryList();
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
                            style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                            onPressed: () async {
                              setState(() {
                                requisitionSlipController.getRequisitionslip_EntryList();
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
                      borderRadius: const BorderRadius.only(
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
                            decoration: InputDecoration(
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
                                requisitionSlipController.ReqSlipEtyList.value = BaseUtitiles.filterSearchResultsemployee(value,requisitionSlipController.mainentrylist);
                                // mrn_request_controller.MrnReqEtyList.value = BaseUtitiles.filterSearchResults_MRNRequestIndent(value,mrn_request_controller.mainEtyList);
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
      ),

    );
  }

  Widget ListDetails() {
    final double height = MediaQuery.of(context).size.height * 6 / 100;
    return SingleChildScrollView(
      child: Container(
        height: BaseUtitiles.getheightofPercentage(context, 69),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: requisitionSlipController.ReqSlipEtyList.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 3, right: 3),
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
                                                  margin: EdgeInsets.only(left: 5, right: 3),
                                                  child: ConstIcons.list_date, ),
                                                Text(
                                                  requisitionSlipController.ReqSlipEtyList.value[index].eDate.toString(),
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
                                          requisitionSlipController.ReqSlipEtyList.value[index].requestionNo.toString(),
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
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Type",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            requisitionSlipController.ReqSlipEtyList.value[index].reqType.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Staff Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            requisitionSlipController.ReqSlipEtyList.value[index].employee.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 5, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Location",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            requisitionSlipController.ReqSlipEtyList.value[index].project.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
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
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Status",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 7,
                                          child: Text(
                                            requisitionSlipController.ReqSlipEtyList.value[index].status.toString(),
                                            style: TextStyle(color:requisitionSlipController.ReqSlipEtyList.value[index].status.toString() == "Approved"?Colors.green:requisitionSlipController.ReqSlipEtyList.value[index].status.toString() == "Rejected"? Colors.red:Colors.black),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                if(requisitionSlipController.ReqSlipEtyList[index].status.toString() == "Approved" || requisitionSlipController.ReqSlipEtyList[index].status.toString() == "Rejected" || requisitionSlipController.ReqSlipEtyList[index].status.toString() == "Verified"){
                                                  BaseUtitiles.showToast("${requisitionSlipController.ReqSlipEtyList[index].status} record can't be edited or deleted");
                                                }else{
                                                  showModalBottomSheet(
                                                      context: context,
                                                      shape: RoundedRectangleBorder(
                                                        // <-- SEE HERE
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                                      ),
                                                      builder: (context) {
                                                        return Container(
                                                          margin: EdgeInsets.only(left: 15),
                                                          height: BaseUtitiles.getheightofPercentage(context, 25),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      margin: EdgeInsets.only(right: 10),
                                                                      child: Text(
                                                                        requisitionSlipController.ReqSlipEtyList.value[index].requestionNo.toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Theme.of(context).primaryColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    icon:  ConstIcons.cancle,)
                                                                ],
                                                              ),
                                                              Visibility(
                                                                visible: commanController.editMode.value == 1 ? true : false,
                                                                child: InkWell(
                                                                    child: Row(
                                                                      children: [
                                                                        Card(
                                                                          color: Colors
                                                                              .lightGreen,
                                                                          child: Padding(
                                                                            padding:
                                                                            const EdgeInsets
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
                                                                    onTap: () async {
                                                                      FocusScope.of(context).unfocus();
                                                                      Navigator.pop(context);
                                                                      if(requisitionSlipController.ReqSlipEtyList.value[index].status == 'APPROVED'){
                                                                        Fluttertoast.showToast(msg: "Approved record can't be edited");
                                                                      }else if(requisitionSlipController.ReqSlipEtyList.value[index].status == 'REJECTED'){
                                                                        Fluttertoast.showToast(msg: "Rejected record can't be edited");
                                                                      } else{
                                                                        requisitionSlipController.editCheck = 1;
                                                                        await requisitionSlipController.Requisitionslip_EditApi(requisitionSlipController.ReqSlipEtyList[index].requestionId, context);
                                                                      }
                                                                      // mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                                                                      // mrn_request_controller.Material_itemview_GetDbList.clear();
                                                                      // mrn_request_controller.getRequestDetList.clear();
                                                                      // FocusScope.of(context).unfocus();
                                                                      // await mrn_request_controller.MaterialIntentList_EditApi(mrn_request_controller.MrnReqEtyList[index].reqMasId, mrn_request_controller.MrnReqEtyList[index].projectid, mrn_request_controller.MrnReqEtyList[index].siteid, context);
                                                                    }),
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets.only(right: 20),
                                                                  child: Divider(thickness: 1)),
                                                              Visibility(
                                                                visible: commanController.deleteMode.value == 1 ? true : false,
                                                                child: InkWell(
                                                                    child: Row(
                                                                      children: [
                                                                        Card(
                                                                          color: Colors.red,
                                                                          child: Padding(
                                                                            padding:
                                                                            const EdgeInsets
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
                                                                    onTap: () async {
                                                                      Navigator.pop(context);
                                                                      if(requisitionSlipController.ReqSlipEtyList.value[index].status == 'APPROVED' || requisitionSlipController.ReqSlipEtyList.value[index].status == 'REJECTED'){
                                                                        Fluttertoast.showToast(msg: "Approved record can't be deleted");
                                                                      }else{
                                                                        requisitionSlipController.DeleteAlert(context, index);
                                                                      }
                                                                    }),
                                                              ),
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
            ),
            SizedBox(height: height),
          ],
        ),
      ),
    );
  }
}

