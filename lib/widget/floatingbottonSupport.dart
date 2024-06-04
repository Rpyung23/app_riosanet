import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/color.dart';
import '../util/dimens.dart';
import '../util/icons.dart';

Widget getFloatingButtomSupport() {
  return SizedBox(
    width: radius_circle_floating_button,
    height: radius_circle_floating_button,
    child: FittedBox(
      child: FloatingActionButton(
        onPressed: () {
          launchUrl(Uri.parse('tel://+593991336447'));
        },
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
