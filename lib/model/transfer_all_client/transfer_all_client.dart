import 'dart:convert';

class TransferAllClientModel {
  int? statusCode;
  List<DatoTransferClient>? datos;
  String? msm;

  TransferAllClientModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory TransferAllClientModel.fromRawJson(String str) =>
      TransferAllClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransferAllClientModel.fromJson(Map<String, dynamic> json) =>
      TransferAllClientModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoTransferClient>.from(
                json["datos"]!.map((x) => DatoTransferClient.fromJson(x))),
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

class DatoTransferClient {
  int? id;
  String? cedula;
  String? nombre;
  String? cel;
  String? dir;
  String? ref;
  double? latTraspaso;
  int? estado;
  double? lngTraspaso;
  String? idTec;
  String? nombreTecnico;

  String? anotaciones;
  String? img_evidencia;
  String? img_firma;

  DatoTransferClient(
      {this.id,
      this.cedula,
      this.nombre,
      this.cel,
      this.dir,
      this.ref,
      this.latTraspaso,
      this.estado,
      this.lngTraspaso,
      this.idTec,
      this.nombreTecnico,
      this.anotaciones,
      this.img_evidencia,
      this.img_firma});

  factory DatoTransferClient.fromRawJson(String str) =>
      DatoTransferClient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoTransferClient.fromJson(Map<String, dynamic> json) =>
      DatoTransferClient(
        id: json["id"],
        cedula: json["cedula"],
        nombre: json["nombre"] == null ? "AUTOTECNICO" : json["nombre"],
        cel: json["cel"],
        dir: json["dir"],
        ref: json["ref"],
        latTraspaso:
            json["lat_traspaso"] == null ? 0 : json["lat_traspaso"]?.toDouble(),
        estado: json["estado"],
        lngTraspaso:
            json["lng_traspaso"] == null ? 0 : json["lng_traspaso"]?.toDouble(),
        idTec: json["id_tec"],
        nombreTecnico: json["nombre_tecnico"],
        anotaciones: json["anotaciones"] == null ? '' : json["anotaciones"],
        img_evidencia:
            json["img_evidencia"] == null ? '' : json["img_evidencia"],
        img_firma: json["img_firma"] == null ? '' : json["img_firma"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cedula": cedula,
        "nombre": nombre,
        "cel": cel,
        "dir": dir,
        "ref": ref,
        "lat_traspaso": latTraspaso,
        "estado": estado,
        "lng_traspaso": lngTraspaso,
        "id_tec": idTec,
        "nombre_tecnico": nombreTecnico,
        "anotaciones": anotaciones,
        "img_evidencia": img_evidencia,
        "img_firma": img_firma,
      };
}
