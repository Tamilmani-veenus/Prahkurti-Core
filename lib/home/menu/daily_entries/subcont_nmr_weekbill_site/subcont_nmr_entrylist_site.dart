import 'package:prahkurticore/home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entry_site.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/nmrweeklybill_controller.dart';
import '../../../../utilities/baseutitiles.dart';

class Subcont_NMR_EntryListScreen_Site extends StatefulWidget {
  const Subcont_NMR_EntryListScreen_Site({Key? key}) : super(key: key);

  @override
  State<Subcont_NMR_EntryListScreen_Site> createState() =>
      _Subcont_NMR_EntryListScreenState_Site();
}

class _Subcont_NMR_EntryListScreenState_Site
    extends State<Subcont_NMR_EntryListScreen_Site> {
  TextEditingController editingController = TextEditingController();
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {

    if(nmrWklyController.editCheck==1){

    }
    else{
      nmrWklyController.editCheck=0;
    }

    setState(() {
      nmrWklyController.NmrEtyList.value.clear();
      nmrWklyController.mainEtyList.value.clear();
    });

    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month - 1, 0);
    nmrWklyController.EntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
    nmrWklyController.EntrylistToDate.text = currentDate.toString().substring(0, 10);
    nmrWklyController.getNmrEntryList();
    nmrWklyController.NmrEtyList.value = nmrWklyController.mainEtyList.value;
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
      child: SafeArea( top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          floatingActionButton:
          Obx(()=> Visibility(
            visible: commanController.addMode.value == 1 ? true : false,
            child: FloatingActionButton.extended(
              onPressed: (){
                nmrWklyController.submitCheck =0;
                nmrWklyController.editCheck =0;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Subcont_Nmr_EntryScreen_Site()));
              },
              label: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
              icon: const Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "NMR Weekly Bill - Generation",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: BaseUtitiles.getWidthtofPercentage(context, 38),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller: nmrWklyController.EntrylistFrDate,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
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
                                var frDate = await showDatePicker(
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
                                nmrWklyController.EntrylistFrDate.text = frDate.toString().substring(0, 10);
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
                      SizedBox(
                        width: BaseUtitiles.getWidthtofPercentage(context, 38),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller: nmrWklyController.EntrylistToDate,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Date",
                                labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                const BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon(Icons.calendar_month,
                                        color: Theme.of(context).primaryColor)),
                              ),
                              onTap: () async {
                                var toDate = await showDatePicker(
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
                                nmrWklyController.EntrylistToDate.text = toDate.toString().substring(0, 10);
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            setState(() {
                              nmrWklyController.getNmrEntryList();
                            });
                          },
                          child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                child: Text("SHOW",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: RequestConstant.App_Font_SIZE,
                                        fontWeight: FontWeight.bold)),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                                nmrWklyController.NmrEtyList.value=BaseUtitiles.filterSearchResults(value, nmrWklyController.mainEtyList);
                              });
                            },
                          ),
                        ),

                        ListDetails(),

                      ],
                    ),
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //       Container(
                //         width: BaseUtitiles.getWidthtofPercentage(context,40),
                //         height: BaseUtitiles.getheightofPercentage(context, 4),
                //         decoration: BoxDecoration(),
                //         child: TextField(
                //           readOnly: true,
                //           controller: nmrWklyController.EntrylistFrDate,
                //           decoration: InputDecoration(
                //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //             border: OutlineInputBorder(),
                //             prefixIcon: Icon(Icons.date_range_sharp,
                //                 color: Theme.of(context).primaryColor),
                //           ),
                //           onTap: () async {
                //             nmrWklyController.NmrEtyList.clear();
                //             var Frdate = await showDatePicker(
                //                 context: context,
                //                 initialDate: DateTime.now(),
                //                 firstDate: DateTime(1900),
                //                 lastDate: DateTime(2100),
                //                 builder: (context, child) {
                //                   return Theme(data: Theme.of(context).copyWith(
                //                     colorScheme: ColorScheme.light(
                //                       primary: Theme.of(context).primaryColor, // header background color
                //                       onPrimary: Colors.white, // header text color
                //                       onSurface: Colors.black, // body text color
                //                     ),
                //                     textButtonTheme: TextButtonThemeData(
                //                       style: TextButton.styleFrom(
                //                         primary: Colors.black, // button text color
                //                       ),
                //                     ),
                //                   ),
                //                     child: child!,
                //                   );
                //                 });
                //             nmrWklyController.EntrylistFrDate.text = Frdate.toString().substring(0, 10);
                //             nmrWklyController.getNmrEntryList();
                //           },
                //         ),
                //       ),
                //       Container(
                //         height: BaseUtitiles.getheightofPercentage(context, 4),
                //         width: BaseUtitiles.getWidthtofPercentage(context,40),
                //         decoration: BoxDecoration(),
                //         child: TextField(
                //           readOnly: true,
                //           controller: nmrWklyController.EntrylistToDate,
                //           decoration: InputDecoration(
                //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //             border: OutlineInputBorder(),
                //             prefixIcon: Icon(Icons.date_range_sharp,
                //                 color: Theme.of(context).primaryColor),
                //           ),
                //           onTap: () async {
                //             nmrWklyController.NmrEtyList.clear();
                //             var Todate = await showDatePicker(
                //                 context: context,
                //                 initialDate: DateTime.now(),
                //                 firstDate: DateTime(1900),
                //                 lastDate: DateTime(2100),
                //                 builder: (context, child) {
                //                   return Theme(data: Theme.of(context).copyWith(
                //                     colorScheme: ColorScheme.light(
                //                       primary: Theme.of(context).primaryColor, // header background color
                //                       onPrimary: Colors.white, // header text color
                //                       onSurface: Colors.black, // body text color
                //                     ),
                //                     textButtonTheme: TextButtonThemeData(
                //                       style: TextButton.styleFrom(
                //                         primary: Colors.black, // button text color
                //                       ),
                //                     ),
                //                   ),
                //                     child: child!,
                //                   );
                //                 });
                //             nmrWklyController.EntrylistToDate.text =
                //                 Todate.toString().substring(0, 10);
                //             nmrWklyController.getNmrEntryList();
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(left:10,top: 10,right: 10),
                //   height: BaseUtitiles.getheightofPercentage(context, 5),
                //   child: TextField(
                //     onChanged: (value) {
                //       setState(() {
                //         nmrWklyController.NmrEtyList.value=BaseUtitiles.filterSearchResults(value, nmrWklyController.mainEtyList);
                //
                //       });
                //     },
                //     controller: editingController,
                //     decoration: InputDecoration(
                //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //         labelText: "Search",
                //         prefixIcon: Icon(
                //           Icons.search,
                //           color: Theme.of(context).primaryColor,
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                //   ),
                // ),
                // Divider(color: Theme.of(context).primaryColor),
                // ListDetails(),

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
                      itemCount: nmrWklyController.NmrEtyList.value.length,
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
                                                  nmrWklyController.NmrEtyList.value[index].entrydate.toString(),
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
                                          nmrWklyController.NmrEtyList.value[index].workNo.toString(),
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
                                          flex: 3,
                                          child: Text(
                                            "Subcontractor",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController
                                                .NmrEtyList.value[index].subconName
                                                .toString(),
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
                                          flex: 3,
                                          child: Text(
                                            "Project Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController
                                                .NmrEtyList.value[index].project
                                                .toString(),
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
                                          flex: 3,
                                          child: Text(
                                            "From Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController
                                                .NmrEtyList.value[index].fromDate
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,),
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
                                          flex: 3,
                                          child: Text(
                                            "To Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController
                                                .NmrEtyList.value[index].toDate
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,),
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
                                          flex: 3,
                                          child: Text(
                                            "Bill No",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController
                                                .NmrEtyList.value[index].billNo
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,),
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
                                      const Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Status",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            nmrWklyController.NmrEtyList.value[index].status.toString(),
                                            style: TextStyle(color: nmrWklyController.NmrEtyList.value[index].status.toString() == "Approved" ? Colors.green : Colors.black),
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
                                            "Site Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            nmrWklyController.NmrEtyList.value[index].siteName.toString(),
                                            style: TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                if(nmrWklyController.NmrEtyList.value[index].appStatus=="N" && nmrWklyController.NmrEtyList.value[index].verifyStatus=="Y"){
                                                  BaseUtitiles.showToast("Verified record cannot be edited or deleted");
                                                }
                                                else if(nmrWklyController.NmrEtyList.value[index].appStatus=="Y" || nmrWklyController.NmrEtyList.value[index].verifyStatus=="Y"){
                                                  BaseUtitiles.showToast("Approval made cannot be edited or deleted");
                                                }
                                                else {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      shape: RoundedRectangleBorder(
                                                        // <-- SEE HERE
                                                        borderRadius: BorderRadius.vertical(
                                                            top: Radius.circular(25.0)),
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
                                                                      margin: EdgeInsets.only(
                                                                          right: 10),
                                                                      child: Text(
                                                                        nmrWklyController.NmrEtyList.value[index].workNo.toString(),
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
                                                                      Navigator.pop(context);
                                                                    },
                                                                    icon:  ConstIcons.cancle,)
                                                                ],
                                                              ),
                                                              InkWell(
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
                                                                    nmrWklyController.EditListSaveDatas.value.clear();
                                                                    nmrWklyController.NmritemList.value.clear();
                                                                    await  nmrWklyController.NmrEntryList_EditApi(nmrWklyController.NmrEtyList.value[index].nmrWorkId,context,1);
                                                                    // Navigator.pop(context);
                                                                    // FocusScope.of(context).unfocus();

                                                                  }),
                                                              Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: 20),
                                                                  child: Divider(
                                                                      thickness: 1)),
                                                              InkWell(
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
                                                                  onTap: () {
                                                                    setState(() {
                                                                      Navigator.pop(context);
                                                                      nmrWklyController.DeleteAlert(context,index);
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
            ),
          ],
        ),
      ),
    );

  }
}
