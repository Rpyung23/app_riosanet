import 'dart:convert';

import 'dato_fail_pen_model.dart';

class FailAllPenModel {
  int? statusCode;
  List<DatoFailPenAllModel>? datos;
  String? msm;

  FailAllPenModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory FailAllPenModel.fromRawJson(String str) =>
      FailAllPenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FailAllPenModel.fromJson(Map<String, dynamic> json) =>
      FailAllPenModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoFailPenAllModel>.from(
                json["datos"]!.map((x) => DatoFailPenAllModel.fromJson(x))),
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
