import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/image_view.dart';
import '../../../../utilities/requestconstant.dart';
import '../../../punch_in_out/camera_screen.dart';

class Inward_Itemlist extends StatefulWidget {
  const Inward_Itemlist({Key? key}) : super(key: key);

  @override
  State<Inward_Itemlist> createState() => _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site extends State<Inward_Itemlist> {
  InwardPending_Controller inwardPendingcontroller =
      Get.put(InwardPending_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // always dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Items",
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
                const SizedBox(height: 20),
                Obx(() => inwardPendingcontroller.checkImgList.value == true
                    ? Container(
                        margin: EdgeInsets.all(8.r),
                        height: 150.h,
                        child: inwardPendingcontroller.saveButton.value ==
                                RequestConstant.RESUBMIT
                            ? netWorkImageList()
                            : imageList(),
                      )
                    : InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.r),
                          child: CircleAvatar(
                            backgroundColor: const Color(0XFFeff9fb),
                            radius: 70.r,
                            child: Image.asset(
                              "assets/images/camera.png",
                              height: 80.h,
                              width: 80.w,
                            ),
                          ),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CameraCapturePage(
                                      fromScreen: "Inward",
                                    )),
                          );
                        },
                      )),
                listDetails(),
                SizedBox(height: 20.r)
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50.h,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setState) => InkWell(
                            onTap: () async {
                              var inwardQtyNonNullableList = <double>[];

                              for (int i = 0;
                                  i <
                                      inwardPendingcontroller
                                          .Itemlist_Inward_QtyListController
                                          .length;
                                  i++) {
                                var itemText = inwardPendingcontroller
                                    .Itemlist_Inward_QtyListController[i].text;

                                if (itemText != null && itemText.isNotEmpty) {
                                  var parsedValue = double.tryParse(itemText);

                                  if (parsedValue != null) {
                                    inwardQtyNonNullableList.add(parsedValue);
                                  }
                                }
                              }

                              if (inwardQtyNonNullableList
                                  .any((value) => value > 0)) {
                                if (inwardPendingcontroller.projectId == 0) {
                                  BaseUtitiles.showToast(
                                      "Please select Project Name");
                                } else if (inwardPendingcontroller.siteId ==
                                    0) {
                                  BaseUtitiles.showToast(
                                      "Please select Site Name");
                                } else if (inwardPendingcontroller
                                        .saveButton.value ==
                                    RequestConstant.RESUBMIT) {
                                  if (inwardPendingcontroller
                                              .netWorkImageCount ==
                                          0 &&
                                      inwardPendingcontroller.count == 0) {
                                    BaseUtitiles.showToast("Please add image");
                                  } else {
                                    if (await BaseUtitiles
                                        .checkNetworkAndShowLoader(context)) {
                                      await inwardPendingcontroller
                                          .getItemlistTablesDatas();
                                      await inwardPendingcontroller
                                          .Save_EntryScreen(context,
                                              inwardPendingcontroller.inwardID);
                                    }
                                  }
                                } else if (inwardPendingcontroller
                                            .saveButton.value ==
                                        RequestConstant.RESUBMIT &&
                                    inwardPendingcontroller.count == 0) {
                                  BaseUtitiles.showToast("Please add image");
                                } else {
                                  if (await BaseUtitiles
                                      .checkNetworkAndShowLoader(context)) {
                                    await inwardPendingcontroller
                                        .getItemlistTablesDatas();
                                    await inwardPendingcontroller
                                        .Save_EntryScreen(context, 0);
                                  }
                                }
                              } else {
                                BaseUtitiles.showToast(
                                    "Inward qty should not be zero(0) or empty");
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 25),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                inwardPendingcontroller.saveButton.value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listDetails() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 5),
          height: BaseUtitiles.getheightofPercentage(context, 57),
          child: Obx(
            () => Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 6, // reduce the thickness to make thumb smaller
              radius: Radius.circular(5),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                itemCount: inwardPendingcontroller.ItemGetTableListdata.length,
                itemBuilder: (BuildContext context, int index) {
                  inwardPendingcontroller.itemlist_textControllersInitiate();
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(left: 3, right: 3),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 66),
                                      child: Text(
                                        "${inwardPendingcontroller.ItemGetTableListdata[index].materialName} (${inwardPendingcontroller.ItemGetTableListdata[index].unit})",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    // Checkbox(
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0),),
                                    //     side: MaterialStateBorderSide.resolveWith(
                                    //           (states) => BorderSide(
                                    //         width: 1.0,
                                    //         // color: Colors.white
                                    //         color: Theme.of(context).primaryColor,
                                    //       ),
                                    //     ),
                                    //     checkColor: Colors.white,
                                    //     activeColor: Theme.of(context).primaryColor,
                                    //     value: inwardPendingcontroller.ischecked![index],
                                    //     onChanged: (val) {
                                    //       setState(() {
                                    //
                                    //         if(double.parse(inwardPendingcontroller.Itemlist_Qty_PlusListController[index].text) > 0.0 ){
                                    //
                                    //         }else{
                                    //           inwardPendingcontroller.ischecked![index] = val!;
                                    //           inwardPendingcontroller.updateItemlistTable();
                                    //         }
                                    //
                                    //       });
                                    //     }),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, bottom: 4),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "PO Qty",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          inwardPendingcontroller
                                              .ItemGetTableListdata[index].poQty
                                              .toString(),
                                        )),
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Bal Qty",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text(
                                          inwardPendingcontroller
                                              .ItemGetTableListdata[index]
                                              .balQty
                                              .toString(),
                                        ))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Rate",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          inwardPendingcontroller
                                              .ItemGetTableListdata[index].rate
                                              .toString(),
                                        )),
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Inward Qty",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 11),
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                                  context, 4),
                                          child: TextFormField(
                                            onTap: () {
                                              if (inwardPendingcontroller
                                                          .Itemlist_Inward_QtyListController[
                                                              index]
                                                          .text !=
                                                      "" &&
                                                  inwardPendingcontroller
                                                          .Itemlist_Inward_QtyListController[
                                                              index]
                                                          .text !=
                                                      "0" &&
                                                  inwardPendingcontroller
                                                          .Itemlist_Inward_QtyListController[
                                                              index]
                                                          .text !=
                                                      "0.0") {
                                                return;
                                              } else {
                                                inwardPendingcontroller
                                                    .Itemlist_Inward_QtyListController[
                                                        index]
                                                    .text = "";
                                              }
                                            },
                                            cursorColor:
                                                Theme.of(context).primaryColor,
                                            textAlign: TextAlign.center,
                                            controller: inwardPendingcontroller
                                                    .Itemlist_Inward_QtyListController[
                                                index],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                inwardPendingcontroller.editClick(
                                                    inwardPendingcontroller
                                                        .ItemGetTableListdata[
                                                            index]
                                                        .id);
                                                // inwardPendingcontroller.updateItemlistTable();
                                              });
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Qty ++",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 11),
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                                  context, 4),
                                          child: TextField(
                                            readOnly: true,
                                            cursorColor:
                                                Theme.of(context).primaryColor,
                                            textAlign: TextAlign.center,
                                            controller: inwardPendingcontroller
                                                    .Itemlist_Qty_PlusListController[
                                                index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        )),
                                    const Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Qty --",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 11, left: 8),
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                                  context, 4),
                                          child: TextField(
                                            readOnly: true,
                                            cursorColor:
                                                Theme.of(context).primaryColor,
                                            textAlign: TextAlign.center,
                                            controller: inwardPendingcontroller
                                                    .Itemlist_Qty_MinusListController[
                                                index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageList() {
    return SizedBox(
      height: 200.h,
      width: ScreenUtil().screenWidth,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: inwardPendingcontroller.count.value + 1,
            itemBuilder: (context, index) {
              if (index < inwardPendingcontroller.count.value) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageViewPage(
                                  imagePath:
                                      inwardPendingcontroller.imageFiles[index],
                                  netUrl: false,
                                )));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.r, right: 8.r, bottom: 16.r),
                        child: Material(
                          color: Colors.white,
                          elevation: 1.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.all(8.r),
                            child: SizedBox(
                              height: 150.h,
                              width: 120.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                    inwardPendingcontroller.imageFiles[index],
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 50.h,
                        width: 50.h,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              inwardPendingcontroller.imageFiles.remove(
                                  inwardPendingcontroller.imageFiles[index]);
                              inwardPendingcontroller.count =
                                  inwardPendingcontroller.count! - 1;
                            });
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (inwardPendingcontroller.count! == 0) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: CircleAvatar(
                      backgroundColor: const Color(0XFFeff9fb),
                      radius: 70.r,
                      child: Image.asset(
                        "assets/images/camera.png",
                        height: 80.h,
                        width: 80.w,
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraCapturePage(
                                fromScreen: "Inward",
                              )),
                    );
                    // setState(() {
                    //   inwardPendingcontroller.checkImgList.value = true;
                    // });
                    // await getImage(ImageSource.camera);
                  },
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(left: 16.4, bottom: 24.r),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CameraCapturePage(
                                    fromScreen: "InwardAddButton",
                                  )));
                      // await getImage(ImageSource.camera);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget netWorkImageList() {
    return SizedBox(
      height: 200.h,
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Obx(() {
          final networkCount =
              inwardPendingcontroller.gettingNetworkImageList.length;
          final pickedCount = inwardPendingcontroller.imageFiles.length;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: networkCount + pickedCount + 1,
            itemBuilder: (context, index) {
              /// NETWORK IMAGE
              if (index < networkCount) {
                return buildNetworkImageItem(index);
              }

              /// PICKED IMAGE
              if (index < networkCount + pickedCount) {
                final pickedIndex = index - networkCount;
                return buildPickedImageItem(pickedIndex);
              }

              /// CAMERA / ADD BUTTON
              if (networkCount == 0 && pickedCount == 0) {
                return InkWell(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.r, left: 100.r),
                      child: CircleAvatar(
                        backgroundColor: const Color(0XFFeff9fb),
                        radius: 70.r,
                        child: Image.asset(
                          "assets/images/camera.png",
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraCapturePage(
                                  fromScreen: "Inward",
                                )));
                  },
                );
              }
              return buildAddImageButton();
            },
          );
        }),
      ),
    );
  }

  Widget buildNetworkImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewPage(
                      imageUrl:
                          "${inwardPendingcontroller.gettingNetworkImageList[index].toString()}?time=${DateTime.now().millisecondsSinceEpoch}",
                      netUrl: true,
                    )));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "${inwardPendingcontroller.gettingNetworkImageList[index].toString()}?time=${DateTime.now().millisecondsSinceEpoch}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 50.h,
            width: 50.h,
            child: GestureDetector(
              onTap: () async {
                final imageId = inwardPendingcontroller.imageId[index];

                final isDeleted = await inwardPendingcontroller.deletingImage(imageId);

                if (isDeleted) {
                  inwardPendingcontroller.gettingNetworkImageList
                      .removeAt(index);
                  inwardPendingcontroller.imageId.removeAt(index);

                  if (inwardPendingcontroller.gettingNetworkImageList.isEmpty &&
                      inwardPendingcontroller.imageFiles.isEmpty) {
                    inwardPendingcontroller.checkImgList.value = false;
                  }
                }
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPickedImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageViewPage(
              imagePath: inwardPendingcontroller.imageFiles[index],
              netUrl: false,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      inwardPendingcontroller.imageFiles[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// DELETE BUTTON
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                inwardPendingcontroller.imageFiles.removeAt(index);

                if (inwardPendingcontroller.imageFiles.isEmpty &&
                    inwardPendingcontroller.gettingNetworkImageList.isEmpty) {
                  inwardPendingcontroller.checkImgList.value = false;
                }
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddImageButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16.4, bottom: 24.r),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CameraCapturePage(
                        fromScreen: "InwardAddButton",
                      )));
          // await getImage(ImageSource.camera);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }
}
