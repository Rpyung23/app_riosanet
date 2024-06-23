import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_riosanet/model/login/login_model.dart';
import 'package:app_riosanet/util/url.dart';

import '../model/model_response.dart';
import '../util/secure_store.dart';

class ProviderLogin {
  static Future<ModelResponse> updatePasswordProvider(tipo, token, pass) async {
    try {
      headersApi['x-access-token'] = token;

      http.Response oR = await http.put(
          Uri.parse(tipo == 1 ? url_update_password : url_update_password_user),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({'pass': pass}));
      print(oR.body);
      return ModelResponse.fromRawJson(oR.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }

  static Future<LoginClientUserModel> loginProvider(user, pass, tipo) async {
    SecureStore oSecureStore = SecureStore();
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
          body: jsonEncode({
            "user": user,
            "pass": pass,
            "fcm": await oSecureStore.readFCM()
          }));

      return LoginClientUserModel.fromRawJson(oResponse.body);
    } catch (e) {
      return LoginClientUserModel(statusCode: 400, msm: e.toString());
    }
  }
}
