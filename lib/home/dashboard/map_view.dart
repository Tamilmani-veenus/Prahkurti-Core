import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prahkurticore/home/dashboard/title_providers.dart';
import 'package:prahkurticore/utilities/baseutitiles.dart';
import '../../controller/site_location_controller.dart';
import 'app_bar.dart';
import 'button_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// search and polygon
class DrawMapView extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? ProjectId;


  const DrawMapView({super.key, this.latitude, this.longitude, this.ProjectId});

  @override
  State<DrawMapView> createState() => _DrawMapViewState();
}

class _DrawMapViewState extends State<DrawMapView> {
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  String? address;
  late LatLng _initialLatLng;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  final TextEditingController searchController = TextEditingController();
  List<dynamic> suggestions = [];
  Set<Polygon> _polygons = {};
  List<LatLng> polygonPoints = [];

  // String locationIqKey = "pk.6f9e5dc2110b38c99b42b1feae7867b7";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initialLatLng = LatLng(
        double.tryParse(widget.latitude!)!,
        double.tryParse(widget.longitude!)!,
      );

      initValue();
    });
  }
  //search functions
  // Future<void> searchPlaces(String query) async {
  //   if (query.trim().length < 3) {
  //     setState(() {
  //       suggestions.clear();
  //     });
  //     return;
  //   }
  //
  //   final url = Uri.parse(
  //     "https://us1.locationiq.com/v1/autocomplete"
  //         "?key=$locationIqKey"
  //         "&q=${Uri.encodeComponent(query)}"
  //         "&limit=5"
  //         "&format=json",
  //   );
  //
  //   try {
  //     final response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         suggestions = jsonDecode(response.body);
  //       });
  //     } else {
  //       debugPrint(response.body);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // void onSearchChanged(String value) {
  //   if (_debounce?.isActive ?? false) {
  //     _debounce!.cancel();
  //   }
  //
  //   _debounce = Timer(
  //     const Duration(milliseconds: 500),
  //         () {
  //       searchPlaces(value);
  //     },
  //   );
  // }

  Future<BitmapDescriptor> createCircleMarker(int size, Color fillColor) async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final double radius = size / 2;

    // Shadow paint (theme color glow)
    final Paint shadowPaint = Paint()
      ..color = fillColor.withOpacity(0.6) // adjust opacity
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Border paint (white outline)
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Fill paint (main circle color)
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // Draw shadow (behind everything)
    canvas.drawCircle(Offset(radius, radius), radius, shadowPaint);

    // Draw white border
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);

    // Draw inner colored circle
    canvas.drawCircle(Offset(radius, radius), radius - 4, fillPaint);

    final img = await recorder.endRecording().toImage(size, size);
    final byteData = await img.toByteData(format: ImageByteFormat.png);

    final Uint8List bytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  @override

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          leading: Padding(
            padding: EdgeInsets.only(
              top: 16.r,
            ),
            child: Builder(
              builder: (context) {
                return InkWell(
                  radius: 24.0,
                  onTap: () {
                    Get.back();
                  },
                  child: const Center(
                    child: SizedBox(
                        height: 18,
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                );
              },
            ),
          ), title: 'Map View',
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialLatLng,
                zoom: 18,
              ),
              markers: _markers,
              polygons: _polygons,

              onMapCreated: (controller) {
                _mapController = controller;
              },

              onTap: drawPolygon,

              myLocationEnabled: false,
              zoomControlsEnabled: false,
            ),
            Positioned(
              right: 15,
              bottom: 110,

              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,

                child: const Icon(Icons.clear),

                onPressed: () {

                  polygonPoints.clear();

                  _markers.clear();

                  _polygons.clear();
                  _markers.add(
                    Marker(
                      markerId: const MarkerId('initial_marker'),
                      position: _initialLatLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    ),
                  );

                  setState(() {});

                },

              ),
            ),
            Positioned(
              bottom: 25,
              left: 16,
              right: 16,
              child: ButtonWidget(
                maxHeight: 40.h,
                color: Theme.of(context).primaryColor,
                title: const Text(
                  "Save Boundary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {

                  if (polygonPoints.length < 3) {

                    Fluttertoast.showToast(
                      msg: "Minimum 3 points required",
                    );

                    return;
                  }
                  else {
                    String latitude = polygonPoints
                        .map((e) => e.latitude.toString())
                        .join(",");

                    String longitude = polygonPoints
                        .map((e) => e.longitude.toString())
                        .join(",");

                    await siteLocationController.setSiteLocation(
                      widget.ProjectId.toString(),
                      latitude,
                      longitude,
                    );
                  }

                },
              ),
            ),

            //search functions

            // Positioned(
            //   top: 50,
            //   left: 15,
            //   right: 15,
            //   child: Material(
            //     elevation: 5,
            //     borderRadius: BorderRadius.circular(10),
            //     child: TextField(
            //       controller: searchController,
            //       onChanged: onSearchChanged,
            //       cursorColor: Colors.black,
            //       onSubmitted: (value) {
            //         FocusScope.of(context).unfocus();
            //       },
            //       decoration: InputDecoration(
            //         hintText: "Search Location",
            //         prefixIcon:  Icon(Icons.search),
            //         prefixIconColor: Colors.grey,
            //         suffixIcon:  IconButton(
            //           icon: const Icon(Icons.cancel_outlined,color: Colors.grey,),
            //           onPressed: () {
            //             searchController.clear();
            //             setState(() {
            //               suggestions.clear();
            //             });
            //           },
            //         ),
            //         border: InputBorder.none,
            //         contentPadding: const EdgeInsets.all(15),
            //       ),
            //     )
            //   ),
            // ),
            // if (suggestions.isNotEmpty)
            //   Positioned(
            //     top: 110,
            //     left: 15,
            //     right: 15,
            //     child: Material(
            //       elevation: 5,
            //       borderRadius: BorderRadius.circular(10),
            //       child: ConstrainedBox(
            //         constraints: const BoxConstraints(
            //           maxHeight: 250,
            //         ),
            //         child: ListView.builder(
            //           padding: EdgeInsets.zero,
            //           shrinkWrap: true,
            //           itemCount: suggestions.length,
            //           itemBuilder: (_, index) {
            //
            //             final item = suggestions[index];
            //
            //             return ListTile(
            //               leading: const Icon(Icons.location_on),
            //
            //               title: Text(
            //                 item["display_name"] ?? "",
            //                 maxLines: 2,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //
            //                 onTap: () async {
            //                   FocusScope.of(context).unfocus();
            //
            //                   final lat = double.parse(item["lat"]);
            //                   final lon = double.parse(item["lon"]);
            //                   final location = LatLng(lat, lon);
            //
            //                   // Move camera
            //                   await _mapController?.animateCamera(
            //                     CameraUpdate.newLatLngZoom(location, 18),
            //                   );
            //
            //                   // Update search field
            //                   searchController.text = item["display_name"];
            //
            //                   // Clear suggestions
            //                   setState(() {
            //                     suggestions.clear();
            //
            //                     // Drop a marker at the searched location
            //                     _markers.clear(); // optional: clear old markers
            //                     _markers.add(
            //                       Marker(
            //                         markerId: MarkerId(item["display_name"]),
            //                         position: location,
            //                         infoWindow: InfoWindow(title: item["display_name"]),
            //                         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            //                       ),
            //                     );
            //                   });
            //                 }
            //
            //             );
            //           },
            //         )
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }


  Future<void> drawPolygon(LatLng point) async {
    polygonPoints.add(point);
    final circleIcon = await createCircleMarker(32, Theme.of(context).primaryColor);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          icon: circleIcon,
        ),
      );
      _polygons = {
        Polygon(
          polygonId: const PolygonId("site"),
          points: polygonPoints,
          strokeColor: Theme.of(context).primaryColor,
          strokeWidth: 2,
          fillColor: Theme.of(context).primaryColor.withOpacity(.2),
        )
      };
    });
  }

  void savePolygon() {

    List<Map<String, dynamic>> data =
    polygonPoints.map((e) {

      return {

        "lat": e.latitude,

        "lng": e.longitude,

      };

    }).toList();

    print(jsonEncode(data));

    bool inside = isPointInPolygon(_initialLatLng, polygonPoints);

    if (inside) {
      BaseUtitiles.showToast("✅ User is inside the polygon");
    } else {
      BaseUtitiles.showToast("❌ User is outside the polygon");
    }
    // Call API here

  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersections = 0;
    for (int i = 0; i < polygon.length; i++) {
      LatLng v1 = polygon[i];
      LatLng v2 = polygon[(i + 1) % polygon.length];

      // Check if the ray crosses the edge
      if ((v1.latitude > point.latitude) != (v2.latitude > point.latitude)) {
        double intersectLon = (v2.longitude - v1.longitude) *
            (point.latitude - v1.latitude) /
            (v2.latitude - v1.latitude) +
            v1.longitude;

        if (point.longitude < intersectLon) {
          intersections++;
        }
      }
    }
    return (intersections % 2) == 1;
  }

  void initValue() {
    _markers.clear();
    siteLocationController.radius.text="0";
    _markers.add(
      Marker(
        markerId: const MarkerId('initial_marker'),
        position: _initialLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    );

    setState(() {});
  }
}


class SetMapView extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? ProjectId;


  const SetMapView({super.key, this.latitude, this.longitude, this.ProjectId});

  @override
  State<SetMapView> createState() => _SetMapViewState();
}

class _SetMapViewState extends State<SetMapView> {
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  String? address;

  late LatLng _initialLatLng;
  GoogleMapController? _mapController;

  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  void initState() {
    _initialLatLng = LatLng(
      double.parse(widget.latitude!),
      double.parse(widget.longitude!),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => initValue());
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          leading: Padding(
            padding: EdgeInsets.only(
              top: 16.r,
            ),
            child: Builder(
              builder: (context) {
                return InkWell(
                  radius: 24.0,
                  onTap: () {
                    Get.back();
                  },
                  child: const Center(
                    child: SizedBox(
                        height: 18,
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                );
              },
            ),
          ), title: '',
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialLatLng,
                zoom: 18,
              ),
              markers: _markers,
              circles: _circles,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onTap: handleTap,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
            ),
            Positioned(
              bottom: 25,
              left: 16,
              right: 16,
              child: ButtonWidget(
                maxHeight: 40.h,
                color: Theme.of(context).primaryColor,
                title: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  await siteLocationController.setSiteLocation(widget.ProjectId.toString(),widget.latitude!,widget.longitude!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> handleTap(LatLng tapLocation) async {
    setState(() {
      _markers.clear();
      _circles.clear();

      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: tapLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

      _circles.add(
        Circle(
          circleId: const CircleId('selected_radius'),
          center: tapLocation,
          radius: double.parse(siteLocationController.radius.text),
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.1),
          strokeWidth: 1,
        ),
      );
    });

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${tapLocation.latitude}&lon=${tapLocation.longitude}');

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'FlutterApp (https://skconstructions.in/contact)', // Replace with your email or app name
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final displayName = data['display_name'] ?? 'No address found';
      final addressData = data['address'] ?? {};

      // You can also use specific fields if you want
      String formattedAddress = displayName;

      Fluttertoast.showToast(msg: 'Tapped Location Address: $formattedAddress');

      if (kDebugMode) {
        print('Tapped location: Latitude: ${tapLocation.latitude}, Longitude: ${tapLocation.longitude}');
        print('Address JSON: ${data['address']}');
        print('Full Address: $formattedAddress');
      }

      siteLocationController.latitude = "${tapLocation.latitude}";
      siteLocationController.longitude = "${tapLocation.longitude}";
      siteLocationController.punchInAddress = formattedAddress;

    } else {
      // Fluttertoast.showToast(msg: 'Failed to get address from OSM');
    }
  }


  void initValue() {
    _markers.add(
      Marker(
        markerId: const MarkerId('initial_marker'),
        position: _initialLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    _circles.add(
      Circle(
        circleId: const CircleId('initial_circle'),
        center: _initialLatLng,
        radius: double.parse(siteLocationController.radius.text),
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.1),
        strokeWidth: 1,
      ),
    );

    setState(() {});
  }

}

