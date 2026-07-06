import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../../controller/dailyentries_controller.dart';
import '../../controller/dailywrk_done_dpr_controller.dart';
import '../../controller/dailywrk_done_dprnew_controller.dart';
import '../../controller/inward_pending_controller.dart';
import '../../controller/sitevoucher_controller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'camera_screen.dart';

class ImageGalleryPopup_Alert extends StatefulWidget {
  final String imageUrl;
  const ImageGalleryPopup_Alert({Key? key,required this.imageUrl}) : super(key: key);

  @override
  State<ImageGalleryPopup_Alert> createState() => _ImageGalleryPopup_AlertState();
}

class _ImageGalleryPopup_AlertState extends State<ImageGalleryPopup_Alert> {

  SiteVoucher_Controller siteVoucher_Controller =
  Get.put(SiteVoucher_Controller());
  DailyEntriesController dailyEntriesController =
  Get.put(DailyEntriesController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  InwardPending_Controller inwardPendingcontroller =
  Get.put(InwardPending_Controller());


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                height: BaseUtitiles.getheightofPercentage(context, 16),

                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Upload Photos",
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 20),
                            height: BaseUtitiles.getheightofPercentage(context, 8),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Icon(Icons.camera_alt,  color: Colors.white,size: 22,),
                                  ),
                                  Text("Camera", style: TextStyle(color: Colors.white,fontSize: 14),)
                                ],
                              ),

                            ),
                          ),
                          onTap: ()
                          {
                            if(widget.imageUrl == "SITE VOUCHER")
                            {
                              Get.back();

                              Get.to(() => CameraCapturePage(
                                fromScreen: "Site Voucher",
                              ));
                            }
                            else if(widget.imageUrl == "DLR")
                              {
                                Get.back();

                                Get.to(() => CameraCapturePage(
                                  fromScreen: "Subcontractor Attendance",
                                ));
                              }
                            else if(widget.imageUrl == "DPR")
                              {
                                Get.back();

                                Get.to(() => CameraCapturePage(
                                  fromScreen: "DPR",
                                ));
                              }
                            else if(widget.imageUrl == "DPR NEW")
                              {
                                Get.back(); // close dialog

                                Get.to(() => CameraCapturePage(
                                  fromScreen: "DPR-NEW",
                                ));
                              }
                            else if(widget.imageUrl == "Inward")
                              {
                                Get.back();

                                Get.to(() => CameraCapturePage(
                                  fromScreen: "Inward",
                                ));
                              }
                            else if(widget.imageUrl == "InwardButton")
                              {
                                Get.back();

                                Get.to(() => CameraCapturePage(
                                  fromScreen: "InwardAddButton",
                                ));
                              }
                          },

                        ),

                        InkWell(
                          child: Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 20),
                            height: BaseUtitiles.getheightofPercentage(context, 8),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.only(top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Icon(Icons.image,  color: Colors.white,size: 22,),
                                  ),

                                  Text("Gallery", style: TextStyle(color: Colors.white,fontSize: 14),)
                                ],
                              ),

                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            await pickImageFromGallery();

                          },

                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      final appDir = await getApplicationDocumentsDirectory();
      List<File> compressedImages = [];

      for (var file in pickedFiles) {
        final originalFile = File(file.path);
        final fileName ="${path.basenameWithoutExtension(file.path)}.jpg";

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          originalFile.path,
          '${appDir.path}/compressed_$fileName',
          quality: 80,
          minWidth: 1000,
          minHeight: 1000,
          format: CompressFormat.jpeg,
        );

        if (compressedFile != null) {
          final sizeKB = File(compressedFile.path).lengthSync() / 1024;
          print("📦 Compressed ${fileName}: ${sizeKB.toStringAsFixed(2)} KB");
          compressedImages.add(File(compressedFile.path));
        } else {
          print("⚠️ Compression failed for ${fileName}");
        }
      }

        if(widget.imageUrl == "SITE VOUCHER")
        {
          siteVoucher_Controller.imageFiles.addAll(compressedImages);
          siteVoucher_Controller.pickedImageCount.value += compressedImages.length;
        }
        else if(widget.imageUrl == "DLR")
          {
            dailyEntriesController.imageFiles.addAll(compressedImages);
            dailyEntriesController.pickedImageCount.value += compressedImages.length;
          }
        else if(widget.imageUrl == "DPR")
        {
          dailyWrkDone_DPR_Controller.imageFiles.addAll(compressedImages);
          dailyWrkDone_DPR_Controller.pickedImageCount.value += compressedImages.length;
        }
        else if(widget.imageUrl == "DPR NEW")
        {
          dailyWrkDone_DPRNEW_Controller.imageFiles.addAll(compressedImages);
          dailyWrkDone_DPRNEW_Controller.pickedImageCount.value += compressedImages.length;
        }
        else if(widget.imageUrl == "Inward" || widget.imageUrl == "InwardButton")
        {
          inwardPendingcontroller.imageFiles.addAll(compressedImages);
          inwardPendingcontroller.count.value += compressedImages.length;
          inwardPendingcontroller.checkImgList.value = true;
          print(
            "Image Count: ${inwardPendingcontroller.imageFiles.length}",
          );

          for (var img in inwardPendingcontroller.imageFiles) {
            print(img.path);
          }
        }
    } else {
      debugPrint('No images selected.');
    }
  }
}