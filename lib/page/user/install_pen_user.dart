import 'package:app_riosanet/provider/ProviderInstall.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import '../../model/install_pen_all/dato_install_pen_model.dart';
import '../../model/install_pen_all/intall_pen_all_model.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InstallPenUser extends StatefulWidget {
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

  _getItemInstallPen(oD, name, tarea, tecnico, cel) {
    return ListTile(
      title: Text(name),
      contentPadding: EdgeInsets.all(0),
      subtitle: Text(tarea),
      leading: IconButton(
          onPressed: () {
            launchUrl(Uri.parse('tel://$cel'));
          },
          icon: icon_phone),
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
}
