import 'dart:convert';

import 'data_login_model.dart';

class LoginClientUserModel {
  int? statusCode;
  DatosLoginModel? datos;
  String? token;
  String? msm;

  LoginClientUserModel({
    this.statusCode,
    this.datos,
    this.token,
    this.msm,
  });

  factory LoginClientUserModel.fromRawJson(String str) =>
      LoginClientUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginClientUserModel.fromJson(Map<String, dynamic> json) =>
      LoginClientUserModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? null
            : DatosLoginModel.fromJson(json["datos"]),
        token: json["token"],
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos?.toJson(),
        "token": token,
        "msm": msm,
      };
}
