import 'dart:async';

import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/icons.dart';
import '../../util/string.dart';

class MapClient extends StatefulWidget {
  MapClient({super.key});
  Position? oPosition;
  final Set<Marker> markers = Set();

  //Marker oMarker = Marker(markerId: MarkerId(oMarkerIdTxt));

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? oGoogleMapController;

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 11,
  );

  @override
  State<MapClient> createState() => _MapClientState();
}

class _MapClientState extends State<MapClient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkPermision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: color_white,
        iconTheme: IconThemeData(color: color_white),
        backgroundColor: color_primary,
        title: Text(
          "FIJAR NUEVA UBICACIÓN",
          style: TextStyle(color: color_white),
        ),
      ),
      body: Stack(
        children: [
          _getmapa(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  right: marginMediumSmall,
                  left: marginMediumSmall,
                  bottom: marginMediumSmall),
              child: ElevatedButton.icon(
                  onPressed: () {
                    _determinePosition();
                  },
                  icon: icon_check_white,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: color_success,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width, altoMedium)),
                  label: Text(
                    "FIJAR UBICACIÓN",
                    style: TextStyle(color: color_white, fontSize: textMedium),
                  )),
            ),
          )
        ],
      ),
    );
  }

  _getmapa() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget._kGooglePlex,
      scrollGesturesEnabled: true,
      markers: widget.markers,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        widget._controller.complete(controller);
        widget.oGoogleMapController = controller;
      },
    );
  }

  _checkPermision() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      print("DETERMINATE POSITION");
      _determinePosition();
    } else {
      await Permission.location.request();
      _checkPermision();
    }
  }

  _determinePosition() async {
    if (widget.oGoogleMapController != null) {
      widget.oPosition = await Geolocator.getCurrentPosition();
      widget.oGoogleMapController!.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(widget.oPosition!.latitude, widget.oPosition!.longitude), 17));
      widget.markers.clear();
      setState(() {});
      widget.markers.add(Marker(
          markerId: MarkerId(oMarkerIdTxt),
          draggable: true,
          position:
              LatLng(widget.oPosition!.latitude, widget.oPosition!.longitude)));
      setState(() {});
    }
  }
}
