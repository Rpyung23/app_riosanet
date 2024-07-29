import 'package:app_riosanet/util/color.dart';
import 'package:app_riosanet/util/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../model/tip_model.dart';
import '../../provider/ProviderTip.dart';
import '../../util/dimens.dart';

class TipPage extends StatefulWidget {
  bool apiRequest = true;
  //List<DatoTip> oDatoTip = [];
  cTipModel? oTipModel = cTipModel(statusCode: 400, datos: null);
  TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  @override
  void initState() {
    // TODO: implement initState
    readTips();
    super.initState();
  }

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
        body: widget.apiRequest
            ? Center(
                child: CircularProgressIndicator(),
              )
            : widget.oTipModel!.datos == null
                ? Container(
                    child: Center(
                      child: Text("NO EXISTEN TIP'S DISPONIBLES"),
                    ),
                  )
                : _getBodyTipPage());
  }

  readTips() async {
    widget.oTipModel = await ProviderTip.readTip();
    widget.apiRequest = false;
    setState(() {});
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
        items: widget.oTipModel!.datos!.map((i) {
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
                  child: Image.network(
                    i.urlTipo!,
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/no_image.png');
                    },
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
