import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:prahkurticore/utilities/apiconstant.dart';
import 'package:ntp/ntp.dart';
import 'main.dart';

// ─────────────────────────────────────────────
//  SERVICE
// ─────────────────────────────────────────────

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  factory SignalRService() => _instance;
  SignalRService._internal();

  HubConnection? hubConnection;
  Timer? countdownTimer;

  ValueNotifier<bool> isMaintenance       = ValueNotifier(false);
  ValueNotifier<int>  secondsLeftNotifier = ValueNotifier(0);
  ValueNotifier<bool> showCenterPopup     = ValueNotifier(false);
  ValueNotifier<bool> showFloatingWidget  = ValueNotifier(false);
  ValueNotifier<bool> freezeScreen        = ValueNotifier(false);

  int totalDurationSeconds = 0;

  // ── LOCAL TEST ───────────────────────────────
  void startLocalMaintenanceTest() {
    handlePayload({"isMaintenance": true, "durationMinutes": 1});
  }

  void stopLocalMaintenanceTest() {
    handlePayload({"isMaintenance": false, "durationMinutes": 0});
  }

  // ── SIGNALR CONNECTION ───────────────────────
  Future<void> startConnection() async {
    hubConnection = HubConnectionBuilder()
        .withUrl("${ApiConfig.APIURL_CORE}maintenanceHub")
        .build();

    hubConnection!.on("MaintenanceStatus", (arguments) {
      print("================================");
      print("MaintenanceStatus received");
      print("Arguments: $arguments");
      print("Type: ${arguments.runtimeType}");

      if (arguments is List && arguments.isNotEmpty) {
        handlePayload(arguments.first);
      } else {
        handlePayload(arguments);
      }

      print("================================");
    });

    hubConnection!.onclose((error) {
      print("SignalR closed: $error");
      Future.delayed(const Duration(seconds: 5), () => startConnection());
    });

    try {
      await hubConnection!.start();
      print("SignalR connected");
    } catch (e) {
      print("SignalR error: $e");
      Future.delayed(const Duration(seconds: 5), () => startConnection());
    }
  }
  // ── PAYLOAD HANDLER ──────────────────────────
  Future<void> handlePayload(
      dynamic payload, {
        bool isLiveEvent = false,
      }) async {
    final bool isMaint = payload["isMaintenance"] ?? false;
    final int durationMinutes = payload["durationMinutes"] ?? 0;
    // ── MAINTENANCE OFF ──
    if (!isMaint) {
      _resetAll();
      return;
    }

    // Reset UI state
    showCenterPopup.value = false;
    showFloatingWidget.value = false;
    freezeScreen.value = false;
    isMaintenance.value = true;

    int remainingSeconds = 0;

    // ── LIVE SIGNALR EVENT ──
    if (isLiveEvent) {
      remainingSeconds = durationMinutes * 60;
      Get.snackbar(
        "Debug",
        "isLiveEvent=$isLiveEvent\nremaining=$remainingSeconds",
        duration: const Duration(seconds: 8),
      );
      print("Live maintenance event -> starting full countdown: $remainingSeconds sec");
    }

    // ── APP REOPEN / INITIAL LOAD ──

    else {
    if (payload["updatedAt"] != null) {
    try {
    final rawUpdatedAt = payload["updatedAt"];
    // Parse directly, trust server format
    final updatedAt = DateTime.parse(rawUpdatedAt).toUtc();

    // ✅ Use global time instead of device clock
    final now = await NTP.now(); // returns UTC DateTime

    final deadline = updatedAt.add(Duration(minutes: durationMinutes));
    remainingSeconds = deadline.difference(now).inSeconds;

    if (remainingSeconds < 0) remainingSeconds = 0;
    final maxSeconds = durationMinutes * 60;
    if (remainingSeconds > maxSeconds) remainingSeconds = maxSeconds;

    } catch (e) {
    print("Date parse error: $e");
    remainingSeconds = durationMinutes * 60;
    }
    } else {
    // fallback if updatedAt missing
    remainingSeconds = durationMinutes * 60;
    }
    }

    // Show overlay
    MaintenanceOverlay.show();

    await Future.delayed(const Duration(milliseconds: 300));

    if (remainingSeconds <= 0) {
      countdownTimer?.cancel();
      showCenterPopup.value = false;
      showFloatingWidget.value = false;
      freezeScreen.value = true;
      return;
    }

    showCenterPopup.value = true;
    startCountdown(remainingSeconds);

    await Future.delayed(const Duration(seconds: 3));

    if (isMaintenance.value &&
        !freezeScreen.value &&
        secondsLeftNotifier.value > 0) {
      showCenterPopup.value = false;
      showFloatingWidget.value = true;
    }
  }

  void startCountdown(int totalSeconds) {
    // Stop any previous countdown
    countdownTimer?.cancel();

    if (totalSeconds <= 0) {
      secondsLeftNotifier.value = 0;
      showCenterPopup.value = false;
      showFloatingWidget.value = false;
      freezeScreen.value = true;
      return;
    }

    totalDurationSeconds = totalSeconds;
    secondsLeftNotifier.value = totalSeconds;

    print("startCountdown called with $totalSeconds seconds");

    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (secondsLeftNotifier.value <= 0) {
          timer.cancel();
          return;
        }

        final next = secondsLeftNotifier.value - 1;
        secondsLeftNotifier.value = next;

        if (next <= 0) {
          secondsLeftNotifier.value = 0;
          showCenterPopup.value = false;
          showFloatingWidget.value = false;
          freezeScreen.value = true;

          timer.cancel();

          print("Maintenance countdown completed");
        }
      },
    );
  }

  void stopCountdown() => countdownTimer?.cancel();

  // ── RESTORE FLOATING ─────────────────────────
  void restoreFloatingIfNeeded() {
    if (isMaintenance.value &&
        !freezeScreen.value &&
        !showCenterPopup.value &&
        secondsLeftNotifier.value > 0) {
      showFloatingWidget.value = true;
    }
  }

  // ── RESET ALL ────────────────────────────────
  void _resetAll() {
    stopCountdown();
    isMaintenance.value      = false;
    showCenterPopup.value    = false;
    showFloatingWidget.value = false;
    freezeScreen.value       = false;
    secondsLeftNotifier.value = 0;
    MaintenanceOverlay.hide();
  }

  // ── CONNECTION HELPERS ───────────────────────
  bool isSignalRConnected() =>
      hubConnection?.state == HubConnectionState.Connected;

  Future<void> stopConnection() async {
    stopCountdown();
    await hubConnection?.stop();
  }
}

// ─────────────────────────────────────────────
//  OVERLAY MANAGER
// ─────────────────────────────────────────────

class MaintenanceOverlay {
  static OverlayEntry? _entry;

  static void show([int retry = 0]) {
    if (_entry != null) return;

    Future.delayed(Duration.zero, () {
      final overlayState = navigatorKey.currentState?.overlay;

      if (overlayState == null) {
        if (retry < 10) {
          Future.delayed(
            const Duration(milliseconds: 300),
                () => show(retry + 1),
          );
        }
        return;
      }

      _entry = OverlayEntry(
        builder: (_) => const _MaintenanceOverlayContent(),
      );

      overlayState.insert(_entry!);

      print("MaintenanceOverlay: inserted");
    });
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
    print("MaintenanceOverlay: removed");
  }
}

// ─────────────────────────────────────────────
//  OVERLAY ROOT  (owns all three layers)
// ─────────────────────────────────────────────

class _MaintenanceOverlayContent extends StatelessWidget {
  const _MaintenanceOverlayContent();

  @override
  Widget build(BuildContext context) {
    final service = SignalRService();

    return ValueListenableBuilder<bool>(
      valueListenable: service.freezeScreen,
      builder: (context, freeze, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: service.showCenterPopup,
          builder: (context, showPopup, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: service.showFloatingWidget,
              builder: (context, showFloating, _) {

                return Stack(
                  children: [

                    // ── BACKGROUND BLOCKER ──
                    // Only block full screen when popup or freeze is active
                    // When ONLY floating is showing → pass through
                    if (showPopup || freeze)
                      Positioned.fill(
                        child: AbsorbPointer(
                          absorbing: true,
                          child: Container(
                            // dim background only for popup
                            color: showPopup
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent,
                          ),
                        ),
                      ),

                    // ── 1. CENTER POPUP ──
                    if (showPopup)
                      Material(
                        color: Colors.transparent,
                        child: _CenterPopup(service: service),
                      ),

                    // ── 2. FLOATING TIMER ──
                    // No background blocker — only the button itself is tappable
                    if (showFloating)
                      Positioned(
                        bottom: 90,
                        right: 20,
                        child: Material(
                          color: Colors.transparent,
                          child: _FloatingTimer(service: service),
                        ),
                      ),

                    // ── 3. FREEZE SCREEN ──
                    if (freeze)
                      const _FreezeScreen(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}// ─────────────────────────────────────────────
//  CENTER POPUP
// ─────────────────────────────────────────────

class _CenterPopup extends StatelessWidget {
  final SignalRService service;
  const _CenterPopup({required this.service});

  String _format(int s) =>
      "${(s ~/ 60).toString().padLeft(2, '0')}:"
          "${(s % 60).toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: service.secondsLeftNotifier,
        builder: (context, seconds, _) {

          // ── red when 60s or less, primary otherwise
          final bool isUrgent = seconds <= 60;
          final Color themeColor = isUrgent
              ? Colors.red.shade600
              : Theme.of(context).primaryColor;

          return Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Icon(Icons.warning_rounded, color: Colors.white, size: 35),
                const SizedBox(height: 15),

                const Text(
                  "Scheduled Maintenance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "Application is under maintenance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 20),

                // countdown
                Text(
                  _format(seconds),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // close button
                GestureDetector(
                  onTap: () {
                    service.showCenterPopup.value = false;
                    service.restoreFloatingIfNeeded();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: themeColor,       // ← matches container color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// ─────────────────────────────────────────────
//  FLOATING TIMER BUTTON
// ─────────────────────────────────────────────

class _FloatingTimer extends StatelessWidget {
  final SignalRService service;
  const _FloatingTimer({required this.service});

  String _format(int s) =>
      "${(s ~/ 60).toString().padLeft(2, '0')}:"
          "${(s % 60).toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        service.showFloatingWidget.value = false;
        service.showCenterPopup.value    = true;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: service.secondsLeftNotifier,
        builder: (context, seconds, _) {

          // ── red when 60s or less, primary otherwise
          final bool isUrgent = seconds <= 60;
          final Color themeColor = isUrgent
              ? Colors.red.shade600
              : Theme.of(context).primaryColor;

          final double progress = service.totalDurationSeconds > 0
              ? seconds / service.totalDurationSeconds
              : 1.0;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: themeColor,          // ← switches to red
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: themeColor.withOpacity(0.4),  // ← glow matches color
                  blurRadius: isUrgent ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                Text(
                  _format(seconds),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// ─────────────────────────────────────────────
//  FREEZE SCREEN
// ─────────────────────────────────────────────

class _FreezeScreen extends StatelessWidget {
  const _FreezeScreen();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(   // ← keep this, it's correct
      child: PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: true,
          child: Material(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/veenuslogo.png",height: 30,),
                      Text(
                        "  Veenus Software Technology",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  /// JSON Animation
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: CircleAvatar(
                      maxRadius: 100,
                      backgroundColor: Colors.blue.shade100.withOpacity(0.1),
                      child: Lottie.asset(
                        'assets/images/freeze_screen.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                        repeat: true,
                        animate: true,
                        frameRate: FrameRate.max,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "We'll be back soon",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    "Application under maintenance.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Thank you for your patience.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed:() {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100.withOpacity(0.2),
                      foregroundColor: Colors.red.shade600,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side:  BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle,color: Colors.blue,size: 12,),
                        Text(
                          "  DEPLOYMENT FREEZE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.blue.shade800
                          ),
                        ),
                      ],
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
}