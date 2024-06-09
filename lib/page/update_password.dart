import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';

import '../model/model_response.dart';
import '../provider/ProviderLogin.dart';
import '../util/dimens.dart';
import 'client/home_client.dart';
import 'user/home_user.dart';

class UpdatePasswordPage extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  String token;
  int tipo;
  TextEditingController oTextEditingController = TextEditingController();
  TextEditingController oTextEditingConfirmController = TextEditingController();

  UpdatePasswordPage({required this.token, required this.tipo});
  @override
  State<UpdatePasswordPage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<UpdatePasswordPage> {
  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: color_primary,
          title: Text(
            "Actualizar contraseña",
            style: TextStyle(color: color_white),
          ),
        ),
        body: Center(
          child: Container(
            child: _getFormPassword(),
            margin: EdgeInsets.all(20),
          ),
        ),
      ),
      canPop: false,
    );
  }

  _getFormPassword() {
    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.oTextEditingController,
            onChanged: (value) {
              widget._formKey.currentState!.validate();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Por favor, ingrese contraseña";
              } else {
                //call function to check password
                bool result = validatePassword(value);
                if (result) {
                  // create account event
                  return null;
                } else {
                  return "La contraseña debe contener mayúscula, minúscula, número y especial.";
                }
              }
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Iconsax.password_check,
                  color: Colors.black,
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(),
                hintText: "Contraseña"),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: widget.oTextEditingConfirmController,
            validator: (value) {
              if (widget.oTextEditingConfirmController.value.text.isNotEmpty) {
                if (widget.oTextEditingController.value.text.trim() ==
                    widget.oTextEditingConfirmController.value.text.trim()) {
                  return null;
                }

                return 'Contraseñas no coinciden';
              }
            },
            onChanged: (value) {
              if (widget.oTextEditingController.value.text.trim() ==
                  widget.oTextEditingConfirmController.value.text.trim()) {
                setState(() {
                  widget._formKey.currentState?.validate();
                });
              } else {
                setState(() {
                  widget._formKey.currentState?.validate();
                });
              }
            },
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Iconsax.password_check),
                border: OutlineInputBorder(),
                hintText: "Confirmar contraseña"),
          ),
          SizedBox(height: 15),
          LinearProgressIndicator(
            value: password_strength,
            backgroundColor: Colors.grey[300],
            minHeight: 5,
            color: password_strength <= 1 / 4
                ? Colors.red
                : password_strength == 2 / 4
                    ? Colors.yellow
                    : password_strength == 3 / 4
                        ? Colors.blue
                        : Colors.green,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: color_primary,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 55)),
                      onPressed: password_strength != 1
                          ? null
                          : () {
                              _updateTokenPassword();
                            },
                      child: Text(
                        "Actualizar",
                        style: TextStyle(color: color_white, fontSize: 17),
                      )))
            ],
          )
        ],
      ),
    );
  }

  _updateTokenPassword() async {
    if (!widget._formKey.currentState!.validate()) {
      return;
    }

    ModelResponse oModelResponse = await ProviderLogin.updatePasswordProvider(
        widget.tipo,
        widget.token,
        widget.oTextEditingController.value.text.trim());

    if (oModelResponse.statusCode == 200) {
      if (widget.tipo == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomeClient()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomeUser()));
      }
    } else {
      Fluttertoast.showToast(
          msg: oModelResponse.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: color_white,
          fontSize: textMedium);
    }
  }
}
