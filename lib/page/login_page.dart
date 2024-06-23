import 'package:app_riosanet/page/session_page.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../util/dimens.dart';
import '../util/image.dart';
import '../util/string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    _requestNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _getfondo(),
        Align(alignment: Alignment.bottomCenter, child: _getButtons(context))
      ],
    ));
  }

  _getfondo() {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: image_network,
        fit: BoxFit.cover,
      ),
    ));
  }

  _getButtons(context) {
    return Container(
      margin: EdgeInsets.all(marginSmallSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              /*Navigator.of(context)
                  .pushNamed("session_page", arguments: {"tipo_": 1});*/
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SessionPage(tipo_: 1)));
            },
            child: Text(
              txt_client,
              style: TextStyle(color: color_white, fontSize: textMedium),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: color_primary,
                elevation: 1,
                minimumSize: Size(
                  double.infinity,
                  altoMedium,
                )),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                /*Navigator.of(context)
                    .pushNamed("session_page", arguments: {"tipo_": 0});*/
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SessionPage(tipo_: 0)));
              },
              child: Text(txt_technical,
                  style: TextStyle(color: color_white, fontSize: textMedium)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: color_secondary,
                  minimumSize: Size(
                    double.infinity,
                    altoMedium,
                  )))
        ],
      ),
    );
  }

  _requestNotification() async {
    bool allGranted = false;

    while (!allGranted) {
      // Solicitar permisos de estado del teléfono y notificaciones.
      Map<Permission, PermissionStatus> statuses =
          await [Permission.notification].request();

      // Verificar el estado de cada permiso.
      allGranted = statuses[Permission.notification]!.isGranted;

      if (!allGranted) {
        // Mostrar un mensaje al usuario indicando que los permisos son necesarios.
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: color_white,
            surfaceTintColor: color_white,
            title: Text('Permisos necesarios'),
            content: Text(
                'Para continuar, la aplicación necesita permisos de notificación.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Reintentar'),
              ),
            ],
          ),
        );
      }
    }
  }
}
