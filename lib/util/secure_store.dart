import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'string.dart';

class SecureStore {
  final oFlutterSecureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<bool> createToken(token) async {
    try {
      await oFlutterSecureStorage.write(key: secure_token, value: token);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> readToken() async {
    try {
      return await oFlutterSecureStorage.read(key: secure_token);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
