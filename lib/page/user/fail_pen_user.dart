import 'package:app_riosanet/page/user/detalle_fail_user.dart';
import 'package:app_riosanet/provider/ProviderFail.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/widget/loading.dart';
import 'package:flutter/material.dart';
import '../../model/fail_pen_all/dato_fail_pen_model.dart';
import '../../model/fail_pen_all/fail_pen_all_model.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/badge.dart';

class FailPenUser extends StatefulWidget {
  FailAllPenModel? oFailAllPenModel;
  bool initApiRest = true;
  FailPenUser({super.key});

  @override
  State<FailPenUser> createState() => _FailPenUserState();
}

class _FailPenUserState extends State<FailPenUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initReadFailPenAll();
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
      itemCount: widget.oFailAllPenModel == null
          ? 0
          : widget.oFailAllPenModel!.datos == null
              ? 0
              : widget.oFailAllPenModel!.datos!.length,
      itemBuilder: (context, item) {
        if (widget.oFailAllPenModel == null ||
            widget.oFailAllPenModel!.datos == null ||
            widget.oFailAllPenModel!.datos!.length == 0) {
          return CircularProgressIndicator(
            backgroundColor: color_primary,
          );
        }

        return _getItemFailPen(
            widget.oFailAllPenModel!.datos![item],
            widget.oFailAllPenModel!.datos![item].nombre,
            widget.oFailAllPenModel!.datos![item].tarea,
            widget.oFailAllPenModel!.datos![item].nombreTecnico,
            widget.oFailAllPenModel!.datos![item].movil,
            double.parse(widget.oFailAllPenModel!.datos![item].latUsuario!),
            double.parse(widget.oFailAllPenModel!.datos![item].lngUsuario!));
      },
    );
  }

  _getItemFailPen(DatoFailPenAllModel oF, name, tarea, tecnico, cel, lat, lng) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          title: Text(tarea),
          subtitle: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name == null ? "TICKET CLIENTE" : "CLIENTE : ${name}"),
              Row(
                children: [
                  BadgeComponent(
                    title: oF!.level! == 1
                        ? "BAJO"
                        : oF!.level! == 2
                            ? "MEDIO"
                            : "ALTO",
                    color_background: oF!.level! == 1
                        ? color_success
                        : oF!.level! == 2
                            ? color_primary
                            : color_danger,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  BadgeComponent(
                      title: oF.estado == 1 ? "EN ESPERA" : "EN PROCESO",
                      color_background:
                          oF.estado == 1 ? color_primary : color_success)
                ],
              )
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                lauchDetalle(oF);
                //openMap(lat, lng);
              },
              icon: icon_see),
          /*leading: IconButton(
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

  _initReadFailPenAll() async {
    widget.initApiRest = true;
    setState(() {});
    widget.oFailAllPenModel = null;
    print("FALLOS TECNICO");
    widget.oFailAllPenModel = await ProviderFail.readFailPenAll();
    widget.initApiRest = false;
    setState(() {});
  }

  Future<void> _refreshApi() async {
    await _initReadFailPenAll();
  }

  lauchDetalle(oF) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => DetalleFailPageUser(
              oDatoFailPenAllModel: oF,
            )));
    _initReadFailPenAll();
  }
}
