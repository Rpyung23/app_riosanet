import 'dart:convert';

class DatoTypeFail {
  int? id;
  String? nombre;

  DatoTypeFail({
    this.id,
    this.nombre,
  });

  factory DatoTypeFail.fromRawJson(String str) =>
      DatoTypeFail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoTypeFail.fromJson(Map<String, dynamic> json) => DatoTypeFail(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
