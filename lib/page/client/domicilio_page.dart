import 'package:app_riosanet/page/client/mapa_client.dart';
import 'package:app_riosanet/provider/ProviderTransfer.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickalert/quickalert.dart';
import '../../model/model_response.dart';
import '../../model/transfer_all_client/transfer_all_client.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class UpdateDomicilioPageClient extends StatefulWidget {
  LatLng? oPosition;

  final oGlobalKeyFail = GlobalKey<FormState>();

  TextEditingController oTextEditingControllerMapa = TextEditingController();
  TextEditingController oTextEditingControllerTel = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerNot = TextEditingController();

  TransferAllClientModel? oTransferAllClientModel;

  UpdateDomicilioPageClient({super.key});

  @override
  State<UpdateDomicilioPageClient> createState() =>
      _UpdateDomicilioPageClientState();
}

class _UpdateDomicilioPageClientState extends State<UpdateDomicilioPageClient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readApiTransferClient();
  }

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
      body: Container(
        child: RefreshIndicator(
          child: widget.oTransferAllClientModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _getListTransfer(),
          onRefresh: _readApiTransferClient,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ShowCreateDomiclio();
        },
        child: icon_add,
        backgroundColor: color_primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _getListTransfer() {
    return ListView.builder(
      itemCount: widget.oTransferAllClientModel == null
          ? 0
          : widget.oTransferAllClientModel!.datos == null
              ? 0
              : widget.oTransferAllClientModel!.datos!.length,
      itemBuilder: (context, index) {
        return _getItemTransfer(widget.oTransferAllClientModel!.datos![index]);
      },
    );
  }

  _getItemTransfer(DatoTransferClient oDatoTransferClient) {
    return ListTile(
      title: Text('CAMBIO DE DOMICLIO'),
      leading: oDatoTransferClient.estado == 3
          ? null
          : IconButton(
              onPressed: () {
                showAlertDeleteDomicilio(oDatoTransferClient.id!);
              },
              icon: icon_trash),
      subtitle: Text(oDatoTransferClient!.dir!),
      enabled: oDatoTransferClient.estado == 3 ? false : true,
      trailing: oDatoTransferClient.estado == 1
          ? icon_pen
          : oDatoTransferClient.estado == 2
              ? icon_prog
              : icon_check,
    );
  }

  Future<void> _readApiTransferClient() async {
    widget.oTransferAllClientModel = null;
    setState(() {});
    widget.oTransferAllClientModel =
        await ProviderTransfer.readTransferClientAll();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  showAlertDeleteDomicilio(int id_domicilio) {
    return QuickAlert.show(
        context: context,
        title: 'ELIMINAR CAMBIO DE DOMICILIO',
        headerBackgroundColor: color_danger,
        type: QuickAlertType.error,
        confirmBtnText: confirmTxtButton,
        cancelBtnText: cancelTxtButton,
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          _consumirApiDelete(id_domicilio);
        });
  }

  _consumirApiDelete(int id_domicilio) async {
    print("id_domicilio : " + id_domicilio.toString());
    ModelResponse oM = await ProviderTransfer.deleteTransfers(id_domicilio);
    if (oM.statusCode == 200) {
      _readApiTransferClient();
    } else {
      Fluttertoast.showToast(
          msg: oM.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: color_white,
          fontSize: textMedium);
    }
  }

  _ShowCreateDomiclio() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("CAMBIO DE DOMICLIO"),
            backgroundColor: color_white,
            surfaceTintColor: color_white,
            content: Container(
              child: _getAlert(),
              width: double.maxFinite,
            ),
          );
        });
  }

  _getAlert() {
    return Form(
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width, altoMedium)),
                child: Text(
                  text_save,
                  style: TextStyle(fontSize: textBigMedium, color: color_white),
                ))
          ],
        ));
  }

  _GetPositionDomicilio() async {
    widget.oPosition = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => MapClient()));

    if (widget.oPosition != null) {
      /*List<Placemark> placemarks = await placemarkFromCoordinates(
          widget.oPosition!.latitude, widget.oPosition!.longitude);*/

      widget.oTextEditingControllerMapa.text =
          (widget.oPosition!.latitude.toString() +
              " " +
              widget.oPosition!.longitude.toString());

      /*widget.oTextEditingControllerMapa.text = placemarks.length > 0
          ? (placemarks[0].thoroughfare! + "" + placemarks[1].thoroughfare!)
          : "NO GEOCODER";*/
    }
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
        _readApiTransferClient();
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
}
