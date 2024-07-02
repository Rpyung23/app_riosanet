import 'dart:convert';

class cTipModel {
  int? statusCode;
  List<DatoTip>? datos;

  cTipModel({
    this.statusCode,
    this.datos,
  });

  factory cTipModel.fromRawJson(String str) =>
      cTipModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory cTipModel.fromJson(Map<String, dynamic> json) => cTipModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoTip>.from(
                json["datos"]!.map((x) => DatoTip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos == null
            ? []
            : List<dynamic>.from(datos!.map((x) => x.toJson())),
      };
}

class DatoTip {
  int? idTip;
  String? urlTipo;

  DatoTip({
    this.idTip,
    this.urlTipo,
  });

  factory DatoTip.fromRawJson(String str) => DatoTip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoTip.fromJson(Map<String, dynamic> json) => DatoTip(
        idTip: json["id_tip"],
        urlTipo: json["url_tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id_tip": idTip,
        "url_tipo": urlTipo,
      };
}
