import 'package:app_riosanet/provider/ProviderFail.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import '../../model/fail_pen_all/fail_pen_all_model.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class FailPenUser extends StatefulWidget {
  FailAllPenModel? oFailAllPenModel;

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
            widget.oFailAllPenModel!.datos![item].nombre,
            widget.oFailAllPenModel!.datos![item].tarea,
            widget.oFailAllPenModel!.datos![item].nombreTecnico,
            widget.oFailAllPenModel!.datos![item].movil,
            double.parse(widget.oFailAllPenModel!.datos![item].latUsuario!),
            double.parse(widget.oFailAllPenModel!.datos![item].lngUsuario!));
      },
    );
  }

  _getItemFailPen(name, tarea, tecnico, cel, lat, lng) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          title: Text(tarea),
          subtitle: Text(name == null ? "TICKET CLIENTE" : "TECNICO : ${name}"),
          trailing: IconButton(
              onPressed: () {
                openMap(lat, lng);
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
    widget.oFailAllPenModel = null;
    print("FALLOS TECNICO");
    widget.oFailAllPenModel = await ProviderFail.readFailPenAll();
    setState(() {});
  }

  Future<void> _refreshApi() async {
    await _initReadFailPenAll();
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
}
