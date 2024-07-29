import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../model/advertising_model.dart';
import '../../model/tip_model.dart';
import '../../provider/ProviderTip.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../widget/bottom_navigation_client.dart';
import '../../widget/floatingbottonSupport.dart';
import '../../widget/toolbar.dart';

class HomeClient extends StatefulWidget {
  List<DatoAdvertisingModel> oDatoAdvertisingModel = [];

  //ProviderTip oProviderTip = ProviderTip();
  //List<DatoAdvertisingModel> oDatoAdvertisingModel = [];

  HomeClient();

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAds();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      child: Scaffold(
        appBar: ToolBarWidget(),
        body: Container(
          padding: EdgeInsets.only(
              top: 0, left: marginSmallSmall, right: marginSmallSmall),
          child: _getBody(),
        ),
        floatingActionButton: getFloatingButtomSupport(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationClient(),
      ),
      canPop: false,
    ));
  }

  Widget _getBody() {
    return ListView(
      children: [
        SizedBox(
          height: marginSmallSmall,
        ),
        _getPostInvoice(),
        SizedBox(
          height: marginSmallSmall,
        ),
        Container(
          child: _getItemBody(),
        )
      ],
    );
  }

  _getPostInvoice() {
    return Card(
      color: color_primary,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  margin:
                      EdgeInsets.only(top: marginSmall, bottom: marginSmall),
                  child: Image.asset('./assets/help.png'),
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    next_bill,
                    style: TextStyle(
                        color: color_white,
                        fontSize: textBigMedium,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: marginSmallSmall,
                        right: marginSmallSmall,
                        left: marginSmallSmall),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("tip_page");
                      },
                      child: Text(
                        see_invoice,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: textBigMedium,
                            color: color_black),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, altoMedium)),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  _getItemBody() {
    return StaggeredGrid.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: GestureDetector(
              child: _getCardSpeedTest(),
              onTap: () {
                Navigator.of(context).pushNamed('speed_test_page');
              },
            )),
        /*Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),*/
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: _getCarrusel(),
        ),
      ],
    );
  }

  _getCardSpeedTest() {
    return Card(
      color: color_white,
      surfaceTintColor: color_white,
      child: Container(
        padding: EdgeInsets.all(marginSmallSmall),
        child: Column(
          children: [
            Image.asset(
              "./assets/speed_test.png",
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.cover,
            ),
            Text(
              title_speed_test,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: textBigMedium),
            ),
            Text(last_checked_speed_test),
            SizedBox(
              height: marginSmallSmall,
            ),
            /*ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('speed_test_page');
              },
              child: Text(
                text_check,
                style:
                    TextStyle(color: color_white, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: color_primary),
            )*/
          ],
        ),
      ),
    );
  }

  _getCarrusel() {
    return widget.oDatoAdvertisingModel.length == 0
        ? Container()
        : FlutterCarousel(
            options: CarouselOptions(
              height: 400.0,
              showIndicator: true,
              autoPlay: true,
              slideIndicator: CircularSlideIndicator(),
            ),
            items: widget.oDatoAdvertisingModel.map((i) {
              print(i.urlAnuncio);
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
                        i.urlAnuncio!,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/no_image.png');
                        },
                      ));
                },
              );
            }).toList(),
          );
  }

  _initAds() async {
    cAdvertisingModel oT = await ProviderTip.readAdvertising();
    if (oT.statusCode == 200) {
      widget.oDatoAdvertisingModel = oT.datos!;
    }
    setState(() {});
  }
}
