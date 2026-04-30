// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class UpdateScreen extends StatefulWidget {
//   const UpdateScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateScreen> createState() => _UpdateScreenState();
// }
//
// class _UpdateScreenState extends State<UpdateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("MCR Construction"),
//         leading: IconButton(
//           icon: const Icon(
//               Icons.arrow_back_ios), // You can use any icon you want here
//           onPressed: () {
//             exit(0);
//           },
//         ),
//         backgroundColor: Theme.of(context).primaryColor
//       ),
//       body: Container(
//         height: ScreenUtil().screenHeight,
//         width: ScreenUtil().screenWidth,
//         margin: EdgeInsets.all(14.r),
//         child: Column(
//           children: [
//             Container(
//               child: Platform.isAndroid
//                   ? Image.asset('assets/mobial.gif')
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 100.h,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                                 margin: EdgeInsets.only(bottom: 14.r),
//                                 height: 100,
//                                 width: 100,
//                                 child: Image.asset(
//                                   'assets/appstore.png',
//                                 )),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(bottom: 14.r),
//                           alignment: Alignment.centerLeft,
//                           child: const Text(
//                             "Update your application to the Latest version",
//                             style: TextStyle(
//                                 fontSize: 32, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(bottom: 14.r),
//                           alignment: Alignment.centerLeft,
//                           child: const Text(
//                             "A new version is available in the App Store.\nPlease update your app to use all of our features.",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 if (Platform.isAndroid) {
//                   launch(
//                       'https://play.google.com/store/apps/details?id=com.veenus.mcr');
//                 } else if (Platform.isIOS) {
//                   launch(
//                       'https://apps.apple.com/us/app/mcr-construction/id6482231892');
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(32.0),
//                   ),
//                   backgroundColor: Theme.of(context).primaryColor,
//                   minimumSize: const Size(150, 40),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   textStyle: const TextStyle(fontWeight: FontWeight.bold)),
//               child: const Text('UPDATE  APP'),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//       // ),
//     );
//   }
// }
