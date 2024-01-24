import 'package:http/http.dart' as http;

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
}
