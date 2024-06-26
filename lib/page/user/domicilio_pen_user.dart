// ignore_for_file: prefer_const_constructors

import 'package:app_riosanet/page/user/detalle_domicilio.dart';
import 'package:app_riosanet/util/string.dart';
import 'package:app_riosanet/widget/loading.dart';
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

import '../../widget/badge.dart';

class DomicilioPenUser extends StatefulWidget {
  bool initApiRest = true;
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
            body: widget.initApiRest
                ? Center(
                    child: LoadingComponent(),
                  )
                : Container(
                    padding: EdgeInsets.only(
                        top: marginSmallSmall,
                        left: marginSmallSmall,
                        right: marginSmallSmall),
                    child: RefreshIndicator(
                        child: _getBody(), onRefresh: _refreshApi),
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
            subtitle: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name == null ? "TICKET CLIENTE" : "CLIENTE : ${name}"),
                BadgeComponent(
                  title: oT!.estado == null || oT!.estado! == 1
                      ? "EN ESPERA"
                      : "EN PROCESO",
                  color_background: oT!.estado == null || oT!.estado! == 1
                      ? color_secondary
                      : color_success,
                )
              ],
            ),
            /*onTap: () {
              _showAlertProgress(oT);
            },*/
            trailing: IconButton(
                onPressed: () {
                  _showDetallePen(oT);
                  //openMap(lat, lng);
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
    widget.initApiRest = true;
    setState(() {});
    widget.oTransferAllClientModel = null;
    widget.oTransferAllClientModel = await ProviderTransfer.readTransferAll();
    widget.initApiRest = false;
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

  _showDetallePen(oT) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => DetalleDomicilioPageUser(
              oDatoTransferAllPen: oT,
            )));
    _initReadTransferPenAll();
  }
}
