import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
        icons: [
          icon_data_home,
          icon_data_plann,
          icon_data_invoice,
          icon_data_profile
        ],
        activeIndex: 0,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {});
  }
}
