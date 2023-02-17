import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selkni/constant.dart';
import 'package:selkni/utilities/sidebar..dart';

class MapG extends StatefulWidget {
  Position? position;
  Position? _position;
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
  // ignore: prefer_typing_uninit
  // ialized_variables

  late Position currntp;

  var geolocator = Geolocator();

  void pos() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currntp = position;
    LatLng myposs = LatLng(position.latitude, position.longitude);
  }

  void lov() {
    Geolocator.getPositionStream().listen((Position position) {
      widget.position = position;
    });
  }

// create this variable
  String _address = "";
  void Getlocalpotion() async {
    LocationPermission permission = await Geolocator.checkPermission();
    widget.position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> newPlace = await placemarkFromCoordinates(
        widget.position!.latitude, widget.position!.longitude,
        localeIdentifier: 'Ar');
    Placemark placeMark = newPlace[0];

    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String aministrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String address =
        "${name}    ${locality}  ${aministrativeArea}  ${postalCode}  ${country}";
    print('${address}');
    print('${widget.position!.longitude}');

    setState(() {
      _address = address;
      widget.isload = true;
    });
  }

  List<LatLng> Polylinecord = [];

  void GetPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(mycurrentposition!.latitude, mycurrentposition!.longitude),
      PointLatLng(destinationposition.latitude, destinationposition.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) =>
            Polylinecord.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {
        widget.isload = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    GetPolyPoint();

    Getlocalpotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Center(
          child: Text(
            _address,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
      body: widget.isload
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentposition,
                zoom: 14,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("value"),
                  points: Polylinecord,
                  color: Colors.deepOrange,
                  width: 6,
                )
              },
              onMapCreated: (controller) {
                mapController = controller;
                addMarker('test', mycurrentposition, mycurrentposition);
                addMarker('test1', currentposition, currentposition);

                addMarker('test2', destinationposition, destinationposition);
              },
              markers: _Markers.values.toSet(),
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  addMarker(String id, LatLng location, LatLng info) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(),
    );
    _Markers[id] = marker;
    setState(() {});
  }
}
