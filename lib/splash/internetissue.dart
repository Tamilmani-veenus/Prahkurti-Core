import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prahkurticore/splash/splash.dart';
import 'package:permission_handler/permission_handler.dart';

import '../login/animation_signinpage/signin_page.dart';

///-----------Lost net connection------------


class InternetLostConnection extends StatefulWidget {
  const InternetLostConnection({super.key});

  @override
  State<InternetLostConnection> createState() => _InternetLostConnectionState();
}

class _InternetLostConnectionState extends State<InternetLostConnection> {

  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool? _isConnectionSuccessful;


  @override
  initState() {
    super.initState();
    var duration = const Duration(seconds: 2);
    Future.delayed(duration,() async {
      SignInPage.checkVersion(context);
      final ConnectivityResult result = await Connectivity().checkConnectivity();
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        print('Current connectivity status: $result');
        setState(() {
          _connectivityResult = result;
        });
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prahkurti Constructions"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // You can use any icon you want here
          onPressed: () {
            exit(0);
          },
        ),
        backgroundColor: const Color(0xFF09a3f3),
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        width:  ScreenUtil().screenWidth,
        color: Colors.white,

        child: Column(
          children: [
            SizedBox(height:100.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/lostnetwork.png'),
              ],
            ),
            Container(
              margin: EdgeInsets.all(4.r),
              child: const Text("Oops! No Network Connection", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),

            const Text("Please check your internet connection...!", ),
            SizedBox(height:50.h,),
            // const Spacer(),
            ElevatedButton(
              onPressed: () {
                if( _connectivityResult == ConnectivityResult.wifi || _connectivityResult == ConnectivityResult.mobile){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Splash()));
                }else{
                  openAppSettings();
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  // backgroundColor: Theme.of(context).primaryColor,
                  backgroundColor: const Color(0xFF09a3f3), // Use the color #09a3f3
                  minimumSize: const Size(150, 40),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text('Try Again'),
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
