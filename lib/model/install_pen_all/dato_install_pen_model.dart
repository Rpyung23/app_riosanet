import 'dart:convert';

class DatoInstallPenAll {
  int? id;
  String? name;
  String? cel;
  String? dir;
  String? ciudad;
  String? tarea;
  String? ref;
  String? notas;
  String? idTec;
  String? nombreTecnico;

  DatoInstallPenAll({
    this.id,
    this.name,
    this.cel,
    this.dir,
    this.ciudad,
    this.tarea,
    this.ref,
    this.notas,
    this.idTec,
    this.nombreTecnico,
  });

  factory DatoInstallPenAll.fromRawJson(String str) =>
      DatoInstallPenAll.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoInstallPenAll.fromJson(Map<String, dynamic> json) =>
      DatoInstallPenAll(
        id: json["id"],
        name: json["name"],
        cel: json["cel"],
        dir: json["dir"],
        ciudad: json["ciudad"],
        tarea: json["tarea"],
        ref: json["ref"],
        notas: json["notas"],
        idTec: json["id_tec"],
        nombreTecnico: json["nombre_tecnico"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cel": cel,
        "dir": dir,
        "ciudad": ciudad,
        "tarea": tarea,
        "ref": ref,
        "notas": notas,
        "id_tec": idTec,
        "nombre_tecnico": nombreTecnico,
      };
}
