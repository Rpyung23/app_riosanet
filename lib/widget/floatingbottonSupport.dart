import 'package:flutter/material.dart';
import '../util/color.dart';
import '../util/dimens.dart';
import '../util/icons.dart';

Widget getFloatingButtomSupport() {
  return SizedBox(
    width: radius_circle_floating_button,
    height: radius_circle_floating_button,
    child: FittedBox(
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: color_primary,
        shape: const CircleBorder(),
        child: Icon(
          icon_data_support,
          color: color_white,
        ),
      ),
    ),
  );
}
