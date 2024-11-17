import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../model/model_response.dart';
import '../../provider/ProviderTransfer.dart';
import '../../util/color.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class CreateDomicilioPage extends StatefulWidget {
  CreateDomicilioPage({super.key});
  LatLng? oPosition;
  final oGlobalKeyFail = GlobalKey<FormState>();
  TextEditingController oTextEditingControllerMapa = TextEditingController();
  TextEditingController oTextEditingControllerTel = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerNot = TextEditingController();

  @override
  State<CreateDomicilioPage> createState() => _CreateDomicilioPageState();
}

class _CreateDomicilioPageState extends State<CreateDomicilioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color_white),
        backgroundColor: color_primary,
        title: Text(
          txt_my_update_domicilio,
          style: TextStyle(color: color_white),
        ),
      ),
      body: _getBodyCreate(),
    );
  }

  _getBodyCreate() {
    return Container(
        margin: EdgeInsets.all(15),
        child: Form(
            key: widget.oGlobalKeyFail,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                    autofocus: false,
                    controller: widget.oTextEditingControllerMapa,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _GetPositionDomicilio();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return txt_ingrese_dir;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: hint_ubicacion,
                        alignLabelWithHint: true,
                        prefixIcon: icon_map,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder())),
                SizedBox(
                  height: marginSmall,
                ),
                TextFormField(
                    controller: widget.oTextEditingControllerTel,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return txt_ingrese_tel;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: hint_telefono,
                        alignLabelWithHint: true,
                        prefixIcon: icon_phone,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder())),
                SizedBox(
                  height: marginSmall,
                ),
                TextFormField(
                    maxLines: 2,
                    controller: widget.oTextEditingControllerRef,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return txt_ingrese_ref;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: hint_referencia,
                        alignLabelWithHint: true,
                        prefixIcon: icon_task_square,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder())),
                SizedBox(
                  height: marginSmall,
                ),
                TextFormField(
                    maxLines: 2,
                    controller: widget.oTextEditingControllerNot,
                    showCursor: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return txt_ingrese_note;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: hint_notes,
                        alignLabelWithHint: true,
                        prefixIcon: icon_task_square,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder())),
                SizedBox(
                  height: marginMediumSmall,
                ),
                ElevatedButton(
                    onPressed: () {
                      _createDomicilio();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: color_primary,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width, altoMedium)),
                    child: Text(
                      text_save,
                      style: TextStyle(
                          fontSize: textBigMedium, color: color_white),
                    ))
              ],
            )));
  }

  _createDomicilio() async {
    if (widget.oGlobalKeyFail.currentState!.validate()) {
      ModelResponse oM = await ProviderTransfer.createTransfer(
          widget.oTextEditingControllerMapa.text,
          widget.oTextEditingControllerTel.text,
          widget.oTextEditingControllerRef.text,
          widget.oTextEditingControllerNot.text,
          widget.oPosition == null ? 0 : widget.oPosition!.latitude,
          widget.oPosition == null ? 0 : widget.oPosition!.longitude);

      if (oM.statusCode == 200) {
        _clearAlert();
        Navigator.of(context).pop();
        //_readApiTransferClient();
      }
    }
  }

  _clearAlert() {
    widget.oPosition = null;
    widget.oTextEditingControllerMapa.clear();
    widget.oTextEditingControllerTel.clear();
    widget.oTextEditingControllerRef.clear();
    widget.oTextEditingControllerNot.clear();
  }

  Future<void> displayPrediction(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: 'AIzaSyCMR83z2AyaiNJTfUHKechVpGh_MjLQvHA',
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    widget.oPosition = LatLng(detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng);

    if (widget.oPosition != null) {
      widget.oTextEditingControllerMapa.text = detail.result.name;

      /*widget.oTextEditingControllerMapa.text = placemarks.length > 0
          ? (placemarks[0].thoroughfare! + "" + placemarks[1].thoroughfare!)
          : "NO GEOCODER";*/
    }
  }

  _GetPositionDomicilio() async {
    try {
      Prediction? oPrediction = await PlacesAutocomplete.show(
          context: context,
          apiKey: 'AIzaSyCMR83z2AyaiNJTfUHKechVpGh_MjLQvHA',
          mode: Mode.overlay,
          language: "es",
          components: [Component(Component.country, "ec")]);

      /*if (oPrediction != null) {
        displayPrediction(oPrediction!);
      }*/
    } catch (e) {
      print(e);
    }

    /*widget.oPosition = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => MapClient()));*/
  }
}
