import '../../../../controller/transfer_acknowledgment_pending_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/auto_yrwise_no_controller.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/fromsite_controller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';

class TransferAcknow_EntryScreen extends StatefulWidget {
  const TransferAcknow_EntryScreen({Key? key}) : super(key: key);

  @override
  State<TransferAcknow_EntryScreen> createState() => _TransferAcknow_EntryScreenState();
}

class _TransferAcknow_EntryScreenState extends State<TransferAcknow_EntryScreen> {
  TransferAcknowledgmentPendingController transferAcknowController=Get.put(TransferAcknowledgmentPendingController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  SiteController siteController = Get.put(SiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  FromSiteController fromsiteController = Get.put(FromSiteController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      transferAcknowController.transferId.value=0;
      if(transferAcknowController.saveButton.value == RequestConstant.SUBMIT){
        await autoYearWiseNoController.AutoYearWiseNo("TRANSFER ACK PENDING");
        transferAcknowController.autoYearWiseNoController.text = autoYearWiseNoController.TransferAckNoautoYrsWise.value;
        transferAcknowController.entryDateController.text=BaseUtitiles.initiateCurrentDateFormat();
        transferAcknowController.transferAlldatas.forEach((element) {
          transferAcknowController.transferId.value=element.id;
          transferAcknowController.transNoController.text=element.transferNo;
          transferAcknowController.fromProjectController.text=element.fromProjectName.toString();
          transferAcknowController.toprojectController.text=element.toProjectName.toString();
          transferAcknowController.frProjectID.value=element.fromProjectId;
          transferAcknowController.toProjectId=element.toProjectId;
          fromsiteController.FromSitename.text = "--SELECT--";
          fromsiteController.selectedsiteId.value = 0;
        });
      }
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
      child: SafeArea( top: false,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text( transferAcknowController.saveButton.value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (fromsiteController.selectedsiteId.value == 0) {
                        BaseUtitiles.showToast("Please select SiteName");
                      }
                      else {
                        bool hasInvalid = false;
                        for (int i = 0; i <
                            transferAcknowController.readListdata.length; i++) {
                          final controller = transferAcknowController
                              .ackQtyListController[i];
                          final text = controller.text.trim();

                          if (text.isEmpty) {
                            hasInvalid = true;
                            break;
                          }

                          final value = double.tryParse(text);
                          if (value == null || value <= 0) {
                            hasInvalid = true;
                            break;
                          }
                        }
                        if (hasInvalid) {
                          BaseUtitiles.showToast(
                              "Ack Qty Should Not be Zero or Empty");
                        } else {
                          SubmitAlert(context);
                        }
                      }
                    }
                  }
                 ),
              ],
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child:
              Stack(
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Transfer Acknowledgement",
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
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: transferAcknowController.autoYearWiseNoController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Request No",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.requestNo),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: BaseUtitiles.getWidthtofPercentage(context, 35),
                              margin: const EdgeInsets.only(top: 5, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: transferAcknowController.entryDateController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Date",
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
                                      var Entrydate = await showDatePicker(
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
                                      transferAcknowController.entryDateController.text =BaseUtitiles.selectDateFormat(Entrydate!);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: transferAcknowController.transNoController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Transfer No",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.requestNo),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter Transfer No';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
        
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: transferAcknowController.fromProjectController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "From Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () {
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select project name.';
                                }
                                return null;
                              },
        
                            ),
                          ),
                        ),
                      ),
        
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: transferAcknowController.toprojectController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () {
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select to project name.';
                                }
                                return null;
                              },
        
                            ),
                          ),
                        ),
                      ),
        
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: fromsiteController.FromSitename,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Site Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () async {
                                await siteController.subcontEntry_siteDropdowntList(context, 0,type: "transAck");
                                if (mounted) {
                                  bottomsheetControllers.FromSiteName(
                                      context,
                                      "Transfer ack pending",
                                      siteController
                                          .getSiteDropdownvalue.value);
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
        
                            ),
                          ),
                        ),
                      ),
        
                    ],
                  ),
                  Obx(() => Visibility(
                      visible: transferAcknowController.readListdata.value.isEmpty ? false : true,
                      child: SizedBox(
                        height: BaseUtitiles.getheightofPercentage(context, 100),
                        child: DraggableScrollableSheet(
                          minChildSize: 0.1,
                          maxChildSize: 0.9,
                          initialChildSize: 0.3,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Setmybackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ListDetails(context, scrollController)),
                                      ],
                                    ),
                                  ),
                                  IgnorePointer(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                                            height: 5,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
        
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(context, scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 4, bottom: 10, right: 4),
            height: BaseUtitiles.getheightofPercentage(context, 80),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: transferAcknowController.readListdata.length,
              itemBuilder: (BuildContext context, int index) {
                transferAcknowController.textControllersInitiate();
                return Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                transferAcknowController.readListdata.value[index].materialName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Dropdown_Font_SIZE,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10,left: 3,bottom: 10,right: 3),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Transfer Qty",
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 11),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      readOnly: true,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      controller: transferAcknowController.transferQtyListController[index],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onChanged:(value){

                                      }
                                  ),
                                )),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Ack Qty",
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: (){
                                        if(transferAcknowController.ackQtyListController[index].text != "" && transferAcknowController.ackQtyListController[index].text != "0" && transferAcknowController.ackQtyListController[index].text != "0.0"){
                                          // return;
                                        } else {
                                            transferAcknowController.ackQtyListController[index].text = "";
                                        }
                                      },
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      controller:  transferAcknowController.ackQtyListController[index],
                                      cursorColor: Theme.of(context).primaryColor,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      ),
                                      onChanged:(value){
                                        setState(() {
                                          transferAcknowController.clickEdit();
                                        });
                                      }

                                  )
                              ),
                            )
                          ],
                        ),
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


  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text('Are you sure to ${transferAcknowController.saveButton.value}?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                        if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                          await transferAcknowController.getDetTablesDatas();
                          await transferAcknowController.Save_EntryScreen(
                            context, transferAcknowController.transferId.value);
                        } }
                        },
                        child: Text(
                          transferAcknowController.saveButton.value,
                          style: TextStyle(
                            color:  Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
