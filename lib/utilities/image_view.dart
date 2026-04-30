import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageViewPage extends StatefulWidget {
  final String? imageUrl;
  final File? imagePath;
  final bool? netUrl;
  const ImageViewPage(
      {super.key, this.imageUrl, this.imagePath, this.netUrl});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black, // Specify your desired color
            ),
          ),
          title: const Text("Image View",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          centerTitle: true),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: InteractiveViewer(
            panEnabled: false,
            maxScale: 10,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            child: widget.netUrl == true
                ? Image.network(widget.imageUrl!)
                : Image.file(
                    widget.imagePath!,
                  ),
          ),
        ),
      ),
    );
  }
}
