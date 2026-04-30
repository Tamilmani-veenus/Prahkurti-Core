import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/mrnrequest_preIndent_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'mrnreq_preindent_entry.dart';

class MRNRequest_PreIndent_List extends StatefulWidget {
  const MRNRequest_PreIndent_List({Key? key}) : super(key: key);

  @override
  State<MRNRequest_PreIndent_List> createState() => _MRNRequest_PreIndent_ListState();
}

class _MRNRequest_PreIndent_ListState extends State<MRNRequest_PreIndent_List> {

  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());
  CommanController commanController = Get.put(CommanController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    if (mrnRequest_PreIndent_Controller.entrycheck == 2) {
      mrnRequest_PreIndent_Controller.entrycheck = 0;
    } else if (mrnRequest_PreIndent_Controller.entrycheck == 0) {
    } else {
      mrnRequest_PreIndent_Controller.entrycheck = 1;
    }
    setState(() {
      mrnRequest_PreIndent_Controller.mainEtyList.value.clear();
      mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value.clear();
    });
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    mrnRequest_PreIndent_Controller.MrnReqPreIndent_FrDate.text = lastDayOfMonth.toString().substring(0, 10);
    mrnRequest_PreIndent_Controller.MrnReqPreIndent_ToDate.text = currentDate.toString().substring(0, 10);
    mrnRequest_PreIndent_Controller.getMrnReq_PreIndent_EntryList();
    mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value = mrnRequest_PreIndent_Controller.mainEtyList.value;
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

          floatingActionButton:
          Obx(()=> Visibility(
            visible: commanController.addMode.value == 1 ? true : false,
            child: FloatingActionButton.extended(
              onPressed: (){
                mrnRequest_PreIndent_Controller.saveButton.value = RequestConstant.SUBMIT;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MRNRequest_PreIndent_EntryScreen()));
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
                        "Site Request (Issue Slip)",
                        // "MRN Request (Pre Indent)",
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
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller: mrnRequest_PreIndent_Controller.MrnReqPreIndent_FrDate,
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
                                mrnRequest_PreIndent_Controller.MrnReqPreIndent_FrDate.text = Frdate.toString().substring(0, 10);
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
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller: mrnRequest_PreIndent_Controller.MrnReqPreIndent_ToDate,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon(Icons.calendar_month,
                                        color: Theme.of(context).primaryColor)),
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
                                mrnRequest_PreIndent_Controller.MrnReqPreIndent_ToDate.text =
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
                                mrnRequest_PreIndent_Controller.getMrnReq_PreIndent_EntryList();
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
                                mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value = BaseUtitiles.filterSearchResults_MRNRequestIndent(value,mrnRequest_PreIndent_Controller.mainEtyList);
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
    return SingleChildScrollView(
      child: Container(
        height: BaseUtitiles.getheightofPercentage(context, 69),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: Obx(
                      () => ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 3, right: 3),
                          child: Card(
                            color: Colors.white,
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
                                                  mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].reqOrdDate.toString(),
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
                                          mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].reqOrdNo.toString(),
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
                                            "Project",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].project.toString(),
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
                                            "Site",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].sitename.toString(),
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
                                        margin: EdgeInsets.only(top: 2, left: 10),
                                        child: Text(""),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Due Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].reqDueDate.toString(),
                                            style: TextStyle(
                                              color: Colors.black,),
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
                                            "Prepared By :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].Preparedby.toString(),
                                            style: TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor: Colors.white,
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
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(right: 10),
                                                                    child: Text(
                                                                      mrnRequest_PreIndent_Controller.MrnReqPreIndentList.value[index].reqOrdNo.toString(),
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
                                                                    mrnRequest_PreIndent_Controller.entrycheck = 1;
                                                                    mrnRequest_PreIndent_Controller.delete_MaterialIntent_itemlist_Table();
                                                                    mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.clear();
                                                                    mrnRequest_PreIndent_Controller.getRequestDetList.clear();
                                                                    FocusScope.of(context).unfocus();
                                                                    await mrnRequest_PreIndent_Controller.MaterialPreIntentList_EditApi(
                                                                        mrnRequest_PreIndent_Controller.MrnReqPreIndentList[index].reqMasId,
                                                                        mrnRequest_PreIndent_Controller.MrnReqPreIndentList[index].projectid,
                                                                        mrnRequest_PreIndent_Controller.MrnReqPreIndentList[index].siteid, context);
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
                                                                    mrnRequest_PreIndent_Controller.DeleteAlert(context, index);
                                                                  }),
                                                            ),
                                                            SizedBox(height: 20)
                                                          ],
                                                        ),
                                                      );
                                                    });
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
          ],
        ),
      ),
    );
  }
}
