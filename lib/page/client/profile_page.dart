import 'dart:async';
import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../util/icons.dart';
import '../../util/string.dart';

class ProfilePage extends StatefulWidget {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          mi_perfil,
          style: TextStyle(color: color_white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: icon_back),
        backgroundColor: color_primary,
      ),
      body: Container(
        margin: EdgeInsets.only(right: marginSmall, left: marginSmall),
        child: _getBodyProfile(),
      ),
    ));
  }

  Widget _getBodyProfile() {
    return ListView(
      children: [
        SizedBox(
          height: marginSmall,
        ),
        _getPictureFoto(),
        SizedBox(
          height: marginMedium,
        ),
        TextFormField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary))),
        ),
        SizedBox(
          height: marginSmallSmall,
        ),
        TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        SizedBox(
          height: marginSmallSmall,
        ),
        TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        SizedBox(
          height: marginSmallSmall,
        ),
        TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        SizedBox(
          height: marginSmallSmall,
        ),
        TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        SizedBox(
          height: marginSmallSmall,
        ),
        TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        SizedBox(
          height: marginSmall,
        ),
        _getMapa(),
        SizedBox(
          height: marginMedium,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            text_save,
            style: TextStyle(color: color_white, fontSize: textBigMedium),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: color_secondary,
              minimumSize: Size(double.infinity, altoMedium)),
        ),
        SizedBox(
          height: marginSmall,
        )
      ],
    );
  }

  Widget _getMapa() {
    return Container(
      height: 300,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: widget._kGooglePlex,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          widget._controller.complete(controller);
        },
      ),
    );
  }

  _getPictureFoto() {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
        child: Image.asset(
          "./assets/no_image.png",
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
    );
  }
}
