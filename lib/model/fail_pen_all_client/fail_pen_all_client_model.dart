import 'dart:convert';

class FailAllPenClientModel {
  int? statusCode;
  List<DatoFailAllPenClientModel>? datos;
  String? msm;

  FailAllPenClientModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory FailAllPenClientModel.fromRawJson(String str) =>
      FailAllPenClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FailAllPenClientModel.fromJson(Map<String, dynamic> json) =>
      FailAllPenClientModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoFailAllPenClientModel>.from(json["datos"]!
                .map((x) => DatoFailAllPenClientModel.fromJson(x))),
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

class DatoFailAllPenClientModel {
  int? id;
  String? cedula;
  String? tarea;
  String? notaFallo;
  String? idTec;
  String? nombreTecnico;
  String? nombre;
  String? direccion;
  String? movil;
  String? latUsuario;
  String? lngUsuario;
  int? estado;
  int? level;

  DatoFailAllPenClientModel(
      {this.id,
      this.cedula,
      this.tarea,
      this.notaFallo,
      this.idTec,
      this.nombreTecnico,
      this.nombre,
      this.direccion,
      this.movil,
      this.latUsuario,
      this.lngUsuario,
      this.estado,
      this.level});

  factory DatoFailAllPenClientModel.fromRawJson(String str) =>
      DatoFailAllPenClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoFailAllPenClientModel.fromJson(Map<String, dynamic> json) =>
      DatoFailAllPenClientModel(
          id: json["id"],
          cedula: json["cedula"],
          tarea: json["tarea"],
          notaFallo: json["nota_fallo"],
          idTec: json["id_tec"],
          nombreTecnico: json["nombre_tecnico"],
          nombre: json["nombre"],
          direccion: json["direccion"],
          movil: json["movil"],
          latUsuario: json["lat_usuario"],
          lngUsuario: json["lng_usuario"],
          estado: json["estado"],
          level: json["level"] == null ? 1 : json["level"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cedula": cedula,
        "tarea": tarea,
        "nota_fallo": notaFallo,
        "id_tec": idTec,
        "nombre_tecnico": nombreTecnico,
        "nombre": nombre,
        "direccion": direccion,
        "movil": movil,
        "lat_usuario": latUsuario,
        "lng_usuario": lngUsuario,
        "estado": estado,
        "level": level
      };
}
