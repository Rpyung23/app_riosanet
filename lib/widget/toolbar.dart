import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/secure_store.dart';
import 'package:flutter/material.dart';

import '../model/login/data_login_model.dart';
import '../util/dimens.dart';
import '../util/string.dart';

class ToolBarWidget extends StatefulWidget implements PreferredSizeWidget {
  DatosLoginModel? oDatosLoginModel;
  SecureStore oSecureStore = SecureStore();
  ToolBarWidget();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<ToolBarWidget> createState() => _ToolBarWidgetState();
}

class _ToolBarWidgetState extends State<ToolBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initReadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color_primary,
      elevation: elevation,
      leading: Container(
        margin: EdgeInsets.all(marginSmallSmall),
        child: CircleAvatar(
          radius: radioContainer,
          child: Text(widget.oDatosLoginModel == null
              ? "/"
              : widget.oDatosLoginModel!.nombre![0]),
        ),
      ),
      title: Text(
        widget.oDatosLoginModel == null
            ? no_name
            : widget.oDatosLoginModel!.nombre!,
        style: TextStyle(color: color_white),
      ),
      centerTitle: false,
      //actions: [IconButton(onPressed: () {}, icon: icon_notification)],
    );
  }

  _initReadProfile() async {
    var profile = await widget.oSecureStore.readProfile();
    if (profile != null) {
      try {
        widget.oDatosLoginModel = DatosLoginModel.fromRawJson(profile);
        setState(() {});
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

/*class ToolBarWidget extends StatelessWidget implements PreferredSizeWidget {
  DatosLoginModel? oDatosLoginModel;
  ToolBarWidget({required this.oDatosLoginModel});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color_primary,
      elevation: elevation,
      leading: Container(
        margin: EdgeInsets.all(marginSmallSmall),
        child: CircleAvatar(
          radius: radioContainer,
          child: Text(this.oDatosLoginModel == null
              ? "/"
              : this.oDatosLoginModel!.nombre![0]),
        ),
      ),
      title: Text(
        this.oDatosLoginModel == null
            ? no_name
            : this.oDatosLoginModel!.nombre!,
        style: TextStyle(color: color_white),
      ),
      centerTitle: false,
      //actions: [IconButton(onPressed: () {}, icon: icon_notification)],
    );
  }
}*/
