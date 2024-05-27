import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/fail_pen_all/fail_pen_all_model.dart';
import '../model/fail_pen_all_client/fail_pen_all_client_model.dart';
import '../model/list_type_fail/list_type_fail_model.dart';
import '../model/model_response.dart';
import '../util/secure_store.dart';
import '../util/url.dart';

class ProviderFail {
  static Future<FailAllPenModel> readFailPenAll() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse =
          await http.get(Uri.parse(url_fail_all_pen), headers: headersApi);
      print(oResponse.body);
      return FailAllPenModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return FailAllPenModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<FailAllPenClientModel> readFailPenAllClient() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse = await http
          .get(Uri.parse(url_fail_all_pen_client), headers: headersApi);
      print(oResponse.body);
      return FailAllPenClientModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return FailAllPenClientModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelResponse> deleteFail(id_fail) async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();

      http.Response oResponse = await http.delete(Uri.parse(url_delete_fail),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({'id_fail': id_fail}));
      return ModelResponse.fromRawJson(oResponse.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelListTypeFail> readTypeFail() async {
    try {
      http.Response oResponse =
          await http.get(Uri.parse(url_type_fail), headers: headersApi);
      print(oResponse.body);
      return ModelListTypeFail.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return ModelListTypeFail(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelResponse> createFail(name_fail, notes_fail) async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();

      http.Response oResponse = await http.post(Uri.parse(url_create_fail),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({'tarea': name_fail, 'notas': notes_fail}));
      return ModelResponse.fromRawJson(oResponse.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }
}
