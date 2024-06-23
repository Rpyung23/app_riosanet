import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color_primary);
  }
}
