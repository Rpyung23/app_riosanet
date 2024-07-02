import 'dart:convert';

class cAdvertisingModel {
  int? statusCode;
  List<DatoAdvertisingModel>? datos;

  cAdvertisingModel({
    this.statusCode,
    this.datos,
  });

  factory cAdvertisingModel.fromRawJson(String str) =>
      cAdvertisingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory cAdvertisingModel.fromJson(Map<String, dynamic> json) =>
      cAdvertisingModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoAdvertisingModel>.from(
                json["datos"]!.map((x) => DatoAdvertisingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos == null
            ? []
            : List<dynamic>.from(datos!.map((x) => x.toJson())),
      };
}

class DatoAdvertisingModel {
  int? id;
  String? urlAnuncio;

  DatoAdvertisingModel({
    this.id,
    this.urlAnuncio,
  });

  factory DatoAdvertisingModel.fromRawJson(String str) =>
      DatoAdvertisingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoAdvertisingModel.fromJson(Map<String, dynamic> json) =>
      DatoAdvertisingModel(
        id: json["id"],
        urlAnuncio: json["url_anuncio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url_anuncio": urlAnuncio,
      };
}
