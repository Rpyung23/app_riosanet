import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_riosanet/model/login/login_model.dart';
import 'package:app_riosanet/util/url.dart';

class ProviderLogin {
  static Future<LoginClientUserModel> loginProvider(user, pass, tipo) async {
    print("USUARIO : ${user}");
    print("PASS : ${pass}");
    print("TIPO : ${tipo}");
    // 1 -> cliente
    // 0 -> (tecnico)
    try {
      http.Response oResponse = await http.post(
          Uri.parse(tipo == 1 ? url_login_client : url_login_user),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({"user": user, "pass": pass}));

      return LoginClientUserModel.fromRawJson(oResponse.body);
    } catch (e) {
      return LoginClientUserModel(statusCode: 400, msm: e.toString());
    }
  }
}
