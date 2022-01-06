import 'package:flutter/material.dart';

class WidgetDescriptionText extends StatelessWidget {
  String text;

  WidgetDescriptionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15,),

    );
  }
}
