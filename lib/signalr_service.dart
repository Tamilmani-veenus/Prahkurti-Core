// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:signalr_netcore/signalr_client.dart';
// import 'package:prahkurticore/utilities/apiconstant.dart';
//
// import 'main.dart';
//
// // ─────────────────────────────────────────────
// //  SERVICE
// // ─────────────────────────────────────────────
//
// class SignalRService {
//   static final SignalRService _instance = SignalRService._internal();
//   factory SignalRService() => _instance;
//   SignalRService._internal();
//
//   HubConnection? hubConnection;
//   Timer? countdownTimer;
//
//   ValueNotifier<bool> isMaintenance       = ValueNotifier(false);
//   ValueNotifier<int>  secondsLeftNotifier = ValueNotifier(0);
//   ValueNotifier<bool> showCenterPopup     = ValueNotifier(false);
//   ValueNotifier<bool> showFloatingWidget  = ValueNotifier(false);
//   ValueNotifier<bool> freezeScreen        = ValueNotifier(false);
//
//   int totalDurationSeconds = 0;
//
//   // ── LOCAL TEST ───────────────────────────────
//   void startLocalMaintenanceTest() {
//     handlePayload({"isMaintenance": true, "durationMinutes": 1});
//   }
//
//   void stopLocalMaintenanceTest() {
//     handlePayload({"isMaintenance": false, "durationMinutes": 0});
//   }
//
//   // ── SIGNALR CONNECTION ───────────────────────
//   Future<void> startConnection() async {
//     hubConnection = HubConnectionBuilder()
//         .withUrl("${ApiConfig.APIURL_CORE}maintenanceHub")
//         .build();
//
//     hubConnection!.on("MaintenanceStatus", (arguments) {
//       print("MaintenanceStatus received: $arguments");
//       if (arguments != null && arguments.isNotEmpty) {
//         handlePayload(arguments[0]);
//       }
//     });
//
//     hubConnection!.onclose((error) {
//       print("SignalR closed: $error");
//       Future.delayed(const Duration(seconds: 5), () => startConnection());
//     });
//
//     try {
//       await hubConnection!.start();
//       print("SignalR connected");
//     } catch (e) {
//       print("SignalR error: $e");
//       Future.delayed(const Duration(seconds: 5), () => startConnection());
//     }
//   }
//   // ── PAYLOAD HANDLER ──────────────────────────
//   Future<void> handlePayload(dynamic payload) async {
//     final bool isMaint        = payload["isMaintenance"] ?? false;
//     final int  durationMinutes = payload["durationMinutes"] ?? 0;
//
//     // ── MAINTENANCE OFF ──
//     if (!isMaint) {
//       _resetAll();
//       return;
//     }
//
//     // ── MAINTENANCE ON ──
//
//     // 1. Reset everything cleanly first
//     showCenterPopup.value    = false;
//     showFloatingWidget.value = false;
//     freezeScreen.value       = false;
//     isMaintenance.value      = true;
//
//     // 2. Insert overlay into widget tree
//     MaintenanceOverlay.show();
//
//     // 3. Give overlay one frame to mount
//     await Future.delayed(const Duration(milliseconds: 150));
//
//     // 4. Show center popup + start countdown
//     showCenterPopup.value = true;
//     startCountdown(durationMinutes * 60);
//
//     // 5. After 3 seconds, collapse to floating button
//     await Future.delayed(const Duration(seconds: 3));
//
//     // Guard: only switch if still in maintenance and not frozen
//     if (isMaintenance.value && !freezeScreen.value) {
//       showCenterPopup.value    = false;
//       showFloatingWidget.value = true;
//     }
//   }
//
//   // ── COUNTDOWN ────────────────────────────────
//   void startCountdown(int totalSeconds) {
//     totalDurationSeconds = totalSeconds;
//     countdownTimer?.cancel();
//     secondsLeftNotifier.value = totalSeconds;
//
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final int next = secondsLeftNotifier.value - 1;
//
//       if (next <= 0) {
//         secondsLeftNotifier.value   = 0;
//         showCenterPopup.value       = false;
//         showFloatingWidget.value    = false;
//         freezeScreen.value          = true;
//         timer.cancel();
//       } else {
//         secondsLeftNotifier.value = next;
//       }
//     });
//   }
//
//   void stopCountdown() => countdownTimer?.cancel();
//
//   // ── RESTORE FLOATING ─────────────────────────
//   void restoreFloatingIfNeeded() {
//     if (isMaintenance.value &&
//         !freezeScreen.value &&
//         !showCenterPopup.value &&
//         secondsLeftNotifier.value > 0) {
//       showFloatingWidget.value = true;
//     }
//   }
//
//   // ── RESET ALL ────────────────────────────────
//   void _resetAll() {
//     stopCountdown();
//     isMaintenance.value      = false;
//     showCenterPopup.value    = false;
//     showFloatingWidget.value = false;
//     freezeScreen.value       = false;
//     secondsLeftNotifier.value = 0;
//     MaintenanceOverlay.hide();
//   }
//
//   // ── CONNECTION HELPERS ───────────────────────
//   bool isSignalRConnected() =>
//       hubConnection?.state == HubConnectionState.Connected;
//
//   Future<void> stopConnection() async {
//     stopCountdown();
//     await hubConnection?.stop();
//   }
// }
//
// // ─────────────────────────────────────────────
// //  OVERLAY MANAGER
// // ─────────────────────────────────────────────
//
// class MaintenanceOverlay {
//   static OverlayEntry? _entry;
//
//   static void show() {
//     hide(); // always clean up first
//
//     final overlayState = navigatorKey.currentState?.overlay;
//     if (overlayState == null) {
//       print("MaintenanceOverlay: overlay state is null");
//       return;
//     }
//
//     _entry = OverlayEntry(
//       builder: (_) => const _MaintenanceOverlayContent(),
//     );
//
//     overlayState.insert(_entry!);
//     print("MaintenanceOverlay: inserted");
//   }
//
//   static void hide() {
//     _entry?.remove();
//     _entry = null;
//     print("MaintenanceOverlay: removed");
//   }
// }
//
// // ─────────────────────────────────────────────
// //  OVERLAY ROOT  (owns all three layers)
// // ─────────────────────────────────────────────
//
// class _MaintenanceOverlayContent extends StatelessWidget {
//   const _MaintenanceOverlayContent();
//
//   @override
//   Widget build(BuildContext context) {
//     final service = SignalRService();
//
//     return ValueListenableBuilder<bool>(
//       valueListenable: service.freezeScreen,
//       builder: (context, freeze, _) {
//         return ValueListenableBuilder<bool>(
//           valueListenable: service.showCenterPopup,
//           builder: (context, showPopup, _) {
//             return ValueListenableBuilder<bool>(
//               valueListenable: service.showFloatingWidget,
//               builder: (context, showFloating, _) {
//
//                 return Stack(
//                   children: [
//
//                     // ── BACKGROUND BLOCKER ──
//                     // Only block full screen when popup or freeze is active
//                     // When ONLY floating is showing → pass through
//                     if (showPopup || freeze)
//                       Positioned.fill(
//                         child: AbsorbPointer(
//                           absorbing: true,
//                           child: Container(
//                             // dim background only for popup
//                             color: showPopup
//                                 ? Colors.black.withOpacity(0.3)
//                                 : Colors.transparent,
//                           ),
//                         ),
//                       ),
//
//                     // ── 1. CENTER POPUP ──
//                     if (showPopup)
//                       Material(
//                         color: Colors.transparent,
//                         child: _CenterPopup(service: service),
//                       ),
//
//                     // ── 2. FLOATING TIMER ──
//                     // No background blocker — only the button itself is tappable
//                     if (showFloating)
//                       Positioned(
//                         bottom: 90,
//                         right: 20,
//                         child: Material(
//                           color: Colors.transparent,
//                           child: _FloatingTimer(service: service),
//                         ),
//                       ),
//
//                     // ── 3. FREEZE SCREEN ──
//                     if (freeze)
//                       const _FreezeScreen(),
//
//                   ],
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }// ─────────────────────────────────────────────
// //  CENTER POPUP
// // ─────────────────────────────────────────────
//
// class _CenterPopup extends StatelessWidget {
//   final SignalRService service;
//   const _CenterPopup({required this.service});
//
//   String _format(int s) =>
//       "${(s ~/ 60).toString().padLeft(2, '0')}:"
//           "${(s % 60).toString().padLeft(2, '0')}";
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ValueListenableBuilder<int>(
//         valueListenable: service.secondsLeftNotifier,
//         builder: (context, seconds, _) {
//
//           // ── red when 60s or less, primary otherwise
//           final bool isUrgent = seconds <= 60;
//           final Color themeColor = isUrgent
//               ? Colors.red.shade600
//               : Theme.of(context).primaryColor;
//
//           return Container(
//             width: 280,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: themeColor,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.25),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//
//                 const Icon(Icons.warning_rounded, color: Colors.white, size: 35),
//                 const SizedBox(height: 15),
//
//                 const Text(
//                   "Scheduled Maintenance",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 const Text(
//                   "Application is under maintenance.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // countdown
//                 Text(
//                   _format(seconds),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//
//                 // close button
//                 GestureDetector(
//                   onTap: () {
//                     service.showCenterPopup.value = false;
//                     service.restoreFloatingIfNeeded();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "Close",
//                       style: TextStyle(
//                         color: themeColor,       // ← matches container color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// // ─────────────────────────────────────────────
// //  FLOATING TIMER BUTTON
// // ─────────────────────────────────────────────
//
// class _FloatingTimer extends StatelessWidget {
//   final SignalRService service;
//   const _FloatingTimer({required this.service});
//
//   String _format(int s) =>
//       "${(s ~/ 60).toString().padLeft(2, '0')}:"
//           "${(s % 60).toString().padLeft(2, '0')}";
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         service.showFloatingWidget.value = false;
//         service.showCenterPopup.value    = true;
//       },
//       child: ValueListenableBuilder<int>(
//         valueListenable: service.secondsLeftNotifier,
//         builder: (context, seconds, _) {
//
//           // ── red when 60s or less, primary otherwise
//           final bool isUrgent = seconds <= 60;
//           final Color themeColor = isUrgent
//               ? Colors.red.shade600
//               : Theme.of(context).primaryColor;
//
//           final double progress = service.totalDurationSeconds > 0
//               ? seconds / service.totalDurationSeconds
//               : 1.0;
//
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             width: 75,
//             height: 75,
//             decoration: BoxDecoration(
//               color: themeColor,          // ← switches to red
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: themeColor.withOpacity(0.4),  // ← glow matches color
//                   blurRadius: isUrgent ? 12 : 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 58,
//                   height: 58,
//                   child: CircularProgressIndicator(
//                     value: progress,
//                     strokeWidth: 4,
//                     backgroundColor: Colors.white24,
//                     valueColor: const AlwaysStoppedAnimation(Colors.white),
//                   ),
//                 ),
//                 Text(
//                   _format(seconds),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// // ─────────────────────────────────────────────
// //  FREEZE SCREEN
// // ─────────────────────────────────────────────
//
// class _FreezeScreen extends StatelessWidget {
//   const _FreezeScreen();
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(   // ← keep this, it's correct
//       child: PopScope(
//         canPop: false,
//         child: AbsorbPointer(
//           absorbing: true,
//           child: Material(
//             color: Colors.white,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset("assets/images/veenuslogo.png",height: 30,),
//                       Text(
//                         "  Veenus Software Technology",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//                   /// JSON Animation
//                   Lottie.asset(
//                     'assets/images/freeze_screen.json',
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.contain,
//                     repeat: true,
//                     animate: true,
//                     frameRate: FrameRate.max,
//                   ),
//
//                   const SizedBox(height: 25),
//
//                   const Text(
//                     "We'll be back soon",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//
//                   const SizedBox(height: 7),
//
//                   const Text(
//                     "Application under maintenance.",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     "Thank you for your patience.",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.blue.shade700,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//
//                   ElevatedButton(
//                     onPressed:() {
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade100.withOpacity(0.2),
//                       foregroundColor: Colors.red.shade600,
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 14,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         side:  BorderSide(
//                           color: Colors.grey.shade200,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.circle,color: Colors.blue,size: 12,),
//                         Text(
//                           "  DEPLOYMENT FREEZE",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13,
//                               color: Colors.blue.shade800
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }