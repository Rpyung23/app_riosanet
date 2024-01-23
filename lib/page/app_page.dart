import 'package:app_riosanet/page/client/home_client.dart';
import 'package:app_riosanet/page/session_page.dart';
import 'package:app_riosanet/page/speed_test_page.dart';
import 'package:app_riosanet/page/user/install_pen_user.dart';
import 'package:flutter/material.dart';

import '../util/color.dart';
import 'login_page.dart';
import 'client/profile_page.dart';

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
        routes: {
          'speed_test_page': (_) => SpeedTestPage(),
          'login_page': (_) => LoginPage(),
          'home_client_page': (_) => HomeClient(),
          'install_pen_user_page': (_) => InstallPenUser(),
          'session_page': (_) => SessionPage(
                tipo_: 0,
              ),
          'profile_page': (_) => ProfilePage(),
        },
        initialRoute: 'login_page');
  }
}
