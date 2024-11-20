import 'package:app_riosanet/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../util/color.dart';
import '../../util/icons.dart';

class RecoveryPassPage extends StatefulWidget {
  TextEditingController oTextEditingController = TextEditingController();
  RecoveryPassPage({super.key});

  @override
  State<RecoveryPassPage> createState() => _RecoveryPassPageState();
}

class _RecoveryPassPageState extends State<RecoveryPassPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(marginMediumSmall),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color_primary,
                minimumSize: Size(double.infinity, altoMedium)),
            onPressed: () {
              _getEmail();
            },
            child: Text(
              "Solicitar contraseña",
              style: TextStyle(color: Colors.white),
            )),
      ),
      appBar: AppBar(
        backgroundColor: color_primary,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pop(widget.oMarker.first.position);
            },
            icon: icon_back),
        title: Text(
          "Recuperar Contraseña",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _getBody(),
    ));
  }

  _getBody() {
    return Container(
      margin: EdgeInsets.all(marginMediumSmall),
      child: TextFormField(
        controller: widget.oTextEditingController,
        decoration: InputDecoration(
            hintText: 'Ingrese su cédula  de identidad',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder()),
      ),
    );
  }

  _getEmail() async {
    if (widget.oTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Por favor, ingrese su cédula de identidad",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      await Future.delayed(Duration(seconds: 2));

      Fluttertoast.showToast(
          msg: "Hemos enviado un enlace a tu correo electrónico registrado.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: color_success,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
    }
  }
}
