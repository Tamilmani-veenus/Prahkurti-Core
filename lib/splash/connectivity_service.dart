import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'internetissue.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  void onInit() {
    super.onInit();

    _subscription = _connectivity.onConnectivityChanged.listen(
          (ConnectivityResult result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          print("Internet Connected");

          // Close InternetLostConnection screen if it's open
          if (Get.currentRoute == "/InternetLostConnection") {
            Get.back();
          }
        } else {
          print("Internet Disconnected");

          if (Get.currentRoute != "/InternetLostConnection") {
            Get.to(
                  () => const InternetLostConnection(),
              routeName: "/InternetLostConnection",
            );
          }
        }
      },
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}