import 'dart:convert';

class cProfileModel {
  int? statusCode;
  DatoProfileModel? datos;
  String? msm;

  cProfileModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory cProfileModel.fromRawJson(String str) =>
      cProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory cProfileModel.fromJson(Map<String, dynamic> json) => cProfileModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? null
            : DatoProfileModel.fromJson(json["datos"]),
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos?.toJson(),
        "msm": msm,
      };
}

class DatoProfileModel {
  String? nombre;
  String? correo;
  String? movil;
  String? latitude;
  String? longitude;
  String? direccion;
  String? avatar;

  DatoProfileModel({
    this.nombre,
    this.correo,
    this.movil,
    this.latitude,
    this.longitude,
    this.direccion,
    this.avatar,
  });

  factory DatoProfileModel.fromRawJson(String str) =>
      DatoProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoProfileModel.fromJson(Map<String, dynamic> json) =>
      DatoProfileModel(
        nombre: json["nombre"],
        correo: json["correo"],
        movil: json["movil"],
        latitude: json["latitude"] == null ? "0" : json["latitude"],
        longitude: json["longitude"] == null ? "0" : json["longitude"],
        direccion: json["direccion"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "movil": movil,
        "latitude": latitude,
        "longitude": longitude,
        "direccion": direccion,
        "avatar": avatar,
      };
}
