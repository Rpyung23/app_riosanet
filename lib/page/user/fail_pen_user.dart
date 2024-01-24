import 'package:app_riosanet/provider/ProviderFail.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import '../../model/fail_pen_all/fail_pen_all_model.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../widget/bottom_navigation_user.dart';
import '../../widget/toolbar.dart';
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
      appBar: ToolBarWidget(
        oDatosLoginModel: null,
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: marginSmallSmall,
            left: marginSmallSmall,
            right: marginSmallSmall),
        child: RefreshIndicator(child: _getBody(), onRefresh: _refreshApi),
      ),
      bottomNavigationBar: BottomNavigationUser(index_bottom_: 1),
    ));
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
            widget.oFailAllPenModel!.datos![item].latUsuario,
            widget.oFailAllPenModel!.datos![item].lngUsuario);
      },
    );
  }

  _getItemFailPen(name, tarea, tecnico, cel, lat, lng) {
    return ListTile(
      title: Text(name),
      subtitle: Text(tarea),
      trailing: IconButton(
          onPressed: () {
            openMap(lat, lng);
          },
          icon: icon_routing),
      leading: IconButton(
          onPressed: () {
            launchUrl(Uri.parse('tel://$cel'));
          },
          icon: icon_phone),
    );
  }

  _initReadFailPenAll() async {
    widget.oFailAllPenModel = null;
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
