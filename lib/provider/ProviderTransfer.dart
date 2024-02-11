import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model_response.dart';
import '../model/transfer_all_client/transfer_all_client.dart';
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
}
