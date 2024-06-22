import 'package:flutter/material.dart';

class BadgeComponent extends StatelessWidget {
  String title;
  Color color_background;

  BadgeComponent({required this.title, required this.color_background});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color_background),
      padding: EdgeInsets.all(5),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
