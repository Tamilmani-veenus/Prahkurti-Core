import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/baseutitiles.dart';
import 'dailywrkdone_dpr_measurement.dart';
import 'materialList_popup.dart';

class DailyWork_done_DPR_Material extends StatefulWidget {
  const DailyWork_done_DPR_Material({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_Material> createState() =>
      _DailyWork_done_DPR_MaterialState();
}

class _DailyWork_done_DPR_MaterialState
    extends State<DailyWork_done_DPR_Material> {
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
      Get.put(DailyWrkDone_DPRNEW_Controller());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
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
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 25,
                        color: Colors.white),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "DPR - NEW (Material)",
                            style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: dailyWrkDone_DPRNEW_Controller
                                .dpr_new_Mat_NameController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Material Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.materialName),
                            ),
                            onTap: () async {
                              await dailyWrkDone_DPRNEW_Controller
                                  .getMaterialName();
                              bottomsheetControllers.MaterialName(
                                  context,
                                  dailyWrkDone_DPRNEW_Controller
                                      .MaterialApiList.value);
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
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onTap: () {
                                      if (dailyWrkDone_DPRNEW_Controller
                                                  .dpr_new_Mat_QtyController
                                                  .text ==
                                              "0" ||
                                          dailyWrkDone_DPRNEW_Controller
                                                  .dpr_new_Mat_QtyController
                                                  .text ==
                                              "0.0") {
                                        dailyWrkDone_DPRNEW_Controller
                                            .dpr_new_Mat_QtyController
                                            .text = "";
                                      }
                                    },
                                    controller: dailyWrkDone_DPRNEW_Controller
                                        .dpr_new_Mat_QtyController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Quantity",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.quantity),
                                    ),
                                    onChanged: (value) {},
                                    validator: (value) {
                                      if (value!.isEmpty || value == "0.0") {
                                        return '\u26A0 ${RequestConstant.VALIDATE}';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: dailyWrkDone_DPRNEW_Controller
                                        .dpr_new_Mat_ScaleController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Unit",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE,
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.unit,
                                      ),
                                    ),
                                    onChanged: (value) {},
                                    validator: (value) {
                                      if (value!.isEmpty || value == "UNIT") {
                                        return '\u26A0 ${RequestConstant.VALIDATE}';
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            width:
                                BaseUtitiles.getWidthtofPercentage(context, 25),
                            height:
                                BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (dailyWrkDone_DPRNEW_Controller
                                          .dpr_new_Mat_QtyController.text ==
                                      "0.0" ||
                                  dailyWrkDone_DPRNEW_Controller
                                          .dpr_new_Mat_QtyController.text ==
                                      "0" ||
                                  dailyWrkDone_DPRNEW_Controller
                                          .dpr_new_Mat_QtyController.text ==
                                      "" ||
                                  dailyWrkDone_DPRNEW_Controller
                                          .dpr_new_Mat_QtyController.text ==
                                      "00") {
                                BaseUtitiles.showToast(
                                    "Please Enter Qty value greater than 0");
                              } else {
                                dailyWrkDone_DPRNEW_Controller
                                    .dprNew_MaterialTableSave();
                                dailyWrkDone_DPRNEW_Controller
                                    .getMaterialTablesDatas();
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Mat_NameController
                                    .text = "--SELECT--";
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Mat_ScaleController.text = "UNIT";
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Mat_QtyController.text = "0.0";
                                dailyWrkDone_DPRNEW_Controller
                                    .matScaleId.value = 0;
                                dailyWrkDone_DPRNEW_Controller
                                    .selectedMatId.value = 0;
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    Obx(() => Listdetails()),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        if (dailyWrkDone_DPRNEW_Controller.saveButton.value ==
                            RequestConstant.APPROVAL) {
                          BaseUtitiles.showToast(
                              "In this approval page can't be reset");
                        } else {
                          ResetAlert(context);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DailyWork_done_DPR_Measurement()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Listdetails() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
      height: BaseUtitiles.getheightofPercentage(context, 65),
      child: ListView.builder(
        itemCount: dailyWrkDone_DPRNEW_Controller
            .dprNewGetMatreadListdata.value.length,
        itemBuilder: (BuildContext context, int index) {
          dailyWrkDone_DPRNEW_Controller.textMatInitiate();
          return Card(
            elevation: 5,
            color: Colors.white,
            margin: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 12,
                        child: Text(
                          dailyWrkDone_DPRNEW_Controller
                                  .dprNewGetMatreadListdata.value[index].Name
                                  .toString() +
                              " - " +
                              dailyWrkDone_DPRNEW_Controller
                                  .dprNewGetMatreadListdata.value[index].Scale
                                  .toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Alert!'),
                                  content: const Text('Do you want to Delete?'),
                                  actions: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE))),
                                            ),
                                            VerticalDivider(
                                              color: Colors.grey
                                                  .shade400, //color of divider
                                              width: 5, //width space of divider
                                              thickness:
                                                  2, //thickness of divier line
                                              indent:
                                                  15, //Spacing at the top of divider.
                                              endIndent:
                                                  15, //Spacing at the bottom of divider.
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      dailyWrkDone_DPRNEW_Controller
                                                          .deleteParticularList(
                                                              dailyWrkDone_DPRNEW_Controller
                                                                  .dprNewGetMatreadListdata
                                                                  .value[index]);
                                                      dailyWrkDone_DPRNEW_Controller
                                                          .dprNewGetMatreadListdata
                                                          .value
                                                          .removeAt(index);
                                                      dailyWrkDone_DPRNEW_Controller
                                                          .getMaterialTablesDatas();
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: RequestConstant
                                                              .Lable_Font_SIZE))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: ConstIcons.cancle

                            // child: Image.asset('assets/cancle.png'),
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 15, left: 5, right: 5, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 6,
                        child: Text(
                          "Quantity",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            height:
                                BaseUtitiles.getheightofPercentage(context, 4),
                            child: TextFormField(
                              onTap: () {
                                dailyWrkDone_DPRNEW_Controller
                                    .dpr_new_Mat_QtylistTextControllers[index]
                                    .text = "";
                              },
                              controller: dailyWrkDone_DPRNEW_Controller
                                  .dpr_new_Mat_QtylistTextControllers[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    5.0, 0.0, 5.0, 0.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                              onChanged: (value) {
                                dailyWrkDone_DPRNEW_Controller.MatclickEdit();
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Future.delayed(Duration(seconds: 0), () {
                            dailyWrkDone_DPRNEW_Controller
                                .dpr_new_Mat_NameController.text = "--SELECT--";
                            dailyWrkDone_DPRNEW_Controller
                                .dpr_new_Mat_ScaleController.text = "UNIT";
                            dailyWrkDone_DPRNEW_Controller
                                .dpr_new_Mat_QtyController.text = "0.0";
                            dailyWrkDone_DPRNEW_Controller.matScaleId.value = 0;
                            dailyWrkDone_DPRNEW_Controller.selectedMatId.value =
                                0;
                            dailyWrkDone_DPRNEW_Controller
                                .dprNew_MaterialTable_Delete();
                            dailyWrkDone_DPRNEW_Controller
                                .dprNewGetMatreadListdata.value = [];
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
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
