import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';

import '../util/dimens.dart';
import '../util/icons.dart';

class BottomNavigationClient extends StatefulWidget {
  const BottomNavigationClient({super.key});

  @override
  State<BottomNavigationClient> createState() => _BottomNavigationClientState();
}

class _BottomNavigationClientState extends State<BottomNavigationClient> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
        backgroundColor: color_white,
        elevation: elevation,
        activeColor: color_secondary,
        icons: [
          icon_data_home,
          icon_warning,
          icon_domicilio,
          icon_data_profile
        ],
        activeIndex: 0,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          if (index == 3) {
            Navigator.of(context).pushNamed('profile_page');
          }
          if (index == 1) {
            Navigator.of(context).pushNamed('fail_client_page');
          }

          if (index == 2) {
            Navigator.of(context).pushNamed('update_domiclio_client_page');
          }
        });
  }
}
