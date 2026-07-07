import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:prahkurticore/splash/splash.dart';
import 'package:permission_handler/permission_handler.dart';

import '../login/animation_signinpage/signin_page.dart';
import '../utilities/baseutitiles.dart';

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
      body: Container(
        height: ScreenUtil().screenHeight,
        width:  ScreenUtil().screenWidth,
        color: Colors.white,

        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/No internet.json',
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                  frameRate: FrameRate.max,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(4.r),
              child: const Text("Oops! No Network Connection", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            ),
            SizedBox(height: 10,),
            const Text("Please check your internet connection...!", ),
            SizedBox(height:50.h,),
            // const Spacer(),
            ElevatedButton(
              onPressed: () {
                if( _connectivityResult == ConnectivityResult.wifi || _connectivityResult == ConnectivityResult.mobile){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Splash()));
                }else{
                  BaseUtitiles.showToast(
                      "Still no internet connection");
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  backgroundColor: Colors.blue.shade600,
                  minimumSize: const Size(150, 40),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh,color: Colors.white,),
                  const Text('  Try Again'),
                ],
              ),
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
