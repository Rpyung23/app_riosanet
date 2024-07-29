import '../model/advertising_model.dart';
import '../model/tip_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../util/url.dart';

class ProviderTip {
  static Future<cTipModel> readTip() async {
    try {
      http.Response oResponse = await http.get(Uri.parse(url_tip));
      return cTipModel.fromRawJson(oResponse.body);
    } catch (e) {
      return cTipModel(statusCode: 400, datos: null);
    }
  }

  static Future<cAdvertisingModel> readAdvertising() async {
    try {
      http.Response oResponse = await http.get(Uri.parse(url_advertising));
      return cAdvertisingModel.fromRawJson(oResponse.body);
    } catch (e) {
      return cAdvertisingModel(statusCode: 400, datos: []);
    }
  }
}
