import 'package:app_riosanet/page/session_page.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import '../util/dimens.dart';
import '../util/image.dart';
import '../util/string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _getfondo(),
        Align(alignment: Alignment.bottomCenter, child: _getButtons(context))
      ],
    ));
  }

  _getfondo() {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: image_network,
        fit: BoxFit.cover,
      ),
    ));
  }

  _getButtons(context) {
    return Container(
      margin: EdgeInsets.all(marginSmallSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              /*Navigator.of(context)
                  .pushNamed("session_page", arguments: {"tipo_": 1});*/
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SessionPage(tipo_: 1)));
            },
            child: Text(
              txt_client,
              style: TextStyle(color: color_white, fontSize: textMedium),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: color_primary,
                elevation: 1,
                minimumSize: Size(
                  double.infinity,
                  altoMedium,
                )),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                /*Navigator.of(context)
                    .pushNamed("session_page", arguments: {"tipo_": 0});*/
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SessionPage(tipo_: 0)));
              },
              child: Text(txt_technical,
                  style: TextStyle(color: color_white, fontSize: textMedium)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: color_secondary,
                  minimumSize: Size(
                    double.infinity,
                    altoMedium,
                  )))
        ],
      ),
    );
  }
}
