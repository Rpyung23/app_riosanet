import 'package:http/http.dart' as http;
import '../model/install_pen_all/intall_pen_all_model.dart';
import '../util/secure_store.dart';
import '../util/url.dart';

class ProviderInstall {
  static Future<InstallAllPenModel> readInstallPenAll() async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();
      http.Response oResponse =
          await http.get(Uri.parse(url_install_all_pen), headers: headersApi);
      print(oResponse.body);
      return InstallAllPenModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return InstallAllPenModel(statusCode: 400, msm: e.toString());
    }
  }
}
