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

    factory TransferPenAllModel.fromRawJson(String str) => TransferPenAllModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransferPenAllModel.fromJson(Map<String, dynamic> json) => TransferPenAllModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null ? [] : List<DatoTransferAllPen>.from(json["datos"]!.map((x) => DatoTransferAllPen.fromJson(x))),
        msm: json["msm"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos == null ? [] : List<dynamic>.from(datos!.map((x) => x.toJson())),
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
    });

    factory DatoTransferAllPen.fromRawJson(String str) => DatoTransferAllPen.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DatoTransferAllPen.fromJson(Map<String, dynamic> json) => DatoTransferAllPen(
        id: json["id"],
        cedula: json["cedula"],
        nombre: json["nombre"],
        cel: json["cel"],
        dir: json["dir"],
        ref: json["ref"],
        latTraspaso: json["lat_traspaso"]?.toDouble(),
        estado: json["estado"],
        lngTraspaso: json["lng_traspaso"]?.toDouble(),
        idTec: json["id_tec"],
        nombreTecnico: json["nombre_tecnico"],
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
    };
}
