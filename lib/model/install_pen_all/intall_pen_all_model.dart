import 'dart:convert';

import 'dato_install_pen_model.dart';

class InstallAllPenModel {
  int? statusCode;
  List<DatoInstallPenAll>? datos;
  String? msm;

  InstallAllPenModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory InstallAllPenModel.fromRawJson(String str) =>
      InstallAllPenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstallAllPenModel.fromJson(Map<String, dynamic> json) =>
      InstallAllPenModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoInstallPenAll>.from(
                json["datos"]!.map((x) => DatoInstallPenAll.fromJson(x))),
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos == null
            ? []
            : List<dynamic>.from(datos!.map((x) => x.toJson())),
        "msm": msm,
      };
}
