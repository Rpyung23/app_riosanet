import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../widget/bottom_navigation_client.dart';
import '../../widget/floatingbottonSupport.dart';
import '../../widget/toolbar.dart';

class HomeClient extends StatefulWidget {
  HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ToolBarWidget(),
      body: Container(
        padding: EdgeInsets.only(
            top: marginSmallSmall,
            left: marginSmallSmall,
            right: marginSmallSmall),
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
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 7.0,
                    percent: 0.7,
                    center: Text(
                      days_next_bill,
                      style: TextStyle(
                          fontSize: textBigBig,
                          color: color_white,
                          fontWeight: FontWeight.bold),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: color_white,
                  ),
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
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
      ],
    );
  }

  _getCardSpeedTest() {
    return Card(
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
}
