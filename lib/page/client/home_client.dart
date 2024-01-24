import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../model/login/data_login_model.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../widget/bottom_navigation_client.dart';
import '../../widget/floatingbottonSupport.dart';
import '../../widget/toolbar.dart';

class HomeClient extends StatefulWidget {
  DatosLoginModel? oDatosLoginModel;
  HomeClient({required this.oDatosLoginModel});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ToolBarWidget(
        oDatosLoginModel: widget.oDatosLoginModel,
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: 0, left: marginSmallSmall, right: marginSmallSmall),
        child: _getBody(),
      ),
      floatingActionButton: getFloatingButtomSupport(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationClient(),
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
                      onPressed: () {},
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
        _getCardSpeedTest(),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('speed_test_page');
              },
              child: Text(
                text_check,
                style:
                    TextStyle(color: color_white, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: color_primary),
            )
          ],
        ),
      ),
    );
  }

  _getCarrusel() {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 400.0,
        showIndicator: true,
        autoPlay: true,
        slideIndicator: CircularSlideIndicator(),
      ),
      items: [
        './assets/p2.jpeg',
        './assets/p3.jpeg',
        './assets/p4.jpeg',
        './assets/p5.jpeg',
        './assets/p1.jpeg'
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
                  fit: BoxFit.cover,
                ));
          },
        );
      }).toList(),
    );
  }
}
