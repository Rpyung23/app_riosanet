import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../util/dimens.dart';

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color_primary,
          iconTheme: IconThemeData(color: color_white),
          title: Text(
            see_invoice,
            style: TextStyle(color: color_white),
          ),
        ),
        body: _getBodyTipPage());
  }

  _getBodyTipPage() {
    return Center(
      child: FlutterCarousel(
        options: CarouselOptions(
          height: 400.0,
          showIndicator: true,
          autoPlay: true,
          slideIndicator: CircularSlideIndicator(),
        ),
        items: [
          './assets/tips/tip1.jpeg',
          './assets/tips/tip2.jpeg',
          './assets/tips/tip3.jpeg'
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      right: marginSmallSmall, bottom: marginSmall),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radioSearch)),
                  child: Image.asset(
                    i,
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ));
            },
          );
        }).toList(),
      ),
    );
  }

  /*_getBodyTipPage() {
    return Container(
      margin: EdgeInsets.only(top: 15, right: 15, left: 15),
      child: ListView(
        children: [
          Image.asset(
            "assets/tips/tip1.jpeg",
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/tips/tip2.jpeg",
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/tips/tip3.jpeg",
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          )
        ],
      ),
    );
  }*/
}
