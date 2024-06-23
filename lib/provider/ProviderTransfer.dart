import 'dart:convert';

import 'package:app_riosanet/util/showtoastdialog.dart';
import 'package:http/http.dart' as http;

import '../model/model_response.dart';
import '../model/transfer_all_client/transfer_all_client.dart';
import '../model/transfer_all_pen.dart';
import '../util/secure_store.dart';
import '../util/url.dart';

class ProviderTransfer {
  static Future<TransferAllClientModel> readTransferClientAll() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse = await http
          .get(Uri.parse(url_update_domiclio_client), headers: headersApi);
      print(oResponse.body);
      return TransferAllClientModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return TransferAllClientModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelResponse> deleteTransfers(int id_transfer) async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();

      http.Response oResponse = await http.delete(
          Uri.parse(url_delete_transfer),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({'id_transfer': id_transfer}));
      return ModelResponse.fromRawJson(oResponse.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelResponse> createTransfer(String dir, String cel,
      String ref, String notas, double lat, double lng) async {
    try {
      http.Response oR = await http.post(Uri.parse(url_create_transfer),
          body: jsonEncode({
            "dir": dir,
            "cel": cel,
            "ref": ref,
            "notas": notas,
            "lat_traspaso": lat,
            "lng_traspaso": lng
          }),
          encoding: encondingApi,
          headers: headersApi);
      return ModelResponse.fromRawJson(oR.body);
    } catch (e) {
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }

  static Future<TransferPenAllModel> readTransferAll() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse =
          await http.get(Uri.parse(url_read_all_transfer), headers: headersApi);
      print(oResponse.body);
      return TransferPenAllModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return TransferPenAllModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ModelResponse> updateEstadoTransfer(
      estado, anotaciones, img_evidencia, img_firma, id_traspaso) async {
    try {
      ShowToastDialog.showLoader();
      //print("ID : " + id.toString());
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse =
          await http.put(Uri.parse(url_update_estado_transfer),
              body: jsonEncode({
                "estado": estado,
                "anotaciones": anotaciones,
                "img_evidencia": img_evidencia,
                "img_firma": img_firma,
                "id_traspaso": id_traspaso
              }),
              encoding: encondingApi,
              headers: headersApi);
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("Estado actualizado con éxito");
      return ModelResponse.fromRawJson(oResponse.body);
    } catch (e) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast(e.toString());
      print(e.toString());
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }
}
