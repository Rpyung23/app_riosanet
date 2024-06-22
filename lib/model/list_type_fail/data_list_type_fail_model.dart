import 'dart:convert';

class DatoTypeFail {
  int? id;
  String? nombre;
  int? level;

  DatoTypeFail({this.id, this.nombre, this.level});

  factory DatoTypeFail.fromRawJson(String str) =>
      DatoTypeFail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoTypeFail.fromJson(Map<String, dynamic> json) => DatoTypeFail(
      id: json["id"], nombre: json["nombre"], level: json["level"]);

  Map<String, dynamic> toJson() => {"id": id, "nombre": nombre, "level": level};
}
