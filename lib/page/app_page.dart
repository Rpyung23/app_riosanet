import 'package:app_riosanet/page/client/domicilio_page.dart';
import 'package:app_riosanet/page/client/home_client.dart';
import 'package:app_riosanet/page/session_page.dart';
import 'package:app_riosanet/page/speed_test_page.dart';
import 'package:app_riosanet/page/user/install_pen_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../util/color.dart';
import 'client/fail_page.dart';
import 'client/tip_page.dart';
import 'login_page.dart';
import 'client/profile_page.dart';
import 'siganture_page.dart';
import 'update_password.dart';

class AppPage extends StatelessWidget {
  AppPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RIOSANET',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: color_fondo,
            useMaterial3: true,
            fontFamily: 'Avenir'),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: color_fondo,
            useMaterial3: true,
            fontFamily: 'Avenir'),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        routes: {
          'update_pass': (_) => UpdatePasswordPage(
                token: "",
                tipo: 0,
              ),
          'speed_test_page': (_) => SpeedTestPage(),
          'tip_page': (_) => TipPage(),
          'login_page': (_) => LoginPage(),
          'home_client_page': (_) => HomeClient(),
          'install_pen_user_page': (_) => InstallPenUser(),
          'session_page': (_) => SessionPage(
                tipo_: 0,
              ),
          'profile_page': (_) => ProfilePage(),
          'fail_client_page': (_) => FailClientPage(),
          'update_domiclio_client_page': (_) => UpdateDomicilioPageClient(),
          'signature': (_) => SignaturePage()
        },
        initialRoute: 'login_page');
  }
}
