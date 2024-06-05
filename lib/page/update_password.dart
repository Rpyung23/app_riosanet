import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);
  @override
  State<UpdatePasswordPage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
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
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (value) {
              _formKey.currentState!.validate();
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
                border: OutlineInputBorder(), hintText: "Contraseña"),
          ),
          SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Confirmar contraseña"),
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
                              //perform click event
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
}
