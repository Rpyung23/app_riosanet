import 'dart:convert';

class DatoFailPenAllModel {
  int? id;
  String? cedula;
  String? tarea;
  String? notaFallo;
  String? idTec;
  String? nombreTecnico;
  String? movil;
  String? nombre;
  String? direccion;
  String? latUsuario;
  String? lngUsuario;
  int? level;
  int? estado;

  DatoFailPenAllModel(
      {this.id,
      this.cedula,
      this.tarea,
      this.notaFallo,
      this.idTec,
      this.nombreTecnico,
      this.nombre,
      this.direccion,
      this.latUsuario,
      this.lngUsuario,
      this.movil,
      this.level,
      this.estado});

  factory DatoFailPenAllModel.fromRawJson(String str) =>
      DatoFailPenAllModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoFailPenAllModel.fromJson(Map<String, dynamic> json) =>
      DatoFailPenAllModel(
          id: json["id"],
          cedula: json["cedula"] == null ? 'S/N' : json["cedula"],
          tarea: json["tarea"] == null ? 'S/N' : json["tarea"],
          notaFallo: json["nota_fallo"] == null ? 'S/N' : json["nota_fallo"],
          idTec: json["id_tec"] == null ? "" : json["id_tec"],
          nombreTecnico: json["nombre_tecnico"] == null
              ? "AUTOTECNICO"
              : json["nombre_tecnico"],
          nombre: json["nombre"] == null ? '' : json["nombre"],
          direccion: json["direccion"] == null ? 'S/N' : json["direccion"],
          latUsuario: json["lat_usuario"] == null ? "0" : json["lat_usuario"],
          lngUsuario: json["lng_usuario"] == null ? "0" : json["lng_usuario"],
          movil: json["movil"] == null ? "" : json["movil"],
          level: json["level"] == null ? 1 : json["level"],
          estado: json["estado"] == null ? 1 : json["estado"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cedula": cedula,
        "tarea": tarea,
        "nota_fallo": notaFallo,
        "id_tec": idTec,
        "nombre_tecnico": nombreTecnico,
        "nombre": nombre,
        "direccion": direccion,
        "lat_usuario": latUsuario,
        "lng_usuario": lngUsuario,
        "movil": movil,
        "level": level,
        "estado": estado
      };
}
