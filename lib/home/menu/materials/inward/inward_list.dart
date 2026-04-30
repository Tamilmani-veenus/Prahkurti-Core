import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Inward_ListScreen extends StatefulWidget {
  const Inward_ListScreen({Key? key}) : super(key: key);

  @override
  State<Inward_ListScreen> createState() => _Inward_ListScreenState();
}

class _Inward_ListScreenState extends State<Inward_ListScreen> {

  InwardPending_Controller inward_controller = Get.put(InwardPending_Controller());
  CommanController commanController = Get.put(CommanController());
  String searchString = "";
  TextEditingController editingController = TextEditingController();


  @override
  void initState() {
    setState(() {
      inward_controller.inwardEtyList.value.clear();
      inward_controller.mainEtyList.value.clear();
    });
    // BaseUtitiles.showToast("Please Wait...");
    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
    inward_controller.InwardEntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    inward_controller.InwardEntrylistToDate.text = currentDate.toString().substring(0, 10);
    inward_controller.getInward_EntryList();
    inward_controller.inwardEtyList.value = inward_controller.mainEtyList.value;
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
            // floatingActionButton:
            // Obx(()=> Visibility(
            //     visible: commanController.addMode.value == 1 ? true : false,
            //     child: FloatingActionButton.extended(
            //   onPressed: (){
            //     inward_controller.entryvalue =0;
            //     inward_controller.editvalue =0;
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Inward_entry()));
            //   },
            //   label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
            //   icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
            //   backgroundColor: Theme.of(context).primaryColor,
            // ))),
        
            body: SingleChildScrollView(
                child: Column(
                  children: [
        
                    const SizedBox(height: 40),
        
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Inward",
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
                                  controller: inward_controller.InwardEntrylistFrDate,
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
                                      child: ConstIcons.date,
                                    ),
                                  ),
                                  onTap: () async {
                                    var Frdate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: Colors.black, // body text color
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
                                    inward_controller.InwardEntrylistFrDate.text = Frdate.toString().substring(0, 10);
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
                                  controller: inward_controller.InwardEntrylistToDate,
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
                                        child:  ConstIcons.date),
                                  ),
                                  onTap: () async {
                                    var Todate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: Colors.black, // body text color
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
                                    inward_controller.InwardEntrylistToDate.text = Todate.toString().substring(0, 10);
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
                                    inward_controller.getInward_EntryList();
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
        
                    const SizedBox(height: 30),
        
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        // height: BaseUtitiles.getheightofPercentage(context, 40),
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child:  Column(
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
                                onChanged: (value) async {
                                  setState(() {
                                    inward_controller.inwardEtyList.value = BaseUtitiles.filterSearchResults_Inward(value,inward_controller.mainEtyList);
                                  });
                                },
                              ),
                            ),
                            ListDetails(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
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
                child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: inward_controller.inwardEtyList.length,
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
                                          width: BaseUtitiles.getWidthtofPercentage(
                                              context, 50),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(left: 5, right: 5, ),
                                                  child: ConstIcons.list_date),
                                              Text(
                                                inward_controller.inwardEtyList[index].entryDate.toString(),
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
                                        inward_controller.inwardEtyList[index].inwardNo.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 8, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "PO/WO No",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          inward_controller.inwardEtyList[index].selectedNo.toString() ,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Supplier",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          inward_controller.inwardEtyList[index].supplierName.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 10),
                                      child: Text(""),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Invoice No",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          inward_controller.inwardEtyList[index].invoiceNo.toString(),
                                          style: TextStyle(
                                            color: Colors.black,),
                                        )),
                                  ],
                                ),
                                const Divider(thickness: 1),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: const Text(""),
                                    ),
                                    const Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Site Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          inward_controller.inwardEtyList[index].siteName.toString(),
                                          style: const TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () async {
                                              inwardId = inward_controller.inwardEtyList[index].id;
                                              if(await inward_controller.InwardStatusCheckApi(inwardId)){
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(
                                                          top: Radius.circular(25.0)),
                                                    ),
                                                    builder: (context) {
                                                      return Container(
                                                        margin: const EdgeInsets.only(
                                                          left: 15,
                                                        ),
                                                        height: BaseUtitiles.getheightofPercentage(context, 25),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        right: 10),
                                                                    child: Text(
                                                                      inward_controller.inwardEtyList[index].inwardNo.toString(),
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          color: Theme.of(
                                                                              context)
                                                                              .primaryColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon:  ConstIcons.cancle,)
                                                              ],
                                                            ),
                                                            Visibility(
                                                              visible: commanController.editMode == 1 ? true : false,
                                                              child: InkWell(
                                                                  child: const Row(
                                                                    children: [
                                                                      Card(
                                                                        color: Colors
                                                                            .lightGreen,
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
                                                                  onTap: () async {
                                                                    inward_controller.itemlistTable_Delete();
                                                                    inward_controller.ItemGetTableListdata.clear();
                                                                    inward_controller.getInwardDetList.clear();
                                                                    inward_controller.editListApiDatas.value.clear();
                                                                    FocusScope.of(context).unfocus();
                                                                    await inward_controller.EntryList_EditApi(  inward_controller.inwardEtyList[index].id,  inward_controller.inwardEtyList[index].inwType.trim(),context);
                                                                  }),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets.only(right: 20),
                                                                child: Divider(thickness: 1)),
                                                            Visibility(
                                                              visible: commanController.deleteMode == 1 ? true : false,
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
                                                                    Future.delayed(const Duration(seconds: 0),() async {
                                                                      setState(() {
                                                                        Navigator.pop(context);
                                                                        inward_controller.DeleteAlert(context,index);
                                                                      });
                                                                    });

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
          ],
        ),
      ),
    );
  }
}
