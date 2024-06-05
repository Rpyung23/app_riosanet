import 'dart:convert';

class DatosLoginModel {
  String? avatar;
  String? nombre;
  int firstLogin;

  DatosLoginModel({this.avatar, this.nombre, required this.firstLogin});

  factory DatosLoginModel.fromRawJson(String str) =>
      DatosLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatosLoginModel.fromJson(Map<String, dynamic> json) =>
      DatosLoginModel(
          avatar: json["avatar"],
          nombre: json["nombre"],
          firstLogin: json["firstLogin"]);

  Map<String, dynamic> toJson() =>
      {"avatar": avatar, "nombre": nombre, "firstLogin": firstLogin};
}
