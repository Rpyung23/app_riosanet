import 'package:app_riosanet/page/user/detalle_install_user.dart';
import 'package:app_riosanet/provider/ProviderInstall.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../../model/install_pen_all/dato_install_pen_model.dart';
import '../../model/install_pen_all/intall_pen_all_model.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/badge.dart';

class InstallPenUser extends StatefulWidget {
  final SignatureController oSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: color_white,
    exportBackgroundColor: color_white,
  );
  InstallAllPenModel? oInstallAllPenModel;

  InstallPenUser();

  @override
  State<InstallPenUser> createState() => _InstallPenUserState();
}

class _InstallPenUserState extends State<InstallPenUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.oSignatureController.clear();
    _initReadInstallPenAll();
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
      ),
    ));
  }

  Widget _getBody() {
    return ListView.builder(
      itemCount: widget.oInstallAllPenModel == null
          ? 0
          : widget.oInstallAllPenModel!.datos == null
              ? 0
              : widget.oInstallAllPenModel!.datos!.length,
      itemBuilder: (context, item) {
        if (widget.oInstallAllPenModel == null ||
            widget.oInstallAllPenModel!.datos == null ||
            widget.oInstallAllPenModel!.datos!.length == 0) {
          return CircularProgressIndicator(
            backgroundColor: color_primary,
          );
        }

        return _getItemInstallPen(
            widget.oInstallAllPenModel!.datos![item],
            widget.oInstallAllPenModel!.datos![item].name,
            widget.oInstallAllPenModel!.datos![item].tarea,
            widget.oInstallAllPenModel!.datos![item].nombreTecnico,
            widget.oInstallAllPenModel!.datos![item].cel);
      },
    );
  }

  _getItemInstallPen(DatoInstallPenAll oD, name, tarea, tecnico, cel) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text(name),
          contentPadding: EdgeInsets.all(0),
          subtitle: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tarea),
              BadgeComponent(
                title: oD!.estado == null || oD!.estado! == 0
                    ? "EN ESPERA"
                    : "EN PROCESO",
                color_background: oD!.estado == null || oD!.estado! == 0
                    ? color_secondary
                    : color_success,
              ),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        DetalleInstallPageUser(oDatoInstallPenAll: oD)));
                //launchUrl(Uri.parse('tel://$cel'));
              },
              icon: icon_see),
        ),
        Divider(height: 1, thickness: 1, color: color_primary)
      ],
    );
  }

  _initReadInstallPenAll() async {
    widget.oInstallAllPenModel = null;
    widget.oInstallAllPenModel = await ProviderInstall.readInstallPenAll();
    setState(() {});
  }

  Future<void> _refreshApi() async {
    await _initReadInstallPenAll();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.oSignatureController.dispose();
  }
}
