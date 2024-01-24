import 'package:http/http.dart' as http;

import '../model/fail_pen_all/fail_pen_all_model.dart';
import '../model/fail_pen_all_client/fail_pen_all_client_model.dart';
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
}
