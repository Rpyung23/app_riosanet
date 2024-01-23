import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../page/user/fail_pen_user.dart';
import '../page/user/install_pen_user.dart';
import '../util/color.dart';
import '../util/dimens.dart';
import '../util/icons.dart';

class BottomNavigationUser extends StatefulWidget {
  int index_bottom = 0;
  BottomNavigationUser({required index_bottom_}) {
    index_bottom = index_bottom_;
  }

  @override
  State<BottomNavigationUser> createState() => _BottomNavigationUserState();
}

class _BottomNavigationUserState extends State<BottomNavigationUser> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
        backgroundColor: color_white,
        elevation: elevation,
        activeColor: color_secondary,
        icons: [
          icon_data_plann,
          icon_warning,
          icon_domicilio,
          icon_data_profile
        ],
        activeIndex: widget.index_bottom,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => InstallPenUser()));
          }

          if (index == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FailPenUser()));
          }
        });
  }
}
