import 'dart:convert';

class ModelResponse {
  int? statusCode;
  String? msm;

  ModelResponse({
    this.statusCode,
    this.msm,
  });

  factory ModelResponse.fromRawJson(String str) =>
      ModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelResponse.fromJson(Map<String, dynamic> json) => ModelResponse(
        statusCode: json["status_code"],
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msm": msm,
      };
}
