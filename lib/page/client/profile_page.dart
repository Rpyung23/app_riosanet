import 'dart:async';
import 'package:app_riosanet/model/profile_client_model.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../model/model_response.dart';
import '../../provider/ProviderClient.dart';
import '../../util/icons.dart';
import '../../util/secure_store.dart';
import '../../util/string.dart';
import '../map_page.dart';
import '../update_password.dart';

class ProfilePage extends StatefulWidget {
  bool isLoading = true;

  ProviderClient oProviderClient = ProviderClient();
  cProfileModel oProfileModel = cProfileModel();

  TextEditingController oTextEditingControllerFullName =
      TextEditingController();
  TextEditingController oTextEditingControllerEmail = TextEditingController();
  TextEditingController oTextEditingControllerPhone = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerLatLng = TextEditingController();

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    _readApiProfile();
    super.initState();
  }

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
      body: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
        //_getPictureFoto(),

        TextFormField(
            controller: widget.oTextEditingControllerFullName,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                isDense: true,
                contentPadding: EdgeInsets.all(0),
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
            controller: widget.oTextEditingControllerEmail,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.email),
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
            controller: widget.oTextEditingControllerPhone,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Iconsax.call),
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
            controller: widget.oTextEditingControllerRef,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.map),
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
            controller: widget.oTextEditingControllerLatLng,
            canRequestFocus: false,
            onTap: () {
              _updateMap();
            },
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.map),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_primary)))),
        /*SizedBox(
          height: marginSmall,
        ),
        GestureDetector(
          child: _getMapa(),
          onTap: () {
            
          },
        ),*/
        SizedBox(
          height: marginMedium,
        ),
        Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    //_updateProfileApi();
                    SecureStore oS = SecureStore();
                    var token_ = await oS.readToken();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            UpdatePasswordPage(token: token_, tipo: 1)));
                  },
                  child: Text(
                    'Actualizar Contraseña',
                    style:
                        TextStyle(color: color_white, fontSize: textBigMedium),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: color_primary,
                      minimumSize: Size(double.infinity, altoMedium)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  _updateProfileApi();
                },
                child: Text(
                  text_save,
                  style: TextStyle(color: color_white, fontSize: textBigMedium),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: color_secondary,
                    minimumSize: Size(double.infinity, altoMedium)),
              ))
            ],
          ),
        ),
        SizedBox(
          height: marginSmall,
        )
      ],
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

  _readApiProfile() async {
    widget.oProfileModel = await widget.oProviderClient.readProfileClient();
    widget.isLoading = false;

    try {
      if (widget.oProfileModel != null &&
          widget.oProfileModel.statusCode! == 200) {
        widget.oTextEditingControllerFullName.text =
            widget.oProfileModel.datos!.nombre!;
        widget.oTextEditingControllerEmail.text =
            widget.oProfileModel.datos!.correo!;
        widget.oTextEditingControllerPhone.text =
            widget.oProfileModel.datos!.movil!;
        widget.oTextEditingControllerRef.text =
            widget.oProfileModel.datos!.direccion!;

        widget.oTextEditingControllerLatLng.text =
            (widget.oProfileModel.datos!.latitude! +
                " " +
                widget.oProfileModel.datos!.longitude!);

        /*oMapController!.moveCamera(CameraUpdate.newLatLngZoom(
            LatLng(double.parse(widget.oProfileModel.datos!.latitude!),
                double.parse(widget.oProfileModel.datos!.longitude!)),
            15));
        widget.oMarker.add(Marker(
            markerId: MarkerId(widget.oMarkerId),
            draggable: true,
            position: LatLng(
                double.parse(widget.oProfileModel.datos!.latitude!),
                double.parse(widget.oProfileModel.datos!.longitude!))));*/
      }
    } catch (e) {
      print(e.toString());
    }

    setState(() {});
  }

  _updateProfileApi() async {
    widget.isLoading = true;
    setState(() {});

    ModelResponse oModelResponse = await widget.oProviderClient
        .updateProfileClient(
            widget.oTextEditingControllerFullName.value.text,
            widget.oTextEditingControllerEmail.value.text,
            widget.oTextEditingControllerPhone.value.text,
            widget.oTextEditingControllerRef.value.text,
            widget.oProfileModel.datos!.latitude!,
            widget.oProfileModel.datos!.longitude!);

    widget.isLoading = false;

    setState(() {});

    Fluttertoast.showToast(
        msg: oModelResponse.msm!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:
            oModelResponse.statusCode == 200 ? color_primary : color_danger,
        textColor: color_white,
        fontSize: textMedium);
  }

  _updateMap() async {
    LatLng olatLng = await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MapPage(
            latitud: double.parse(widget.oProfileModel.datos!.latitude!),
            longitud: double.parse(widget.oProfileModel.datos!.longitude!))));

    if (olatLng != null) {
      widget.oProfileModel.datos!.latitude = olatLng.latitude.toString();
      widget.oProfileModel.datos!.longitude = olatLng.longitude.toString();
      setState(() {});
    }
  }
}
