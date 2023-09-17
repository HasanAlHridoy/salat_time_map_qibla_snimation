import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMecca extends StatefulWidget {
  const GoogleMapMecca({Key? key}) : super(key: key);

  @override
  State<GoogleMapMecca> createState() => _GoogleMapMeccaState();
}

// Api key google =  AIzaSyBBdB4TOMTTGLFpqnqcXwU8RsETe-CAzu8
class _GoogleMapMeccaState extends State<GoogleMapMecca> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.81400929539273, 90.42410278973571),
    zoom: 14,
  );
  Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void addMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/images/location.png', 200);
    final Uint8List markerIconMecca = await getBytesFromAsset('assets/images/qibla.png', 200);
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: const LatLng(23.81400929539273, 90.42410278973571),
        infoWindow: const InfoWindow(title: 'My Position'),
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: const LatLng(21.42302365593683, 39.82571996137234),
        infoWindow: const InfoWindow(title: 'My new'),
        icon: BitmapDescriptor.fromBytes(markerIconMecca),
      ),
    );
    setState(() {});
  }

  static Polyline polyline = Polyline(
      polylineId: PolylineId('p1'),
      geodesic: true,
      patterns: [PatternItem.dash(20.0), PatternItem.gap(20)],
      // patterns: [PatternItem.dash(2.0)],
      points: [
        LatLng(23.81400929539273, 90.42410278973571),
        LatLng(21.42302365593683, 39.82571996137234),
      ],
      width: 3,
      color: Colors.black);
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   addMarker();
  //   print(markers);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers,
        polylines: {polyline},
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          addMarker();
        },
        compassEnabled: true,
      ),
    );
  }
}
