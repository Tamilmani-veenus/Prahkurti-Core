import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/splash/connectivity_service.dart';
import 'package:upgrader/upgrader.dart';
import 'package:prahkurticore/signalr_service.dart';
import 'package:prahkurticore/utilities/apiconstant.dart';
import '../splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/theme_bloc/theme_bloc.dart';
import 'app_theme/theme_bloc/theme_state.dart';
import 'constants/storage_constant.dart';
import 'home/dashboard/common_binding.dart';
import 'notificationservice/local_notification_service.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title.toString());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppClient.init();
  print("Package Name: ${AppClient.packageName}");
  await ApiConfig.initializeUrl();
  await Upgrader.clearSavedSettings();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);
  await SessionStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBDxxoNWh74liPyUbFhkVeP87TWfLse87I",
          appId: "1:444764150959:android:e13649f58b191cb63d485a",
          messagingSenderId: "444764150959",
          projectId: "prahkurti-72eac"));
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  await Get.putAsync(() async => ConnectivityService());
  runApp(const StartApp());
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});


  @override
  State<StatefulWidget> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {

  @override
  void initState() {
    super.initState();

    /// Start SignalR after UI is ready
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3)); // ⏳ delay 3 seconds
      SignalRService().startConnection();
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print("FirebaseMessaging.onMessage.listen");
      }
      if (message.notification != null) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
      }
      if (message.notification != null) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        if (kDebugMode) {
          print("Message ${message.data['_id']}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(ThemeState(themeData: appThemeData[AppTheme.DeepPurpleAccent])),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }


  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: "Prahkurti Constructions",
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: state.themeData,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      initialBinding: CommonBinding(),
    );
  }
}
