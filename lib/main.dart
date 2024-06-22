import 'package:app_riosanet/page/app_page.dart';
import 'package:app_riosanet/util/firebase_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtils.initialzeFirebase();
  EasyLoading.init();
  runApp(AppPage());
}
