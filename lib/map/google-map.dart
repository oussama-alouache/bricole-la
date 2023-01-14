import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selkni/constant.dart';

class MapG extends StatefulWidget {
  Position? position;

  bool isload = false;
  @override
  State<MapG> createState() => _MapGState();
}

class _MapGState extends State<MapG> {
  late GoogleMapController mapController;
  late LatLng currentposition =
      LatLng(widget.position!.latitude, widget.position!.longitude);

  static const LatLng mycurrentposition = LatLng(36.736205, 3.099853);
  static const LatLng destinationposition = LatLng(36.7999968, 3.0499998);

  Map<String, Marker> _Markers = {};

// LocationData? currentlocation;

  // void getcurrentlocation() {
  //  Location location = Location();
  //  location.getLocation().then((location) {
  //    currentlocation = location;
  //    print('${currentlocation!.latitude!}' + '${currentlocation!.longitude!}');
  //   });
  // }

  // late LatLng currrentlocation =
  //     LatLng(currentlocation!.latitude!, currentlocation!.longitude!);
  // ignore: prefer_typing_uninitialized_variables

  void Getlocalpotion() async {
    LocationPermission permission = await Geolocator.checkPermission();
    widget.position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print('${widget.position!.longitude}');

    setState(() {
      widget.isload = true;
    });
  }

  List<LatLng> Polylinecord = [];

  void GetPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(mycurrentposition.latitude, mycurrentposition.longitude),
      PointLatLng(destinationposition.latitude, destinationposition.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) =>
            Polylinecord.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    GetPolyPoint();
    StreamSubscription<ServiceStatus> serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((currentposition) {});
    Getlocalpotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isload
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mycurrentposition,
                zoom: 14,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("value"),
                  points: Polylinecord,
                  color: Colors.deepOrange,
                  width: 6,
                )
              },
              onMapCreated: (controller) {
                mapController = controller;
                addMarker('test', mycurrentposition);
                addMarker('test1', currentposition);
                addMarker('test2', destinationposition);
              },
              markers: _Markers.values.toSet(),
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
    );
    _Markers[id] = marker;
    setState(() {});
  }
}
