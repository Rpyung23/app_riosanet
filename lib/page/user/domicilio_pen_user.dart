// ignore_for_file: prefer_const_constructors

import 'package:app_riosanet/util/string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import '../../model/estado_model.dart';
import '../../model/model_response.dart';
import '../../model/transfer_all_pen.dart';
import '../../provider/ProviderTransfer.dart';
import '../../util/color.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DomicilioPenUser extends StatefulWidget {
  TransferPenAllModel? oTransferAllClientModel;

  RadioGroupController myControllerRG = RadioGroupController();

  DomicilioPenUser({super.key});

  @override
  State<DomicilioPenUser> createState() => _DomicilioPenUserState();
}

class _DomicilioPenUserState extends State<DomicilioPenUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initReadTransferPenAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: EdgeInsets.only(
          top: marginSmallSmall,
          left: marginSmallSmall,
          right: marginSmallSmall),
      child: RefreshIndicator(child: _getBody(), onRefresh: _refreshApi),
    )));
  }

  Widget _getBody() {
    return ListView.builder(
      itemCount: widget.oTransferAllClientModel == null
          ? 0
          : widget.oTransferAllClientModel!.datos == null
              ? 0
              : widget.oTransferAllClientModel!.datos!.length,
      itemBuilder: (context, item) {
        if (widget.oTransferAllClientModel == null ||
            widget.oTransferAllClientModel!.datos == null ||
            widget.oTransferAllClientModel!.datos!.length == 0) {
          return CircularProgressIndicator(
            backgroundColor: color_primary,
          );
        }

        return _getItemTransferPen(
            widget.oTransferAllClientModel!.datos![item],
            widget.oTransferAllClientModel!.datos![item].nombre,
            widget.oTransferAllClientModel!.datos![item].ref,
            widget.oTransferAllClientModel!.datos![item].nombreTecnico,
            widget.oTransferAllClientModel!.datos![item].cel,
            widget.oTransferAllClientModel!.datos![item].latTraspaso,
            widget.oTransferAllClientModel!.datos![item].lngTraspaso);
      },
    );
  }

  _getItemTransferPen(
      DatoTransferAllPen oT, name, tarea, tecnico, cel, lat, lng) {
    return Column(
      children: [
        ListTile(
            title: Text(tarea == null ? "SIN TAREA" : tarea),
            contentPadding: EdgeInsets.all(0),
            dense: true,
            subtitle:
                Text(name == null ? "TICKET CLIENTE" : "TECNICO : ${name}"),
            onTap: () {
              _showAlertProgress(oT);
            },
            trailing: IconButton(
                onPressed: () {
                  openMap(lat, lng);
                },
                icon:
                    icon_see) /*,
      leading: IconButton(
          onPressed: () {
            launchUrl(Uri.parse('tel://$cel'));
          },
          icon: icon_phone),*/
            ),
        Divider(
          height: 1,
          thickness: 1,
          color: color_primary,
        )
      ],
    );
  }

  _initReadTransferPenAll() async {
    widget.oTransferAllClientModel = null;
    widget.oTransferAllClientModel = await ProviderTransfer.readTransferAll();
    setState(() {});
  }

  Future<void> _refreshApi() async {
    await _initReadTransferPenAll();
  }

  static Future<void> openMap(double lat, double lng) async {
    Uri url = Uri.parse('geo:${lat},${lng}?q=${lat},${lng}');

    // ignore: deprecated_member_use
    if (await canLaunch(url.toString())) {
      // ignore: deprecated_member_use
      await launch(url.toString());
    } else {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gms.maps',
        iosUrlScheme: 'maps://',
        openStore: true,
      );
    }
  }

  _showAlertProgress(DatoTransferAllPen oT) {
    //widget.myControllerRG.selectAt(oT.estado);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: color_white,
            actions: [
              ElevatedButton(
                onPressed: () {
                  _updateEstadoDomicilio(oT);
                },
                child: Text(
                  "Guardar Cambios",
                  style: TextStyle(color: color_white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: color_primary),
              )
            ],
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(oT.ref!),
                  SizedBox(
                    height: marginSmallSmall,
                  ),
                  RadioGroup(
                    controller: widget.myControllerRG,
                    values: oListaEstado,
                    indexOfDefault: 0,
                    labelBuilder: (value) {
                      return Text(value.detalle_estado);
                    },
                    orientation: RadioGroupOrientation.horizontal,
                    decoration: RadioGroupDecoration(
                      spacing: 10.0,
                      labelStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      activeColor: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _updateEstadoDomicilio(DatoTransferAllPen oT) async {
    ModelResponse oM = await ProviderTransfer.updateEstadoTransfer(
        widget.myControllerRG.value.estado, oT.id!);

    if (oM.statusCode == 200) {
      Navigator.of(context).pop();
      _initReadTransferPenAll();
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
}
