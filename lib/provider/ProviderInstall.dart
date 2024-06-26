import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/install_pen_all/intall_pen_all_model.dart';
import '../model/model_response.dart';
import '../util/secure_store.dart';
import '../util/showtoastdialog.dart';
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

  static Future<ModelResponse> updateInstall(
      estado, url_img, notas, id_install, url_firma) async {
    try {
      SecureStore oSecureStore = new SecureStore();
      headersApi['x-access-token'] = await oSecureStore.readToken();

      http.Response oResponse =
          await http.put(Uri.parse(url_update_estado_install),
              headers: headersApi,
              encoding: encondingApi,
              body: jsonEncode({
                'estado': estado,
                'notas': notas,
                'url_img': url_img,
                'id_install': id_install,
                'url_firma': url_firma
              }));
      print(oResponse.body);
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast(
          'La instalación ha sido actualizado exitosamente.');
      return ModelResponse.fromRawJson(oResponse.body);
    } catch (e) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast(e.toString());
      return ModelResponse(statusCode: 400, msm: e.toString());
    }
  }
}
