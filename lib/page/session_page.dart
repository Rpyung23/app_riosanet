import 'package:app_riosanet/page/client/home_client.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/dimens.dart';
import 'package:app_riosanet/util/icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/login/login_model.dart';
import '../provider/ProviderLogin.dart';
import '../util/secure_store.dart';
import '../util/string.dart';
import 'user/install_pen_user.dart';

class SessionPage extends StatefulWidget {
  SecureStore oSecureStore = new SecureStore();
  GlobalKey<FormState> _formKeySession = GlobalKey<FormState>();
  TextEditingController oTextEditingControllerUser = TextEditingController();
  TextEditingController oTextEditingControllerPass = TextEditingController();
  int tipo = 0;
  SessionPage({required tipo_}) {
    this.tipo = tipo_;
  }

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.all(marginSmall),
        child: Center(
          child: Card(
            color: color_white,
            surfaceTintColor: color_primary,
            child: Container(
              margin: EdgeInsets.all(marginSmall),
              child: _getLogin(),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _getLogin() {
    return Form(
        key: widget._formKeySession,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("./assets/logo.png"),
            SizedBox(
              height: marginMedium,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return txt_ingrese_user;
                }
              },
              controller: widget.oTextEditingControllerUser,
              decoration: InputDecoration(
                  hintText: hint_user,
                  prefixIcon: icon_user,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary))),
            ),
            SizedBox(
              height: marginSmall,
            ),
            TextFormField(
              obscureText: true,
              controller: widget.oTextEditingControllerPass,
              obscuringCharacter: obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return txt_ingrese_pass;
                }
              },
              decoration: InputDecoration(
                  hintText: hint_pass,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  prefixIcon: icon_pass),
            ),
            SizedBox(
              height: marginMedium,
            ),
            ElevatedButton(
              onPressed: () {
                _showApiSession();
              },
              child: Text(
                txt_ingresar,
                style: TextStyle(color: color_white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: color_secondary,
                  minimumSize: Size(double.infinity, altoMedium)),
            )
          ],
        ));
  }

  _showApiSession() async {
    if (!widget._formKeySession.currentState!.validate()) {
      return;
    }
    LoginClientUserModel oLoginClientUserModel =
        await ProviderLogin.loginProvider(
            widget.oTextEditingControllerUser.text,
            widget.oTextEditingControllerPass.text,
            widget.tipo);

    if (oLoginClientUserModel.statusCode == 200) {
      widget.oSecureStore.createToken(oLoginClientUserModel.token);

      widget.oSecureStore
          .createProfile(oLoginClientUserModel.datos!.toRawJson());

      if (widget.tipo == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomeClient()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => InstallPenUser()));
      }

      /*Navigator.of(context).pushNamed(
          widget.tipo == 1 ? 'home_client_page' : 'install_pen_user_page');*/
    } else {
      Fluttertoast.showToast(
          msg: oLoginClientUserModel.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: color_white,
          fontSize: textMedium);
    }
  }
}
