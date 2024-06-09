import 'dart:convert';

import '../model/model_response.dart';
import '../model/profile_client_model.dart';
import 'package:http/http.dart' as http;

import '../util/secure_store.dart';
import '../util/url.dart';

class ProviderClient {
  Future<cProfileModel> readProfileClient() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oR =
          await http.get(Uri.parse(url_profile_client), headers: headersApi);
      print(oR.body);
      return cProfileModel.fromRawJson(oR.body);
    } catch (e) {
      print(e.toString());
      return cProfileModel(statusCode: 400, msm: e.toString());
    }
  }

  Future<ModelResponse> updateProfileClient(
      nombre, correo, telefono, referencia, latitude, longitude) async {
    try {
      http.Response oR = await http.put(Uri.parse(url_update_profile_client),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({
            "nombre": nombre,
            "correo": correo,
            "telefono": telefono,
            "referencia": referencia,
            "latitude": latitude,
            "longitude": longitude
          }));
      return ModelResponse.fromRawJson(oR.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }
}
