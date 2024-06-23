import 'dart:convert';

class TransferPenAllModel {
  int? statusCode;
  List<DatoTransferAllPen>? datos;
  String? msm;

  TransferPenAllModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory TransferPenAllModel.fromRawJson(String str) =>
      TransferPenAllModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransferPenAllModel.fromJson(Map<String, dynamic> json) =>
      TransferPenAllModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoTransferAllPen>.from(
                json["datos"]!.map((x) => DatoTransferAllPen.fromJson(x))),
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

class DatoTransferAllPen {
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

  DatoTransferAllPen({
    this.id,
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
    this.img_firma,
  });

  factory DatoTransferAllPen.fromRawJson(String str) =>
      DatoTransferAllPen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoTransferAllPen.fromJson(Map<String, dynamic> json) =>
      DatoTransferAllPen(
        id: json["id"],
        cedula: json["cedula"],
        nombre: json["nombre"],
        cel: json["cel"],
        dir: json["dir"],
        ref: json["ref"],
        latTraspaso: json["lat_traspaso"] == null || json["lat_traspaso"] == 0
            ? 0.0
            : json["lat_traspaso"],
        estado: json["estado"],
        lngTraspaso: json["lng_traspaso"] == null || json["lng_traspaso"] == 0
            ? 0.0
            : json["lng_traspaso"],
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
