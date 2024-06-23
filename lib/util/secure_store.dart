import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'string.dart';

class SecureStore {
  final oFlutterSecureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<bool> createFCM(fcm) async {
    try {
      await oFlutterSecureStorage.write(key: fc_secure_token, value: fcm);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> readFCM() async {
    try {
      return await oFlutterSecureStorage.read(key: fc_secure_token);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> createToken(token) async {
    try {
      await oFlutterSecureStorage.write(key: secure_token, value: token);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> createProfile(profile) async {
    try {
      await oFlutterSecureStorage.write(key: profile_riosanet, value: profile);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> readProfile() async {
    try {
      return await oFlutterSecureStorage.read(key: profile_riosanet);
    } catch (e) {
      print(e.toString());
      return null;
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
