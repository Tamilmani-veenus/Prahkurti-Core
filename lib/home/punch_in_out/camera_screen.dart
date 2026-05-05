import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controller/dailyentries_controller.dart';
import '../../controller/dailywrk_done_dpr_controller.dart';
import '../../controller/inward_pending_controller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/sitevoucher_controller.dart';
import '../../utilities/baseutitiles.dart';
import 'package:image/image.dart' as img;

class CameraCapturePage extends StatefulWidget {
  final String fromScreen;
  const CameraCapturePage({Key? key,required this.fromScreen}) : super(key: key);

  @override
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> with WidgetsBindingObserver {
  PunchInController punchInController = Get.put(PunchInController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());
  InwardPending_Controller inwardPendingcontroller = Get.put(InwardPending_Controller());
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  bool initial = false;
  int? newlyAddedIndex;
  bool _isCameraBusy = false;
  bool isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissionAndInitCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      await _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<File> addWatermark(File originalFile, {required bool flip}) async {
    final bytes = await originalFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    if (image == null) return originalFile;

    // 🔁 FIX MIRROR (Samsung front camera)
    if (flip) {
      image = img.flipHorizontal(image);
    }

    // 🖊️ Add watermark
    img.drawString(
      image,
      img.arial_48,
      450,
      1400,
      punchInController.networkTime!,
      color: img.getColor(255, 255, 255),
    );

    final newPath = originalFile.path.replaceFirst('.jpg', '_wm.jpg');
    final newFile = File(newPath)
      ..writeAsBytesSync(img.encodeJpg(image, quality: 90));

    return newFile;
  }

  Future<void> _checkPermissionAndInitCamera() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      await _initCamera();
    } else {
      if (mounted) {
        BaseUtitiles.showToast("Camera permission is required");
        Navigator.pop(context);
      }
    }
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    punchInController.getNetworkTime();

    final selectedCamera = cameras[selectedCameraIndex];
    isFrontCamera = selectedCamera.lensDirection == CameraLensDirection.front;

    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  void _switchCamera() async {
    if (cameras.length < 2) return; // Only one camera available

    selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;

    await _controller?.dispose();
    _initCamera();
  }

  Future<void> takePicture() async {
    if (_isCameraBusy) return;

    setState(() => _isCameraBusy = true);

    try {
      await _initializeControllerFuture;
      await _controller!.setFlashMode(FlashMode.off);

      final image = await _controller!.takePicture();

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final originalFile = File(image.path);

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        '${appDir.path}/$fileName',
        quality: 80,
        minWidth: 1000,
        minHeight: 1000,
      );


      if (compressedFile == null) {
        debugPrint('Compression failed.');
        return;
      }

      final watermarkedFile = await addWatermark(
        File(compressedFile.path),
        flip: isFrontCamera,
      );

      setState(() {
        initial = true;
        if(widget.fromScreen=="Punch In"){
          punchInController.isSelect.value = true;
          punchInController.imageFile.value = XFile(watermarkedFile.path);
        }
        else if(widget.fromScreen=="Punch Out"){
          punchInController.isSelect.value = true;
          punchInController.punchOutImageFile.value = XFile(watermarkedFile.path);
        }
        else if(widget.fromScreen=="Subcontractor Attendance"){
          dailyEntriesController.imageFiles.add(watermarkedFile);
          newlyAddedIndex = dailyEntriesController.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="DPR"){
          dailyWrkDone_DPR_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = dailyWrkDone_DPR_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="Site Voucher"){
          siteVoucher_Controller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = siteVoucher_Controller.imageFiles.length - 1;
        }
        else if(widget.fromScreen=="Inward"){
          inwardPendingcontroller.checkImgList.value = true;
          inwardPendingcontroller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
          inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
          inwardPendingcontroller.pickedImageCount.value++;
        }
        else if(widget.fromScreen=="InwardAddButton"){
          inwardPendingcontroller.imageFiles.add(watermarkedFile);
          newlyAddedIndex = inwardPendingcontroller.imageFiles.length - 1;
          inwardPendingcontroller.count = inwardPendingcontroller.count + 1;
          inwardPendingcontroller.pickedImageCount.value++;
        }
      });
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
    finally {
      setState(() => _isCameraBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return SizedBox( );
    }

    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
        if (widget.fromScreen == "Punch In") {
          punchInController.isSelect.value = false;
          punchInController.imageFile.value = null;
        }
        else if (widget.fromScreen == "Punch Out") {
          punchInController.isSelect.value = false;
          punchInController.punchOutImageFile.value = null;
        }
        else if (widget.fromScreen == "Subcontractor Attendance" && newlyAddedIndex != null) {
          dailyEntriesController.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "DPR" && newlyAddedIndex != null) {
          dailyWrkDone_DPR_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Site Voucher" && newlyAddedIndex != null) {
          siteVoucher_Controller.imageFiles.removeAt(newlyAddedIndex!);
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Inward"  && newlyAddedIndex != null ) {
          inwardPendingcontroller.checkImgList.value = false;
          inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
          inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
          inwardPendingcontroller.pickedImageCount.value--;
          newlyAddedIndex = null;
        }
        else if (widget.fromScreen == "Inward"  && newlyAddedIndex == null ) {
          inwardPendingcontroller.checkImgList.value = false;
        }
        else if ( widget.fromScreen == "InwardAddButton"  && newlyAddedIndex != null ) {
          inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
          inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
          inwardPendingcontroller.pickedImageCount.value--;
          newlyAddedIndex = null;
        }
        return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("Camera"),
          ),
          body: Column(
            children: [
              if (initial == false)
                Column(
                  children: [
                    Container(
                      height: BaseUtitiles.getheightofPercentage(context, 65),
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: FutureBuilder(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _controller!.value.previewSize!.height,
                                height: _controller!.value.previewSize!.width,
                                child: CameraPreview(_controller!),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 4,
                            ),
                            onPressed: _isCameraBusy ? null : takePicture, // 🔒 disable tap
                            child: _isCameraBusy
                                ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Icon(Icons.camera_alt, size: 24),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),                  // makes it round
                              padding: const EdgeInsets.all(18),            // controls size
                              backgroundColor: Colors.black,
                              elevation: 4,
                            ),
                            onPressed: _isCameraBusy ? null : _switchCamera,
                            child: const Icon(Icons.flip_camera_ios_sharp, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if(initial == true )...{
                if ((widget.fromScreen == "Punch In" && punchInController.imageFile.value != null) ||
                    (widget.fromScreen == "Punch Out" && punchInController.punchOutImageFile.value != null) ||
                    (widget.fromScreen == "Subcontractor Attendance" && dailyEntriesController.imageFiles != null) ||
                    (widget.fromScreen == "DPR" && dailyWrkDone_DPR_Controller.imageFiles.isNotEmpty) ||
                    (widget.fromScreen == "Site Voucher" && siteVoucher_Controller.imageFiles.isNotEmpty) ||
                    ((widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton" ) && inwardPendingcontroller.imageFiles.isNotEmpty))

              Column(
                    children: [
                      Builder(builder: (_) {
                        XFile? selectedImage;

                        if (widget.fromScreen == "Punch In") {
                          selectedImage = punchInController.imageFile.value;
                        }
                        else if (widget.fromScreen == "Punch Out") {
                          selectedImage = punchInController.punchOutImageFile.value;
                        }
                        else if(widget.fromScreen == "Subcontractor Attendance") {
                          if (dailyEntriesController.imageFiles.isNotEmpty) {
                            selectedImage = XFile(dailyEntriesController.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "DPR") {
                          if (dailyWrkDone_DPR_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(dailyWrkDone_DPR_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "Site Voucher") {
                          if (siteVoucher_Controller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(siteVoucher_Controller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        else if(widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton") {
                          if (inwardPendingcontroller.imageFiles.isNotEmpty) {
                            selectedImage = XFile(inwardPendingcontroller.imageFiles.last.path); // ✔ safe
                          }
                        }
                        if (selectedImage == null) {
                          return const SizedBox();
                        }
                        return Container(
                          height: BaseUtitiles.getheightofPercentage(
                              context, 65),
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.file(
                              File(selectedImage.path),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: MediaQuery
                          .sizeOf(context)
                          .height * 0.05,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor, // 🔹 Button background color
                            ),
                            onPressed: () {
                              setState(() {
                                initial = false;
                                if (widget.fromScreen == "Punch In"){
                                  punchInController.imageFile.value = null;
                                }
                                else if (widget.fromScreen == "Punch Out"){
                                  punchInController.punchOutImageFile.value = null;
                                }
                                else if (widget.fromScreen == "Subcontractor Attendance" && newlyAddedIndex != null) {
                                  dailyEntriesController.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if (widget.fromScreen == "DPR" && newlyAddedIndex != null) {
                                  dailyWrkDone_DPR_Controller.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if (widget.fromScreen == "Site Voucher" && newlyAddedIndex != null) {
                                  siteVoucher_Controller.imageFiles.removeAt(newlyAddedIndex!);
                                  newlyAddedIndex = null;
                                }
                                else if ((widget.fromScreen == "Inward" || widget.fromScreen == "InwardAddButton" ) && newlyAddedIndex != null) {
                                  inwardPendingcontroller.imageFiles.removeAt(newlyAddedIndex!);
                                  inwardPendingcontroller.count = inwardPendingcontroller.count - 1;
                                  inwardPendingcontroller.pickedImageCount.value--;
                                  newlyAddedIndex = null;
                                }
                              });
                              _initCamera();
                            },
                            child: const Text("Retry"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context, "Camera");
                              });
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ],
                  ),
              },
        
              if (cameras.length > 1 && initial == false)
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios_sharp),
                  onPressed: _switchCamera,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
