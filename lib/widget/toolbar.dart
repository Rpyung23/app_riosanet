import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';

import '../util/dimens.dart';
import '../util/string.dart';

class ToolBarWidget extends StatelessWidget implements PreferredSizeWidget {
  ToolBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color_primary,
      elevation: elevation,
      leading: Container(
        margin: EdgeInsets.all(marginSmallSmall),
        child: CircleAvatar(
          radius: radioContainer,
          child: Text("T"),
        ),
      ),
      title: Text(
        no_name,
        style: TextStyle(color: color_white),
      ),
      centerTitle: false,
      //actions: [IconButton(onPressed: () {}, icon: icon_notification)],
    );
  }
}
