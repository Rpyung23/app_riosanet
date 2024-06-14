import 'dart:async';

import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  double latitud;
  double longitud;
  Set<Marker> oMarker = Set();
  String oMarkerId = "MIPOSITION";
  Completer<GoogleMapController> oGoogleMapController =
      Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  MapPage({required this.latitud, required this.longitud});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? oMapController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color_primary,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(widget.oMarker.first.position);
              },
              icon: icon_back),
          title: Text(
            "Mi ubicación",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () async {
        Navigator.of(context).pop(widget.oMarker.first.position);
        return false;
      },
    );
  }

  _getBody() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget._kGooglePlex,
      scrollGesturesEnabled: true,
      zoomControlsEnabled: true,
      markers: widget.oMarker,
      onMapCreated: (GoogleMapController controller) {
        oMapController = controller;
        widget.oGoogleMapController.complete(controller);
        moveCamera();
      },
    );
  }

  moveCamera() {
    oMapController!.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.latitud, widget.longitud), 15));
    widget.oMarker.add(Marker(
        markerId: MarkerId(widget.oMarkerId),
        draggable: true,
        position: LatLng(widget.latitud, widget.longitud)));
    setState(() {});
  }
}
