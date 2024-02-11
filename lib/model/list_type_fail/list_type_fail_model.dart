import 'dart:convert';

import 'data_list_type_fail_model.dart';

class ModelListTypeFail {
  int? statusCode;
  List<DatoTypeFail>? datos;
  String? msm;

  ModelListTypeFail({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory ModelListTypeFail.fromRawJson(String str) =>
      ModelListTypeFail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelListTypeFail.fromJson(Map<String, dynamic> json) =>
      ModelListTypeFail(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoTypeFail>.from(
                json["datos"]!.map((x) => DatoTypeFail.fromJson(x))),
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
